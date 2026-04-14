local ATFU = require "AnthroTraitsFoodUtilities"

local function sign(number)
    return (number > 0 and 1) or (number == 0 and 0) or -1
end

local function getClampedAdditionalFoodStats(player, food, percentage)
    local addFoodStats, extraInfo = ATFU.getAdditionalFoodStats(player, food);
    if not addFoodStats then
        return nil, nil;
    end
    addFoodStats:multiplyScalar(percentage);
    local preStats = ATFU.getPlayerStats(player);
    local foodStats = ATFU.getFoodStats(food):multiplyScalar(percentage);
    -- get all values, that will be clamped by base game
    preStats:add(foodStats):filterPredicate(function(val, info) return val < info.min or val > info.max; end);
    -- filter out any stats, that AT won't change
    addFoodStats:filterPredicate(function(val, info) return val ~= 0; end);
    -- counteract clamping by base game
    addFoodStats:customOperation(preStats,
        function(a, b, info)
            -- base game clamps and AT changes same value in different directions. E.g.: Unhappines: 80 + 50(dogfood) - 55(AT food motivated) with clamping would result in 45 instead of correct 75
            if a and b then
                if sign(a) == -1 and b > info.max then
                    return a + (b - info.max);
                elseif sign(a) == 1 and b < info.min then
                    return a + (b + info.max);
                end
            end
            return a;
        end);
    return addFoodStats, extraInfo;
end

local function playerEat(originalFunc, action)
    local addFoodChanges, extraInfo = getClampedAdditionalFoodStats(action.character, action.item, action.percentage);
    if addFoodChanges then
        local dangerousUncooked = action.item:isbDangerousUncooked();
		print("AT eating dangerous uncooked " .. tostring(dangerousUncooked));
		if extraInfo then
			print("AT eating has extra info")
			if extraInfo then
				print("AT eating can eat uncooked " .. tostring(extraInfo.CanEatUncooked))
			end
		end
        if extraInfo and extraInfo.CanEatUncooked and dangerousUncooked then
			print("AT protecting against dangerous uncooked")
            action.item:setbDangerousUncooked(false);
        end
		local foodStats = ATFU.getFoodStats(action.item):multiplyScalar(action.percentage);
		print("AT eating food: " .. foodStats:toString());
		print("AT add food: " .. addFoodChanges:toString());
        originalFunc(action);
        action.item:setbDangerousUncooked(dangerousUncooked);
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
