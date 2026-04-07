local AnthroTraitsServer = {};

local ATU = require("AnthroTraitsUtilities");


---Executes commands on the SERVER FROM the CLIENT.
---@param module string
---@param command string
---@param player IsoPlayer
---@param args table
AnthroTraitsServer.ATOnClientCommand = function(module, command, player, args)
    DebugLog.log("ClientCommand triggered");
    if not isClient() and isServer() then
        DebugLog.log("ClientCommand triggered on SERVER");
        DebugLog.log("Module: "..module);
        DebugLog.log("Command: "..command);
        if module == "AnthroTraits"
        then
        DebugLog.log("ClientCommand: Anthrotraits");
            if command == "KnockdownZombie"
            then
                args.collidee:setBumpType("stagger");
                args.collidee:setVariable("BumpDone", true);
                args.collidee:setVariable("BumpFall", true);
                args.collidee:setVariable("BumpFallType", "pushedbehind");
            elseif command == "CureKnoxInfection"
            then
                local player = getPlayerByOnlineID(args.playerOnlineID);
                local bodyDmg = player:getBodyDamage();

                bodyDmg:getBodyPart(args.bodyPartType):SetInfected(false);

                bodyDmg:setInfected(false);
                bodyDmg:setInfectionMortalityDuration(-1);
                bodyDmg:setInfectionTime(-1);
                bodyDmg:setInfectionGrowthRate(0);
            elseif command == "InfectWound"
            then
                DebugLog.log("InfectWound triggered");
                local player = getPlayerByOnlineID(args.playerOnlineID);
                local bodyPart = player:getBodyDamage():getBodyPart(args.bodyPartType);

                bodyPart:setInfectedWound(true);
            end
        end
    end
end

Events.OnClientCommand.Add(AnthroTraitsServer.ATOnClientCommand);

return AnthroTraitsServer;