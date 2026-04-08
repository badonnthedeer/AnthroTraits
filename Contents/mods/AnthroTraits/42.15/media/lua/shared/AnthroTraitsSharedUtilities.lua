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

return AnthroTraitsSharedUtilities;