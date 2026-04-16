local ATFU = require "AnthroTraitsFoodUtilities"

local function sign(number)
    return (number > 0 and 1) or (number == 0 and 0) or -1
end

local tooltipAddendums = {}
tooltipAddendums.POISONOUS = { Text = "IGUI_AT_FeralPoison", Colour = Colors.Purple }
tooltipAddendums.BETTER = { Text = "IGUI_AT_MoreNutritous", Colour = Colors.LightGreen }
tooltipAddendums.WORSE = { Text = "IGUI_AT_LessNutritous", Colour = Colors.LavenderBlush }

local function isNotBad(val, info)
    return sign(val) ~= -info.DesiredMultiplier;
end

local function isBad(val, info)
    return sign(val) == -info.DesiredMultiplier;
end

local function isNotGood(val, info)
    return sign(val) ~= info.DesiredMultiplier;
end

local function isGood(val, info)
    return sign(val) == info.DesiredMultiplier;
end


local oldRender = ISToolTipInv.render;
local function adjustFoodTooltip(tooltip, addFoodStats, extraFoodInfo)
    local originalfoodStats = ATFU.getFoodStats(tooltip.item);
    local adjustedFoodStats = originalfoodStats:add(addFoodStats, true, true);

    local originalItem = tooltip.item;
    tooltip.item = tooltip.item:createCloneItem();
    adjustedFoodStats:setToItem(tooltip.item);
    if extraFoodInfo then extraFoodInfo:setToItem(tooltip.item); end
    oldRender(tooltip);
    tooltip.item = originalItem;
    local addendum = nil;
    if extraFoodInfo and extraFoodInfo.FeralPoison then
        addendum = tooltipAddendums.POISONOUS;
    elseif addFoodStats then
        addFoodStats:filterByNames(AnthroTraitsGlobals.FoodTraits.NUTRITIONSTATS);
        if addFoodStats:allAre(isNotBad) and addFoodStats:atLeastOneIs(isGood) then
            -- if only neutral or good changes to food stats (at least one must be good)
            addendum = tooltipAddendums.BETTER;
        elseif addFoodStats:allAre(isNotGood) and addFoodStats:atLeastOneIs(isBad) then
            -- if only neutral or bad changes to food stats (at least one must be bad)
            addendum = tooltipAddendums.WORSE;
        end
    end
    return addendum;
end

ISToolTipInv.render = function(self)
    local player = self.tooltip:getCharacter();
    if not self.item or not player then
        oldRender(self);
        return;
    end
    local addendum = nil;
    if self.item:isFluidContainer() and player:hasTrait(AnthroTraitsGlobals.CharacterTrait.FERALDIGESTION) and ATFU.getFeralPoisonPercent(self.item:getFluidContainer()) > 0 then
        oldRender(self);
        addendum = tooltipAddendums.POISONOUS;
    else
        local addFoodStats, extraFoodInfo = ATFU.getAdditionalFoodStats(player, self.item);
        if not addFoodStats then
            oldRender(self);
            return;
        end
        addendum = adjustFoodTooltip(self, addFoodStats, extraFoodInfo);
    end
    if addendum then
        local tooltipPaddingLeft = 7;
        local originalHeight = self.tooltip:getHeight();
        local textHeight = getTextManager():MeasureStringY(UIFont[getCore():getOptionTooltipFont()], addendum.Text)
        self:drawRect(0, self.height, self.width, textHeight, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b);
        self:drawRectBorder(0, self.height, self.width, textHeight, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
        self.tooltip:DrawText(getText(addendum.Text), tooltipPaddingLeft, originalHeight, addendum.Colour:getR(), addendum.Colour:getG(), addendum.Colour:getB(), addendum.Colour:getAlpha())
    end
end
