local ATFU = require "AnthroTraitsFoodUtilities"

local function isNaN(number)
    return number ~= number;
end

local originalUpdateEat = ISDrinkFluidAction.updateEat;
function ISDrinkFluidAction:updateEat(delta)
    if self.character:getInventory():contains(self.item) and self.character:hasTrait(AnthroTraitsGlobals.CharacterTrait.FERALDIGESTION) and self.AT_FeralPoisonPercent > 0 then
        --NOTE: calculations copied from original updateEat() 
        local targetRatio = delta * self.targetConsumedRatio;
        local consumedRatio = self.startRatio - self.fluidContainer:getFilledRatio();
        local ratioToConsume = targetRatio - consumedRatio;
        local deltaToConsume = ratioToConsume / self.fluidContainer:getFilledRatio();
        -- deltaToConsume is the amount of fluid consumed per tick, multiplied with alcohol percent and feral poison amount = poison per tick
        -- NOTE: the numbers tend to get a bit wonky, the longer one drinks (maybe due to FP imprecision?)
        local poisonDelta = SandboxVars.AnthroTraits.AT_FeralDigestionPoisonAmt * deltaToConsume * self.AT_FeralPoisonPercent;
        if not isNaN(poisonDelta) then
            self.character:getStats():add(CharacterStat.POISON, poisonDelta);
        end
    end
    originalUpdateEat(self, delta)
end

local originalNew = ISDrinkFluidAction.new;
function ISDrinkFluidAction.new(self, character, item, percentage)
    local o = originalNew(self, character, item, percentage);
    o.AT_FeralPoisonPercent = ATFU.getFeralPoisonPercent(o.fluidContainer);
    return o;
end