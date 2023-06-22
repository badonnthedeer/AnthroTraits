local ATM = AnthroTraitsMain;
local ATC = AnthroTraitsMainCreationMethods;
require('AnthroTraitsGlobals');


--Cost modifier

local traitMetatable = __classmetatables[Trait.class].__index
local old_getCost = traitMetatable.getCost
---@param self Trait
traitMetatable.getCost = function(self)
    if SandboxVars.AnthroTraits[self:getType().."_Cost"] ~= nil
    then
        return SandboxVars.AnthroTraits[self:getType().."_Cost"]
    else
        return old_getCost(self)
    end
end

local old_getRightLabel = traitMetatable.getRightLabel
---@param self Trait
traitMetatable.getRightLabel = function(self)

    if SandboxVars.AnthroTraits[self:getType().."_Cost"] ~= nil
    then
        local cost = SandboxVars.AnthroTraits[self:getType().."_Cost"];
        local label = "+"

        if cost > 0
        then
            label = "-"
        elseif cost == 0
        then
            label = ""
        end

        if cost < 0
        then
            cost = cost * -1
        end

        return label..cost

    else
        return old_getRightLabel(self)
    end
end

--VANILLA LUA FUNCTION HOOKS

local OriginalEvolvedRecipeAdd = ISAddItemInRecipe.perform
ISAddItemInRecipe.perform = function(self)

    OriginalEvolvedRecipeAdd(self);
    --get items in the recipe
    local ingredients = self.baseItem:getExtraItems();
    local tags = {}

    --get all tags relating to food, and init table with string keys so their count can be added to
    for _, tag in pairs(AnthroTraitsGlobals.EvolvedRecipeFoodTags)
    do
        tags[tag] = 0;
    end

    local tagWithLargestCount = "";
    local tagWithLargestCountCount = 0;

    --for each ingredient...
    for i = 0, ingredients:size() -1
    do
        -- for each tag...
        for tag, _ in pairs(tags)
        do
            --if the ingredient has this tag, up the count for that key in tags
            local ingredient = ingredients:get(i) ;
            local ingredientTags = getScriptManager():getItem(ingredient):getTags()
            if ingredientTags:contains(tag)
            then
                tags[tag] = tags[tag] + 1;
            end
        end
    end

    --for each tag...
    for tag, count in pairs(tags)
    do
        --record if the count is larger than the previous
        if count > tagWithLargestCountCount
        then
            tagWithLargestCount = tag;
            tagWithLargestCountCount = count;
        end
        --and remove the tag from the recipe to reset what food-tags it may already have
        if self.baseItem:hasTag(tag)
        then
            self.baseItem:getTags():remove(tag);
            --local tagB, tagE = allItemTags:find(tag);
            --allItemTags = allItemTags:sub(0, tagB)..allItemTags:sub(tagE + 1, allItemTags:size()-1)
        end
    end

    --if the largest count tag is present on greater than 50% of the recipe's items...
    if tagWithLargestCountCount / ingredients:size() > .5
    then
        --add the tag to the item, so it can be handled appropriately when eaten.
        self.baseItem:getTags():add(tagWithLargestCount);
    end
end


local OriginalEatPerform = ISEatFoodAction.perform;
ISEatFoodAction.perform = function(self)
    -- code to run before the original
    OriginalEatPerform(self);
    -- code to run after the original
    ATM.DoVoreModifier(self.character, self.item, self.percentage)
end

local OriginalEatStop = ISEatFoodAction.stop;
ISEatFoodAction.stop = function(self)
    -- code to run before the original
    OriginalEatStop(self);
    -- code to run after the original
    ATM.DoVoreModifier(self.character, self.item, self:getJobDelta())
end


local OriginalTimedActionCreate = ISBaseTimedAction.create;
ISBaseTimedAction.create = function(self)
    OriginalTimedActionCreate(self);
    if self.character:HasTrait("AT_UnwieldyHands")
    then
        for _, action in pairs(AnthroTraitsGlobals.UnwieldyHandsAffectedTimedActions)
        do
            if self.Type == action
            then
                local newTime = self.maxTime * (1 + SandboxVars.AnthroTraits.AT_UnwieldyHandsTimeIncrease)
                if getDebug()
                then
                    print("UnwieldyHands activated. Old time: "..tostring(self.maxTime).." New time: "..tostring(newTime));
                end
                self.maxTime = newTime;
                break;
            end
        end
    end
end

--poison gui update?
local originalRefreshContainer = ISInventoryPane.refreshContainer;
ISInventoryPane.refreshContainer = function(self)
    --before original
    originalRefreshContainer(self);
    --after original
    local player = getSpecificPlayer(self.player);
    local inventory = self.inventory:getItems();
    for i = 0, inventory:size() - 1
    do
        local item = inventory:get(i);
        local itemDisplayName = item:getDisplayName();

        if item:IsFood() and item:hasTag("ATFeralPoison")
        then
            if player:HasTrait("AT_FeralDigestion")
            then
                if not itemDisplayName:contains("Poisonous")
                then
                    item:setName("Poisonous "..itemDisplayName);
                end
            else
                if itemDisplayName:contains("Poisonous ") and item:getPoisonPower() <= 0
                then
                    item:setName(itemDisplayName:sub(11));
                end
            end
        end
    end
end


--Accessing trait gui for tags, maybe?
--[[local OriginalStatsScreenPopulateTraits = ISPlayerStatsChooseTraitUI.create
ISPlayerStatsChooseTraitUI.create = function(self)
    OriginalStatsScreenPopulateTraits(self);

    for i=0,TraitFactory.getTraits():size()-1
    do
        local trait = TraitFactory.getTraits():get(i);
        if not self.chr:getTraits():contains(trait:getType())
        then
            if trait:getCost() >= 0
            then
                table.Remove(self.goodTraits, trait);
            else
                table.Remove(self.badTraits, trait);
            end
        end
    end
end]]


local oldSOSMD = SandboxOptionsScreen.onOptionMouseDown
SandboxOptionsScreen.onOptionMouseDown = function(...)
    ATC.refundSelectedAffectedTraits();
    oldSOSMD(...);
    ATC.sortTraits();
end