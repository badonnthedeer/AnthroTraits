local foodVoreTags = {}
foodVoreTags[AnthroTraitsGlobals.FoodTags.CARNIVORE] = {
    CountsForDangerousUncooked = true,
}
foodVoreTags[AnthroTraitsGlobals.FoodTags.HERBIVORE] = {
    CountsForDangerousUncooked = true,
}
foodVoreTags[AnthroTraitsGlobals.FoodTags.INSECT] = {
    CountsForDangerousUncooked = true,
}
foodVoreTags[AnthroTraitsGlobals.FoodTags.FERALPOISON] = {
    CountsForDangerousUncooked = false,
}
foodVoreTags[AnthroTraitsGlobals.FoodTags.FOODMOTIVATED] = {
    CountsForDangerousUncooked = false,
}

local AnthroTraitsFoodVoreUtilities = {}

local function getSingleFoodVoreType(food, foodTagInfo)
    local res = foodTagInfo;
    local tagCount = 0;
    for tag, tagMetaData in pairs(foodVoreTags) do
        if food:hasTag(tag) then
            res = res or { };
            if not res[tag] then
                res[tag] = { Weight = 1 };
            else
                res[tag].Weight = res[tag].Weight + 1;
            end
            --NOTE: yay, somebody REALLY wanted us to know that a "is..." method returns a b(oolean) >.<
            --NOTE2: but of course (!) only only on the InventoryItem. The (Script)Item is mean and doesn't tell us that it returns a boolean...
            if tagMetaData.CountsForDangerousUncooked and ((food.isbDangerousUncooked and food:isbDangerousUncooked()) or food:isDangerousUncooked()) then
                res[tag].DangerousUncooked = true;
            end
            tagCount = tagCount + 1;
        end
    end
    return res, tagCount;
end

-- returns table of a all present food tags with their weight for this food item
function AnthroTraitsFoodVoreUtilities.getFoodVoreType(food)
    local res = nil;
    local tagTotal;
    -- check if is combined food item (evolved recipe) or single food item
    if not food:haveExtraItems() then
        res, tagTotal = getSingleFoodVoreType(food, nil);
        -- every tag on single item gets same weight
    else
        tagTotal = 0;
        -- for combined food items, find all relevant tags and calculate their weight
        local ingredients = food:getExtraItems();
        for i = 0, ingredients:size() - 1 do
            local ingredientName = ingredients:get(i);
            local ingredient = getScriptManager():getItem(ingredientName)
            local tagCount;
            res, tagCount = getSingleFoodVoreType(ingredient, res);
            tagTotal = tagTotal + tagCount;
        end
    end
    if res then
        local dutc = 0;
        -- normalize tag weights and count dangerousUncooked
        for _, info in pairs(res) do
            info.Weight = info.Weight / tagTotal;
            if info.DangerousUncooked then
                dutc = dutc + 1;
            end
        end
        res.DangerousUncookedTagCount = dutc;
    end
    return res;
end

return AnthroTraitsFoodVoreUtilities;