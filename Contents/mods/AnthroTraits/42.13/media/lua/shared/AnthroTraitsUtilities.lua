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

AnthroTraitsUtilities.Sign = function(number)
	return (number > 0 and 1) or (number == 0 and 0) or -1
end

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
                    DebugLog.log("tag "..tag:toString().." added to "..tableEntry);
                end
            end
        else
            DebugLog.log("Cannot find item "..tableEntry.." to add tag "..tag:toString());
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
    local modifiers = { }

    local this = AnthroTraitsUtilities
    local foodVoreType = this.FoodVoreType(food)

	local mod = 0
	local modCarrion = 0
	if foodVoreType == AnthroTraitsGlobals.FoodTags.HERBIVORE 
    then
		if character:hasTrait(AnthroTraitsGlobals.CharacterTrait.HERBIVORE)
		then
			mod = SandboxVars.AnthroTraits.AT_HerbivoreBonus
		elseif character:hasTrait(AnthroTraitsGlobals.CharacterTrait.CARNIVORE)
		then
			mod = SandboxVars.AnthroTraits.AT_CarnivoreMalus
		end
    elseif foodVoreType == AnthroTraitsGlobals.FoodTags.CARNIVORE
    then
        if character:hasTrait(AnthroTraitsGlobals.CharacterTrait.HERBIVORE)
        then
			mod = SandboxVars.AnthroTraits.AT_HerbivoreMalus
        elseif character:hasTrait(AnthroTraitsGlobals.CharacterTrait.CARNIVORE)
        then
			mod = SandboxVars.AnthroTraits.AT_CarnivoreBonus
		end
		if food:IsRotten() and character:hasTrait(AnthroTraitsGlobals.CharacterTrait.CARRIONEATER)
		then
			modCarrion = SandboxVars.AnthroTraits.AT_CarrionEaterBonus
		end
    end
	for stat, _ in pairs(AnthroTraitsGlobals.FoodCharacterStatInfo) do
		modifiers[stat] = mod
	end
	for _, stat in ipairs(AnthroTraitsGlobals.CarrionFoodCharacterStats) do
		modifiers[stat] = modifiers[stat] + modCarrion
	end
	modifiers.Calories = mod + modCarrion
	modifiers.Carbs = mod + modCarrion
	modifiers.Proteins = mod + modCarrion
	modifiers.Lipids = mod + modCarrion
	-- for now same modifier is applied to every stat
	if mod + modCarrion == 0
	then
		modifiers.foodTooltip = nil	-- no modifiers => use default tooptip (for now)
	else
		modifiers.foodTooltip = this.Sign(mod + modCarrion)
	end
    return modifiers
end


---For extra effects of food.
AnthroTraitsUtilities.CalculateFoodChanges = function(character, food, foodProps)
	local ATGt = AnthroTraitsGlobals.CharacterTrait
    local this = AnthroTraitsUtilities
    local modifiers = AnthroTraitsUtilities.CalculateFoodModifiers(character, food)
	local result = {}

	-- calculate trait related boni/mali
	for stat, info in pairs(AnthroTraitsGlobals.FoodCharacterStatInfo) do
		-- only apply modifier if change is good
		if foodProps[stat] ~= nil and this.Sign(foodProps[stat]) == info.Sign
		then
			result[stat] = foodProps[stat] * modifiers[stat]
		else
			result[stat] = 0
		end
	end
	result[CharacterStat.POISON] = 0
	if foodProps.Calories ~= nil and this.Sign(foodProps.Calories) == 1
	then
		result.Calories = foodProps.Calories * modifiers.Calories
	else
		result.Calories = 0
	end
	if foodProps.Carbs ~= nil and this.Sign(foodProps.Carbs) == 1
	then
		result.Carbs = foodProps.Carbs * modifiers.Carbs
	else
		result.Carbs = 0
	end
	if foodProps.Proteins ~= nil and this.Sign(foodProps.Proteins) == 1
	then
		result.Proteins = foodProps.Proteins * modifiers.Proteins
	else
		result.Proteins = 0
	end
	if foodProps.Lipids ~= nil and this.Sign(foodProps.Lipids) == 1
	then
		result.Lipids = foodProps.Lipids * modifiers.Lipids
	else
		result.Lipids = 0
	end
	result.undoAddedPoison = false
	-- 1 or -1 for more/less nutritious
	-- 0 for no nutritional change but should still create custom Tooltip
	-- -2 for plain bad
	-- nil for vanilla tooltip
	result.foodTooltip = modifiers.foodTooltip
	
	-- process UNHAPPINESS and BOREDOM for certain traits (as long as either character is CARRIONEATER or food is fresh or both)
	if (character:hasTrait(ATGt.CARRIONEATER) and food:hasTag(AnthroTraitsGlobals.FoodTags.CARNIVORE)) or not food:IsRotten()
	then
		-- counteract UNHAPPINESS and BOREDOM for certain trait/food combos
		if (character:hasTrait(ATGt.BUG_O_SSIEUR) and food:hasTag(AnthroTraitsGlobals.FoodTags.INSECT)) or	--BUG_O_SSIEUR doesn't mind eating insects
			(food:IsRotten() and food:hasTag(AnthroTraitsGlobals.FoodTags.CARNIVORE)) or					--CARRIONEATER doesn't mind rotten meat
			(character:hasTrait(ATGt.FOODMOTIVATED) and food:hasTag(AnthroTraitsGlobals.FoodTags.FOODMOTIVATED))	--FOODMOTIVATED doesn't mind eating certain foods
		then
			if this.Sign(foodProps[CharacterStat.UNHAPPINESS]) ~= AnthroTraitsGlobals.FoodCharacterStatInfo[CharacterStat.UNHAPPINESS].Sign
			then
				result[CharacterStat.UNHAPPINESS] = result[CharacterStat.UNHAPPINESS] - foodProps[CharacterStat.UNHAPPINESS]
				result.foodTooltip = result.foodTooltip or 0
			end
			if this.Sign(foodProps[CharacterStat.BOREDOM]) ~= AnthroTraitsGlobals.FoodCharacterStatInfo[CharacterStat.BOREDOM].Sign
			then
				result[CharacterStat.BOREDOM] = result[CharacterStat.BOREDOM] - foodProps[CharacterStat.BOREDOM]
				result.foodTooltip = result.foodTooltip or 0
			end
		end
		-- FOODMOTIVATED really likes eating stuff
		if character:hasTrait(ATGt.FOODMOTIVATED)
		then
			result[CharacterStat.UNHAPPINESS] = result[CharacterStat.UNHAPPINESS] - SandboxVars.AnthroTraits.AT_FoodMotivatedBonus
			result[CharacterStat.BOREDOM] = result[CharacterStat.BOREDOM] - SandboxVars.AnthroTraits.AT_FoodMotivatedBonus
			result.foodTooltip = result.foodTooltip or 0
		end
	end
	
	if character:hasTrait(ATGt.FERALDIGESTION)
    then
        local maxPoisonAmt = SandboxVars.AnthroTraits.AT_FeralDigestionPoisonAmt
        if food:getFluidContainer() ~= nil and not food:getFluidContainer():isEmpty()
        then
			-- ferals can't process alcohol
            if food:getFluidContainer():getPrimaryFluid():isCategory(FluidCategory.Alcoholic)
            then
                result[CharacterStat.POISON] = maxPoisonAmt;
				result.foodTooltip = -2
            end
        elseif food:haveExtraItems()
        then
			-- ferals can't process certain ingredients
            local foodIngredients = food:getExtraItems()
            for i = 0, foodIngredients:size() - 1
            do
                local foodIngredientTags = getScriptManager():getItem(foodIngredients:get(i)):getTags()
                if foodIngredientTags:contains(AnthroTraitsGlobals.FoodTags.FERALPOISON)
                then
                    result[CharacterStat.POISON] = result[CharacterStat.POISON] + maxPoisonAmt;
					result.foodTooltip = -2
                end
            end
        elseif food:hasTag(AnthroTraitsGlobals.FoodTags.FERALPOISON)
        then
			-- ferals can't process certain foods
            result[CharacterStat.POISON] = maxPoisonAmt;
			result.foodTooltip = -2
        end
    end
	-- counteract poison from uncooked food depending on certain traits
	if food:hasTag(AnthroTraitsGlobals.FoodTags.CARNIVORE)
    then
        if (character:hasTrait(ATGt.CARNIVORE) or character:hasTrait(ATGt.CARRIONEATER)) and not food:isRotten()
        then
            if instanceof(character, "IsoPlayer") and not food:isPoison()
            then
                result.undoAddedPoison = true;
            end
        elseif food:isRotten() and character:hasTrait(ATGt.CARRIONEATER)
        then
            if instanceof(character, "IsoPlayer") and not food:isPoison()
            then
                result.undoAddedPoison = true;
            end
        end
    elseif food:hasTag(AnthroTraitsGlobals.FoodTags.HERBIVORE)
    then
        if character:hasTrait(ATGt.HERBIVORE)
        then
            if not food:isRotten()
            then
                if instanceof(character, "IsoPlayer") and not food:isPoison()
                then
					result.undoAddedPoison = true;
                end
            end
        end
    end
	
    return result
end

AnthroTraitsUtilities.GetConsumableProperties = function(item)
	local result = {}
	local consumable
	if item:getFluidContainer() ~= nil
    then
        consumable = item:getFluidContainer():getProperties()
        -- no boredom in fluid properties
        result[CharacterStat.BOREDOM] = 0
    else
		consumable = item
		result[CharacterStat.BOREDOM] = consumable:getBoredomChange() or 0
    end   
	result[CharacterStat.THIRST] = consumable:getThirstChange() or 0
	result[CharacterStat.HUNGER] = consumable:getHungerChange() or 0
	result[CharacterStat.ENDURANCE] = consumable:getEnduranceChange() or 0
	result[CharacterStat.STRESS] = consumable:getStressChange() or 0
	result[CharacterStat.UNHAPPINESS] = consumable:getUnhappyChange() or 0
	result[CharacterStat.FATIGUE] = consumable:getFatigueChange() or 0
	result[CharacterStat.POISON] = consumable:getPoisonPower() or 0
	result.Calories = consumable:getCalories() or 0
	result.Carbs = consumable:getCarbohydrates() or 0
	result.Proteins = consumable:getProteins() or 0
	result.Lipids = consumable:getLipids() or 0
	return result
end

local function AddFoodPropsChanges(foodProps, foodChanges)
	local result = {}
	for stat, _ in pairs(AnthroTraitsGlobals.FoodCharacterStatInfo) do
		result[stat] = foodProps[stat] + foodChanges[stat]
	end
	result[CharacterStat.POISON] = foodProps[CharacterStat.POISON] + foodChanges[CharacterStat.POISON]
	result.Calories = foodProps.Calories + foodChanges.Calories
	result.Carbs = foodProps.Carbs + foodChanges.Carbs
	result.Proteins = foodProps.Proteins + foodChanges.Proteins
	result.Lipids = foodProps.Lipids + foodChanges.Lipids
	return result
end

AnthroTraitsUtilities.BuildFoodDescription = function(player, foodProps, foodChanges, item)
    local this = AnthroTraitsUtilities;
    local returnTable = {}

    local foodName = item:getName();
    local foodID = item:getFullType();
    local foodIngredients = item:getExtraItems();
    local foodIngredientTags;
    local encumbrance = item:getActualWeight();
    local stackEncum = item:getCount() * encumbrance;

    local foodCookedMicrowave = item:isCookedInMicrowave();

    local currCookTime = item:getCookingTime();
    local minutesTillCooked = item:getMinutesToCook();
    local minutesTillBurned = item:getMinutesToBurn();

	local newFoodProps = AddFoodPropsChanges(foodProps, foodChanges)

	local description = nil
	if foodChanges.foodTooltip == 1
	then
		description = "%LightGreen%This food is more nutritious for you."
	elseif foodChanges.foodTooltip == -1
	then
		description = "%LavenderBlush%This food is less nutritious for you."
	end
	
    if foodName ~= nil
    then
        if foodProps[CharacterStat.POISON] > 0
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
	
	for stat, info in pairs(AnthroTraitsGlobals.FoodCharacterStatInfo) do
		if newFoodProps[stat] ~= 0
		then
			table.insert(returnTable, getText("Tooltip_food_" .. info.TooltipName)..":"..this.getTooltipValueColor(foodProps[stat], newFoodProps[stat], info.Sign < 0)..this.getTooltipValueSymbol(newFoodProps[stat])..string.format("%3.1f", newFoodProps[stat] * info.TooltipFactor))
		end
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
        if newFoodProps.Calories ~= 0
        then
            table.insert(returnTable, getText("Tooltip_food_Calories")..":"..this.getTooltipValueColor(foodProps.Calories, newFoodProps.Calories, false)..string.format("%5.1f", newFoodProps.Calories));
        end
        if newFoodProps.Carbs ~= 0
        then
            table.insert(returnTable, getText("Tooltip_food_Carbs")..":"..this.getTooltipValueColor(foodProps.Carbs, newFoodProps.Carbs, false)..string.format("%5.1f", newFoodProps.Carbs));
        end
        if newFoodProps.Proteins ~= 0
        then
            table.insert(returnTable, getText("Tooltip_food_Prots")..":"..this.getTooltipValueColor(foodProps.Proteins, newFoodProps.Proteins, false)..string.format("%5.1f", newFoodProps.Proteins));
        end
        if newFoodProps.Lipids ~= 0
        then
            table.insert(returnTable, getText("Tooltip_food_Fat")..":"..this.getTooltipValueColor(foodProps.Lipids, newFoodProps.Lipids, false)..string.format("%5.1f", newFoodProps.Lipids));
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

    if foodChanges[CharacterStat.POISON] > 0
    then
        table.insert(returnTable, 2, "%Violet%This food is poisonous to you!")
        --table.insert(returnTable, 2, "%Violet%This food is poisonous to you! ("..string.format("%3.2f",feralDigestionPoisonAmount / bleachPoisonAmt).." full bleach bottle(s))")
    end
    return returnTable;
end

AnthroTraitsUtilities.BuildFluidContainerDescription = function(player, description, item)
    local this = AnthroTraitsUtilities;
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


    -- will this even be a thing?
    local foodCookedMicrowave = false;
        --foodCookedMicrowave = fluid:isCookedInMicrowave();

    local currCookTime = item:getCookingTime();
    local minutesTillCooked = item:getMinutesToCook();
    local minutesTillBurned = item:getMinutesToBurn();

	local foodProps = this.GetConsumableProperties(item)
    local foodChanges = this.CalculateFoodChanges(player, item, foodProps)
	local newFoodProps = AddFoodPropsChanges(foodProps, foodChanges)

    if foodName ~= nil
    then
        if foodProps[CharacterStat.POISON] > 0
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
	for stat, info in pairs(AnthroTraitsGlobals.FoodCharacterStatInfo) do
		if newFoodProps[stat] ~= 0
		then
			table.insert(returnTable, "%DarkKhaki%"..getText("Tooltip_food_" .. info.TooltipName)..":"..this.getTooltipValueColor(foodProps[stat], newFoodProps[stat], info.Sign < 0)..this.getTooltipValueSymbol(newFoodProps[stat])..string.format("%3.1f", newFoodProps[stat]))
		end
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
        if newFoodProps.Calories ~= 0
        then
            table.insert(returnTable, "%DarkKhaki%"..getText("Tooltip_food_Calories")..":"..this.getTooltipValueColor(foodProps.Calories, newFoodProps.Calories, false)..string.format("%5.1f", newFoodProps.Calories));
        end
        if newFoodProps.Carbs ~= 0
        then
            table.insert(returnTable, "%DarkKhaki%"..getText("Tooltip_food_Carbs")..":"..this.getTooltipValueColor(foodProps.Carbs, newFoodProps.Carbs, false)..string.format("%5.1f", newFoodProps.Carbs));
        end
        if newFoodProps.Proteins ~= 0
        then
            table.insert(returnTable, "%DarkKhaki%"..getText("Tooltip_food_Prots")..":"..this.getTooltipValueColor(foodProps.Proteins, newFoodProps.Proteins, false)..string.format("%5.1f", newFoodProps.Proteins));
        end
        if newFoodProps.Lipids ~= 0
        then
            table.insert(returnTable, "%DarkKhaki%"..getText("Tooltip_food_Fat")..":"..this.getTooltipValueColor(foodProps.Lipids, newFoodProps.Lipids, false)..string.format("%5.1f", newFoodProps.Lipids));
        end
    end
    if foodProps[CharacterStat.POISON] > 0
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

---comment
---@param bodyDamage BodyDamage
---@param bodyPartType BodyPartType
AnthroTraitsUtilities.HealScratch = function(bodyDamage, bodyPartType)
    local bodyPart = bodyDamage:getBodyPart(bodyPartType)

    bodyPart:setScratched(false, true);
    bodyPart:setScratchTime(0);
    bodyPart:SetScratchedWeapon(false);
    bodyPart:setBleedingTime(0);
	bodyPart:setBleeding(false);
end


---comment
---@param bodyDamage BodyDamage
---@param bodyPartType BodyPartType
AnthroTraitsUtilities.HealLaceration = function(bodyDamage, bodyPartType)
    local bodyPart = bodyDamage:getBodyPart(bodyPartType)

    bodyPart:setCut(false, true);
    bodyPart:setCutTime(0);
    bodyPart:setBleedingTime(0);
	bodyPart:setBleeding(false);
end


---comment
---@param bodyDamage BodyDamage
---@param bodyPartType BodyPartType
AnthroTraitsUtilities.HealBite = function(bodyDamage, bodyPartType)
    local bodyPart = bodyDamage:getBodyPart(bodyPartType)

    bodyPart:setBiteTime(0);
    bodyPart:SetBitten(false, false);
    bodyPart:setBleedingTime(0);
	bodyPart:setBleeding(false);
end



-- overwrites vanilla processing of stats but also avoids clamping issues at 0 and 100
AnthroTraitsUtilities.ApplyFoodChanges = function(character, foodEaten, percentEaten, preCharStats)
	local ATGt = AnthroTraitsGlobals.CharacterTrait
    local this = AnthroTraitsUtilities
	local foodProps = this.GetConsumableProperties(foodEaten)
    local foodChanges = this.CalculateFoodChanges(character, foodEaten, foodProps)
    local charStats = character:getStats()
    local charNutrition = character:getNutrition()
	
	for stat, _ in pairs(AnthroTraitsGlobals.FoodCharacterStatInfo) do
		if foodChanges[stat] ~= 0
		then
			charStats:set(stat, preCharStats[stat] + (foodProps[stat] + foodChanges[stat]) * percentEaten)
		end
	end
    if foodChanges[CharacterStat.POISON] ~= 0
    then
		local newPoisonValue = preCharStats[CharacterStat.POISON] + (foodProps[CharacterStat.POISON] + foodChanges[CharacterStat.POISON]) * percentEaten
        charStats:set(CharacterStat.POISON, newPoisonValue);
		if newPoisonValue > 0
		then
			--b42 specific. Won't trigger dmg unless sick moodle = lvl 1 or up.
			charStats:set(CharacterStat.FOOD_SICKNESS, 55)
		end
    end
	if foodChanges.Calories ~= 0
	then
		charNutrition:setCalories(preCharStats.Calories + (foodProps.Calories + foodChanges.Calories) * percentEaten)
	end
	if foodChanges.Carbs ~= 0
	then
		charNutrition:setCarbohydrates(preCharStats.Carbs + (foodProps.Carbs + foodChanges.Carbs) * percentEaten)
	end
	if foodChanges.Proteins ~= 0
	then
		charNutrition:setProteins(preCharStats.Proteins + (foodProps.Proteins + foodChanges.Proteins) * percentEaten)
	end
	if foodChanges.Lipids ~= 0
	then
		charNutrition:setLipids(preCharStats.Lipids + (foodProps.Lipids + foodChanges.Lipids) * percentEaten)
	end
	-- RabenRabo: I'm not 100% sure what this does...best guess? deal with dangerous uncooked food?
    -- Badonn: that's correct. Eating raw foods, and dangerous uncooked foods can cause food sickness.
	if foodChanges.undoAddedPoison
	then
		character:getModData().ATPlayerData.undoAddedPoison = true;
		character:getModData().ATPlayerData.beforeEatPoisonLvl = preCharStats[CharacterStat.POISON];
	end
	-- -> moved to ATU for more centralized calculations
	-- if foodEaten:hasTag(AnthroTraitsGlobals.FoodTags.CARNIVORE)
    -- then
        -- if (character:hasTrait(ATGt.CARNIVORE) or character:hasTrait(ATGt.CARRIONEATER)) and not foodEaten:isRotten()
        -- then
            -- if instanceof(character, "IsoPlayer") and not foodEaten:isPoison()
            -- then
                -- character:getModData().ATPlayerData.undoAddedPoison = true;
                -- character:getModData().ATPlayerData.beforeEatPoisonLvl = preCharStats[CharacterStat.POISON];
            -- end
        -- elseif foodEaten:isRotten() and character:hasTrait(ATGt.CARRIONEATER)
        -- then
            -- if instanceof(character, "IsoPlayer") and not foodEaten:isPoison()
            -- then
                -- character:getModData().ATPlayerData.undoAddedPoison = true;
                -- character:getModData().ATPlayerData.beforeEatPoisonLvl = preCharStats[CharacterStat.POISON];
            -- end
        -- end
    -- elseif foodEaten:hasTag(AnthroTraitsGlobals.FoodTags.HERBIVORE)
    -- then
        -- if character:hasTrait(ATGt.HERBIVORE)
        -- then
            -- if not foodEaten:isRotten()
            -- then
                -- if instanceof(character, "IsoPlayer") and not foodEaten:isPoison()
                -- then
                    -- character:getModData().ATPlayerData.undoAddedPoison = true;
                    -- character:getModData().ATPlayerData.beforeEatPoisonLvl = preCharStats[CharacterStat.POISON];
                -- end
            -- end
        -- end
    -- end
end

AnthroTraitsUtilities.ExclaimerCheck = function(player)
	local ATGt = AnthroTraitsGlobals.CharacterTrait;
    local this = AnthroTraitsUtilities;
    local moodles = player:getMoodles();
    local panicLevel = moodles:getMoodleLevel(MoodleType.PANIC)
    local thresholdMultiplier = SandboxVars.AnthroTraits.AT_ExclaimerExclaimThresholdMultiplier;
	local mitigationThreshold = SandboxVars.AnthroTraits.AT_ExclaimerAnthroVoiceMitigation
    local exclaimChance = ZombRand(1,100);

    if (exclaimChance <= (panicLevel * thresholdMultiplier)) and panicLevel > 1
    then
        local phrases = nil
		local mitigationChance = 100
		-- check if any trait-related phrases available
		for trait, phr in pairs(this.ExclaimPhrases) do
			if player:hasTrait(trait)
			then
				phrases = phr
				-- assume additional trait has chance to be mistaken for real animal call => will be ignored by zombies
				mitigationChance = ZombRand(1, 100)
				break
			end
		end
		-- otherwise use generic phrases
		if phrases == nil
		then
			phrases = this.GenericExclaimPhrases
		end
		local phraseChance = ZombRand(1, #phrases);
		if mitigationChance > mitigationThreshold
		then
			player:SayShout(string.upper(phrases[phraseChance]));
			local playerSquare = player:getCurrentSquare();
			getWorldSoundManager():addSound(player,
					playerSquare:getX(),
					playerSquare:getY(),
					playerSquare:getZ(),
					20,
					100);
		else
			player:SayShout("(" .. string.lower(phrases[phraseChance]) .. ")");
		end
    end
end


AnthroTraitsUtilities.BeStinky = function(player)
    local stinkyLoudness = SandboxVars.AnthroTraits.AT_StinkyLoudness
    local stinkyDistance = SandboxVars.AnthroTraits.AT_StinkyDistance
    local stinkyCommentChance = SandboxVars.AnthroTraits.AT_StinkyCommentChance
    local stinkyThreshold = SandboxVars.AnthroTraits.AT_StinkyThreshold
    local playerSquare = player:getCurrentSquare();
    --this is for splitscreen :C
    local localPlayers = getNumActivePlayers();
    --getOnlinePlayers can return nil if not in mp
    local onlinePlayers = getOnlinePlayers();
    local playerInQuestion = player;
    local bloodBodyPartType = BloodBodyPartType.FromIndex(0)
    local totalDirtiness = 0;
    local visual = player:getHumanVisual();

    for i = 0, BloodBodyPartType.MAX:index()-1 do
        bloodBodyPartType = BloodBodyPartType.FromIndex(i)
        totalDirtiness = totalDirtiness + visual:getDirt(bloodBodyPartType);
    end

    if(totalDirtiness >= stinkyThreshold)
    then
        getWorldSoundManager():addSound(player,
                playerSquare:getX(),
                playerSquare:getY(),
                playerSquare:getZ(),
                stinkyDistance,
                stinkyLoudness);
        if (onlinePlayers:size() - 1) > 1
        then
            for playerIndex = 0, (onlinePlayers:size() - 1)
            do
                playerInQuestion = getSpecificPlayer(playerIndex)
                if player == not playerInQuestion
                then
                    if ZombRand(0,1) >= stinkyCommentChance and playerInQuestion:DistTo(player) < stinkyLoudness and playerInQuestion:getMoodles():getMoodleLevel(MoodleType.Pain) < 2 and playerInQuestion:getMoodles():getMoodleLevel(MoodleType.Panic) < 1
                    then
                        playerInQuestion:Say("Stinky!");
                    end
                end
            end
        end
    end
end

AnthroTraitsUtilities.LonelyUpdate = function(player)
    local lonelyDistance = SandboxVars.AnthroTraits.AT_StinkyDistance
    local modData = player:getModData().ATPlayerData
    local activePlayers = getNumActivePlayers();
    local playerInQuestion = player;

    if activePlayers > 1
    then
        for playerIndex = 0, (activePlayers - 1)
        do
            playerInQuestion = getSpecificPlayer(playerIndex);
            if player == not playerInQuestion and playerInQuestion:DistTo() < lonelyDistance
            then
                modData.HoursSinceSeenOthers = 0;
            end
        end
    end
end

AnthroTraitsUtilities.CarryWeightUpdate = function(player)
	local ATGt = AnthroTraitsGlobals.CharacterTrait
    local strength = player:getPerkLevel(Perks.Strength);
    --local traits = player:getTraits();
    local baseWeightChanged = false;
    local defaultMaxWeightBase = 8;

    local newMaxWeightBase = defaultMaxWeightBase;
    if getDebug()
    then
        --DebugLog.log(string.format("Base: %f", newMaxWeightBase));
    end
    -- if getActivatedMods():contains("\\ToadTraits")
    -- then
        -- local MTGlobalMod = SandboxVars.MoreTraits.WeightGlobalMod or 0;
        -- local MTPackMuleBonus = SandboxVars.MoreTraits.WeightPackMule or 2;
        -- local MTPackMouseMalus = SandboxVars.MoreTraits.WeightPackMouse or -2;
        -- local MTDefaultWeight = SandboxVars.MoreTraits.WeightDefault or 8;

        -- defaultMaxWeightBase = MTDefaultWeight;

        -- MTPackMuleBonus = MTPackMuleBonus + math.floor(strength / 5) + MTGlobalMod;
        -- MTPackMouseMalus = MTPackMouseMalus + MTGlobalMod;
        
        -- if player:hasTrait(CharacterTrait.get(ResourceLocation.of("packmule")))
        -- then
            -- baseWeightChanged = true;
            -- newMaxWeightBase =  MTDefaultWeight + MTPackMuleBonus;
            -- if getDebug()
            -- then
                -- DebugLog.log(string.format("packmule: %f", newMaxWeightBase));
            -- end    
        -- elseif player:hasTrait(CharacterTrait.get(ResourceLocation.of("packmouse")))
        -- then
            -- baseWeightChanged = true;
            -- newMaxWeightBase =  MTDefaultWeight + MTPackMouseMalus;
            -- if getDebug()
            -- then
                -- DebugLog.log(string.format("packmouse: %f", newMaxWeightBase));
            -- end    
        -- end
    -- end
    if (getActivatedMods():contains("\\MoreSimpleTraits") 
    or getActivatedMods():contains("\\MoreSimpleTraitsVanilla")
    or getActivatedMods():contains("\\SimpleOverhaulTraitsAndOccupations"))
    then
        local SOTOStrongBackBonus =  2;
        local SOTOWeakBackMalus = -1;
        if player:hasTrait(CharacterTrait.get(ResourceLocation.of("SOTO:StrongBack"))) or player:hasTrait(CharacterTrait.get(ResourceLocation.of("SOTO:StrongBack2")))
        then
            baseWeightChanged = true;
            newMaxWeightBase = newMaxWeightBase + SOTOStrongBackBonus;
            if getDebug()
            then
                DebugLog.log(string.format("StrongBack: %f", newMaxWeightBase));
            end    
        elseif player:hasTrait(CharacterTrait.get(ResourceLocation.of("SOTO:WeakBack")))
        then
            baseWeightChanged = true;
            newMaxWeightBase = newMaxWeightBase + SOTOWeakBackMalus;
            if getDebug()
            then
                DebugLog.log(string.format("WeakBack: %f", newMaxWeightBase));
            end    
        end
    end
    -- if getActivatedMods():contains("\\DracoExpandedTraits")
    -- then
        -- local DracoHoarderPctIncrease = .25;
    -- if player:hasTrait(CharacterTrait.get(ResourceLocation.of("Hoarder")))
        -- then
            -- baseWeightChanged = true;
            -- local hBonus = (math.floor(newMaxWeightBase *  DracoHoarderPctIncrease));
            -- newMaxWeightBase = newMaxWeightBase + hBonus;
            -- if getDebug()
            -- then
                -- DebugLog.log(string.format("Hoarder: %f", newMaxWeightBase));
            -- end    
        -- end
    -- end
    local BobPctIncrease = SandboxVars.AnthroTraits.AT_BeastOfBurdenPctIncrease;
    if player:hasTrait(ATGt.BEASTOFBURDEN)
    then
        baseWeightChanged = true;
        local bobBonus = (math.floor(newMaxWeightBase * BobPctIncrease));
        newMaxWeightBase = newMaxWeightBase + bobBonus;
        if getDebug()
        then
            DebugLog.log(string.format("BOB: %f", newMaxWeightBase));
        end    
    end
    if baseWeightChanged
    then
        --max weight is 50 due to java cap. BASE must be calculated to be slightly less than 50 to allow for hunger bonuses.
        -- 18 here is more or less the equivalent of 50 in max weight i guess. Base weight is weird af.
        if newMaxWeightBase > 18
        then
            newMaxWeightBase = 18
        end
        player:setMaxWeightBase(newMaxWeightBase)
    else
        if getActivatedMods():contains("\\ToadTraits")
        then
            player:setMaxWeightBase(defaultMaxWeightBase + (SandboxVars.MoreTraits.WeightGlobalMod or 0));
        else
            player:setMaxWeightBase(defaultMaxWeightBase);
        end
        
    end
end


AnthroTraitsUtilities.IsAnthro = function(gameCharacter)
    if (getActivatedMods():contains("\\FurryMod") or getActivatedMods():contains("\\FurryApocalypse")) and gameCharacter ~= nil
    then
        local hasFur = false;
        local itemVisuals = gameCharacter:getItemVisuals();
        if itemVisuals ~= nil
        then
            for i=0, itemVisuals:size() - 1
            do
                local itemVisual = itemVisuals:get(i);
                local item =  itemVisual:getScriptItem();
                if item ~= nil and (item:hasTag(ItemTag.get(ResourceLocation.of("FurryMod:Fur"))) or item:hasTag(ItemTag.get(ResourceLocation.of("FurryMod:DeceasedFur"))))
                then
                    hasFur = true;
                    break;
                end
            end;
        end 
        return hasFur;
    else
        return false;
    end
end

---@param player IsoPlayer
---@param bodyPartType BodyPartType
AnthroTraitsUtilities.InfectWound = function(player, bodyPartType)
    if not isClient
    then
        local bodyDmg = player:getBodyDamage();
        bodyDmg:getBodyPart(bodyPartType):setInfectedWound(true); 
    else
        sendClientCommand("AnthroTraits", "InfectWound", {{playerOnlineID = player:getOnlineID(), bodyPartType = bodyPartType}});
    end
end


AnthroTraitsUtilities.HandleInfection = function(player)
    local this = AnthroTraitsUtilities;
	local ATGt = AnthroTraitsGlobals.CharacterTrait
    local biteInfectionChance = SandboxVars.AnthroTraits.AT_AnthroImmunityBiteInfectionChance;
    local lacerationInfectionChance = SandboxVars.AnthroTraits.AT_AnthroImmunityLacerationInfectionChance;
    local scratchInfectionChance = SandboxVars.AnthroTraits.AT_AnthroImmunityScratchInfectionChance;
    if getDebug()
    then
        DebugLog.log("Handle Infection Triggered");
    end

    for i = 0, player:getBodyDamage():getBodyParts():size() - 1 
    do
        local bodyPart = player:getBodyDamage():getBodyParts():get(i);
        if bodyPart:HasInjury() == true and bodyPart:IsInfected()
        then
            if getDebug()
            then
                DebugLog.log( tostring(bodyPart:getType()) .. " is injured and infected.");
            end
            if player:hasTrait(ATGt.UNGULIGRADE)
            then
                if tostring(bodyPart:getType()) == "Foot_L" or tostring(bodyPart:getType()) == "Foot_R"
                then
                    if getDebug()
                    then
                        DebugLog.log("AT_Unguligrade foot immunity triggered.");
                    end
                    this.CureKnoxInfection(player, bodyPart:getType());
                end
            end
            if player:hasTrait(ATGt.ANTHROIMMUNITY) 
            then
                local rolledInfectionChance = ZombRand(1, 100);
                local lastAttackedBy = player:getAttackedBy();
				local attackerIsAnthro = this.IsAnthro(lastAttackedBy)
				local anthroIgnoreImmunity = SandboxVars.AnthroTraits.AT_AnthroImmunityIgnoredByAnthroZombies
                if not anthroIgnoreImmunity or not attackerIsAnthro
                then
                    if getDebug()
                    then
                        DebugLog.log("Rolled " .. rolledInfectionChance);
                    end
                    if bodyPart:bitten() 
                    then
                        if biteInfectionChance <= rolledInfectionChance 
                        then
                            this.CureKnoxInfection(player, bodyPart:getType());
                            if getDebug()
                            then
                                DebugLog.log("Infection defense successful.");
                            end
                            if SandboxVars.AnthroTraits.AT_AnthroImmunityBiteGetsRegularInfectionOnDefense
                            then
                                this.InfectWound(player, bodyPart:getType())
                                if getDebug()
                                then
                                    DebugLog.log("Knox infection substituted with regular infection. Human mouths are septic :S");
                                end

                            end
                            return false;
                        else
                            if getDebug()
                            then
                                DebugLog.log("Infection defense UNSUCCESSFUL. DIE WELL!");
                            end
                            return true;
                        end
                    elseif bodyPart:isCut() --irritatingly, using the function to get laceration doesn't follow the same naming convention
                    then
                        if lacerationInfectionChance <= rolledInfectionChance 
                        then
                            this.CureKnoxInfection(player, bodyPart:getType());
                            if getDebug()
                            then
                                DebugLog.log("Infection defense successful.");
                            end
                            return false;
                        else
                            if getDebug()
                            then
                                DebugLog.log("Infection defense UNSUCCESSFUL. DIE WELL!");
                            end
                            return true;
                        end
                    elseif bodyPart:scratched() 
                    then
                        if scratchInfectionChance <= rolledInfectionChance 
                        then
                            this.CureKnoxInfection(player, bodyPart:getType());
                            if getDebug()
                            then
                                DebugLog.log("Infection defense successful.");
                            end
                            return false;
                        else
                            if getDebug()
                            then
                                DebugLog.log("Infection defense UNSUCCESSFUL. DIE WELL!");
                            end
                            return true;
                        end
                    end
                else
                    if getDebug()
                    then
                        DebugLog.log("Not applying Anthro Immunity to infection from anthro. DIE WELL!")
                    end
                end
            end
        end
    end
end


---@param player IsoPlayer
---@param bodyPartType BodyPartType
AnthroTraitsUtilities.CureKnoxInfection = function(player, bodyPartType)
    if not isClient()
    then
        local bodyDmg = player:getBodyDamage();

        bodyDmg:getBodyPart(bodyPartType):SetInfected(false);

        bodyDmg:setInfected(false);
        bodyDmg:setInfectionMortalityDuration(-1);
        bodyDmg:setInfectionTime(-1);
        bodyDmg:setInfectionGrowthRate(0);
    else
        sendClientCommand("AnthroTraits", "CureKnoxInfection", {playerOnlineID = player:getOnlineID(), bodyPartType = bodyPartType})
    end

    DebugLog.log("Knox Infection removed from "..player:getDisplayName())
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