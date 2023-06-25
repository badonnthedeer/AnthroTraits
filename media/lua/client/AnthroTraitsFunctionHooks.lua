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

--fail 2
--local oldAddEatTooltip = ISInventoryPaneContextMenu.addEatTooltip
--ISInventoryPaneContextMenu.addEatTooltip = function(self, option, items, percent)
--    oldAddEatTooltip(self);
--    local itemTags = item:getTags()
--    if itemTags:contains("AT_Herbivore") then
--        table.insert(self.notes, "Extra nutritious for Herbivores.");
--        table.insert(self.notes, true)
--
--        --table.insert(self.notes, getText("Tooltip_food_CookedInMicrowave"))
--        --table.insert(self.notes, true)
--    end
--end

-- fail 1
--local oldDoTooltip = InventoryItem.DoTooltip
--InventoryItem.DoTooltip = function(self)
--    oldDoTooltip(self);
--    self.tooltip = "This has been modified!\n"..self.tooltip;
--end

local OriginalEvolvedRecipeAdd = ISAddItemInRecipe.perform
ISAddItemInRecipe.perform = function(self)

    OriginalEvolvedRecipeAdd(self);
    --get items in the recipe
    local ingredients = self.baseItem:getExtraItems();
    local tags = {}

    --get all tags relating to food, and init table with string keys so their count can be added to
    for i = 1, #AnthroTraitsGlobals.EvolvedRecipeFoodTags
    do
        tags[AnthroTraitsGlobals.EvolvedRecipeFoodTags[i]] = 0;
    end

    local tagWithLargestCount = "";
    local tagWithLargestCountCount = 0;

    --for each ingredient...
    for i = 0, ingredients:size() -1
    do
        -- for each tag...
        for tag, _ in pairs(tags)
        do
            --if the ingredient has this tag, up the count for that key in tags
            local ingredient = ingredients:get(i) ;
            local ingredientTags = getScriptManager():getItem(ingredient):getTags()
            if ingredientTags:contains(tag)
            then
                tags[tag] = tags[tag] + 1;
            end
        end
    end

    --for each tag...
    for tag, count in pairs(tags)
    do
        --record if the count is larger than the previous
        if count > tagWithLargestCountCount
        then
            tagWithLargestCount = tag;
            tagWithLargestCountCount = count;
        end
        --and remove the tag from the recipe to reset what food-tags it may already have
        if self.baseItem:hasTag(tag)
        then
            self.baseItem:getTags():remove(tag);
            --local tagB, tagE = allItemTags:find(tag);
            --allItemTags = allItemTags:sub(0, tagB)..allItemTags:sub(tagE + 1, allItemTags:size()-1)
        end
    end

    --if the largest count tag is present on greater than 50% of the recipe's items...
    if tagWithLargestCountCount / ingredients:size() > .5
    then
        --add the tag to the item, so it can be handled appropriately when eaten.
        self.baseItem:getTags():add(tagWithLargestCount);
    end
end


local OriginalEatPerform = ISEatFoodAction.perform;
ISEatFoodAction.perform = function(self)
    -- code to run before the original
    OriginalEatPerform(self);
    -- code to run after the original
    ATM.DoVoreModifier(self.character, self.item, self.percentage)
end

local OriginalEatStop = ISEatFoodAction.stop;
ISEatFoodAction.stop = function(self)
    -- code to run before the original
    OriginalEatStop(self);
    -- code to run after the original
    ATM.DoVoreModifier(self.character, self.item, self:getJobDelta())
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

--[[--poison gui update?
local originalRefreshContainer = ISInventoryPane.refreshContainer;
ISInventoryPane.refreshContainer = function(self)
    --before original
    originalRefreshContainer(self);
    --after original
    local player = getSpecificPlayer(self.player);
    local inventory = self.inventory:getItems();
    for i = 0, inventory:size() - 1
    do
        local item = inventory:get(i);
        local itemDisplayName = item:getDisplayName();

        if item:IsFood() and item:hasTag("ATFeralPoison")
        then
            if player:HasTrait("AT_FeralDigestion")
            then
                if not itemDisplayName:contains("Poisonous")
                then
                    item:setName("Poisonous "..itemDisplayName);
                end
            else
                if itemDisplayName:contains("Poisonous ") and item:getPoisonPower() <= 0
                then
                    item:setName(itemDisplayName:sub(11));
                end
            end
        end
    end
end]]
--GUI


local oldRender = ISToolTipInv.render
ISToolTipInv.render = function(self)
    if ISContextMenu.instance and ISContextMenu.instance.visibleCheck then
        oldRender(self);
    end

    if not self.item and not self.item:isFood() then
        oldRender(self);
    end

    local player = self.tooltip.character;
    local tooltipTextTable = {}
    if (self.item:hasTag("ATHerbivore") or self.item:hasTag("ATCarnivore") or self.item:hasTag("ATFeralPoison")
            and  (player:HasTrait("AT_Herbivore") or player:HasTrait("AT_Carnivore") or player:HasTrait("AT_CarrionEater") or player:HasTrait("AT_FeralDigestion")))
    then
        if self.item:hasTag("ATHerbivore")
        then
            if player:HasTrait("AT_Herbivore")
            then
                tooltipTextTable = ATU.BuildFoodDescription("This food is more nutritious for you.", self.item, SandboxVars.AnthroTraits.HerbivoreBonus)
            elseif player:HasTrait("AT_Carnivore")
            then
                tooltipTextTable = ATU.BuildFoodDescription("This food is less nutritious for you.", self.item, SandboxVars.AnthroTraits.CarnivoreMalus)
            end
        elseif self.item:hasTag("ATCarnivore")
        then
            if player:HasTrait("AT_Carnivore") and player:HasTrait("AT_CarrionEater")
            then
                tooltipTextTable = ATU.BuildFoodDescription("This food is extra nutritious for you.", self.item, (SandboxVars.AnthroTraits.CarnivoreBonus + SandboxVars.AnthroTraits.CarrionEaterBonus))
            elseif player:HasTrait("AT_Carnivore")
            then
                tooltipTextTable = ATU.BuildFoodDescription("This food is more nutritious for you.", self.item, SandboxVars.AnthroTraits.CarnivoreBonus)
            elseif player:HasTrait("AT_CarrionEater")
            then
                tooltipTextTable = ATU.BuildFoodDescription("This food is more nutritious for you.", self.item, SandboxVars.AnthroTraits.CarrionEaterBonus)
            elseif player:HasTrait("AT_Herbivore")
            then
                tooltipTextTable = ATU.BuildFoodDescription("This food is less nutritious for you.", self.item, SandboxVars.AnthroTraits.HerbivoreMalus)
            end
        end
        if self.item:hasTag("ATFeralPoison")
        then
            table.insert(tooltipTextTable, 1, "This food is poisonous to you!")
        end
    else
        oldRender(self);
    end

    local startPos = self.tooltip:getHeight() + self.tooltip:getLineSpacing() / 2;
    local widestText = 0
    for i = 1, #tooltipTextTable do
        widestText = math.max(
                widestText,
                getTextManager():MeasureStringX(UIFont[getCore():getOptionTooltipFont()], ITE.Lines[i]["Text"])
        )

    end
    local spacing = self.tooltip:getLineSpacing()
    local width = math.max(self.tooltip:getWidth(), widestText + spacing / 2) + spacing
    self.tooltip:setWidth(width)




    local count = 0
    for i = 1, #tooltipTextTable do count = count + 1 end
    if count > 0 then count = count + 1 end
    self.tooltip:setHeight(#tooltipTextTable + self.tooltip:getLineSpacing() * count)

    local startPos = self.tooltip:getHeight() + self.tooltip:getLineSpacing() / 2

    for i = 1, #tooltipTextTable do
        local position = startPos + self.tooltip:getLineSpacing() * (i - 1)
        local color = tooltipTextTable[i]["Color"] or Colors.LemonChiffon
        local text = tooltipTextTable[i]

        -- local name = Colors.GetColorNames():get(ZombRand(1, Colors.GetColorsCount()))
        -- color = Colors.GetColorByName(name)

        self.tooltip:DrawText(text, 5, position,
                color:getRedFloat(),
                color:getGreenFloat(),
                color:getBlueFloat(),
                color:getAlphaFloat())
    end
end




local oldSOSMD = SandboxOptionsScreen.onOptionMouseDown
SandboxOptionsScreen.onOptionMouseDown = function(...)
    ATC.refundSelectedAffectedTraits();
    oldSOSMD(...);
    ATC.sortTraits();
end