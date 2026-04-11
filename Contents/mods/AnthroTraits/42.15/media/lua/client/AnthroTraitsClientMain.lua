local ATU = require "AnthroTraitsUtilities"
local ATShU = require "AnthroTraitsSharedUtilities"

--NOTE: uses playerIndex as keys instead of playerOnlineID, since playerOnlineID might assign different ID to same player after re-join. playerIndex should be limited to 0-3 for split screen players
local prevFallSpeedPlayers = {}
local isWinter;

local playerTripInfos = {};

local function processTripping(player)
    if (not player:getStats():isTripping() and not player:isBumped()) or not player:hasTrait(AnthroTraitsGlobals.CharacterTrait.TAIL) then
        return;
    end 
    local playerIndex = player:getIndex();
    playerTripInfos[playerIndex] = playerTripInfos[playerIndex] or {};
    local tripInfo = playerTripInfos[playerIndex];
    if not tripInfo.checked then
        tripInfo.protected = ZombRand(1,100) <= SandboxVars.AnthroTraits.AT_TailTripReduction;
        tripInfo.checked = true;
    end
    if tripInfo.protected then
        DebugLog.log("AT Tail prevented bump/trip");
        player:getStats():setTripping(false);
        player:setBumpFall(false);
    end
end

local function processBullrush(player, collidee)
    if not player:hasTrait(AnthroTraitsGlobals.CharacterTrait.BULLRUSH) then
        return false;
    end
    if not player:isSprinting() then
        return false;
    end
    DebugLog.log("AT Bullrush prevented bump/trip");
    player:getStats():setTripping(false);
    player:setBumpDone(true);
    player:setBumpFall(false);
    player:setHitReaction("");
    player:setBumpFallType("");
    return true;
end


local function onObjectCollide(collider, collidee)
    if not instanceof(collider, "IsoPlayer") or collider:isAnimal() or not collider:isLocalPlayer() then
        return;
    end
    processTripping(collider);
end


local function onCharacterCollide(collider, collidee)
    if not instanceof(collider, "IsoPlayer") or collider:isAnimal() or not collider:isLocalPlayer() then
        return;
    end
    if processBullrush(collider, collidee) then
        return;
    end
    processTripping(collider);
end

local function onPlayerUpdate(player)
    local playerID = player:getIndex();
    -- SP/MP server must process fallspeed and MP client must do the same
    prevFallSpeedPlayers[playerID] = ATShU.processFallingPlayer(player, prevFallSpeedPlayers[playerID]);
    -- server is authority but client should also enforce limit to avoid inconsistent states
    ATShU.applyTorporPlayer(player, isWinter);
end

local function everyDays()
    isWinter = ATShU.checkIfIsWinter();
end

local function everyOneMinute()
    for i=0, getNumActivePlayers()-1 do
        if playerTripInfos[i] then
            playerTripInfos[i].protected = false;
            playerTripInfos[i].checked = false;
        end
    end
end

local function onCreatePlayer(playerIndex, player)
    isWinter = ATShU.checkIfIsWinter();
    local playerID = player:getIndex();
    prevFallSpeedPlayers[playerIndex] = nil;
end

local function initAnthroTraits()
    ATU.ImportExclaimerPhrases();
end


Events.OnObjectCollide.Add(onObjectCollide);
Events.OnCharacterCollide.Add(onCharacterCollide);

-- don't do playerUpdates in SP: AnthroTraitsServerMain already does an onTick operation that runs on MP server and in SP.
-- this should only run in MP client to match MP server fall speed/location.
if isClient() then
    Events.OnPlayerUpdate.Add(onPlayerUpdate);
    Events.EveryDays.Add(everyDays);
end

Events.EveryOneMinute.Add(everyOneMinute);

Events.OnCreatePlayer.Add(onCreatePlayer);
Events.OnGameBoot.Add(initAnthroTraits);
