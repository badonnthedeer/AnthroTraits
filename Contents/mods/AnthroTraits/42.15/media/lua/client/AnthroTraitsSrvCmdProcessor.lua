local ATShU = require "AnthroTraitsSharedUtilities"
local ATU = require "AnthroTraitsUtilities"

local function showLonelyComment(player)
    player:Say(getText("IGUI_AT_Lonely_Comment"));
end

local function showStinkyComments(nearbyPlayers)
    for _, playerID in ipairs(nearbyPlayers) do
        local nearbyPlayer = ATShU.getPlayerFromID(playerID);
        if nearbyPlayer then
            nearbyPlayer:Say(getText("IGUI_AT_Stinky_Comment"));
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

local function bullrushZombies(player, zombieIDs)
    -- too far away for this client to know about zombies being knocked down
    if not player:getCell() then
        return;
    end
    local count = 0;
    for _, zombieID in ipairs(zombieIDs) do
        local zombie = ATShU.getZombieFromID(player, zombieID);
        if zombie then
            ATShU.knockdownZombie(zombie);
            count = count + 1;
        end
    end
    print("AT bullrush player " .. zombieIDs.player .. " knocking down " .. count .. "/" .. #zombieIDs .. " zombies");
end

local function onServerCommandReceived(module, command, data)
    if module ~= AnthroTraitsGlobals.ModID then
        return;
    end
    DebugLog.log(DebugLog.Network, "AT client received command from server: " .. command)
    if command == "exclaimerTriggered" then
        local exclaimingPlayer = ATShU.getPlayerFromID(data[1])
        local mitigated = data[2];
        triggerExclaimer(exclaimingPlayer, mitigated);
    elseif command == "stinkyComments" then
        showStinkyComments(data);
    elseif command == "feelingLonely" then
        local player = ATShU.getPlayerFromID(data[1]);
        showLonelyComment(player);
    elseif command == "bullrushZombies" then
        local bullrushingPlayer = ATShU.getPlayerFromID(data.player);
        bullrushZombies(bullrushingPlayer, data);
    end
end

Events.OnServerCommand.Add(onServerCommandReceived)
