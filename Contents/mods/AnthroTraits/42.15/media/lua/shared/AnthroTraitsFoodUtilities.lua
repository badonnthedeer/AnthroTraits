--NOTE: this probably contains a lot of utility functions, that aren't actually used...

local AnthroTraitsFoodUtilities = {}
local ATFVU = require "AnthroTraitsFoodVoreUtilities"

local statInfos =
{
    Boredom = {
        Name = "Boredom",
        DesiredMultiplier = -1,
        Min = 0,
        Max = 100,
        scale = function(value) return value; end,
        fromItem = function(item) return item:getBoredomChange(); end,
        setToItem = function(item, value) item:setBoredomChange(value); end,
        fromPlayer = function(player) return player:getStats():get(CharacterStat.BOREDOM); end,
        setToPlayer = function(player, value) player:getStats():set(CharacterStat.BOREDOM, value); end,
        addToPlayer = function(player, value) player:getStats():add(CharacterStat.BOREDOM, value); end,
    },
    Endurance = {
        Name = "Endurance",
        DesiredMultiplier = 1,
        Min = 0,
        Max = 1,
        scale = function(value) return value * 0.01; end,
        fromItem = function(item) return item:getEnduranceChange(); end,
        setToItem = function(item, value) item:setEndChange(value); end,
        fromPlayer = function(player) return player:getStats():get(CharacterStat.ENDURANCE); end,
        setToPlayer = function(player, value) player:getStats():set(CharacterStat.ENDURANCE, value); end,
        addToPlayer = function(player, value) player:getStats():add(CharacterStat.ENDURANCE, value); end,
    },
    Fatigue = {
        Name = "Fatigue",
        DesiredMultiplier = -1,
        Min = 0,
        Max = 1,
        scale = function(value) return value * 0.01; end,
        fromItem = function(item) return item:getFatigueChange(); end,
        setToItem = function(item, value) item:setFatigueChange(value); end,
        fromPlayer = function(player) return player:getStats():get(CharacterStat.FATIGUE); end,
        setToPlayer = function(player, value) player:getStats():set(CharacterStat.FATIGUE, value); end,
        addToPlayer = function(player, value) player:getStats():add(CharacterStat.FATIGUE, value); end,
    },
    Food_Sickness = {
        Name = "Food_Sickness",
        DesiredMultiplier = -1,
        Min = 0,
        Max = 100,
        scale = function(value) return value; end,
        fromItem = function(item) return item:getFoodSicknessChange(); end,
        setToItem = function(item, value) item:setFoodSicknessChange(value); end,
        fromPlayer = function(player) return player:getStats():get(CharacterStat.FOOD_SICKNESS); end,
        setToPlayer = function(player, value) player:getStats():set(CharacterStat.FOOD_SICKNESS, value); end,
        addToPlayer = function(player, value) player:getStats():add(CharacterStat.FOOD_SICKNESS, value); end,
    },
    Hunger = {
        Name = "Hunger",
        DesiredMultiplier = -1,
        Min = 0,
        Max = 1,
        scale = function(value) return value * 0.01; end,
        fromItem = function(item) return item:getHungChange(); end,
        setToItem = function(item, value) item:setHungChange(value); end,
        fromPlayer = function(player) return player:getStats():get(CharacterStat.HUNGER); end,
        setToPlayer = function(player, value) player:getStats():set(CharacterStat.HUNGER, value); end,
        addToPlayer = function(player, value) player:getStats():add(CharacterStat.HUNGER, value); end,
    },
    -- Pain = {
    --     DesiredMultiplier = -1,  -- less pain on character is desired, but more pain reduction on item is desired...
    --     fromItem = function(item) return item:getPainReduction(); end,
    --     fromPlayer = function(player) return player:getStats():get(CharacterStat.PAIN); end,
    --     setToPlayer = function(player, value) player:getStats():set(CharacterStat.PAIN, value); end,
    --     addToPlayer = function(player, value) player:getStats():add(CharacterStat.PAIN, value); end,
    -- },
    Poison = {
        Name = "Poison",
        DesiredMultiplier = -1,
        Min = 0,
        Max = 100,
        scale = function(value) return value; end,
        fromItem = function(item) return item:getPoisonPower(); end,
        setToItem = function(item, value) item:setPoisonPower(value); end,
        fromPlayer = function(player) return player:getStats():get(CharacterStat.POISON); end,
        setToPlayer = function(player, value) player:getStats():set(CharacterStat.POISON, value); end,
        addToPlayer = function(player, value) player:getStats():add(CharacterStat.POISON, value); end,
    },
    -- Sickness = {  -- less sickness on character is desired, but more flu reduction on item is desired...
    --     DesiredMultiplier = -1,
    --     fromItem = function(item) return item:getFluReduction(); end,
    --     fromPlayer = function(player) return player:getStats():get(CharacterStat.SICKNESS); end,
    --     setToPlayer = function(player, value) player:getStats():set(CharacterStat.SICKNESS, value); end,
    -- },
    Stress = {
        Name = "Stress",
        DesiredMultiplier = -1,
        Min = 0,
        Max = 1,
        scale = function(value) return value * 0.01; end,
        fromItem = function(item) return item:getStressChange(); end,
        setToItem = function(item, value) item:setStressChange(value); end,
        fromPlayer = function(player) return player:getStats():get(CharacterStat.STRESS); end,
        setToPlayer = function(player, value) player:getStats():set(CharacterStat.STRESS, value); end,
        addToPlayer = function(player, value) player:getStats():add(CharacterStat.STRESS, value); end,
    },
    Thirst = {
        Name = "Thirst",
        DesiredMultiplier = -1,
        Min = 0,
        Max = 1,
        scale = function(value) return value * 0.01; end,
        fromItem = function(item) return item:getThirstChange(); end,
        setToItem = function(item, value) item:setThirstChange(value); end,
        fromPlayer = function(player) return player:getStats():get(CharacterStat.THIRST); end,
        setToPlayer = function(player, value) player:getStats():set(CharacterStat.THIRST, value); end,
        addToPlayer = function(player, value) player:getStats():add(CharacterStat.THIRST, value); end,
    },
    Unhappiness = {
        Name = "Unhappiness",
        DesiredMultiplier = -1,
        Min = 0,
        Max = 100,
        scale = function(value) return value; end,
        fromItem = function(item) return item:getUnhappyChange(); end,
        setToItem = function(item, value) item:setUnhappyChange(value); end,
        fromPlayer = function(player) return player:getStats():get(CharacterStat.UNHAPPINESS); end,
        setToPlayer = function(player, value) player:getStats():set(CharacterStat.UNHAPPINESS, value); end,
        addToPlayer = function(player, value) player:getStats():add(CharacterStat.UNHAPPINESS, value); end,
    },
    Carbohydrates = {
        Name = "Carbohydrates",
        DesiredMultiplier = 1,
        Min = -500,
        Max = 1000,
        scale = function(value) return value * 10; end,
        fromItem = function(item) return item:getCarbohydrates(); end,
        setToItem = function(item, value) item:setCarbohydrates(value); end,
        fromPlayer = function(player) return player:getNutrition():getCarbohydrates(); end,
        setToPlayer = function(player, value) player:getNutrition():setCarbohydrates(value); end,
        addToPlayer = function(player, value) player:getNutrition():setCarbohydrates(player:getNutrition():getCarbohydrates() + value); end,
    },
    Lipids = {
        Name = "Lipids",
        DesiredMultiplier = 1,
        Min = -500,
        Max = 1000,
        scale = function(value) return value * 10; end,
        fromItem = function(item) return item:getLipids(); end,
        setToItem = function(item, value) item:setLipids(value); end,
        fromPlayer = function(player) return player:getNutrition():getLipids(); end,
        setToPlayer = function(player, value) player:getNutrition():setLipids(value); end,
        addToPlayer = function(player, value) player:getNutrition():setLipids(player:getNutrition():getLipids() + value); end,
    },
    Proteins = {
        Name = "Proteins",
        DesiredMultiplier = 1,
        Min = -500,
        Max = 1000,
        scale = function(value) return value * 10; end,
        fromItem = function(item) return item:getProteins(); end,
        setToItem = function(item, value) item:setProteins(value); end,
        fromPlayer = function(player) return player:getNutrition():getProteins(); end,
        setToPlayer = function(player, value) player:getNutrition():setProteins(value); end,
        addToPlayer = function(player, value) player:getNutrition():setProteins(player:getNutrition():getProteins() + value); end,
    },
    Calories = {
        Name = "Calories",
        DesiredMultiplier = 1,
        Min = -2200,
        Max = 3700,
        scale = function(value) return value * 37; end,
        fromItem = function(item) return item:getCalories(); end,
        setToItem = function(item, value) item:setCalories(value); end,
        fromPlayer = function(player) return player:getNutrition():getCalories(); end,
        setToPlayer = function(player, value) player:getNutrition():setCalories(value); end,
        addToPlayer = function(player, value) player:getNutrition():setCalories(player:getNutrition():getCalories() + value); end,
    },
};

function AnthroTraitsFoodUtilities.getStatInfo(name)
    return statInfos[name];
end

local function sign(number)
    return (number > 0 and 1) or (number == 0 and 0) or -1
end

local function isNaN(number)
    return number ~= number;
end

local function createExtraFoodInfo()
    return {
        setToItem = function(self, item)
            if self.CanEatUncooked and item:isbDangerousUncooked() then
                self.IsDangerousUncooked = true;
                item:setbDangerousUncooked(false);
            end
        end,
        resetItem = function(self, item)
            if self.IsDangerousUncooked then
                self.IsDangerousUncooked = nil;
                item:setbDangerousUncooked(true);
            end
        end
    };
end

function AnthroTraitsFoodUtilities.createStatsObject()
    return {
        add = function(self, other, ignoreNil, createNew)
            local res = (createNew and AnthroTraitsFoodUtilities.createStatsObject()) or self;
            for name, _ in pairs(statInfos) do
                if not ignoreNil or self[name] then
                    res[name] = (self[name] or 0) + (other[name] or 0);
                end
            end
            return res;
        end,
        subtract = function(self, other, ignoreNil, createNew)
            local res = (createNew and AnthroTraitsFoodUtilities.createStatsObject()) or self;
            for name, _ in pairs(statInfos) do
                if not ignoreNil or self[name] then
                    res[name] = (self[name] or 0) - (other[name] or 0);
                end
            end
            return res;
        end,
        multiply = function(self, other, ignoreNil, createNew)
            local res = (createNew and AnthroTraitsFoodUtilities.createStatsObject()) or self;
            for name, _ in pairs(statInfos) do
                if not ignoreNil or self[name] then
                    res[name] = (self[name] or 0) * (other[name] or 1);
                end
            end
            return res;
        end,
        multiplyScalar = function(self, value, ignoreNil, createNew)
            local res = (createNew and AnthroTraitsFoodUtilities.createStatsObject()) or self;
            for name, _ in pairs(statInfos) do
                if not ignoreNil or self[name] then
                    res[name] = (self[name] or 0) * value;
                end
            end
            return res;
        end,
        customOperation = function(self, other, operation, createNew)
            local res = (createNew and AnthroTraitsFoodUtilities.createStatsObject()) or self;
            for name, info in pairs(statInfos) do
                res[name] = operation(self[name], other[name], info);
            end
            return res;
        end,
        isDesired = function(self, name)
            return self[name] and sign(self[name]) == statInfos[name].DesiredMultiplier;
        end,
        isUndesired = function(self, name)
            return self[name] and sign(self[name]) == -statInfos[name].DesiredMultiplier;
        end,
        filterPredicate = function(self, predicate, createNew)
            local res = (createNew and AnthroTraitsFoodUtilities.createStatsObject()) or self;
            for name, info in pairs(statInfos) do
                local val = self[name];
                if val and not isNaN(val) and predicate(val, info) then
                    res[name] = val;
                else
                    res[name] = nil;
                end
            end
            return res;
        end,
        filterByNames = function(self, names, createNew)
            local res = (createNew and AnthroTraitsFoodUtilities.createStatsObject()) or self;
            for name, info in pairs(statInfos) do
                local remove = true;
                for i=1, #names do
                    if names[i] == name then
                        remove = false;
                        break;
                    end
                end
                if remove then
                    res[name] = nil;
                else
                    res[name] = self[name];
                end
            end
            return res;
        end,
        atLeastOneIs = function(self, predicate)
            for name, info in pairs(statInfos) do
                local val = self[name];
                if val and not isNaN(val) and predicate(val, info) then
                    return true;
                end
            end
            return false;
        end,
        allAre = function(self, predicate)
            for name, info in pairs(statInfos) do
                local val = self[name];
                if val and not isNaN(val) and not predicate(val, info) then
                    return false;
                end
            end
            return true;
        end,
        setToItem = function(self, item)
            for name, info in pairs(statInfos) do
                local val = self[name];
                if val then
                    info.setToItem(item, val);
                end
            end
        end,
        addToPlayer = function(self, player)
            AnthroTraitsFoodUtilities.addStatsToPlayer(player, self);
        end,
        toValuesOnly = function(self)
            local res = {};
            for name, _ in pairs(statInfos) do
                local val = self[name];
                if val and not isNaN(val) then
                    res[name] = val;
                end
            end
            return res;
        end,
        toString = function(self)
            local res = "{food modifiers: "
            for name, _ in pairs(statInfos) do
                local val = self[name];
                if val and not isNaN(val) then
                    res = res .. name .. "=" .. tostring(val) .. ";";
                end
            end
            res = res .. "}";
            return res;
        end,
    };
end

function AnthroTraitsFoodUtilities.addStatsToPlayer(player, stats)
    for name, info in pairs(statInfos) do
        local val = stats[name];
        if val and not isNaN(val) then
            info.addToPlayer(player, val);
        end
    end
end

function AnthroTraitsFoodUtilities.getPlayerStats(player)
    local res = AnthroTraitsFoodUtilities.createStatsObject();
    for name, info in pairs(statInfos) do
        res[name] = info.fromPlayer(player);
    end
    return res;
end

function AnthroTraitsFoodUtilities.getFoodStats(item)
    local res = AnthroTraitsFoodUtilities.createStatsObject();
    for name, info in pairs(statInfos) do
        res[name] = info.fromItem(item);
    end
    return res;
end

local function addMultiplierForDesiredStats(current, multiplier, foodStats, multiplierStats)
    local mod = AnthroTraitsFoodUtilities.createStatsObject();
    for _, name in ipairs(multiplierStats) do
        if foodStats:isDesired(name) then
            mod[name] = multiplier;
        end
    end
    if not current then
        return mod;
    end
    return current:add(mod);
end

-- returns multipliers for food stats or nil if nothing to change
--NOTE: also returns extra info (non-stat related properties, tooltip info) (maybe move to separate function? but then would need to duplicate conditions )
local function getFoodMultiplier(player, food, foodStats, foodTagInfo)
    -- food info
    local isRotten = food:IsRotten();
    -- player info
    local isBugEater = player:hasTrait(AnthroTraitsGlobals.CharacterTrait.BUG_O_SSIEUR);
    local isCarnivore = player:hasTrait(AnthroTraitsGlobals.CharacterTrait.CARNIVORE);
    local isCarrionEater = player:hasTrait(AnthroTraitsGlobals.CharacterTrait.CARRIONEATER);
    local isHerbivore = player:hasTrait(AnthroTraitsGlobals.CharacterTrait.HERBIVORE);
    local isFoodMotivated = player:hasTrait(AnthroTraitsGlobals.CharacterTrait.FOODMOTIVATED);

    local res = nil;
    local insectTagInfo = foodTagInfo[AnthroTraitsGlobals.FoodTags.INSECT];
    local uncookedCounteracted = 0;
    if insectTagInfo and not isRotten and isBugEater then
        res = addMultiplierForDesiredStats(res, SandboxVars.AnthroTraits.AT_Bug_o_ssieurBonus * insectTagInfo.Weight, foodStats, AnthroTraitsGlobals.FoodTraits.NUTRITIONSTATS);
        if foodStats:isUndesired("Boredom") then
            res.Boredom = -1;
        end
        if foodStats:isUndesired("Food_Sickness") then
            res.Food_Sickness = -1;
        end
        if foodStats:isUndesired("Unhappiness") then
            res.Unhappiness = -1;
        end
        if foodStats:isUndesired("Stress") then
            res.Stress = -1;
        end
        if insectTagInfo.DangerousUncooked then
            uncookedCounteracted = uncookedCounteracted + 1;
        end
    end
    local meatTagInfo = foodTagInfo[AnthroTraitsGlobals.FoodTags.CARNIVORE];
    if meatTagInfo then
        if isCarnivore and not isRotten then
            res = addMultiplierForDesiredStats(res, SandboxVars.AnthroTraits.AT_CarnivoreBonus * meatTagInfo.Weight, foodStats, AnthroTraitsGlobals.FoodTraits.NUTRITIONSTATS);
        elseif isCarrionEater and isRotten then
            res = addMultiplierForDesiredStats(res, SandboxVars.AnthroTraits.AT_CarrionEaterBonus * meatTagInfo.Weight, foodStats, AnthroTraitsGlobals.FoodTraits.NUTRITIONSTATS);
            -- counteract the mali from stale/rotten food
            for _, name in ipairs(AnthroTraitsGlobals.FoodTraits.ROTTENSTATS) do
                if foodStats:isUndesired(name) then
                    if not res then
                        res = AnthroTraitsFoodUtilities.createStatsObject();
                    end
                    res[name] = -1;
                end
            end
        elseif isHerbivore then
            res = addMultiplierForDesiredStats(res, SandboxVars.AnthroTraits.AT_HerbivoreMalus * meatTagInfo.Weight, foodStats, AnthroTraitsGlobals.FoodTraits.NUTRITIONSTATS);
        end
        -- both carrion eater and carnivore don't mind eating uncooked meat
        if (isCarnivore or isCarrionEater) and meatTagInfo.DangerousUncooked then
            uncookedCounteracted = uncookedCounteracted + 1;
        end
    end
    local pantTagInfo = foodTagInfo[AnthroTraitsGlobals.FoodTags.HERBIVORE];
    if pantTagInfo then
        if not isRotten and isHerbivore then
            res = addMultiplierForDesiredStats(res,  SandboxVars.AnthroTraits.AT_HerbivoreBonus * pantTagInfo.Weight, foodStats, AnthroTraitsGlobals.FoodTraits.NUTRITIONSTATS);
            if pantTagInfo.DangerousUncooked then
                uncookedCounteracted = uncookedCounteracted + 1;
            end
        elseif isCarnivore then
            res = addMultiplierForDesiredStats(res, SandboxVars.AnthroTraits.AT_CarnivoreMalus * pantTagInfo.Weight, foodStats, AnthroTraitsGlobals.FoodTraits.NUTRITIONSTATS);
        end
    end
    if not isRotten and isFoodMotivated and foodTagInfo[AnthroTraitsGlobals.FoodTags.FOODMOTIVATED] then
        if not res then
            res = AnthroTraitsFoodUtilities.createStatsObject();
        end
        for _, name in ipairs(AnthroTraitsGlobals.FoodTraits.FOODMOTIVATEDSTATS) do
            if foodStats:isUndesired(name) then
                res[name] = -1;
            end
        end
    end
    if res then
        -- if player has enough traits to counteract dangerousUncooked tags make food safe, and vice versa
        local resExtra = createExtraFoodInfo();
        resExtra.CanEatUncooked = uncookedCounteracted >= foodTagInfo.DangerousUncookedTagCount;
        return res, resExtra;
    end
    return nil, nil;
end

-- returns values for addition to food stats (after multiplication) or nil if nothing to change
--NOTE: additive values should range from -100 to 100, since they are then automatically scaled according to each stat
local function getFoodAdditive(player, food, foodStats, foodTagInfo, extra)
    local res = nil;
    -- food info
    local isRotten = food:IsRotten();
    -- player info
    local isFoodMotivated = player:hasTrait(AnthroTraitsGlobals.CharacterTrait.FOODMOTIVATED);
    local feralDigestion = player:hasTrait(AnthroTraitsGlobals.CharacterTrait.FERALDIGESTION);

    local resExtra = extra;
    if not isRotten and isFoodMotivated then
        if not res then
            res = AnthroTraitsFoodUtilities.createStatsObject();
        end
        for _, name in ipairs(AnthroTraitsGlobals.FoodTraits.FOODMOTIVATEDSTATS) do
            res[name] = (res[name] or 0) + statInfos[name].DesiredMultiplier * statInfos[name].scale(SandboxVars.AnthroTraits. AT_FoodMotivatedBonus);
        end
    end
    local feralTagInfo = foodTagInfo[AnthroTraitsGlobals.FoodTags.FERALPOISON];
    if feralTagInfo and feralDigestion then
        if not res then
            res = AnthroTraitsFoodUtilities.createStatsObject();
        end
        res.Poison = (res.Poison or 0) + SandboxVars.AnthroTraits.AT_FeralDigestionPoisonAmt * feralTagInfo.Weight;
        if not resExtra then
            resExtra = createExtraFoodInfo();
        end
        resExtra.FeralPoison = true;
    end
    return res, resExtra;
end

function AnthroTraitsFoodUtilities.getAdditionalFoodStats(player, food)
    local foodTagInfo = ATFVU.getFoodVoreType(food);
    if not foodTagInfo then
        return nil, nil;
    end
    local foodStats = AnthroTraitsFoodUtilities.getFoodStats(food);
    local foodMultiplier, extraInfo = getFoodMultiplier(player, food, foodStats, foodTagInfo);
    local foodAdditive;
    foodAdditive, extraInfo = getFoodAdditive(player, food, foodStats, foodTagInfo, extraInfo);

    if foodMultiplier then
        -- filter out any food stats without a corresponding multiplier and then multiply 
        foodStats:filterPredicate(function(val, info) return foodMultiplier[info.Name]; end):multiply(foodMultiplier);
        if foodAdditive then
            foodStats:add(foodAdditive);
        end
        return foodStats, extraInfo;
    end
    return foodAdditive, extraInfo;
end

return AnthroTraitsFoodUtilities;