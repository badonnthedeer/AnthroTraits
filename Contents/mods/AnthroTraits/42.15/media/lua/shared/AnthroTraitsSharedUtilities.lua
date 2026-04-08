local AnthroTraitsSharedUtilities = {}

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

return AnthroTraitsSharedUtilities;