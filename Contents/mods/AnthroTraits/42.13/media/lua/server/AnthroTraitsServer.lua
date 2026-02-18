local AnthroTraitsServer = {};

local ATU = require("AnthroTraitsUtilities");


    ---Executes commands on the SERVER FROM the CLIENT.
    ---@param module string
    ---@param command string
    ---@param args table
    AnthroTraitsServer.ATOnClientCommand = function(module, command, args)
        if not isClient and isServer then
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

                    bodyPart:setInfectedWound(true);
                end
            end
        end
    end

Events.OnClientCommand.Add(AnthroTraitsServer.ATOnClientCommand);

return AnthroTraitsServer;