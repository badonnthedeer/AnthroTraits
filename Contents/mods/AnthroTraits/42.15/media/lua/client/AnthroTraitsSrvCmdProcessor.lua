local ATShU = require "AnthroTraitsSharedUtilities"
local ATU = require "AnthroTraitsUtilities"

local function showStinkyComments(nearbyPlayers)
    for _, playerID in ipairs(nearbyPlayers) do
        local nearbyPlayer = ATShU.getPlayerFromID(playerID);
        if nearbyPlayer then
            nearbyPlayer:Say("You stink!");
        end
    end
end

local function triggerExclaimer(exclaimingPlayer, mitigated)
    local phrases = ATU.GenericExclaimPhrases;
    -- check if any trait-related phrases available
    for trait, phr in pairs(ATU.ExclaimPhrases) do
        if exclaimingPlayer:hasTrait(trait) then
            phrases = phr;
            break
        end
    end
    local phrase = phrases[ZombRand(1, #phrases)]
    if mitigated then
        exclaimingPlayer:Say("(" .. string.lower(phrase) .. ")");
    else
        exclaimingPlayer:SayShout(string.upper(phrase));
    end
end

local function onServerCommandReceived(module, command, data)
    if module ~= AnthroTraitsGlobals.ModID then
        return;
    end
    DebugLog.log(DebugLog.Network, "AT server command received: " .. command)
    if command == "exclaimerTriggered" then
        local exclaimingPlayer = ATShU.getPlayerFromID(data[1])
        local mitigated = data[2];
        triggerExclaimer(exclaimingPlayer, mitigated);
    elseif command == "stinkyComments" then
        showStinkyComments(data);
    end
end

Events.OnServerCommand.Add(onServerCommandReceived)
