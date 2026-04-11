
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

return AnthroTraitsSharedUtilities;