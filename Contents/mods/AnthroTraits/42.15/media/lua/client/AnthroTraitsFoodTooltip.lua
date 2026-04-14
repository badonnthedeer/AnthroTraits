
-- AnthroTraitsUtilities.getTooltipValueColor = function(oldValChangeAmt, newValChangeAmt, positiveBad)
--     local color = "%Purple%";

--     if (positiveBad and newValChangeAmt > 0 and oldValChangeAmt < newValChangeAmt) or (not positiveBad and newValChangeAmt < 0 and oldValChangeAmt > newValChangeAmt)
--     then
--         color = "%Crimson%";
--     elseif (positiveBad and newValChangeAmt < 0 and oldValChangeAmt > newValChangeAmt) or (not positiveBad and newValChangeAmt > 0 and oldValChangeAmt < newValChangeAmt)
--     then
--         color = "%LightGreen%";
--     elseif (positiveBad and newValChangeAmt > 0 and oldValChangeAmt > newValChangeAmt) or (not positiveBad and newValChangeAmt < 0 and oldValChangeAmt < newValChangeAmt)
--     then
--         color = "%LavenderBlush%";
--     elseif (positiveBad and newValChangeAmt < 0 and oldValChangeAmt < newValChangeAmt) or (not positiveBad and newValChangeAmt > 0 and oldValChangeAmt > newValChangeAmt)
--     then
--         color = "%Yellow%";
--     elseif (positiveBad and newValChangeAmt > 0 and oldValChangeAmt == newValChangeAmt) or (not positiveBad and newValChangeAmt < 0 and oldValChangeAmt == newValChangeAmt)
--     then
--         color = "%Red%";
--     elseif (positiveBad and newValChangeAmt < 0 and oldValChangeAmt == newValChangeAmt) or (not positiveBad and newValChangeAmt > 0 and oldValChangeAmt == newValChangeAmt)
--     then
--         color = "%White%";
--     end

--     return color;
-- end


-- AnthroTraitsUtilities.getTooltipValueSymbol = function(newValChangeAmt)
--     local symbol = "~";

--     if newValChangeAmt > 0
--     then
--         symbol = "+"
--     elseif newValChangeAmt < 0
--     then
--         symbol = ""
--     end

--     return symbol
-- end


-- AnthroTraitsUtilities.BuildFoodDescription = function(player, foodProps, foodChanges, item)
--     local ATU = AnthroTraitsUtilities;
--     local returnTable = {}

--     local foodName = item:getName();
--     local foodID = item:getFullType();
--     local foodIngredients = item:getExtraItems();
--     local foodIngredientTags;
--     local encumbrance = item:getActualWeight();
--     local stackEncum = item:getCount() * encumbrance;

--     local foodCookedMicrowave = item:isCookedInMicrowave();

--     local currCookTime = item:getCookingTime();
--     local minutesTillCooked = item:getMinutesToCook();
--     local minutesTillBurned = item:getMinutesToBurn();

-- 	local newFoodProps = AddFoodPropsChanges(foodProps, foodChanges)

-- 	local description = nil
-- 	if foodChanges.foodTooltip == 1
-- 	then
-- 		description = "%LightGreen%This food is more nutritious for you."
-- 	elseif foodChanges.foodTooltip == -1
-- 	then
-- 		description = "%LavenderBlush%This food is less nutritious for you."
-- 	end
	
--     if foodName ~= nil
--     then
--         if foodProps[CharacterStat.POISON] > 0
--         then
--             table.insert(returnTable, "%Violet%"..foodName);
--         elseif item:IsRotten() and not player:hasTrait(AnthroTraitsGlobals.CharacterTrait.CARRIONEATER)
--         then
--             table.insert(returnTable, "%Red%"..foodName);
--         elseif item:IsRotten() and item:hasTag(AnthroTraitsGlobals.FoodTags.CARNIVORE) and player:hasTrait(AnthroTraitsGlobals.CharacterTrait.CARRIONEATER)
--         then
--             table.insert(returnTable, "%LightGreen%"..foodName);
--         else
--             table.insert(returnTable, foodName);
--         end
--         table.insert(returnTable, description);
--         table.insert(returnTable, ""); --spacer line
--     end


--     if encumbrance ~= nil
--     then
--         table.insert(returnTable, getText("Tooltip_item_Weight")..":%White%"..string.format("%5.1f", encumbrance))
--     end
--     if encumbrance ~= nil and item:getCount() > 1
--     then
--         table.insert(returnTable, getText("Tooltip_item_StackWeight")..":%White%"..string.format("%5.1f", stackEncum))
--     end
	
-- 	for stat, info in pairs(AnthroTraitsGlobals.FoodCharacterStatInfo) do
-- 		if newFoodProps[stat] ~= 0
-- 		then
-- 			table.insert(returnTable, getText("Tooltip_food_" .. info.TooltipName)..":"..ATU.getTooltipValueColor(foodProps[stat], newFoodProps[stat], info.Sign < 0)..ATU.getTooltipValueSymbol(newFoodProps[stat])..string.format("%3.1f", newFoodProps[stat] * info.TooltipFactor))
-- 		end
-- 	end
	
--     if item:isCookable() and not item:isFrozen() and item:getHeat() > 1.6 then
--         currCookTime = item:getCookingTime();
--         minutesTillCooked = item:getMinutesToCook();
--         minutesTillBurned = item:getMinutesToBurn();
--         --for found "cooked" items in the beginning of the game
--         if (currCookTime == nil or currCookTime == 0) and item:isCooked()
--         then
--             currCookTime = minutesTillCooked;
--         end
--         if currCookTime < minutesTillCooked
--         then
--             table.insert(returnTable, "%Lime%"..getText("IGUI_invpanel_Cooking").."|".."%Lime%"..string.format("%3.2f",currCookTime / minutesTillCooked));
--         elseif currCookTime < minutesTillBurned
--         then
--             table.insert(returnTable, "%Red%"..getText("IGUI_invpanel_Burning").."|".."%Red%"..string.format("%3.2f",(currCookTime - minutesTillCooked ) / (minutesTillBurned - minutesTillCooked)));
--         elseif currCookTime > minutesTillBurned
--         then
--             table.insert(returnTable, "%Red%"..getText("IGUI_invpanel_Burnt"));
--         end
--     elseif not instanceof(item, "ComboItem") and item:getFreezingTime() > 0 and item:getFreezingTime() < 100
--     then
--         if item:isThawing()
--         then
--             table.insert(returnTable, getText("IGUI_invpanel_Melting").."|".."%Green%"..string.format("%3.2f", item:getFreezingTime() / 100));
--         else
--             table.insert(returnTable, getText("IGUI_invpanel_FreezingTime").."|".."%Green%"..string.format("%3.2f", item:getFreezingTime() / 100));
--         end
--     end
--     if not instanceof(item, "ComboItem") and item:isPackaged() or player:hasTrait(CharacterTrait.NUTRITIONIST) or player:hasTrait(CharacterTrait.NUTRITIONIST2)
--     then
--         if newFoodProps.Calories ~= 0
--         then
--             table.insert(returnTable, getText("Tooltip_food_Calories")..":"..ATU.getTooltipValueColor(foodProps.Calories, newFoodProps.Calories, false)..string.format("%5.1f", newFoodProps.Calories));
--         end
--         if newFoodProps.Carbs ~= 0
--         then
--             table.insert(returnTable, getText("Tooltip_food_Carbs")..":"..ATU.getTooltipValueColor(foodProps.Carbs, newFoodProps.Carbs, false)..string.format("%5.1f", newFoodProps.Carbs));
--         end
--         if newFoodProps.Proteins ~= 0
--         then
--             table.insert(returnTable, getText("Tooltip_food_Prots")..":"..ATU.getTooltipValueColor(foodProps.Proteins, newFoodProps.Proteins, false)..string.format("%5.1f", newFoodProps.Proteins));
--         end
--         if newFoodProps.Lipids ~= 0
--         then
--             table.insert(returnTable, getText("Tooltip_food_Fat")..":"..ATU.getTooltipValueColor(foodProps.Lipids, newFoodProps.Lipids, false)..string.format("%5.1f", newFoodProps.Lipids));
--         end
--     end
--     if not instanceof(item, "ComboItem") and item:isbDangerousUncooked() and not item:isCooked() and not item:isBurnt()
--     then
--         if item:hasTag(ItemTag.EGG)
--         then
--             table.insert(returnTable, "%LavenderBlush%"..getText("Tooltip_food_SlightDanger_uncooked"));
--         else
--             if ((player:hasTrait(AnthroTraitsGlobals.CharacterTrait.CARNIVORE) and item:hasTag(AnthroTraitsGlobals.FoodTags.CARNIVORE) and not item:IsRotten())
--                     or (player:hasTrait(AnthroTraitsGlobals.CharacterTrait.HERBIVORE) and item:hasTag(AnthroTraitsGlobals.FoodTags.HERBIVORE) and not item:IsRotten())
--                     or (player:hasTrait(AnthroTraitsGlobals.CharacterTrait.CARRIONEATER)))
--             then
--                 --do nothing
--             else
--                 table.insert(returnTable, "%Red%"..getText("Tooltip_food_Dangerous_uncooked"));
--             end
--         end
--     end
--     if not instanceof(item, "ComboItem") and (item:isGoodHot() or item:isBadCold()) and item:getHeat() < 1.3
--     then
--         table.insert(returnTable, "%LavenderBlush%"..getText("Tooltip_food_BetterHot"));
--     end
--     if foodCookedMicrowave ~= nil and foodCookedMicrowave == true
--     then
--         table.insert(returnTable, getText("Tooltip_food_CookedInMicrowave"));
--     end

--     if foodChanges[CharacterStat.POISON] > 0
--     then
--         table.insert(returnTable, 2, "%Violet%This food is poisonous to you!")
--         --table.insert(returnTable, 2, "%Violet%This food is poisonous to you! ("..string.format("%3.2f",feralDigestionPoisonAmount / bleachPoisonAmt).." full bleach bottle(s))")
--     end
--     return returnTable;
-- end

-- AnthroTraitsUtilities.BuildFluidContainerDescription = function(player, description, item)
--     local ATU = AnthroTraitsUtilities;
--     local returnTable = {}

--     local foodName = item:getName();
--     local encumbrance = item:getActualWeight();
--     local stackEncum = item:getCount() * encumbrance;
--     local fluidContainer = item:getFluidContainer();
--     local numFluids = 0;
--     local amount = fluidContainer:getAmount() * 1000;
--     local capacity = fluidContainer:getCapacity() * 1000;
--     local color = fluidContainer:getColor();
--     local filledPct = fluidContainer:getFilledRatio();
--     local fluid = item:getFluidContainer():getProperties();


--     -- will this even be a thing?
--     local foodCookedMicrowave = false;
--         --foodCookedMicrowave = fluid:isCookedInMicrowave();

--     local currCookTime = item:getCookingTime();
--     local minutesTillCooked = item:getMinutesToCook();
--     local minutesTillBurned = item:getMinutesToBurn();

-- 	local foodProps = ATU.GetConsumableProperties(item)
--     local foodChanges = ATU.CalculateFoodChanges(player, item, foodProps)
-- 	local newFoodProps = AddFoodPropsChanges(foodProps, foodChanges)

--     if foodName ~= nil
--     then
--         if foodProps[CharacterStat.POISON] > 0
--         then
--             table.insert(returnTable, "%Violet%"..foodName);
--         elseif item:IsRotten()
--         then
--             table.insert(returnTable, "%Red%"..foodName);
--         else
--             table.insert(returnTable, foodName);
--         end
--         table.insert(returnTable, description);
--         table.insert(returnTable, ""); --spacer line
--     end


--     if encumbrance ~= nil
--     then
--         table.insert(returnTable, getText("Tooltip_item_Weight")..":%White%"..string.format("%5.1f", encumbrance));
--     end
--     if encumbrance ~= nil and item:getCount() > 1
--     then
--         table.insert(returnTable, getText("Tooltip_item_StackWeight")..":%White%"..string.format("%5.1f", stackEncum));
--     end
--     if amount ~= nil
--     then
--         table.insert(returnTable, getText("Fluid_Amount")..":%White%"..string.format("%6.0f/%6.0f mL", amount, capacity));
--     end
--     if amount ~= nil
--     then
--         table.insert(returnTable, getText("Fluid_Properties_Per"));
--     end
-- 	for stat, info in pairs(AnthroTraitsGlobals.FoodCharacterStatInfo) do
-- 		if newFoodProps[stat] ~= 0
-- 		then
-- 			table.insert(returnTable, "%DarkKhaki%"..getText("Tooltip_food_" .. info.TooltipName)..":"..ATU.getTooltipValueColor(foodProps[stat], newFoodProps[stat], info.Sign < 0)..ATU.getTooltipValueSymbol(newFoodProps[stat])..string.format("%3.1f", newFoodProps[stat]))
-- 		end
-- 	end

--     if item:isCookable() and not item:isFrozen() and item:getHeat() > 1.6 then
--         currCookTime = item:getCookingTime();
--         minutesTillCooked = item:getMinutesToCook();
--         minutesTillBurned = item:getMinutesToBurn();
--         --for found "cooked" items in the beginning of the game
--         if (currCookTime == nil or currCookTime == 0) and item:isCooked()
--         then
--             currCookTime = minutesTillCooked;
--         end
--         if currCookTime < minutesTillCooked
--         then
--             table.insert(returnTable, "%Lime%"..getText("IGUI_invpanel_Cooking").."|".."%Lime%"..string.format("%3.2f",currCookTime / minutesTillCooked));
--         elseif currCookTime < minutesTillBurned
--         then
--             table.insert(returnTable, "%Red%"..getText("IGUI_invpanel_Burning").."|".."%Red%"..string.format("%3.2f",(currCookTime - minutesTillCooked ) / (minutesTillBurned - minutesTillCooked)));
--         elseif currCookTime > minutesTillBurned
--         then
--             table.insert(returnTable, "%Red%"..getText("IGUI_invpanel_Burnt"));
--         end
--     elseif not instanceof(item, "ComboItem") and item:getFreezingTime() > 0 and item:getFreezingTime() < 100
--     then
--         if item:isThawing()
--         then
--             table.insert(returnTable, getText("IGUI_invpanel_Melting").."|".."%Green%"..string.format("%3.2f", item:getFreezingTime() / 100));
--         else
--             table.insert(returnTable, getText("IGUI_invpanel_FreezingTime").."|".."%Green%"..string.format("%3.2f", item:getFreezingTime() / 100));
--         end
--     end
--     if (not instanceof(item, "ComboItem") and item:isPackaged()) or player:hasTrait(CharacterTrait.NUTRITIONIST) or player:hasTrait(CharacterTrait.NUTRITIONIST2)
--     then
--         if newFoodProps.Calories ~= 0
--         then
--             table.insert(returnTable, "%DarkKhaki%"..getText("Tooltip_food_Calories")..":"..ATU.getTooltipValueColor(foodProps.Calories, newFoodProps.Calories, false)..string.format("%5.1f", newFoodProps.Calories));
--         end
--         if newFoodProps.Carbs ~= 0
--         then
--             table.insert(returnTable, "%DarkKhaki%"..getText("Tooltip_food_Carbs")..":"..ATU.getTooltipValueColor(foodProps.Carbs, newFoodProps.Carbs, false)..string.format("%5.1f", newFoodProps.Carbs));
--         end
--         if newFoodProps.Proteins ~= 0
--         then
--             table.insert(returnTable, "%DarkKhaki%"..getText("Tooltip_food_Prots")..":"..ATU.getTooltipValueColor(foodProps.Proteins, newFoodProps.Proteins, false)..string.format("%5.1f", newFoodProps.Proteins));
--         end
--         if newFoodProps.Lipids ~= 0
--         then
--             table.insert(returnTable, "%DarkKhaki%"..getText("Tooltip_food_Fat")..":"..ATU.getTooltipValueColor(foodProps.Lipids, newFoodProps.Lipids, false)..string.format("%5.1f", newFoodProps.Lipids));
--         end
--     end
--     if foodProps[CharacterStat.POISON] > 0
--     then
--         table.insert(returnTable, 2, "%Violet%This food is poisonous to you!")
--         --table.insert(returnTable, 2, "%Violet%This food is poisonous to you! ("..string.format("%3.2f",feralDigestionPoisonAmount / bleachPoisonAmt).." full bleach bottle(s))")
--     end
--     return returnTable;
-- end










-- local oldRender = ISToolTipInv.render
-- ISToolTipInv.render = function(self)
-- 	local ATGt = AnthroTraitsGlobals.CharacterTrait
-- 	local ATGf = AnthroTraitsGlobals.FoodTags
--     --redirect back to oldrender if tooltip isn't for food.
-- 	--short-circuit to prevent components from triggering (transfer fluid gui)
--     if (ISContextMenu.instance and ISContextMenu.instance.visibleCheck) or (self.item == nil) or not instanceof(self.item, "Food")
--     then
--         oldRender(self);
-- 		return
-- 	end
-- 	--declare and get vars
-- 	local player = self.tooltip:getCharacter();
-- 	local mx = getMouseX() + 32;
-- 	local my = getMouseY() + 10;
-- 	local tooltipOffsetX = -8;
-- 	local tooltipOffsetY = 15;
-- 	local tooltipPaddingLeft = 7;
-- 	local tooltipPaddingRight = 6;
-- 	local tooltipPaddingTop = 3;
-- 	local tooltipPaddingBottom = 0;
-- 	local tooltipTextTable = {};
-- 	local longestTextWidth = 0;
-- 	local longestLeftTextWidth = 0;
-- 	local textHeight = 0;
-- 	local barPaddingLeft = 5;
-- 	local barPaddingRight = 5;
-- 	local rightTextLeftPadding = 5;
-- 	local barHeight = 3;
-- 	local lineSpacing = self.tooltip:getLineSpacing();
-- 	local defaultColor = Colors.LemonChiffon;
-- 	local text = "";
-- 	local leftText = "";

-- 	local foodProps = ATU.GetConsumableProperties(self.item)
--     local foodChanges = ATU.CalculateFoodChanges(player, self.item, foodProps)
	
-- 	if foodChanges.foodTooltip ~= nil
-- 	then
-- 		tooltipTextTable = ATU.BuildFoodDescription(player, foodProps, foodChanges, self.item)
-- 	elseif player:hasTrait(ATGt.FERALDIGESTION) and instanceof(self.item, "ComboItem") and self.item:getFluidContainer() ~= nil
-- 	then
-- 		if not self.item:getFluidContainer():isEmpty() and self.item:getFluidContainer():getPrimaryFluid():isCategory(FluidCategory.Alcoholic)
-- 		then
-- 			tooltipTextTable = ATU.BuildFluidContainerDescription(player, nil, self.item)
-- 		else
-- 			return oldRender(self);
-- 		end
-- 	else
-- 		--If it doesn't have any relevant tags, go instead to oldRender
-- 		return oldRender(self);
-- 	end 
	
-- 	-- if (((ATU.FoodVoreType(self.item) == ATGf.HERBIVORE  or ATU.FoodVoreType(self.item) == ATGf.CARNIVORE) and (player:hasTrait(ATGt.HERBIVORE) or player:hasTrait(ATGt.CARNIVORE) or player:hasTrait(ATGt.CARRIONEATER)))
-- 			-- or (self.item:hasTag(ATGf.FERALPOISON) and player:hasTrait(ATGt.FERALDIGESTION))
-- 			-- or (self.item:hasTag(ATGf.INSECT) and player:hasTrait(ATGt.BUG_O_SSIEUR))
-- 			-- or (player:hasTrait(ATGt.FOODMOTIVATED)))
-- 	-- then
-- 		-- if ATU.FoodVoreType(self.item) == ATGf.HERBIVORE
-- 		-- then
-- 			-- if player:hasTrait(ATGt.HERBIVORE)
-- 			-- then
-- 				-- tooltipTextTable = ATU.BuildFoodDescription(player, "%LightGreen%This food is more nutritious for you.", self.item)
-- 			-- elseif player:hasTrait(ATGt.CARNIVORE)
-- 			-- then
-- 				-- tooltipTextTable = ATU.BuildFoodDescription(player, "%LavenderBlush%This food is less nutritious for you.", self.item)
-- 			-- elseif player:hasTrait(ATGt.FOODMOTIVATED) or player:hasTrait(ATGt.FERALDIGESTION)
-- 			-- then
-- 				-- tooltipTextTable = ATU.BuildFoodDescription(player, nil, self.item)
-- 			-- end
-- 		-- elseif ATU.FoodVoreType(self.item) == ATGf.CARNIVORE
-- 		-- then
-- 			-- if player:hasTrait(ATGt.CARNIVORE) and player:hasTrait(ATGt.CARRIONEATER) and self.item:IsRotten()
-- 			-- then
-- 				-- tooltipTextTable = ATU.BuildFoodDescription(player, "%LightGreen%This food is better for you.", self.item)
-- 			-- elseif player:hasTrait(ATGt.CARNIVORE)
-- 			-- then
-- 				-- tooltipTextTable = ATU.BuildFoodDescription(player, "%LightGreen%This food is better for you.", self.item)
-- 			-- elseif player:hasTrait(ATGt.CARRIONEATER) and self.item:IsRotten()
-- 			-- then
-- 				-- tooltipTextTable = ATU.BuildFoodDescription(player, "%LightGreen%This food is better for you.", self.item)
-- 			-- elseif player:hasTrait(ATGt.CARRIONEATER) and not self.item:IsRotten()
-- 			-- then
-- 				-- tooltipTextTable = ATU.BuildFoodDescription(player, nil, self.item)
-- 			-- elseif player:hasTrait(ATGt.HERBIVORE)
-- 			-- then
-- 				-- tooltipTextTable = ATU.BuildFoodDescription(player, "%LavenderBlush%This food is worse for you.", self.item)
-- 			-- elseif player:hasTrait(ATGt.FOODMOTIVATED) or player:hasTrait(ATGt.FERALDIGESTION)
-- 			-- then
-- 				-- tooltipTextTable = ATU.BuildFoodDescription(player, nil, self.item)
-- 			-- end
-- 		-- elseif player:hasTrait(ATGt.FOODMOTIVATED) or player:hasTrait(ATGt.BUG_O_SSIEUR) or player:hasTrait(ATGt.FERALDIGESTION)
-- 		-- then
-- 			-- tooltipTextTable = ATU.BuildFoodDescription(player, nil, self.item)
-- 		-- end
-- 	-- elseif player:hasTrait(ATGt.FERALDIGESTION) and instanceof(self.item, "ComboItem") and self.item:getFluidContainer() ~= nil
-- 	-- then
-- 		-- if not self.item:getFluidContainer():isEmpty() and self.item:getFluidContainer():getPrimaryFluid():isCategory(FluidCategory.Alcoholic)
-- 		-- then
-- 			-- tooltipTextTable = ATU.BuildFluidContainerDescription(player, nil, self.item)
-- 		-- else
-- 			-- return oldRender(self);
-- 		-- end
-- 	-- else
-- 		-- --If it doesn't have any relevant tags, go instead to oldRender
-- 		-- return oldRender(self);
-- 	-- end

-- 	for i = 1, #tooltipTextTable do
-- 		text = string.gsub(tooltipTextTable[i], "%%[^%%]+%%", "")
-- 		longestTextWidth = math.max(longestTextWidth, getTextManager():MeasureStringX(UIFont[getCore():getOptionTooltipFont()], text));
-- 		if tooltipTextTable[i]:find(":")
-- 		then
-- 			leftText = text:sub(0, text:find(":"))
-- 			longestLeftTextWidth = math.max(longestLeftTextWidth, getTextManager():MeasureStringX(UIFont[getCore():getOptionTooltipFont()], leftText));
-- 		end

-- 	end
-- 	for i = 1, #tooltipTextTable do
-- 		if tooltipTextTable[i] ~= nil
-- 		then
-- 			textHeight = textHeight + self.tooltip:getLineSpacing();
-- 		else
-- 			textHeight = self.tooltip:getLineSpacing() / 2;
-- 		end


-- 	end
-- 	textHeight = self.tooltip:getLineSpacing() * #tooltipTextTable;

-- 	if not self.followMouse then
-- 		mx = self:getX();
-- 		my = self:getY();
-- 	end
-- 	if self.desiredX and self.desiredY then
-- 		mx = self.desiredX;
-- 		my = self.desiredY;
-- 	end

-- 	--update tooltip objects with calculated vars
-- 	self:setX(mx + tooltipOffsetX);
-- 	self:setY(my + tooltipOffsetY);

-- 	self.tooltip:setX(mx + tooltipOffsetX);
-- 	self.tooltip:setY(my + tooltipOffsetY);

-- 	--[[if self.contextMenu and self.contextMenu.joyfocus then
-- 		local playerNum = self.contextMenu.player
-- 		self:setX(getPlayerScreenLeft(playerNum) + 60);
-- 		self:setY(getPlayerScreenTop(playerNum) + 60);
-- 	elseif self.contextMenu and self.contextMenu.currentOptionRect then
-- 		if self.contextMenu.currentOptionRect.height > 32 then
-- 			self:setY(my + self.contextMenu.currentOptionRect.height)
-- 		end
-- 		self:adjustPositionToAvoidOverlap(self.contextMenu.currentOptionRect)
-- 	elseif self.owner and self.owner.isButton then
-- 		local ownerRect = { x = self.owner:getAbsoluteX(), y = self.owner:getAbsoluteY(), width = self.owner.width, height = self.owner.height }
-- 		self:adjustPositionToAvoidOverlap(ownerRect)
-- 	end]]

-- 	-- screen bounding
-- 	if self.followMouse then
-- 		--needs adjustment but fine for now.
-- 		self:adjustPositionToAvoidOverlap({ x = mx - 24 * 2, y = my - 24 * 2, width = 24 * 2, height = 24 * 2 })
-- 	end
-- 	--Draw tooltip

-- 	self:drawRect(0, 0, (longestTextWidth + tooltipPaddingLeft + tooltipPaddingRight), (textHeight + tooltipPaddingTop + tooltipPaddingBottom), self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b)
-- 	self:drawRectBorder(0, 0, (longestTextWidth + tooltipPaddingLeft + tooltipPaddingRight), (textHeight + tooltipPaddingTop + tooltipPaddingBottom), self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b)

-- 	local lineY = tooltipPaddingTop;

-- 	for i = 1, #tooltipTextTable do
-- 		local lineX = tooltipPaddingLeft;
-- 		local lineRightX = longestTextWidth + tooltipPaddingLeft;
-- 		local lineYBar;
-- 		local currColor = defaultColor;
-- 		local leftTextWidth;
-- 		local leftTextColor;
-- 		local rightText;
-- 		local rightTextColor;
-- 		local barLength;
-- 		local textFindBeg;
-- 		local textFindEnd;

-- 		text = tooltipTextTable[i]
-- 		leftText = nil;

-- 		if text:contains(":")
-- 		then
-- 			leftText = text:sub(0, text:find(":"))
-- 			leftTextColor = leftText:match("%%.+%%")
-- 			if leftTextColor ~= nil
-- 			then
-- 				textFindBeg,textFindEnd  = leftText:find("%%.+%%");
-- 				leftText = leftText:sub(textFindEnd +1, #leftText)
-- 				leftTextColor = leftTextColor:sub(2, #leftTextColor - 1)
-- 			end
-- 			rightText = text:sub((text:find(":")  +1), #text)
-- 			rightTextColor = rightText:match("%%.+%%")
-- 			if rightTextColor ~= nil
-- 			then
-- 				textFindBeg,textFindEnd  = rightText:find("%%.+%%");
-- 				rightText = rightText:sub(textFindEnd +1, #rightText)
-- 				rightTextColor = rightTextColor:sub(2, #rightTextColor - 1)
-- 			end
-- 			currColor = Colors[leftTextColor] or defaultColor;

-- 			self.tooltip:DrawText(leftText, lineX, lineY,
-- 					currColor:getRedFloat(),
-- 					currColor:getGreenFloat(),
-- 					currColor:getBlueFloat(),
-- 					currColor:getAlphaFloat())

-- 			currColor = Colors[rightTextColor] or defaultColor;
-- 			if rightText ~= nil
-- 			then
-- 				self.tooltip:DrawTextRight(rightText, lineRightX, lineY,
-- 						currColor:getRedFloat(),
-- 						currColor:getGreenFloat(),
-- 						currColor:getBlueFloat(),
-- 						currColor:getAlphaFloat())
-- 			end
-- 				lineY = lineY + lineSpacing
-- 		elseif text:contains("|")
-- 		then
-- 			leftText = text:sub(0, text:find("|") - 1)
-- 			leftTextWidth = getTextManager():MeasureStringX(UIFont[getCore():getOptionTooltipFont()], leftText)
-- 			leftTextColor = leftText:match("%%.+%%")
-- 			if leftTextColor ~= nil
-- 			then
-- 				textFindBeg,textFindEnd  = leftText:find("%%.+%%");
-- 				leftText = leftText:sub(textFindEnd +1, #leftText)
-- 				leftTextColor = leftTextColor:sub(2, #leftTextColor - 1)
-- 			end
-- 			rightText = text:sub(text:find("|") +1, #text)
-- 			rightTextColor = rightText:match("%%.+%%")
-- 			if rightTextColor ~= nil
-- 			then
-- 				textFindBeg,textFindEnd  = rightText:find("%%.+%%");
-- 				rightText = rightText:sub(textFindEnd +1, #rightText)
-- 				rightTextColor = rightTextColor:sub(2, #rightTextColor - 1)
-- 			end
-- 			currColor = Colors[leftTextColor] or defaultColor;

-- 			self.tooltip:DrawText(leftText, lineX, lineY,
-- 					currColor:getRedFloat(),
-- 					currColor:getGreenFloat(),
-- 					currColor:getBlueFloat(),
-- 					currColor:getAlphaFloat())

-- 			currColor = Colors[rightTextColor] or defaultColor;
-- 			if rightText ~= nil
-- 			then
-- 				barLength = (longestTextWidth - leftTextWidth - barPaddingRight);
-- 				--center the bar in the available line space
-- 				lineYBar = (lineY + (self.tooltip:getLineSpacing() / 2) - 1)
-- 				self.tooltip:DrawProgressBar(lineX + leftTextWidth, lineYBar, barLength, 12, tonumber(rightText), currColor:getRedFloat(), currColor:getGreenFloat(), currColor:getBlueFloat(), currColor:getAlphaFloat())
-- 			end
-- 			lineY = lineY + lineSpacing
-- 		elseif text == nil or text == ""
-- 		then
-- 			lineY = lineY + (lineSpacing / 2)
-- 		else
-- 			leftTextColor = text:match("%%.+%%")
-- 			if leftTextColor ~= nil
-- 			then
-- 				textFindBeg,textFindEnd  = text:find("%%.+%%");
-- 				text = text:sub(textFindEnd +1, #text)
-- 				leftTextColor = leftTextColor:sub(2, #leftTextColor - 1)
-- 			end
-- 			currColor = Colors[leftTextColor] or defaultColor;
-- 			self.tooltip:DrawText(text,  lineX, lineY,
-- 					currColor:getRedFloat(),
-- 					currColor:getGreenFloat(),
-- 					currColor:getBlueFloat(),
-- 					currColor:getAlphaFloat())
-- 			lineY = lineY + lineSpacing
-- 		end
-- 	end
-- end



