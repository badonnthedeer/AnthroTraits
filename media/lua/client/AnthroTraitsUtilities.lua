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

AnthroTraitsUtilities.BuildFoodDescription = function(description, item, statModifier)
    local returnTable = {}

    local foodBaseHunger = item:getBaseHunger();
    --local foodHungChange = item:getHungerChange();
    local foodThirstChange = item:getThirstChange();
    local foodBoredomChange = item:getBoredomChange();
    local foodUnhappyChange = item:getUnhappyChange();
    local foodCalories = item:getCalories();
    local rightRenderColor = "%Green%"

    if statModifier > 0
    then
        rightRenderColor = "%Red%"
    end

    table.insert(returnTable, description);

    if foodBaseHunger ~= nil
    then
        table.insert(returnTable, "Hunger: "..rightRenderColor..(foodBaseHunger * statModifier) % 1);
    end
    if foodThirstChange ~= nil
    then
        table.insert(returnTable, "Thirst: "..rightRenderColor..(foodThirstChange * statModifier) % 1);
    end
    if foodBoredomChange ~= nil and foodBoredomChange < 0
    then
        table.insert(returnTable, "Boredom: "..rightRenderColor..(foodBoredomChange * statModifier) % 1);
    else
        table.insert(returnTable, "Boredom: "..foodBoredomChange);
    end
    if foodUnhappyChange ~= nil and foodUnhappyChange < 0
    then
        table.insert(returnTable, "Unhappiness: "..rightRenderColor..(foodUnhappyChange * statModifier) % 1);
    else
        table.insert(returnTable, "Unhappiness: "..foodUnhappyChange);
    end
    if foodCalories ~= nil
    then
        table.insert(returnTable, "Calories: "..rightRenderColor..(foodCalories * statModifier) % 1);
    end

    return returnTable;
end



return AnthroTraitsUtilities;