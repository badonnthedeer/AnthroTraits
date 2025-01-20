--
--                                  @*x/||x8
--                                   %8%n&v]`Ic
--                                     *)   }``W
--                                     *>&  1``n
--                                  &@ tI1/^`"@
--                                 &11\]"``^v
--                                M"`````,[&@@@@@
--                            &#cv(`:[/];"`````^r%
--                        @z);^`^;}"~}"........;&
--                 @WM##n~;+"`^^^.<[}}+,`'''`:tB
--                 #*xj<;).`i"``"l}}}}}}}%@B
--                 j^'..`+..,}}}}}}}}}}}(
--                  /,'.'...I}}}}}}}}}}}r
--                    @Muj/x*c"`'';}}}}}n
--                           !..'!}}}}}}x
--                          r`^;[}}}}}}}t                        @|M
--                         8{}}}}}}}}}}}{&                       B?>|@
--                         \}}}}}}}}}}}}})W                      x}?'<
--                        v}}}}}}}}}}}}}}}}/v#&%B  @@          Bj}}:.`
--                        :,}}}}}}}}}}}}}}}}}}}}}}}{{{1)(|/jnzr{}+"..-
--                        :.;}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}]l,;_c
--                        (.:}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}t
--                      &r_^']}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}+*
--                   Mt-I,,,^`[}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}"W
--               *\+;,,,,,,,,",}}}}}}}}}}}]??]]}}}}}}}}}}}}}}}]""*
--             c;,,,,:;+{rW8BBB!+}}}}}}}}}>,:;!}}}}}}}}}}}}-"^`"l\%
--             W:,,,?@         n'+}}}}}}}?:,,,:[}}}}}}}}}}}:.,,,+|f@
--              /,,,i8          ,"}}}}}}|vnrrrrt}}}}}}}}}}}"`,,,:1|\v@
--               xI,,;rB%%B     [:}}}}{u        c(}}}}}}}}},`,,,,;}||/8
--                @fl]trrrrr    *}}}}}t           &vf(}}}}}]`:,,,,,?||t
--                  @*rrrrrx    *}}}}})@              &/}}}}-nxj\{[)|||xc#
--                     Mrrrv    v}}}}}c                 u}}}}}}r   8t|||||8
--                      8nr*    x}}}}n                   j}}}}}v    Bj|||?t
--                        &B    r}}}\                    %}}}}>%     &_]}:u
--                              j}}}z                    _"~l`1    Bx<,,,;B
--                              njxt@                @z}"....!   z[;;;;:;}
--                           %MvnnnnM               *~"^^^``iB  B*xrrrffrrB
--                         Wunnnnnnn*             &cnnnnnnnv   @*z*****zz#
--                        &MWWWWWWMWB            WMWWWWWWMWB
------------------------------------------------------------------------------------------------------
-- AUTHOR: Badonn the Deer
-- LICENSE: MIT
-- REFERENCES: Named Literature (Chuckleberry Finn)
-- Did this code help you write your own mod? Consider donating to me at https://ko-fi.com/badonnthedeer!
-- I'm in financial need and every little bit helps!!
--
-- Have a problem or question? Reach me on Discord: badonn
------------------------------------------------------------------------------------------------------

local ATM = require("NPCs/AnthroTraitsMain");
local ATC = require("NPCs/AnthroTraitsCreationMethods");
local ATU = require("AnthroTraitsUtilities");
require('AnthroTraitsGlobals');


--Cost modifier

local traitMetatable = __classmetatables[Trait.class].__index
local old_getCost = traitMetatable.getCost
---@param self Trait
traitMetatable.getCost = function(self)
    if SandboxVars.AnthroTraits[self:getType().."_Cost"] ~= nil
    then
        return SandboxVars.AnthroTraits[self:getType().."_Cost"]
    else
        return old_getCost(self)
    end
end

local old_getRightLabel = traitMetatable.getRightLabel
---@param self Trait
traitMetatable.getRightLabel = function(self)

    if SandboxVars.AnthroTraits[self:getType().."_Cost"] ~= nil
    then
        local cost = SandboxVars.AnthroTraits[self:getType().."_Cost"];
        local label = "+"

        if cost > 0
        then
            label = "-"
        elseif cost == 0
        then
            label = ""
        end

        if cost < 0
        then
            cost = cost * -1
        end

        return label..cost

    else
        return old_getRightLabel(self)
    end
end

--VANILLA LUA FUNCTION HOOKS

local OriginalEatPerform = ISEatFoodAction.perform;
ISEatFoodAction.perform = function(self)
    -- code to run before the original
    local currPoisonLvl = self.character:getBodyDamage():getPoisonLevel();
    ATM.ApplyFoodChanges(self.character, self.item, self.percentage)
    OriginalEatPerform(self);
    -- code to run after the original
    ATM.ApplyAfterEatFoodChanges(self.character, self.item, self.percentage, currPoisonLvl)
end

local OriginalEatStop = ISEatFoodAction.stop;
ISEatFoodAction.stop = function(self)
    -- code to run before the original
    ATM.ApplyFoodChanges(self.character, self.item, self.percentage * self:getJobDelta())
    OriginalEatStop(self);
    -- code to run after the original
    ATM.ApplyAfterEatFoodChanges(self.character, self.item, self.percentage * self:getJobDelta());
end


local OriginalTimedActionCreate = ISBaseTimedAction.create;
ISBaseTimedAction.create = function(self)
    OriginalTimedActionCreate(self);
    if self.character:HasTrait("AT_UnwieldyHands")
    then
        for i = 1, #AnthroTraitsGlobals.UnwieldyHandsAffectedTimedActions
        do
            if self.Type == AnthroTraitsGlobals.UnwieldyHandsAffectedTimedActions[i]
            then
                local newTime = self.maxTime * (1 + SandboxVars.AnthroTraits.AT_UnwieldyHandsTimeIncrease)
                if getDebug()
                then
                    print("UnwieldyHands activated. Old time: "..tostring(self.maxTime).." New time: "..tostring(newTime));
                end
                self.maxTime = newTime;
                break;
            end
        end
    end
end


local oldRender = ISToolTipInv.render
ISToolTipInv.render = function(self)
     --redirect back to oldrender if tooltip isn't for food.
    if (ISContextMenu.instance and ISContextMenu.instance.visibleCheck) or (self.item == nil)
    then
        oldRender(self);
    else
        --short-circuit to prevent components from triggering (transfer fluid gui)
        if not instanceof(self.item, "Food") and (not instanceof(self.item, "ComboItem"))
        then
            oldRender(self);
        else
            --declare and get vars
            local player = self.tooltip:getCharacter();
            local mx = getMouseX() + 32;
            local my = getMouseY() + 10;
            local tooltipOffsetX = -8;
            local tooltipOffsetY = 15;
            local tooltipPaddingLeft = 7;
            local tooltipPaddingRight = 6;
            local tooltipPaddingTop = 3;
            local tooltipPaddingBottom = 0;
            local tooltipTextTable = {};
            local longestTextWidth = 0;
            local longestLeftTextWidth = 0;
            local textHeight = 0;
            local barPaddingLeft = 5;
            local barPaddingRight = 5;
            local rightTextLeftPadding = 5;
            local barHeight = 3;
            local lineSpacing = self.tooltip:getLineSpacing();
            local defaultColor = Colors.LemonChiffon;
            local text = "";
            local leftText = "";

            if (((ATU.FoodVoreType(self.item) == "ATHerbivore" or ATU.FoodVoreType(self.item) == "ATCarnivore") and (player:HasTrait("AT_Herbivore") or player:HasTrait("AT_Carnivore") or player:HasTrait("AT_CarrionEater")))
                    or (self.item:hasTag("ATFeralPoison") and player:HasTrait("AT_FeralDigestion"))
                    or (self.item:hasTag("ATInsect") and player:HasTrait("AT_Bug_o_ssieur"))
                    or (player:HasTrait("AT_FoodMotivated")))
            then
                if ATU.FoodVoreType(self.item) == "ATHerbivore"
                then
                    if player:HasTrait("AT_Herbivore")
                    then
                        tooltipTextTable = ATU.BuildFoodDescription(player, "%LightGreen%This food is more nutritious for you.", self.item, SandboxVars.AnthroTraits.AT_HerbivoreBonus)
                    elseif player:HasTrait("AT_Carnivore")
                    then
                        tooltipTextTable = ATU.BuildFoodDescription(player, "%LavenderBlush%This food is less nutritious for you.", self.item, SandboxVars.AnthroTraits.AT_CarnivoreMalus)
                    elseif player:HasTrait("AT_FoodMotivated") or player:HasTrait("AT_FeralDigestion")
                    then
                        tooltipTextTable = ATU.BuildFoodDescription(player, nil, self.item, 0)
                    end
                elseif ATU.FoodVoreType(self.item) == "ATCarnivore"
                then
                    if player:HasTrait("AT_Carnivore") and player:HasTrait("AT_CarrionEater") and self.item:IsRotten()
                    then
                        tooltipTextTable = ATU.BuildFoodDescription(player, "%LightGreen%This food is better for you.", self.item, (SandboxVars.AnthroTraits.AT_CarnivoreBonus + SandboxVars.AnthroTraits.AT_CarrionEaterBonus))
                    elseif player:HasTrait("AT_Carnivore")
                    then
                        tooltipTextTable = ATU.BuildFoodDescription(player, "%LightGreen%This food is better for you.", self.item, SandboxVars.AnthroTraits.AT_CarnivoreBonus)
                    elseif player:HasTrait("AT_CarrionEater") and self.item:IsRotten()
                    then
                        tooltipTextTable = ATU.BuildFoodDescription(player, "%LightGreen%This food is better for you.", self.item, SandboxVars.AnthroTraits.AT_CarrionEaterBonus)
                    elseif player:HasTrait("AT_Herbivore")
                    then
                        tooltipTextTable = ATU.BuildFoodDescription(player, "%LavenderBlush%This food is worse for you.", self.item, SandboxVars.AnthroTraits.AT_HerbivoreMalus)
                    elseif player:HasTrait("AT_FoodMotivated") or player:HasTrait("AT_FeralDigestion")
                    then
                        tooltipTextTable = ATU.BuildFoodDescription(player, nil, self.item, 0)
                    end
                elseif player:HasTrait("AT_FoodMotivated") or player:HasTrait("AT_Bug_o_ssieur") or player:HasTrait("AT_FeralDigestion")
                then
                    tooltipTextTable = ATU.BuildFoodDescription(player, nil, self.item, 0)
                end
            else
                --If it doesn't have any relevant tags, go instead to oldRender
                return oldRender(self);
            end

            for i = 1, #tooltipTextTable do
                text = string.gsub(tooltipTextTable[i], "%%[^%%]+%%", "")
                longestTextWidth = math.max(longestTextWidth, getTextManager():MeasureStringX(UIFont[getCore():getOptionTooltipFont()], text));
                if tooltipTextTable[i]:find(":")
                then
                    leftText = text:sub(0, text:find(":"))
                    longestLeftTextWidth = math.max(longestLeftTextWidth, getTextManager():MeasureStringX(UIFont[getCore():getOptionTooltipFont()], leftText));
                end

            end
            for i = 1, #tooltipTextTable do
                if tooltipTextTable[i] ~= nil
                then
                    textHeight = textHeight + self.tooltip:getLineSpacing();
                else
                    textHeight = self.tooltip:getLineSpacing() / 2;
                end


            end
            textHeight = self.tooltip:getLineSpacing() * #tooltipTextTable;

            if not self.followMouse then
                mx = self:getX();
                my = self:getY();
            end
            if self.desiredX and self.desiredY then
                mx = self.desiredX;
                my = self.desiredY;
            end

            --update tooltip objects with calculated vars
            self:setX(mx + tooltipOffsetX);
            self:setY(my + tooltipOffsetY);

            self.tooltip:setX(mx + tooltipOffsetX);
            self.tooltip:setY(my + tooltipOffsetY);

            --[[if self.contextMenu and self.contextMenu.joyfocus then
                local playerNum = self.contextMenu.player
                self:setX(getPlayerScreenLeft(playerNum) + 60);
                self:setY(getPlayerScreenTop(playerNum) + 60);
            elseif self.contextMenu and self.contextMenu.currentOptionRect then
                if self.contextMenu.currentOptionRect.height > 32 then
                    self:setY(my + self.contextMenu.currentOptionRect.height)
                end
                self:adjustPositionToAvoidOverlap(self.contextMenu.currentOptionRect)
            elseif self.owner and self.owner.isButton then
                local ownerRect = { x = self.owner:getAbsoluteX(), y = self.owner:getAbsoluteY(), width = self.owner.width, height = self.owner.height }
                self:adjustPositionToAvoidOverlap(ownerRect)
            end]]

            -- screen bounding
            if self.followMouse then
                --needs adjustment but fine for now.
                self:adjustPositionToAvoidOverlap({ x = mx - 24 * 2, y = my - 24 * 2, width = 24 * 2, height = 24 * 2 })
            end
            --Draw tooltip

            self:drawRect(0, 0, (longestTextWidth + tooltipPaddingLeft + tooltipPaddingRight), (textHeight + tooltipPaddingTop + tooltipPaddingBottom), self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b)
            self:drawRectBorder(0, 0, (longestTextWidth + tooltipPaddingLeft + tooltipPaddingRight), (textHeight + tooltipPaddingTop + tooltipPaddingBottom), self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b)

            local lineY = tooltipPaddingTop;

            for i = 1, #tooltipTextTable do
                local lineX = tooltipPaddingLeft;
                local lineRightX = longestTextWidth + tooltipPaddingLeft;
                local lineYBar;
                local currColor = defaultColor;
                local leftTextWidth;
                local leftTextColor;
                local rightText;
                local rightTextColor;
                local barLength;
                local textFindBeg;
                local textFindEnd;

                text = tooltipTextTable[i]
                leftText = nil;

                if text:contains(":")
                then
                    leftText = text:sub(0, text:find(":"))
                    leftTextColor = leftText:match("%%.+%%")
                    if leftTextColor ~= nil
                    then
                        textFindBeg,textFindEnd  = leftText:find("%%.+%%");
                        leftText = leftText:sub(textFindEnd +1, #leftText)
                        leftTextColor = leftTextColor:sub(2, #leftTextColor - 1)
                    end
                    rightText = text:sub((text:find(":")  +1), #text)
                    rightTextColor = rightText:match("%%.+%%")
                    if rightTextColor ~= nil
                    then
                        textFindBeg,textFindEnd  = rightText:find("%%.+%%");
                        rightText = rightText:sub(textFindEnd +1, #rightText)
                        rightTextColor = rightTextColor:sub(2, #rightTextColor - 1)
                    end
                    currColor = Colors[leftTextColor] or defaultColor;

                    self.tooltip:DrawText(leftText, lineX, lineY,
                            currColor:getRedFloat(),
                            currColor:getGreenFloat(),
                            currColor:getBlueFloat(),
                            currColor:getAlphaFloat())

                    currColor = Colors[rightTextColor] or defaultColor;
                    if rightText ~= nil
                    then
                        self.tooltip:DrawTextRight(rightText, lineRightX, lineY,
                                currColor:getRedFloat(),
                                currColor:getGreenFloat(),
                                currColor:getBlueFloat(),
                                currColor:getAlphaFloat())
                    end
                        lineY = lineY + lineSpacing
                elseif text:contains("|")
                then
                    leftText = text:sub(0, text:find("|") - 1)
                    leftTextWidth = getTextManager():MeasureStringX(UIFont[getCore():getOptionTooltipFont()], leftText)
                    leftTextColor = leftText:match("%%.+%%")
                    if leftTextColor ~= nil
                    then
                        textFindBeg,textFindEnd  = leftText:find("%%.+%%");
                        leftText = leftText:sub(textFindEnd +1, #leftText)
                        leftTextColor = leftTextColor:sub(2, #leftTextColor - 1)
                    end
                    rightText = text:sub(text:find("|") +1, #text)
                    rightTextColor = rightText:match("%%.+%%")
                    if rightTextColor ~= nil
                    then
                        textFindBeg,textFindEnd  = rightText:find("%%.+%%");
                        rightText = rightText:sub(textFindEnd +1, #rightText)
                        rightTextColor = rightTextColor:sub(2, #rightTextColor - 1)
                    end
                    currColor = Colors[leftTextColor] or defaultColor;

                    self.tooltip:DrawText(leftText, lineX, lineY,
                            currColor:getRedFloat(),
                            currColor:getGreenFloat(),
                            currColor:getBlueFloat(),
                            currColor:getAlphaFloat())

                    currColor = Colors[rightTextColor] or defaultColor;
                    if rightText ~= nil
                    then
                        barLength = (longestTextWidth - leftTextWidth - barPaddingRight);
                        --center the bar in the available line space
                        lineYBar = (lineY + (self.tooltip:getLineSpacing() / 2) - 1)
                        self.tooltip:DrawProgressBar(lineX + leftTextWidth, lineYBar, barLength, 12, tonumber(rightText), currColor:getRedFloat(), currColor:getGreenFloat(), currColor:getBlueFloat(), currColor:getAlphaFloat())
                    end
                    lineY = lineY + lineSpacing
                elseif text == nil or text == ""
                then
                    lineY = lineY + (lineSpacing / 2)
                else
                    leftTextColor = text:match("%%.+%%")
                    if leftTextColor ~= nil
                    then
                        textFindBeg,textFindEnd  = text:find("%%.+%%");
                        text = text:sub(textFindEnd +1, #text)
                        leftTextColor = leftTextColor:sub(2, #leftTextColor - 1)
                    end
                    currColor = Colors[leftTextColor] or defaultColor;
                    self.tooltip:DrawText(text,  lineX, lineY,
                            currColor:getRedFloat(),
                            currColor:getGreenFloat(),
                            currColor:getBlueFloat(),
                            currColor:getAlphaFloat())
                    lineY = lineY + lineSpacing
                end
            end
        end
    end
end
--ISInventoryPaneContextMenu.addEatTooltip = function(option, items, percent)
--ISInventoryPane.drawItemDetails =



local oldSOSMD = SandboxOptionsScreen.onOptionMouseDown
SandboxOptionsScreen.onOptionMouseDown = function(...)
    ATC.refundSelectedAffectedTraits();
    oldSOSMD(...);
    ATC.setTraitDescriptions();
    ATC.sortTraits();
end
