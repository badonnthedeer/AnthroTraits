--require "Foraging/forageSystem";

local ATGt = AnthroTraitsGlobals.CharacterTrait

local originalPickRandomItemType = forageSystem.pickRandomItemType;

function forageSystem.pickRandomItemType(_zoneName, _rolledCategory)
    local player = getSpecificPlayer(forageSystem.AT_CallingPlayerIndex);
    -- _rolledCategory is not nil when ISSearchManager executes createBonusIcon(), otherwise should be empty if (re)creating foraging zomes
    if not _rolledCategory then
        if player:hasTrait(ATGt.CARNIVORE) and player:hasTrait(ATGt.CARRIONEATER) then
            if ZombRand(0, 100) < SandboxVars.AnthroTraits.AT_CarnivoreForageBonus + SandboxVars.AnthroTraits.AT_CarrionEaterForageBonus then
                _rolledCategory = "DeadAnimals";
            end
        elseif player:hasTrait(ATGt.CARNIVORE) then
            if ZombRand(0, 100) < SandboxVars.AnthroTraits.AT_CarnivoreForageBonus then
                _rolledCategory = "DeadAnimals";
            end
        elseif player:hasTrait(ATGt.CARRIONEATER) then
            if ZombRand(0, 100) < SandboxVars.AnthroTraits.AT_CarrionEaterForageBonus then
                _rolledCategory = "DeadAnimals";
            end
        elseif player:hasTrait(ATGt.BUG_O_SSIEUR) then
            if ZombRand(0, 100) < SandboxVars.AnthroTraits.AT_Bug_o_ssieurForageBonus then
                _rolledCategory = "Insects";
            end
        elseif player:hasTrait(ATGt.HERBIVORE) then
            if ZombRand(0, 100) < SandboxVars.AnthroTraits.AnthroTraits_HerbivoreForageBonus then
				local catRoll = ZombRand(0, 3)
				if catRoll < 1 then
					_rolledCategory = "Berries";
				elseif catRoll < 2 then
					_rolledCategory = "Fruits";
				else
					_rolledCategory = "Vegetables";
				end
            end
        end
    end
    return originalPickRandomItemType(_zoneName, _rolledCategory);
end
