local AnthroTraitsUtilities = {}


--UTILITIES
AnthroTraitsUtilities.FileExists = function(path)

    local reader = getModFileReader(AnthroTraitsGlobals.ModID, path, false);
    if not reader
    then
        return false
    else
        reader:close();
        return true
    end
end


AnthroTraitsUtilities.AddItemTagToItemsFromFile = function(path, tag)
    local this = AnthroTraitsUtilities;
    if not this.FileExists(path)
    then
        print("Cannot find file");
        return {};
    end

    local reader = getModFileReader(AnthroTraitsGlobals.ModID, path, false);
    local line;
    local foundItem;
    local itemTags;

    while reader:ready()
    do
        line = reader:readLine();
        foundItem = getScriptManager():getItem(line);
        if foundItem ~= nil
        then
            itemTags = foundItem:getTags();
            if not itemTags:contains(tag)
            then
                itemTags:add(tag);
                if getDebug()
                then
                    print("tag "..tag.." added to "..line);
                end
            end
        else
            print("Cannot find item "..line.." to add tag "..tag);
        end
    end
    reader:close();
end

--[[AnthroTraitsUtilities.InitTableFromFile = function(path)
    if not FileExists(path)
    then
        print("Cannot find file");
        return {};
    end

    local reader = getModFileReader(AnthroTraitsGlobals.ModID, path, false);
    local line;
    local returnTable = {}
    local returnTableCurrentIndex = 1;

    while reader:ready()
    do
        line = reader:readLine();
        returnTable[returnTableCurrentIndex] = line;
        returnTableCurrentIndex = returnTableCurrentIndex + 1;
    end
    reader:close();
    return returnTable;
end]]

return AnthroTraitsUtilities;