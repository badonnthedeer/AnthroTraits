local AnthroTraitsServerUtilities = {}

AnthroTraitsServerUtilities.IsAnthro = function(gameCharacter)
    -- if (getActivatedMods():contains("\\FurryMod") or getActivatedMods():contains("\\FurryApocalypse")) and gameCharacter ~= nil
    -- then
        -- local hasFur = false;
        -- local itemVisuals = gameCharacter:getItemVisuals();
        -- if itemVisuals ~= nil
        -- then
            -- for i=0, itemVisuals:size() - 1
            -- do
                -- local itemVisual = itemVisuals:get(i);
                -- local item =  itemVisual:getScriptItem();
                -- if item ~= nil and (item:hasTag("Fur") or item:hasTag("DeceasedFur"))
                -- then
                    -- hasFur = true;
                    -- break;
                -- end
            -- end;
        -- end 
        -- return hasFur;
    -- else
        -- return false;
    -- end
	
	return false
end

return AnthroTraitsServerUtilities;