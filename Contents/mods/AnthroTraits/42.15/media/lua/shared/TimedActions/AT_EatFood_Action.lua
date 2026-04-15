local ATFU = require "AnthroTraitsFoodUtilities"

local function sign(number)
    return (number > 0 and 1) or (number == 0 and 0) or -1
end

local function getClampedAdditionalFoodStats(player, food, percentage)
    local addFoodStats, extraFoodInfo = ATFU.getAdditionalFoodStats(player, food);
    if not addFoodStats then
        return nil, nil;
    end
    addFoodStats:multiplyScalar(percentage);
    local playerStats = ATFU.getPlayerStats(player);
    local foodStats = ATFU.getFoodStats(food):multiplyScalar(percentage);
    -- get all values, that will be clamped by base game
    playerStats:add(foodStats):filterPredicate(function(val, info) return val < info.Min or val > info.Max; end);
    -- filter out any stats, that AT won't change
    addFoodStats:filterPredicate(function(val, info) return val ~= 0; end);
    -- counteract clamping by base game
    addFoodStats:customOperation(playerStats,
        function(a, b, info)
            -- base game clamps and AT changes same value in different directions. E.g.: Unhappines: 80 + 50(dogfood) - 55(AT food motivated) with clamping would result in 45 instead of correct 75
            if a and b then
                if sign(a) == -1 and b > info.Max then
                    return a - (info.Max - b);  -- a needs to compensate for how much b is beyond max
                elseif sign(a) == 1 and b < info.Min then
                    return a - (info.Min - b);  -- a needs to compensate for how much b is beyond min
                end
            end
            return a;
        end);
    return addFoodStats, extraFoodInfo;
end

local function playerEat(originalFunc, action)
    local addFoodChanges, extraFoodInfo = getClampedAdditionalFoodStats(action.character, action.item, action.percentage);
    if addFoodChanges then
        if extraFoodInfo then
            extraFoodInfo:setToItem(action.item);
        end
        originalFunc(action);
        if extraFoodInfo then
            extraFoodInfo:resetItem(action.item);
        end
        addFoodChanges:addToPlayer(action.character);
    else
        originalFunc(action);
    end
end

--NOTE: this only runs on the server (?) or SP
local originalComplete = ISEatFoodAction.complete;
function ISEatFoodAction.complete(self)
    playerEat(originalComplete, self);
    return true;
end

--NOTE: this probably only runs on the server or SP
local originalServerStop = ISEatFoodAction.serverStop;
function ISEatFoodAction.serverStop(self)
    --NOTE: applyEat logic copied from base game
    local applyEat = true;
	if self.item and self.item:getFullType()=="Base.Cigarettes" then
		applyEat = false; -- don't apply cigarette effects when action cancelled.
	end
	local hungerChange = math.abs(self.item:getHungerChange() * 100)
	if (hungerChange or self.item:getBaseHunger()) and hungerChange <= 1 then
		applyEat = false; -- don't consume 1 hunger food items when action cancelled.
	end
	if applyEat and self.character:getInventory():contains(self.item) then
        playerEat(originalServerStop, self);
    else
        originalServerStop(self);
	end
end
