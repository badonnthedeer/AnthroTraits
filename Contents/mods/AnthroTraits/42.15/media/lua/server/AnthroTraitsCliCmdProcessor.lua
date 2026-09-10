local ATShU = require "AnthroTraitsSharedUtilities"
local ATSU = require ("AnthroTraitsServerUtilities");
local ATSM = require "AnthroTraitsServerMain"

local function onClientCommandReceived(module, command, player, data)
    if module ~= AnthroTraitsGlobals.ModID then
        return;
    end

    DebugLog.log(DebugType.Network, "AT client command received: " .. command)

    if command == "setPlayerModDataField"
    then
        for key, value in pairs(data) do
            ATSU.setPlayerModDataField(player, key, value);
            DebugLog.log(DebugType.Network, "AT did setPlayerModDataField for "..tostring(player).." : "..tostring(key).." = ".. tostring(value))
        end
    end  

end

Events.OnClientCommand.Add(onClientCommandReceived)

