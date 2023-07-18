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


AnthroTraitsUtilities.AddItemTagToItemsFromFile = function(path, tag)
    local this = AnthroTraitsUtilities;
    if not this.FileExists(path)
    then
        print("Cannot find file");
        return {};
    end

    local reader = getModFileReader(AnthroTraitsGlobals.ModID, path, false);
    local line;
    local foundItem;
    local itemTags;

    while reader:ready()
    do
        line = reader:readLine();
        foundItem = getScriptManager():getItem(line);
        if foundItem ~= nil
        then
            itemTags = foundItem:getTags();
            if not itemTags:contains(tag)
            then
                itemTags:add(tag);
                if getDebug()
                then
                    print("tag "..tag.." added to "..line);
                end
            end
        else
            print("Cannot find item "..line.." to add tag "..tag);
        end
    end
    reader:close();
end


AnthroTraitsUtilities.getTooltipValueColor = function(oldValChangeAmt, newValChangeAmt, positiveBad)
    local color = "%Purple%";

    if (positiveBad and newValChangeAmt > 0 and oldValChangeAmt < newValChangeAmt) or (not positiveBad and newValChangeAmt < 0 and oldValChangeAmt > newValChangeAmt)
    then
        color = "%Crimson%";
    elseif (positiveBad and newValChangeAmt < 0 and oldValChangeAmt > newValChangeAmt) or (not positiveBad and newValChangeAmt > 0 and oldValChangeAmt < newValChangeAmt)
    then
        color = "%Lime%";
    elseif (positiveBad and newValChangeAmt > 0 and oldValChangeAmt > newValChangeAmt) or (not positiveBad and newValChangeAmt < 0 and oldValChangeAmt < newValChangeAmt)
    then
        color = "%LavenderBlush%";
    elseif (positiveBad and newValChangeAmt < 0 and oldValChangeAmt < newValChangeAmt) or (not positiveBad and newValChangeAmt > 0 and oldValChangeAmt > newValChangeAmt)
    then
        color = "%Yellow%";
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

AnthroTraitsUtilities.BuildFoodDescription = function(player, description, item, statModifier)
    local this = AnthroTraitsUtilities;
    local returnTable = {}

    local foodName = item:getName();
    local encumbrance = item:getWeight();
    local stackEncum = item:getCount() * encumbrance
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

    if (player:HasTrait("AT_Bug-o-ssieur") and item:hasTag("ATInsect")) or (player:HasTrait("AT_FoodMotivated") and item:getFullType() == "base.DogfoodOpen")
    then
        foodUnhappyChange = 0;
    end
    if player:HasTrait("AT_FoodMotivated")
    then
        foodUnhappyChange = foodUnhappyChange - SandboxVars.AnthroTraits.AT_FoodMotivatedBonus;
    end

    local newFoodHungerChange = (foodHungerChange + (foodHungerChange * statModifier));
    local newFoodThirstChange = (foodThirstChange + (foodThirstChange * statModifier));
    local newFoodEndChange = (foodEndChange + (foodEndChange * statModifier));
    local newFoodStressChange = (foodStressChange + (foodStressChange * statModifier));
    local newFoodBoredomChange = (foodBoredomChange - (foodBoredomChange * statModifier));
    local newFoodUnhappyChange = (foodUnhappyChange - (foodUnhappyChange * statModifier));
    local newFoodCalories = (foodCalories + (foodCalories * statModifier));

    if foodName ~= nil
    then
        table.insert(returnTable, foodName);
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
    if foodHungerChange ~= nil and foodHungerChange ~= 0
    then
        table.insert(returnTable, getText("Tooltip_food_Hunger")..":"..this.getTooltipValueColor(foodHungerChange, newFoodHungerChange, true)..this.getTooltipValueSymbol(newFoodHungerChange)..string.format("%3.1f",(newFoodHungerChange * 100)));
    end
    if foodThirstChange ~= nil and foodThirstChange ~= 0
    then
        table.insert(returnTable, getText("Tooltip_food_Thirst")..":"..this.getTooltipValueColor(foodThirstChange, newFoodThirstChange, true)..this.getTooltipValueSymbol(newFoodThirstChange)..string.format("%3.1f",(newFoodThirstChange * 100)));
    end
    if foodEndChange ~= nil and foodEndChange ~=0
    then
        table.insert(returnTable, getText("Tooltip_food_Endurance")..":"..this.getTooltipValueColor(foodEndChange, newFoodEndChange, false)..this.getTooltipValueSymbol(newFoodEndChange)..string.format("%3.1f",(newFoodEndChange * 100)));
    end
    if foodStressChange ~= nil and foodStressChange ~=0
    then
        table.insert(returnTable, getText("Tooltip_food_Stress")..":"..this.getTooltipValueColor(foodStressChange, newFoodStressChange, true)..this.getTooltipValueSymbol(newFoodStressChange)..string.format("%3.1f",newFoodStressChange));
    end
    if foodBoredomChange ~= nil and foodBoredomChange ~=0
    then
        table.insert(returnTable, getText("Tooltip_food_Boredom")..":"..this.getTooltipValueColor(foodBoredomChange, newFoodBoredomChange, true)..this.getTooltipValueSymbol(newFoodBoredomChange)..string.format("%3.1f",newFoodBoredomChange));
    end
    if foodUnhappyChange ~= nil and foodUnhappyChange ~=0
    then
        table.insert(returnTable, getText("Tooltip_food_Unhappiness")..":"..this.getTooltipValueColor(foodUnhappyChange, newFoodUnhappyChange, true)..this.getTooltipValueSymbol(newFoodUnhappyChange)..string.format("%3.1f",newFoodUnhappyChange));
    end
    if item:isPackaged() or player:HasTrait("Nutritionist") or player:HasTrait("Nutritionist2")
    then
        if foodCalories ~= nil and foodCalories ~= 0
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
            table.insert(returnTable, "%Red%"..getText("Tooltip_food_Dangerous_uncooked"));
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
    return returnTable;
end


return AnthroTraitsUtilities;