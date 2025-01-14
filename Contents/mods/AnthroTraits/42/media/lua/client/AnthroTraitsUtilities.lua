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

local AnthroTraitsUtilities = {}


--UTILITIES
AnthroTraitsUtilities.FileExists = function(path)

    local reader = getModFileReader(AnthroTraitsGlobals.ModID, path, false);
    if not reader
    then
        return false
    else
        reader:close();
        return true
    end
end


AnthroTraitsUtilities.AddItemTagToItemsFromSandbox = function(itemList, tag)
    local this = AnthroTraitsUtilities;

    local itemTable = {};
    local foundItem;
    local itemTags;

    for str in string.gmatch(itemList, "([^;]+)")
    do
        table.insert(itemTable, str)
    end

    for _, tableEntry in ipairs(itemTable)
    do
        foundItem = getScriptManager():getItem(tableEntry);
        if foundItem ~= nil
        then
            itemTags = foundItem:getTags();
            if not itemTags:contains(tag)
            then
                itemTags:add(tag);
                if getDebug()
                then
                    print("tag "..tag.." added to "..tableEntry);
                end
            end
        else
            print("Cannot find item "..tableEntry.." to add tag "..tag);
        end
    end
end


AnthroTraitsUtilities.getTooltipValueColor = function(oldValChangeAmt, newValChangeAmt, positiveBad)
    local color = "%Purple%";

    if (positiveBad and newValChangeAmt > 0 and oldValChangeAmt < newValChangeAmt) or (not positiveBad and newValChangeAmt < 0 and oldValChangeAmt > newValChangeAmt)
    then
        color = "%Crimson%";
    elseif (positiveBad and newValChangeAmt < 0 and oldValChangeAmt > newValChangeAmt) or (not positiveBad and newValChangeAmt > 0 and oldValChangeAmt < newValChangeAmt)
    then
        color = "%LightGreen%";
    elseif (positiveBad and newValChangeAmt > 0 and oldValChangeAmt > newValChangeAmt) or (not positiveBad and newValChangeAmt < 0 and oldValChangeAmt < newValChangeAmt)
    then
        color = "%LavenderBlush%";
    elseif (positiveBad and newValChangeAmt < 0 and oldValChangeAmt < newValChangeAmt) or (not positiveBad and newValChangeAmt > 0 and oldValChangeAmt > newValChangeAmt)
    then
        color = "%Yellow%";
    elseif (positiveBad and newValChangeAmt > 0 and oldValChangeAmt == newValChangeAmt) or (not positiveBad and newValChangeAmt < 0 and oldValChangeAmt == newValChangeAmt)
    then
        color = "%Red%";
    elseif (positiveBad and newValChangeAmt < 0 and oldValChangeAmt == newValChangeAmt) or (not positiveBad and newValChangeAmt > 0 and oldValChangeAmt == newValChangeAmt)
    then
        color = "%Lime%";
    end

    return color;
end


AnthroTraitsUtilities.getTooltipValueSymbol = function(newValChangeAmt)
    local symbol = "~";

    if newValChangeAmt > 0
    then
        symbol = "+"
    elseif newValChangeAmt < 0
    then
        symbol = ""
    end

    return symbol
end

---For basic food modifiers. This is built upon by CalculateFoodChanges later.
AnthroTraitsUtilities.CalculateFoodModifiers = function(character, food)
    local modifiers = {
        multHunger = 0,
        multThirst = 0,
        multEndurance = 0,
        multStress = 0,
        multBoredom = 0,
        multUnhappiness = 0,
        multCalories = 0,
    }

    if food:hasTag("ATHerbivore") then
        if character:HasTrait("AT_Carnivore")
        then
            modifiers.multHunger = SandboxVars.AnthroTraits.AT_CarnivoreMalus;
            modifiers.multThirst = SandboxVars.AnthroTraits.AT_CarnivoreMalus;
            modifiers.multEndurance = SandboxVars.AnthroTraits.AT_CarnivoreMalus;
            modifiers.multStress = SandboxVars.AnthroTraits.AT_CarnivoreMalus;
            modifiers.multBoredom = SandboxVars.AnthroTraits.AT_CarnivoreMalus;
            modifiers.multUnhappiness = SandboxVars.AnthroTraits.AT_CarnivoreMalus;
            modifiers.multCalories = SandboxVars.AnthroTraits.AT_CarnivoreMalus;
        elseif character:HasTrait("AT_Herbivore")
        then
            modifiers.multHunger = SandboxVars.AnthroTraits.AT_HerbivoreBonus;
            modifiers.multThirst = SandboxVars.AnthroTraits.AT_HerbivoreBonus;
            modifiers.multEndurance = SandboxVars.AnthroTraits.AT_HerbivoreBonus;
            modifiers.multStress = SandboxVars.AnthroTraits.AT_HerbivoreBonus;
            modifiers.multBoredom = SandboxVars.AnthroTraits.AT_HerbivoreBonus;
            modifiers.multUnhappiness = SandboxVars.AnthroTraits.AT_HerbivoreBonus;
            modifiers.multCalories = SandboxVars.AnthroTraits.AT_HerbivoreBonus;
        end
    elseif food:hasTag("ATCarnivore") then
        if character:HasTrait("AT_Herbivore")
        then
            modifiers.multHunger = SandboxVars.AnthroTraits.AT_HerbivoreMalus;
            modifiers.multThirst = SandboxVars.AnthroTraits.AT_HerbivoreMalus;
            modifiers.multEndurance = SandboxVars.AnthroTraits.AT_HerbivoreMalus;
            modifiers.multStress = SandboxVars.AnthroTraits.AT_HerbivoreMalus;
            modifiers.multBoredom = SandboxVars.AnthroTraits.AT_HerbivoreMalus;
            modifiers.multUnhappiness = SandboxVars.AnthroTraits.AT_HerbivoreMalus;
            modifiers.multCalories = SandboxVars.AnthroTraits.AT_HerbivoreMalus;
        elseif character:HasTrait("AT_Carnivore") and character:HasTrait("AT_CarrionEater") and food:isRotten()
        then
            modifiers.multHunger = SandboxVars.AnthroTraits.AT_CarnivoreBonus + SandboxVars.AnthroTraits.AT_CarrionEaterBonus;
            modifiers.multThirst = SandboxVars.AnthroTraits.AT_CarnivoreBonus + SandboxVars.AnthroTraits.AT_CarrionEaterBonus;
            modifiers.multCalories = SandboxVars.AnthroTraits.AT_CarnivoreBonus + SandboxVars.AnthroTraits.AT_CarrionEaterBonus;
        elseif character:HasTrait("AT_Carnivore")
        then
            modifiers.multHunger = SandboxVars.AnthroTraits.AT_CarnivoreBonus;
            modifiers.multThirst = SandboxVars.AnthroTraits.AT_CarnivoreBonus;
            modifiers.multEndurance = SandboxVars.AnthroTraits.AT_CarnivoreBonus;
            modifiers.multStress = SandboxVars.AnthroTraits.AT_CarnivoreBonus;
            modifiers.multBoredom = SandboxVars.AnthroTraits.AT_CarnivoreBonus;
            modifiers.multUnhappiness = SandboxVars.AnthroTraits.AT_CarnivoreBonus;
            modifiers.multCalories = SandboxVars.AnthroTraits.AT_CarnivoreBonus;
        elseif character:HasTrait("AT_CarrionEater") and food:isRotten()
        then
            modifiers.multHunger = SandboxVars.AnthroTraits.AT_CarrionEaterBonus;
            modifiers.multThirst = SandboxVars.AnthroTraits.AT_CarrionEaterBonus;
            modifiers.multCalories = SandboxVars.AnthroTraits.AT_CarrionEaterBonus;
        end
    end

    return modifiers
end


---For extra effects of food. Dog food change from FoodMotivated is in here for example.
AnthroTraitsUtilities.CalculateFoodChanges = function(character, food)
    local modifiers = AnthroTraitsUtilities.CalculateFoodModifiers(character, food)

    local foodName = food:getName();
    local foodID = food:getFullType();
    local encumbrance = food:getWeight();
    local stackEncum = food:getCount() * encumbrance
    local foodBaseHunger = food:getBaseHunger() or 0;
    local origHungerChange = food:getHungerChange() or 0;
    local origThirstChange = food:getThirstChange() or 0;
    local origEndChange = food:getEnduranceChange() or 0;
    local origStressChange = food:getStressChange() or 0;
    local origBoredomChange = food:getBoredomChange() or 0;
    local origUnhappyChange = food:getUnhappyChange() or 0;
    local origFoodCalories = food:getCalories() or 0;

    local extraFoodHungerChange = (origHungerChange * modifiers.multHunger);
    local extraFoodThirstChange = (origThirstChange * modifiers.multThirst);
    local extraFoodEndChange = (origEndChange * modifiers.multEndurance);
    local extraFoodStressChange = (origStressChange * modifiers.multStress);
    local extraFoodBoredomChange = (origBoredomChange * modifiers.multBoredom);
    local extraFoodUnhappyChange = (origUnhappyChange * modifiers.multUnhappiness);
    local extraFoodCalories = (origFoodCalories * modifiers.multCalories);
    local extraPoison = 0;


    if origBoredomChange > 0 and extraFoodBoredomChange ~= 0
    then
        extraFoodBoredomChange = (extraFoodBoredomChange * (modifiers.multBoredom * -1));
    end
    if origUnhappyChange > 0 and extraFoodUnhappyChange ~= 0
    then
        extraFoodUnhappyChange = (extraFoodUnhappyChange * (modifiers.multUnhappiness * -1));
    end

    if (character:HasTrait("AT_Bug_o_ssieur") and food:hasTag("ATInsect")) or (character:HasTrait("AT_CarrionEater") and food:hasTag("ATCarnivore") and (food:HowRotten() > 0))
    then
        extraFoodUnhappyChange = extraFoodUnhappyChange - origUnhappyChange;
        extraFoodBoredomChange =  extraFoodBoredomChange - origBoredomChange;
    end

    if (character:HasTrait("AT_FoodMotivated") and foodID == "Base.DogfoodOpen")
    then
        extraFoodBoredomChange =  extraFoodUnhappyChange - SandboxVars.AnthroTraits.AT_FoodMotivatedBonus;
        extraFoodUnhappyChange =  extraFoodUnhappyChange - (50 + SandboxVars.AnthroTraits.AT_FoodMotivatedBonus);
    elseif character:HasTrait("AT_FoodMotivated")
    then
        extraFoodBoredomChange = extraFoodBoredomChange - SandboxVars.AnthroTraits.AT_FoodMotivatedBonus;
        extraFoodUnhappyChange = extraFoodUnhappyChange - SandboxVars.AnthroTraits.AT_FoodMotivatedBonus;
    end

    if character:HasTrait("AT_FeralDigestion")
    then
        local maxPoisonAmt = SandboxVars.AnthroTraits.AT_FeralDigestionPoisonAmt
        if food:getExtraItems() ~= nil
        then
            local foodIngredients = food:getExtraItems()
            for i = 0, foodIngredients:size() - 1
            do
                local foodIngredientTags = getScriptManager():getItem(foodIngredients:get(i)):getTags()
                if foodIngredientTags:contains("ATFeralPoison")
                then
                    extraPoison = extraPoison + maxPoisonAmt
                end
            end
        elseif food:hasTag("ATFeralPoison")
        then
            extraPoison = maxPoisonAmt
        end
    end

    local foodChanges = {
        addHungerChange = extraFoodHungerChange,
        addThirstChange = extraFoodThirstChange,
        addEndChange = extraFoodEndChange,
        addStressChange = extraFoodStressChange,
        addBoredomChange = extraFoodBoredomChange,
        addUnhappyChange = extraFoodUnhappyChange,
        addCalories = extraFoodCalories,
        addPoison = extraPoison,
    }
    return foodChanges
end


AnthroTraitsUtilities.BuildFoodDescription = function(player, description, item, statModifier)
    local this = AnthroTraitsUtilities;
    local returnTable = {}

    local foodName = item:getName();
    local foodID = item:getFullType();
    local foodIngredients = item:getExtraItems();
    local foodIngredientTags;
    local encumbrance = item:getActualWeight();
    local stackEncum = item:getCount() * encumbrance
    local foodBaseHunger = item:getBaseHunger();
    local foodHungerChange = item:getHungerChange();
    local foodThirstChange = item:getThirstChange();
    local foodEndChange = item:getEnduranceChange();
    local foodStressChange = item:getStressChange();
    local foodBoredomChange = item:getBoredomChange();
    local foodUnhappyChange = item:getUnhappyChange();
    local foodCalories = item:getCalories();
    local foodCarbs = item:getCarbohydrates();
    local foodProtein = item:getProteins();
    local foodFat = item:getLipids();
    local foodCookedMicrowave = item:isCookedInMicrowave();

    local currCookTime = item:getCookingTime();
    local minutesTillCooked = item:getMinutesToCook();
    local minutesTillBurned = item:getMinutesToBurn();

    --local remainingFoodUses = (item:getUses() - item:getCurrentUses());
    --print ("uses: "..item:getUses().." Curr Uses: "..item:getCurrentUses())
    local baseFeralDigestionPoisonAmount = SandboxVars.AnthroTraits.AT_FeralDigestionPoisonAmt;
    --local feralDigestionPoisonAmount = remainingFoodUses * baseFeralDigestionPoisonAmount;
    local totalPoisonPower = 0;
    --local bleach = getScriptManager():getItem("Base.Bleach");
    --local bleachPoisonAmt = bleach:getPoisonPower();
    --local bleachPoisonAmt = 120;

    local foodChanges = this.CalculateFoodChanges(player, item)


    local newFoodHungerChange = foodHungerChange + foodChanges.addHungerChange;
    local newFoodThirstChange = foodThirstChange + foodChanges.addThirstChange;
    local newFoodEndChange = foodEndChange + foodChanges.addEndChange;
    local newFoodStressChange = foodStressChange + foodChanges.addStressChange;
    local newFoodBoredomChange = foodBoredomChange + foodChanges.addBoredomChange;
    local newFoodUnhappyChange = foodUnhappyChange + foodChanges.addUnhappyChange;
    local newFoodCalories = foodCalories + foodChanges.addCalories;


    if foodName ~= nil
    then
        if item:isRotten() and not player:HasTrait("AT_CarrionEater")
        then
            table.insert(returnTable, "%Red%"..foodName);
        elseif item:isRotten() and item:hasTag("AT_Carnivore") and player:HasTrait("AT_CarrionEater")
        then
            table.insert(returnTable, "%LightGreen%"..foodName);
        else
            table.insert(returnTable, foodName);
        end
        table.insert(returnTable, description);
        table.insert(returnTable, ""); --spacer line
        end


    if encumbrance ~= nil
    then
        table.insert(returnTable, getText("Tooltip_item_Weight")..":"..string.format("%5.1f", encumbrance))
    end
    if encumbrance ~= nil and item:getCount() > 1
    then
        table.insert(returnTable, getText("Tooltip_item_StackWeight")..":"..string.format("%5.1f", stackEncum))
    end
    if newFoodHungerChange ~= 0
    then
        table.insert(returnTable, getText("Tooltip_food_Hunger")..":"..this.getTooltipValueColor(foodHungerChange, newFoodHungerChange, true)..this.getTooltipValueSymbol(newFoodHungerChange)..string.format("%3.1f",(newFoodHungerChange * 100)));
    end
    if newFoodThirstChange ~= 0
    then
        table.insert(returnTable, getText("Tooltip_food_Thirst")..":"..this.getTooltipValueColor(foodThirstChange, newFoodThirstChange, true)..this.getTooltipValueSymbol(newFoodThirstChange)..string.format("%3.1f",(newFoodThirstChange * 100)));
    end
    if newFoodEndChange ~= 0
    then
        table.insert(returnTable, getText("Tooltip_food_Endurance")..":"..this.getTooltipValueColor(foodEndChange, newFoodEndChange, false)..this.getTooltipValueSymbol(newFoodEndChange)..string.format("%3.1f",(newFoodEndChange * 100)));
    end
    if newFoodStressChange ~= 0
    then
        table.insert(returnTable, getText("Tooltip_food_Stress")..":"..this.getTooltipValueColor(foodStressChange, newFoodStressChange, true)..this.getTooltipValueSymbol(newFoodStressChange)..string.format("%3.1f",newFoodStressChange));
    end
    if newFoodBoredomChange ~= 0
    then
        table.insert(returnTable, getText("Tooltip_food_Boredom")..":"..this.getTooltipValueColor(foodBoredomChange, newFoodBoredomChange, true)..this.getTooltipValueSymbol(newFoodBoredomChange)..string.format("%3.1f",newFoodBoredomChange));
    end
    if newFoodUnhappyChange ~= 0
    then
        table.insert(returnTable, getText("Tooltip_food_Unhappiness")..":"..this.getTooltipValueColor(foodUnhappyChange, newFoodUnhappyChange, true)..this.getTooltipValueSymbol(newFoodUnhappyChange)..string.format("%3.1f",newFoodUnhappyChange));
    end
    if item:isCookable() and not item:isFrozen() and item:getHeat() > 1.6 then
        currCookTime = item:getCookingTime();
        minutesTillCooked = item:getMinutesToCook();
        minutesTillBurned = item:getMinutesToBurn();
        --for found "cooked" items in the beginning of the game
        if (currCookTime == nil or currCookTime == 0) and item:isCooked()
        then
            currCookTime = minutesTillCooked;
        end
        if currCookTime < minutesTillCooked
        then
            table.insert(returnTable, "%Lime%"..getText("IGUI_invpanel_Cooking").."|".."%Lime%"..string.format("%3.2f",currCookTime / minutesTillCooked));
        elseif currCookTime < minutesTillBurned
        then
            table.insert(returnTable, "%Red%"..getText("IGUI_invpanel_Burning").."|".."%Red%"..string.format("%3.2f",(currCookTime - minutesTillCooked ) / (minutesTillBurned - minutesTillCooked)));
        elseif currCookTime > minutesTillBurned
        then
            table.insert(returnTable, "%Red%"..getText("IGUI_invpanel_Burnt"));
        end
    elseif item:getFreezingTime() > 0 and item:getFreezingTime() < 100
    then
        if item:isThawing()
        then
            table.insert(returnTable, getText("IGUI_invpanel_Melting").."|".."%Green%"..string.format("%3.2f", item:getFreezingTime() / 100));
        else
            table.insert(returnTable, getText("IGUI_invpanel_FreezingTime").."|".."%Green%"..string.format("%3.2f", item:getFreezingTime() / 100));
        end
    end
    if item:isPackaged() or player:HasTrait("Nutritionist") or player:HasTrait("Nutritionist2")
    then
        if foodCalories ~= nil and (foodCalories + newFoodCalories) ~= 0
        then
            table.insert(returnTable, getText("Tooltip_food_Calories")..":"..this.getTooltipValueColor(foodCalories, newFoodCalories, false)..string.format("%5.1f", newFoodCalories));
        end
        if foodCarbs ~= nil and foodCarbs ~= 0
        then
            table.insert(returnTable, getText("Tooltip_food_Carbs")..":"..string.format("%5.1f",foodCarbs));
        end
        if foodProtein ~= nil and foodProtein ~= 0
        then
            table.insert(returnTable, getText("Tooltip_food_Prots")..":"..string.format("%5.1f",foodProtein));
        end
        if foodFat ~= nil and foodFat ~= 0
        then
            table.insert(returnTable, getText("Tooltip_food_Fat")..":"..string.format("%5.1f",foodFat));
        end
    end
    if item:isbDangerousUncooked() and not item:isCooked() and not item:isBurnt()
    then
        if item:hasTag("Egg")
        then
            table.insert(returnTable, "%LavenderBlush%"..getText("Tooltip_food_SlightDanger_uncooked"));
        else
            if ((player:HasTrait("AT_Carnivore") and item:hasTag("ATCarnivore") and not item:isRotten())
                    or (player:HasTrait("AT_Herbivore") and item:hasTag("ATHerbivore") and not item:isRotten())
                    or (player:HasTrait("AT_CarrionEater")))
            then
                --do nothing
            else
                table.insert(returnTable, "%Red%"..getText("Tooltip_food_Dangerous_uncooked"));
            end
        end
    end
    if (item:isGoodHot() or item:isBadCold()) and item:getHeat() < 1.3
    then
        table.insert(returnTable, "%LavenderBlush%"..getText("Tooltip_food_BetterHot"));
    end
    if foodCookedMicrowave ~= nil and foodCookedMicrowave == true
    then
        table.insert(returnTable, getText("Tooltip_food_CookedInMicrowave"));
    end

    if foodChanges.addPoison ~= nil and foodChanges.addPoison > 0
    then
        table.insert(returnTable, 2, "%Violet%This food is poisonous to you!")
        --table.insert(returnTable, 2, "%Violet%This food is poisonous to you! ("..string.format("%3.2f",feralDigestionPoisonAmount / bleachPoisonAmt).." full bleach bottle(s))")
    end
    return returnTable;
end


AnthroTraitsUtilities.IsAnthro = function(gameCharacter)
    if getActivatedMods():contains("FurryMod") and gameCharacter ~= nil
    then
        return false;
    else
        local hasFur = false;
        local itemVisuals = gameCharacter:getItemVisuals();
        if itemVisuals ~= nil
        then
            for i=0, itemVisuals:size() - 1
            do
                local itemVisual = itemVisuals:get(i);
                local item =  itemVisual:getScriptItem();
                if item ~= nil and (item:hasTag("Fur") or item:hasTag("DeceasedFur"))
                then
                    hasFur = true;
                    break;
                end
            end;
        end 
        return hasFur;
    end
end

return AnthroTraitsUtilities;