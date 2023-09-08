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


AnthroTraitsUtilities.BuildFoodDescription = function(player, description, item, statModifier)
    local this = AnthroTraitsUtilities;
    local returnTable = {}

    local foodName = item:getName();
    local foodID = item:getFullType();
    local foodIngredients = item:getExtraItems();
    local foodIngredientTags;
    local encumbrance = item:getActualWeight();
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

    if (player:HasTrait("AT_Bug_o_ssieur") and item:hasTag("ATInsect")) or (player:HasTrait("AT_FoodMotivated") and item:getFullType() == "base.DogfoodOpen")
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
    local newFoodBoredomChange = (foodBoredomChange + (foodBoredomChange * statModifier));
    local newFoodUnhappyChange = (foodUnhappyChange + (foodUnhappyChange * statModifier));
    local newFoodCalories = (foodCalories + (foodCalories * statModifier));

    if foodBoredomChange > 0
    then
        newFoodBoredomChange = (foodBoredomChange + (foodBoredomChange * (statModifier * -1)));
    end
    if foodUnhappyChange > 0
    then
        newFoodUnhappyChange = (foodUnhappyChange + (foodUnhappyChange * (statModifier * -1)));
    end
    if foodID == "Base.DogfoodOpen" and player:HasTrait("AT_FoodMotivated")
    then
        newFoodUnhappyChange = -SandboxVars.AnthroTraits.AT_FoodMotivatedBonus;
    end

    if foodName ~= nil
    then
        if item:isRotten() and not player:HasTrait("AT_CarrionEater")
        then
            table.insert(returnTable, "%Red%"..foodName);
        elseif item:isRotten() and player:HasTrait("AT_CarrionEater")
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

    if item:hasTag("ATFeralPoison") and player:HasTrait("AT_FeralDigestion")
    then
        table.insert(returnTable, 2, "%Violet%This food is poisonous to you!")
        --table.insert(returnTable, 2, "%Violet%This food is poisonous to you! ("..string.format("%3.2f",feralDigestionPoisonAmount / bleachPoisonAmt).." full bleach bottle(s))")
    elseif player:HasTrait("AT_FeralDigestion") and foodIngredients ~= nil
    then
        for i = 0, foodIngredients:size() -1
        do
            foodIngredientTags = getScriptManager():getItem(foodIngredients:get(i)):getTags()
            if foodIngredientTags:contains("ATFeralPoison")
            then
                totalPoisonPower = totalPoisonPower + baseFeralDigestionPoisonAmount;
            end
        end
    end
    if totalPoisonPower ~= 0
    then
        table.insert(returnTable, 2, "%Violet%This food is poisonous to you!")
        --table.insert(returnTable, 2, "%Violet%This food is poisonous to you! ("..string.format("%3.2f",totalPoisonPower / bleachPoisonAmt).." full bleach bottle(s))")
    end
    return returnTable;
end


return AnthroTraitsUtilities;