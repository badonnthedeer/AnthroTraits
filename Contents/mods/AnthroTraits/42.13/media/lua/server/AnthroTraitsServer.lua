local AnthroTraitsServer = {};

local ATU = require("AnthroTraitsUtilities");


---Sends commands TO THE SERVER from the originating client.
---@param module string
---@param command string
---@param args table
AnthroTraitsServer.ATOnClientCommand = function(module, command, args)
    if isServer()
    then
        --no use for this yet
    end
end


---Sends commands TO THE CLIENT from the server. Used for anything the server has priority on, including bodydamage.
---@param module string
---@param command string
---@param args table
AnthroTraitsServer.ATOnServerCommand = function(module, command, args)
    if isClient()
    then
        if module == "AnthroTraits"
        then
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
                local player = getPlayerByOnlineID(args.playerOnlineID);
                local bodyPart = player:getBodyDamage():getBodyPart(args.bodyPartType);

                bodyPart:setWoundInfectionLevel(1);
            end
        end
    end
end


Events.OnClientCommand.Add(AnthroTraitsServer.ATOnClientCommand);
Events.OnServerCommand.Add(AnthroTraitsServer.ATOnServerCommand);


return AnthroTraitsServer;