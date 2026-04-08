local ATU = require "AnthroTraitsUtilities"
local ATShU = require "AnthroTraitsSharedUtilities"

--NOTE: uses playerIndex as keys instead of playerOnlineID, since playerOnlineID might assign different ID to same player after re-join. playerIndex should be limited to 0-3 for split screen players
local prevFallSpeedPlayers = {}

local function onPlayerUpdate(player)
    local playerID = player:getIndex();
    -- SP/MP server must process fallspeed and MP client must do the same
    prevFallSpeedPlayers[playerID] = ATShU.processFallingPlayer(player, prevFallSpeedPlayers[playerID])
end

local function onCreatePlayer(playerIndex, player)
    local playerID = player:getIndex();
    prevFallSpeedPlayers[playerIndex] = nil;
end

local function initAnthroTraits()

    ATU.ImportExclaimerPhrases();
end

-- don't do playerUpdates in SP: AnthroTraitsServerMain already does an onTick operation that runs on MP server and in SP
-- this should only run in MP client to match MP server fall speed/location
if isClient() then
    Events.OnPlayerUpdate.Add(onPlayerUpdate);
end

Events.OnCreatePlayer.Add(onCreatePlayer);
Events.OnGameBoot.Add(initAnthroTraits);
