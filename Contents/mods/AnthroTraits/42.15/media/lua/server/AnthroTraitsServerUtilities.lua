local AnthroTraitsServerUtilities = {}

-- AnthroTraitsServerUtilities.IsAnthro = function(gameCharacter)
    -- -- if (getActivatedMods():contains("\\FurryMod") or getActivatedMods():contains("\\FurryApocalypse")) and gameCharacter ~= nil
    -- -- then
        -- -- local hasFur = false;
        -- -- local itemVisuals = gameCharacter:getItemVisuals();
        -- -- if itemVisuals ~= nil
        -- -- then
            -- -- for i=0, itemVisuals:size() - 1
            -- -- do
                -- -- local itemVisual = itemVisuals:get(i);
                -- -- local item =  itemVisual:getScriptItem();
                -- -- if item ~= nil and (item:hasTag("Fur") or item:hasTag("DeceasedFur"))
                -- -- then
                    -- -- hasFur = true;
                    -- -- break;
                -- -- end
            -- -- end;
        -- -- end 
        -- -- return hasFur;
    -- -- else
        -- -- return false;
    -- -- end
	
	-- return false
-- end

function AnthroTraitsServerUtilities.foreachPlayerDo(func)
	if isServer() then
		local players = getOnlinePlayers();
		if not players then
			return;
		end
		for i=0, players:size()-1 do
			local res = func(players:get(i));
			if res then
				return;
			end
		end
	else
		for i=0, getNumActivePlayers()-1 do
			local res = func(getSpecificPlayer(i));
			if res then
				return;
			end
		end
	end
end

function AnthroTraitsServerUtilities.sendServerCommand(playerOrModule, moduleOrCommand, commandOrData, maybeData)
    local player = nil;
    local module;
    local command;
    local data;

    if maybeData then
        player = playerOrModule;
        module =  moduleOrCommand;
        command = commandOrData;
        data = maybeData;
    else
        module = playerOrModule;
        command = moduleOrCommand;
        data = commandOrData;
    end
        
	if isServer() then
        if player then
            sendServerCommand(player, module, command, data);
        else
            sendServerCommand(module, command, data);
        end
    else
        triggerEvent("OnServerCommand", module, command, data);
    end
end

return AnthroTraitsServerUtilities