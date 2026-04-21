local ATShU = require "AnthroTraitsSharedUtilities"
local ATSM = require "AnthroTraitsServerMain"

local function onClientCommandReceived(module, command, data)
    if module ~= AnthroTraitsGlobals.ModID then
        return;
    end
    DebugLog.log(DebugType.Network, "AT client command received: " .. command)
    --NOTE: no client commands defined yet
end

if not isClient() then
    Events.OnClientCommand.Add(onClientCommandReceived)
end
