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
-- fallback exclaimer phrases
AnthroTraitsUtilities.GenericExclaimPhrases = {"AAAH!", "AAAH!", "AAAH!!", "AEIEEEE!", "EAAH!", "AAAGH!"}
AnthroTraitsUtilities.ExclaimPhrases = { }
-- moved to AT_ExclaimerPhrases.txt: allows defining phrases for any trait
--yeen = {"HAHAHAHAHA!", "HAHAHAHAHA!", "HAHAHAHAHA!!", "HUHEHEHEHAHA!", "HAAAAH!", "HEEEHEEEHAHAHAHA!"},
--avian = { "!!♩♪-♩♪-♩♪!!", "!!♫♩♪-♫♩♪!!", "!!♪♫♩-♪♫♩!!", "!!♫♫♩♫!!" } sadly these symbols don't work in-game :(

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

AnthroTraitsUtilities.ImportExclaimerPhrases = function()
	local reader = getModFileReader("\\".. AnthroTraitsGlobals.ModID, "AT_ExclaimerPhrases.txt", false);
	if reader
	then
		local line = reader:readLine()
		while line ~= nil
		do
			local traitName = nil
			local phrases = { }
			for word in string.gmatch(line, "[^;]+") do
				if traitName == nil
				then
					traitName = word
				else
					table.insert(phrases, word)
				end
			end
			local trait = CharacterTrait.get(ResourceLocation.of(traitName))
			if trait ~= nil and #phrases > 0
			then
				AnthroTraitsUtilities.ExclaimPhrases[trait] = phrases
			end
			line = reader:readLine()
		end
		reader:close()
	end
end

AnthroTraitsUtilities.ExportFoodGuideFiles = function()

    local allItems = getScriptManager():getAllItems();
    local unusedFood = {};
    local line;

    local CarnItems = getScriptManager():getItemsTag(AnthroTraitsGlobals.FoodTags.CARNIVORE);
    local HerbItems = getScriptManager():getItemsTag(AnthroTraitsGlobals.FoodTags.HERBIVORE);
    local BugItems = getScriptManager():getItemsTag(AnthroTraitsGlobals.FoodTags.INSECT);
    local PoisItems = getScriptManager():getItemsTag(AnthroTraitsGlobals.FoodTags.FERALPOISON);

    for i = 0, allItems:size() -1
    do
        local foundItem = allItems:get(i);
        if foundItem:getItemType() == ItemType.FOOD --(foundItem:getDisplayCategory() == "Food" or foundItem:getItemType() == ItemType.FOOD)
        then
            if CarnItems:contains(foundItem)
            then
            elseif HerbItems:contains(foundItem)
            then
            elseif BugItems:contains(foundItem)
            then
            elseif PoisItems:contains(foundItem)
            then
            else
                table.insert(unusedFood, foundItem);
            end
        end
    end

    local writer1 = getModFileWriter("\\"..AnthroTraitsGlobals.ModID, "AT_Carnivore_Items.txt", false, false);
    for i = 0, CarnItems:size() -1
    do
        line = CarnItems:get(i):getFullName()..";";
        writer1:writeln(line);
    end
    writer1:close();

    local writer2 = getModFileWriter("\\"..AnthroTraitsGlobals.ModID, "AT_Herbivore_Items.txt", false, false);
    for i = 0, HerbItems:size() -1
    do
        line = HerbItems:get(i):getFullName()..";";
        writer2:writeln(line);
    end
    writer2:close();

    local writer3 = getModFileWriter("\\"..AnthroTraitsGlobals.ModID, "AT_Insect_Items.txt", false, false);
    for i = 0, BugItems:size() -1
    do
        line = BugItems:get(i):getFullName()..";";
        writer3:writeln(line);
    end
    writer3:close();

    local writer4 = getModFileWriter("\\"..AnthroTraitsGlobals.ModID, "AT_FeralPoison_Items.txt", false, false);
    for i = 0, PoisItems:size() -1
    do
        line = PoisItems:get(i):getFullName()..";";
        writer4:writeln(line);
    end
    writer4:close();

    local writer = getModFileWriter("\\"..AnthroTraitsGlobals.ModID, "Unused_Food_Items.txt", false, false);
    for _, tableEntry in ipairs(unusedFood)
    do
        line = tableEntry:getFullName()..";";
        writer:writeln(line);
    end;
    writer:close();
end

AnthroTraitsUtilities.AddItemTagToItemsFromSandbox = function(itemList, tag)
    local ATU = AnthroTraitsUtilities;

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
                    print("tag "..tag:toString().." added to "..tableEntry);
                end
            end
        else
            print("Cannot find item "..tableEntry.." to add tag "..tag:toString());
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
        color = "%White%";
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
    local ATU = AnthroTraitsUtilities;
    local modifiers = {
        multHunger = 0,
        multThirst = 0,
        multEndurance = 0,
        multStress = 0,
        multBoredom = 0,
        multUnhappiness = 0,
        multCalories = 0,
    }

    local foodVoreType = ATU.FoodVoreType(food);

	print("AT eating " .. foodVoreType:toString())

    if foodVoreType == nil
    then
        --do nothing
    elseif foodVoreType == AnthroTraitsGlobals.FoodTags.HERBIVORE 
    then
        if character:hasTrait(AnthroTraitsGlobals.CharacterTrait.CARNIVORE)
        then

            modifiers.multHunger = SandboxVars.AnthroTraits.AT_CarnivoreMalus;
            modifiers.multThirst = SandboxVars.AnthroTraits.AT_CarnivoreMalus;
            modifiers.multEndurance = SandboxVars.AnthroTraits.AT_CarnivoreMalus;
            modifiers.multStress = SandboxVars.AnthroTraits.AT_CarnivoreMalus;
            modifiers.multBoredom = SandboxVars.AnthroTraits.AT_CarnivoreMalus;
            modifiers.multUnhappiness = SandboxVars.AnthroTraits.AT_CarnivoreMalus;
            modifiers.multCalories = SandboxVars.AnthroTraits.AT_CarnivoreMalus;
        elseif character:hasTrait(AnthroTraitsGlobals.CharacterTrait.HERBIVORE)
        then
            modifiers.multHunger = SandboxVars.AnthroTraits.AT_HerbivoreBonus;
            modifiers.multThirst = SandboxVars.AnthroTraits.AT_HerbivoreBonus;
            modifiers.multEndurance = SandboxVars.AnthroTraits.AT_HerbivoreBonus;
            modifiers.multStress = SandboxVars.AnthroTraits.AT_HerbivoreBonus;
            modifiers.multBoredom = SandboxVars.AnthroTraits.AT_HerbivoreBonus;
            modifiers.multUnhappiness = SandboxVars.AnthroTraits.AT_HerbivoreBonus;
            modifiers.multCalories = SandboxVars.AnthroTraits.AT_HerbivoreBonus;
        end
    elseif foodVoreType == AnthroTraitsGlobals.FoodTags.CARNIVORE 
    then
        if character:hasTrait(AnthroTraitsGlobals.CharacterTrait.HERBIVORE)
        then
            modifiers.multHunger = SandboxVars.AnthroTraits.AT_HerbivoreMalus;
            modifiers.multThirst = SandboxVars.AnthroTraits.AT_HerbivoreMalus;
            modifiers.multEndurance = SandboxVars.AnthroTraits.AT_HerbivoreMalus;
            modifiers.multStress = SandboxVars.AnthroTraits.AT_HerbivoreMalus;
            modifiers.multBoredom = SandboxVars.AnthroTraits.AT_HerbivoreMalus;
            modifiers.multUnhappiness = SandboxVars.AnthroTraits.AT_HerbivoreMalus;
            modifiers.multCalories = SandboxVars.AnthroTraits.AT_HerbivoreMalus;
        elseif character:hasTrait(AnthroTraitsGlobals.CharacterTrait.CARNIVORE) and character:hasTrait(AnthroTraitsGlobals.CharacterTrait.CARRIONEATER) and food:IsRotten()
        then
            modifiers.multHunger = SandboxVars.AnthroTraits.AT_CarnivoreBonus + SandboxVars.AnthroTraits.AT_CarrionEaterBonus;
            modifiers.multThirst = SandboxVars.AnthroTraits.AT_CarnivoreBonus + SandboxVars.AnthroTraits.AT_CarrionEaterBonus;
            modifiers.multCalories = SandboxVars.AnthroTraits.AT_CarnivoreBonus + SandboxVars.AnthroTraits.AT_CarrionEaterBonus;
        elseif character:hasTrait(AnthroTraitsGlobals.CharacterTrait.CARNIVORE)
        then
            modifiers.multHunger = SandboxVars.AnthroTraits.AT_CarnivoreBonus;
            modifiers.multThirst = SandboxVars.AnthroTraits.AT_CarnivoreBonus;
            modifiers.multEndurance = SandboxVars.AnthroTraits.AT_CarnivoreBonus;
            modifiers.multStress = SandboxVars.AnthroTraits.AT_CarnivoreBonus;
            modifiers.multBoredom = SandboxVars.AnthroTraits.AT_CarnivoreBonus;
            modifiers.multUnhappiness = SandboxVars.AnthroTraits.AT_CarnivoreBonus;
            modifiers.multCalories = SandboxVars.AnthroTraits.AT_CarnivoreBonus;
        elseif character:hasTrait(AnthroTraitsGlobals.CharacterTrait.CARRIONEATER) and food:IsRotten()
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

    local origHungerChange;
    local origThirstChange;
    local origEndChange;
    local origStressChange;
    local origBoredomChange;
    local origUnhappyChange;
    local origFoodCalories;

    if food:getFluidContainer() ~= nil
    then
        local fluid = food:getFluidContainer():getProperties();
        origHungerChange = fluid:getHungerChange() or 0;
        origThirstChange = fluid:getThirstChange() or 0;
        origEndChange = fluid:getEnduranceChange() or 0;
        origStressChange = fluid:getStressChange() or 0;
        -- no boredom in fluid properties
        origBoredomChange = 0;
        origUnhappyChange = fluid:getUnhappyChange() or 0;
        origFoodCalories = fluid:getCalories() or 0;
    else
        origHungerChange = food:getHungerChange() or 0;
        origThirstChange = food:getThirstChange() or 0;
        origEndChange = food:getEnduranceChange() or 0;
        origStressChange = food:getStressChange() or 0;
        origBoredomChange = food:getBoredomChange() or 0;
        origUnhappyChange = food:getUnhappyChange() or 0;
        origFoodCalories = food:getCalories() or 0;
    end    
    

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

    if (character:hasTrait(AnthroTraitsGlobals.CharacterTrait.BUG_O_SSIEUR) and food:hasTag(AnthroTraitsGlobals.FoodTags.INSECT)) or (character:hasTrait(AnthroTraitsGlobals.CharacterTrait.CARRIONEATER) and food:hasTag(AnthroTraitsGlobals.FoodTags.CARNIVORE) and (food:HowRotten() > 0))
    then
        extraFoodUnhappyChange = extraFoodUnhappyChange - origUnhappyChange;
        extraFoodBoredomChange =  extraFoodBoredomChange - origBoredomChange;
    end

    if (character:hasTrait(AnthroTraitsGlobals.CharacterTrait.FOODMOTIVATED) and foodID == "Base.DogfoodOpen")
    then
        extraFoodBoredomChange =  extraFoodUnhappyChange - SandboxVars.AnthroTraits.AT_FoodMotivatedBonus;
        extraFoodUnhappyChange =  extraFoodUnhappyChange - (50 + SandboxVars.AnthroTraits.AT_FoodMotivatedBonus);
    elseif character:hasTrait(AnthroTraitsGlobals.CharacterTrait.FOODMOTIVATED)
    then
        extraFoodBoredomChange = extraFoodBoredomChange - SandboxVars.AnthroTraits.AT_FoodMotivatedBonus;
        extraFoodUnhappyChange = extraFoodUnhappyChange - SandboxVars.AnthroTraits.AT_FoodMotivatedBonus;
    end

    if character:hasTrait(AnthroTraitsGlobals.CharacterTrait.FERALDIGESTION)
    then
        local maxPoisonAmt = SandboxVars.AnthroTraits.AT_FeralDigestionPoisonAmt
        if food:getFluidContainer() ~= nil and not food:getFluidContainer():isEmpty()
        then
            if food:getFluidContainer():getPrimaryFluid():isCategory(FluidCategory.Alcoholic)
            then
                extraPoison = maxPoisonAmt;
            end
        elseif food:getExtraItems() ~= nil
        then
            local foodIngredients = food:getExtraItems()
            for i = 0, foodIngredients:size() - 1
            do
                local foodIngredientTags = getScriptManager():getItem(foodIngredients:get(i)):getTags()
                if foodIngredientTags:contains("ATFeralPoison")
                then
                    extraPoison = extraPoison + maxPoisonAmt;
                end
            end
        elseif food:hasTag(AnthroTraitsGlobals.FoodTags.FERALPOISON)
        then
            extraPoison = maxPoisonAmt;
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
    local ATU = AnthroTraitsUtilities;
    local returnTable = {}

    local foodName = item:getName();
    local foodID = item:getFullType();
    local foodIngredients = item:getExtraItems();
    local foodIngredientTags;
    local encumbrance = item:getActualWeight();
    local stackEncum = item:getCount() * encumbrance;
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

    local foodChanges = ATU.CalculateFoodChanges(player, item)

    local newFoodHungerChange = foodHungerChange + foodChanges.addHungerChange;
    local newFoodThirstChange = foodThirstChange + foodChanges.addThirstChange;
    local newFoodEndChange = foodEndChange + foodChanges.addEndChange;
    local newFoodStressChange = foodStressChange + foodChanges.addStressChange;
    local newFoodBoredomChange = foodBoredomChange + foodChanges.addBoredomChange;
    local newFoodUnhappyChange = foodUnhappyChange + foodChanges.addUnhappyChange;
    local newFoodCalories = foodCalories + foodChanges.addCalories;


    if foodName ~= nil
    then
        if foodChanges.addPoison ~= nil and foodChanges.addPoison > 0
        then
            table.insert(returnTable, "%Violet%"..foodName);
        elseif item:IsRotten() and not player:hasTrait(AnthroTraitsGlobals.CharacterTrait.CARRIONEATER)
        then
            table.insert(returnTable, "%Red%"..foodName);
        elseif item:IsRotten() and item:hasTag(AnthroTraitsGlobals.FoodTags.CARNIVORE) and player:hasTrait(AnthroTraitsGlobals.CharacterTrait.CARRIONEATER)
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
        table.insert(returnTable, getText("Tooltip_item_Weight")..":%White%"..string.format("%5.1f", encumbrance))
    end
    if encumbrance ~= nil and item:getCount() > 1
    then
        table.insert(returnTable, getText("Tooltip_item_StackWeight")..":%White%"..string.format("%5.1f", stackEncum))
    end
    if newFoodHungerChange ~= 0
    then
        table.insert(returnTable, getText("Tooltip_food_Hunger")..":"..ATU.getTooltipValueColor(foodHungerChange, newFoodHungerChange, true)..ATU.getTooltipValueSymbol(newFoodHungerChange)..string.format("%3.1f",(newFoodHungerChange * 100)));
    end
    if newFoodThirstChange ~= 0
    then
        table.insert(returnTable, getText("Tooltip_food_Thirst")..":"..ATU.getTooltipValueColor(foodThirstChange, newFoodThirstChange, true)..ATU.getTooltipValueSymbol(newFoodThirstChange)..string.format("%3.1f",(newFoodThirstChange * 100)));
    end
    if newFoodEndChange ~= 0
    then
        table.insert(returnTable, getText("Tooltip_food_Endurance")..":"..ATU.getTooltipValueColor(foodEndChange, newFoodEndChange, false)..ATU.getTooltipValueSymbol(newFoodEndChange)..string.format("%3.1f",(newFoodEndChange * 100)));
    end
    if newFoodStressChange ~= 0
    then
        table.insert(returnTable, getText("Tooltip_food_Stress")..":"..ATU.getTooltipValueColor(foodStressChange, newFoodStressChange, true)..ATU.getTooltipValueSymbol(newFoodStressChange)..string.format("%3.1f",newFoodStressChange));
    end
    if newFoodBoredomChange ~= 0
    then
        table.insert(returnTable, getText("Tooltip_food_Boredom")..":"..ATU.getTooltipValueColor(foodBoredomChange, newFoodBoredomChange, true)..ATU.getTooltipValueSymbol(newFoodBoredomChange)..string.format("%3.1f",newFoodBoredomChange));
    end
    if newFoodUnhappyChange ~= 0
    then
        table.insert(returnTable, getText("Tooltip_food_Unhappiness")..":"..ATU.getTooltipValueColor(foodUnhappyChange, newFoodUnhappyChange, true)..ATU.getTooltipValueSymbol(newFoodUnhappyChange)..string.format("%3.1f",newFoodUnhappyChange));
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
    elseif not instanceof(item, "ComboItem") and item:getFreezingTime() > 0 and item:getFreezingTime() < 100
    then
        if item:isThawing()
        then
            table.insert(returnTable, getText("IGUI_invpanel_Melting").."|".."%Green%"..string.format("%3.2f", item:getFreezingTime() / 100));
        else
            table.insert(returnTable, getText("IGUI_invpanel_FreezingTime").."|".."%Green%"..string.format("%3.2f", item:getFreezingTime() / 100));
        end
    end
    if not instanceof(item, "ComboItem") and item:isPackaged() or player:hasTrait(CharacterTrait.NUTRITIONIST) or player:hasTrait(CharacterTrait.NUTRITIONIST2)
    then
        if foodCalories ~= nil and (foodCalories + newFoodCalories) ~= 0
        then
            table.insert(returnTable, getText("Tooltip_food_Calories")..":"..ATU.getTooltipValueColor(foodCalories, newFoodCalories, false)..string.format("%5.1f", newFoodCalories));
        end
        if foodCarbs ~= nil and foodCarbs ~= 0
        then
            table.insert(returnTable, getText("Tooltip_food_Carbs")..":%White%"..string.format("%5.1f",foodCarbs));
        end
        if foodProtein ~= nil and foodProtein ~= 0
        then
            table.insert(returnTable, getText("Tooltip_food_Prots")..":%White%"..string.format("%5.1f",foodProtein));
        end
        if foodFat ~= nil and foodFat ~= 0
        then
            table.insert(returnTable, getText("Tooltip_food_Fat")..":%White%"..string.format("%5.1f",foodFat));
        end
    end
    if not instanceof(item, "ComboItem") and item:isbDangerousUncooked() and not item:isCooked() and not item:isBurnt()
    then
        if item:hasTag(ItemTag.EGG)
        then
            table.insert(returnTable, "%LavenderBlush%"..getText("Tooltip_food_SlightDanger_uncooked"));
        else
            if ((player:hasTrait(AnthroTraitsGlobals.CharacterTrait.CARNIVORE) and item:hasTag(AnthroTraitsGlobals.FoodTags.CARNIVORE) and not item:IsRotten())
                    or (player:hasTrait(AnthroTraitsGlobals.CharacterTrait.HERBIVORE) and item:hasTag(AnthroTraitsGlobals.FoodTags.HERBIVORE) and not item:IsRotten())
                    or (player:hasTrait(AnthroTraitsGlobals.CharacterTrait.CARRIONEATER)))
            then
                --do nothing
            else
                table.insert(returnTable, "%Red%"..getText("Tooltip_food_Dangerous_uncooked"));
            end
        end
    end
    if not instanceof(item, "ComboItem") and (item:isGoodHot() or item:isBadCold()) and item:getHeat() < 1.3
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

AnthroTraitsUtilities.BuildFluidContainerDescription = function(player, description, item, statModifier)
    local ATU = AnthroTraitsUtilities;
    local returnTable = {}

    local foodName = item:getName();
    local encumbrance = item:getActualWeight();
    local stackEncum = item:getCount() * encumbrance;
    local fluidContainer = item:getFluidContainer();
    local numFluids = 0;
    local amount = fluidContainer:getAmount() * 1000;
    local capacity = fluidContainer:getCapacity() * 1000;
    local color = fluidContainer:getColor();
    local filledPct = fluidContainer:getFilledRatio();
    local fluid = item:getFluidContainer():getProperties();
    
    local foodThirstChange = fluid:getThirstChange();
    local foodHungerChange = fluid:getHungerChange();
    local foodEndChange = fluid:getEnduranceChange();
    local foodStressChange = fluid:getStressChange();
    --no boredom change yet
    local foodBoredomChange = 0;
    local foodUnhappyChange = fluid:getUnhappyChange();

    local foodCalories = fluid:getCalories();
    local foodCarbs = fluid:getCarbohydrates();
    local foodProtein = fluid:getProteins();
    local foodFat = fluid:getLipids();
    -- will this even be a thing?
    local foodCookedMicrowave = false;
        --foodCookedMicrowave = fluid:isCookedInMicrowave();

    local currCookTime = item:getCookingTime();
    local minutesTillCooked = item:getMinutesToCook();
    local minutesTillBurned = item:getMinutesToBurn();

    local foodChanges = ATU.CalculateFoodChanges(player, item)

    local newFoodHungerChange = foodHungerChange + foodChanges.addHungerChange;
    local newFoodThirstChange = foodThirstChange + foodChanges.addThirstChange;
    local newFoodEndChange = foodEndChange + foodChanges.addEndChange;
    local newFoodStressChange = foodStressChange + foodChanges.addStressChange;
    local newFoodBoredomChange = foodBoredomChange + foodChanges.addBoredomChange;
    local newFoodUnhappyChange = foodUnhappyChange + foodChanges.addUnhappyChange;
    local newFoodCalories = foodCalories + foodChanges.addCalories;


    if foodName ~= nil
    then
        if foodChanges.addPoison ~= nil and foodChanges.addPoison > 0
        then
            table.insert(returnTable, "%Violet%"..foodName);
        elseif item:IsRotten()
        then
            table.insert(returnTable, "%Red%"..foodName);
        else
            table.insert(returnTable, foodName);
        end
        table.insert(returnTable, description);
        table.insert(returnTable, ""); --spacer line
    end


    if encumbrance ~= nil
    then
        table.insert(returnTable, getText("Tooltip_item_Weight")..":%White%"..string.format("%5.1f", encumbrance));
    end
    if encumbrance ~= nil and item:getCount() > 1
    then
        table.insert(returnTable, getText("Tooltip_item_StackWeight")..":%White%"..string.format("%5.1f", stackEncum));
    end
    if amount ~= nil
    then
        table.insert(returnTable, getText("Fluid_Amount")..":%White%"..string.format("%6.0f/%6.0f mL", amount, capacity));
    end
    if amount ~= nil
    then
        table.insert(returnTable, getText("Fluid_Properties_Per"));
    end
    if newFoodThirstChange ~= 0
    then
        table.insert(returnTable, "%DarkKhaki%"..getText("Tooltip_food_Thirst")..":"..ATU.getTooltipValueColor(foodThirstChange, newFoodThirstChange, true)..ATU.getTooltipValueSymbol(newFoodThirstChange)..string.format("%3.1f",newFoodThirstChange));
    end
    if newFoodHungerChange ~= 0
    then
        table.insert(returnTable, "%DarkKhaki%"..getText("Tooltip_food_Hunger")..":"..ATU.getTooltipValueColor(foodHungerChange, newFoodHungerChange, true)..ATU.getTooltipValueSymbol(newFoodHungerChange)..string.format("%3.1f",newFoodHungerChange));
    end
    if newFoodEndChange ~= 0
    then
        table.insert(returnTable, "%DarkKhaki%"..getText("Tooltip_food_Endurance")..":"..ATU.getTooltipValueColor(foodEndChange, newFoodEndChange, false)..ATU.getTooltipValueSymbol(newFoodEndChange)..string.format("%3.1f",newFoodEndChange));
    end
    if newFoodStressChange ~= 0
    then
        table.insert(returnTable, "%DarkKhaki%"..getText("Tooltip_food_Stress")..":"..ATU.getTooltipValueColor(foodStressChange, newFoodStressChange, true)..ATU.getTooltipValueSymbol(newFoodStressChange)..string.format("%3.1f",newFoodStressChange));
    end
    if newFoodBoredomChange ~= 0
    then
        table.insert(returnTable, "%DarkKhaki%"..getText("Tooltip_food_Boredom")..":"..ATU.getTooltipValueColor(foodBoredomChange, newFoodBoredomChange, true)..ATU.getTooltipValueSymbol(newFoodBoredomChange)..string.format("%3.1f",newFoodBoredomChange));
    end
    if newFoodUnhappyChange ~= 0
    then
        table.insert(returnTable, "%DarkKhaki%"..getText("Tooltip_food_Unhappiness")..":"..ATU.getTooltipValueColor(foodUnhappyChange, newFoodUnhappyChange, true)..ATU.getTooltipValueSymbol(newFoodUnhappyChange)..string.format("%3.1f",newFoodUnhappyChange));
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
    elseif not instanceof(item, "ComboItem") and item:getFreezingTime() > 0 and item:getFreezingTime() < 100
    then
        if item:isThawing()
        then
            table.insert(returnTable, getText("IGUI_invpanel_Melting").."|".."%Green%"..string.format("%3.2f", item:getFreezingTime() / 100));
        else
            table.insert(returnTable, getText("IGUI_invpanel_FreezingTime").."|".."%Green%"..string.format("%3.2f", item:getFreezingTime() / 100));
        end
    end
    if (not instanceof(item, "ComboItem") and item:isPackaged()) or player:hasTrait(CharacterTrait.NUTRITIONIST) or player:hasTrait(CharacterTrait.NUTRITIONIST2)
    then
        if foodCalories ~= nil and (foodCalories + newFoodCalories) ~= 0
        then
            table.insert(returnTable, "%DarkKhaki%"..getText("Tooltip_food_Calories")..":"..ATU.getTooltipValueColor(foodCalories, newFoodCalories, false)..string.format("%5.1f", newFoodCalories));
        end
        if foodCarbs ~= nil and foodCarbs ~= 0
        then
            table.insert(returnTable, "%DarkKhaki%"..getText("Tooltip_food_Carbs")..":%Gainsboro%"..string.format("%5.1f",foodCarbs));
        end
        if foodProtein ~= nil and foodProtein ~= 0
        then
            table.insert(returnTable, "%DarkKhaki%"..getText("Tooltip_food_Prots")..":%Gainsboro%"..string.format("%5.1f",foodProtein));
        end
        if foodFat ~= nil and foodFat ~= 0
        then
            table.insert(returnTable, "%DarkKhaki%"..getText("Tooltip_food_Fat")..":%Gainsboro%"..string.format("%5.1f",foodFat));
        end
    end
    if foodChanges.addPoison ~= nil and foodChanges.addPoison > 0
    then
        table.insert(returnTable, 2, "%Violet%This food is poisonous to you!")
        --table.insert(returnTable, 2, "%Violet%This food is poisonous to you! ("..string.format("%3.2f",feralDigestionPoisonAmount / bleachPoisonAmt).." full bleach bottle(s))")
    end
    return returnTable;
end

AnthroTraitsUtilities.FoodVoreType = function(food)
    --get items in the recipe, if it's a recipe
	local hasIngredients = food:haveExtraItems()
    local tags = {}

    --get all tags relating to food, and init table with ItemTag keys so their count can be added to
    for i = 1, #(AnthroTraitsGlobals.EvolvedRecipeFoodTags)
    do
        tags[AnthroTraitsGlobals.EvolvedRecipeFoodTags[i]] = 0;
    end

    if hasIngredients
    then
		local ingredients = food:getExtraItems();
        local tagWithLargestCount = nil;
        local tagWithLargestCountCount = 0;

        --for each ingredient...
        for i = 0, ingredients:size() - 1
        do
            -- for each tag...
            for tag, _ in pairs(tags)
            do
                --if the ingredient has this tag, up the count for that key in tags
                local ingredient = ingredients:get(i);
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
        end

        --if the largest count tag is present on greater than 50% of the recipe's items...
        if tagWithLargestCountCount / ingredients:size() > .5
        then
            --return the tag, so it can be handled appropriately when eaten.
            return tagWithLargestCount;
        else
            return nil;
        end
    else
		--here, food must be single item
        for tag, _ in pairs(tags)
        do
            if food:hasTag(tag)
            then
                return tag;
            end
        end
    end
end


-- AnthroTraitsUtilities.IsAnthro = function(gameCharacter)
    -- -- if (getActivatedMods():contains("\\FurryMod") or getActivatedMods():contains("\\FurryApocalypse")) and gameCharacter ~= nil
    -- -- then
        -- -- local hasFur = false;
        -- -- local itemVisuals = gameCharacter:getItemVisuals();
        -- -- if itemVisuals ~= nil
        -- -- then
            -- -- for i=0, itemVisuals:size() - 1
            -- -- do
                -- -- local itemVisual = itemVisuals:get(i);
                -- -- local item =  itemVisual:getScriptItem();
                -- -- if item ~= nil and (item:hasTag("Fur") or item:hasTag("DeceasedFur"))
                -- -- then
                    -- -- hasFur = true;
                    -- -- break;
                -- -- end
            -- -- end;
        -- -- end 
        -- -- return hasFur;
    -- -- else
        -- -- return false;
    -- -- end
	
	-- return false
-- end

return AnthroTraitsUtilities;