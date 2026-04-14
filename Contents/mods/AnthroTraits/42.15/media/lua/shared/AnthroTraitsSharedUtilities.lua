local usingSOTO = getActivatedMods():contains("SimpleOverhaulTraitsAndOccupations") or getActivatedMods():contains("SOTOB42MPTEST");

local AnthroTraitsSharedUtilities = {}

function AnthroTraitsSharedUtilities.getZombieID(zombie)
	if isClient() or isServer() then
		return zombie:getOnlineID()
	end
	return zombie:getID() 
end

function AnthroTraitsSharedUtilities.getZombieFromID(referencePlayer, zombieID)
	local cell = referencePlayer:getCell();
	if not cell then
		return nil;
	end
	local zombieList = cell:getZombieList();
	for i=0, zombieList:size() - 1 do
		local zombie = zombieList:get(i);
		if (isClient() or isServer()) then
			if zombie:getOnlineID() == zombieID then
				return zombie;
			end
		elseif zombie:getID() == zombieID then
			return zombie;
		end
	end
	return nil;
end

function AnthroTraitsSharedUtilities.getPlayerID(player)
	if isClient() or isServer() then
		return player:getOnlineID()
	end
	return player:getIndex() 
end

function AnthroTraitsSharedUtilities.getPlayerFromID(playerID)
	if isClient() or isServer() then
		return getPlayerByOnlineID(playerID);
	end
	if playerID < getNumActivePlayers() then
		return getSpecificPlayer(playerID);
	end
	return nil;
end

function AnthroTraitsSharedUtilities.knockdownZombie(zombie)
	--zombie:setStaggerBack(false);
	zombie:setKnockedDown(true);
	zombie:setOnFloor(true);
	--zombie:setHitReaction("stagger");
	if not isServer() then
		zombie:setBumpFall(true); -- throwing error, only for players?
	end
	-- if ZombRand(100) < 50 then
	-- 	zombie:setBumpFallType("pushedBehind");
	-- else
	-- 	zombie:setBumpFallType("pushedFront");
	-- end
	-- zombie:reportEvent("wasBumped");
end

-- returns the current "LastFallSpeed" for the next processFallingPlayer() call or nil if not relevant
function AnthroTraitsSharedUtilities.processFallingPlayer(player, prevLastFallSpeed)
	if player:isFalling() then
        if player:hasTrait(AnthroTraitsGlobals.CharacterTrait.VESTIGIALWINGS) then
            player:setLastFallSpeed(math.min(player:getLastFallSpeed(), AnthroTraitsGlobals.VESTIGIALWINGS_MAXFALLSPEED));
        elseif player:hasTrait(AnthroTraitsGlobals.CharacterTrait.NATURALTUMBLER) then
            local currLastFallSpeed = player:getLastFallSpeed();
			prevLastFallSpeed = prevLastFallSpeed or 0;
			if currLastFallSpeed > prevLastFallSpeed then
				local newFallSpeed = prevLastFallSpeed + (currLastFallSpeed - prevLastFallSpeed) * SandboxVars.AnthroTraits.AT_NaturalTumblerFallTimeMult;
				player:setLastFallSpeed(newFallSpeed);
				return newFallSpeed;
			end
			return currLastFallSpeed;
		end
    end
	return prevLastFallSpeed;
end

function AnthroTraitsSharedUtilities.checkIfIsWinter()
	local season = getClimateManager():getSeason();
    local winterInt = zombie.erosion.season.ErosionSeason.SEASON_WINTER;
    --https://demiurgequantified.github.io/ProjectZomboidJavaDocs/constant-values.html#zombie.erosion.season.ErosionSeason.NUM_SEASONS
    return season:isSeason(winterInt);
end

function AnthroTraitsSharedUtilities.applyTorporPlayer(player, isWinter)
	if isWinter and player:hasTrait(AnthroTraitsGlobals.CharacterTrait.TORPOR) then
        local limit = 1.0 - SandboxVars.AnthroTraits.AT_TorporEnduranceDecrease;
        local stats = player:getStats();
        if stats:get(CharacterStat.ENDURANCE) > limit then
            stats:set(CharacterStat.ENDURANCE, limit);
        end
    end
end

function AnthroTraitsSharedUtilities.calcCarryWeightMultiplier(player)
	local res = 0;
	if player:hasTrait(AnthroTraitsGlobals.CharacterTrait.BEASTOFBURDEN) then
		res = res + SandboxVars.AnthroTraits.AT_BeastOfBurdenPctIncrease;
	end
	if player:hasTrait(AnthroTraitsGlobals.CharacterTrait.DIGITIGRADE) then
		res = res - SandboxVars.AnthroTraits.AT_DigitigradeCarryWeightMalus;
	elseif player:hasTrait(AnthroTraitsGlobals.CharacterTrait.UNGULIGRADE) then
		res = res - SandboxVars.AnthroTraits.AT_UnguligradeCarryWeightMalus;
	end
	return res + 1;
end

function AnthroTraitsSharedUtilities.updatePlayerCarryWeight(player)
	local baseWeight = 8;
	if usingSOTO then
		if player:hasTrait(SOTO.CharacterTrait.STRONG_BACK) then
			baseWeight = 9;
		elseif player:hasTrait(SOTO.CharacterTrait.WEAK_BACK) then
			baseWeight = 7;
		end
	end
	local mult = AnthroTraitsSharedUtilities.calcCarryWeightMultiplier(player)
	print("AT adjusting carry weight")
	player:setMaxWeightBase(baseWeight * mult);
	player:getBodyDamage():UpdateStrength();
end

local minInHour = -1;

local delayedHourlyQueueRepeating = {}
function AnthroTraitsSharedUtilities.queueRepeatingDelayedEvent(func, minInHour)
	table.insert(delayedHourlyQueueRepeating, { Func = func, MinInHour = minInHour });
end

local delayedHourlyQueueOnce = {}
function AnthroTraitsSharedUtilities.queueDelayedEvent(func, delayInMin)
	if delayInMin < 1 then
		func();
		return;
	end
	local hours = math.floor((minInHour + delayInMin) / 60);
	local minInHour = (minInHour + delayInMin) % 60;
	for index, ev in ipairs(delayedHourlyQueueOnce) do
		if hours < ev.Hours and minInHour < ev.MinInHour then
			table.insert(delayedHourlyQueueOnce, index, { Func = func, Hours = hours, MinInHour = minInHour });
			return;
		end
	end
	table.insert(delayedHourlyQueueOnce, { Func = func, Hours = hours, MinInHour = minInHour });
end

local function addItemTagToItemsFromSandbox(itemList, tag)
    local itemTable = {};
    local foundItem;
    local itemTags;

    for str in string.gmatch(itemList, "([^;]+)") do
        table.insert(itemTable, str)
    end

    for _, tableEntry in ipairs(itemTable) do
        foundItem = getScriptManager():getItem(tableEntry);
        if foundItem then
            itemTags = foundItem:getTags();
            if not itemTags:contains(tag) then
                itemTags:add(tag);
                DebugLog.log("tag "..tag:toString().." added to "..tableEntry);
            end
        else
            DebugLog.log("Cannot find item "..tableEntry.." to add tag "..tag:toString());
        end
    end
end

function AnthroTraitsSharedUtilities.initialiseItemTags()
    addItemTagToItemsFromSandbox(SandboxVars.AnthroTraits.AT_CarnivoreItems, AnthroTraitsGlobals.FoodTags.CARNIVORE);
    addItemTagToItemsFromSandbox(SandboxVars.AnthroTraits.AT_HerbivoreItems, AnthroTraitsGlobals.FoodTags.HERBIVORE);
    addItemTagToItemsFromSandbox(SandboxVars.AnthroTraits.AT_Bug_o_ssieurItems, AnthroTraitsGlobals.FoodTags.INSECT);
    addItemTagToItemsFromSandbox(SandboxVars.AnthroTraits.AT_FeralDigestionItems, AnthroTraitsGlobals.FoodTags.FERALPOISON);
    addItemTagToItemsFromSandbox(SandboxVars.AnthroTraits.AT_FoodMotivatedItems, AnthroTraitsGlobals.FoodTags.FOODMOTIVATED);
end

local function everyOneMinute()
	minInHour = minInHour + 1;
	for _, ev in ipairs(delayedHourlyQueueRepeating) do
		if ev.MinInHour == minInHour then
			ev.Func();
		end
	end
	while #delayedHourlyQueueOnce > 0 and delayedHourlyQueueOnce[1].Hours <= 0 and delayedHourlyQueueOnce[1].MinInHour <= minInHour do
		delayedHourlyQueueOnce[1].Func();
		table.remove(delayedHourlyQueueOnce, 1);
	end
end

local function onEveryHours()
	minInHour = -1;
	for _, ev in ipairs(delayedHourlyQueueOnce) do
		ev.Hours = ev.Hours - 1;
	end
end

Events.EveryOneMinute.Add(everyOneMinute);
Events.EveryHours.Add(onEveryHours);

return AnthroTraitsSharedUtilities;