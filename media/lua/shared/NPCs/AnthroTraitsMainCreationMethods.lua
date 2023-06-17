require("NPCs/MainCreationMethods");
local TTF = require("TraitTagFramework");

-- C:\Program Files (x86)\Steam\3steamapps\common\ProjectZomboid\media\lua | Project Zomboid files
-- C:\Program Files (x86)\Steam\steamapps\common\ProjectZomboid\media\AnimSets\player
-- C:\Program Files (x86)\Steam\steamapps\workshop\content\108600\

-- C:\Users\Zach\Zomboid\mods
-- C:\Users\Zach\Zomboid\Logs


local function initAnthroTraits()
    --TTF.Add("Axeman", "Human,Anthro");
    --TTF.Add("Handy", "Human,Anthro");
    --TTF.Add("SpeedDemon", "Human,Anthro");
    --TTF.Add("SundayDriver", "Human,Anthro");
    --TTF.Add("Brave", "Human,Anthro");
    --TTF.Add("Cowardly", "Human,Anthro");
    --TTF.Add("Clumsy", "Human,Anthro");
    --TTF.Add("Graceful", "Human,Anthro");
    --TTF.Add("ShortSighted", "Human,Anthro");
    --TTF.Add("HardOfHearing", "Human,Anthro");
    --TTF.Add("Deaf", "Human,Anthro");
    TTF.Add("KeenHearing", "Anthro,KeenHearing");
    TTF.Add("EagleEyed", "Anthro,KeenVision");
    --TTF.Add("HeartyAppitite", "Human,Anthro");
    --TTF.Add("LightEater", "Human,Anthro");
    TTF.Add("ThickSkinned", "Anthro,Tough");
    --TTF.Add("Unfit", "Human,Anthro");
    --TTF.Add("Out of Shape", "Human,Anthro");
    --TTF.Add("Fit", "Human,Anthro");
    --TTF.Add("Athletic", "Human,Anthro");
    --TTF.Add("Nutritionist", "Human,Anthro");
    --TTF.Add("Nutritionist2", "Human,Anthro");
    --TTF.Add("Emaciated", "Human,Anthro");
    --TTF.Add("Very Underweight", "Human,Anthro");
    --TTF.Add("Underweight", "Human,Anthro");
    --TTF.Add("Overweight", "Human,Anthro");
    --TTF.Add("Obese", "Human,Anthro");
    --TTF.Add("Strong", "Human,Anthro");
    --TTF.Add("Stout", "Human,Anthro");
    --TTF.Add("Weak", "Human,Anthro");
    --TTF.Add("Feeble", "Human,Anthro");
    --TTF.Add("Resilient", "Human,Anthro");
    --TTF.Add("ProneToIllness", "Human,Anthro");
    --TTF.Add("Agoraphobic", "Human,Anthro");
    --TTF.Add("Claustophobic", "Human,Anthro");
    --TTF.Add("Lucky", "Human,Anthro");
    --TTF.Add("Unlucky", "Human,Anthro");
    --TTF.Add("Marksman", "Human,Anthro");
    --TTF.Add("NightOwl", "Human,Anthro");
    --TTF.Add("Outdoorsman", "Human,Anthro");
    --TTF.Add("FastHealer", "Human,Anthro");
    --TTF.Add("FastLearner", "Human,Anthro");
    --TTF.Add("FastReader", "Human,Anthro");
    --TTF.Add("AdrenalineJunkie", "Human,Anthro");
    --TTF.Add("Inconspicuous", "Human,Anthro");
    --TTF.Add("NeedsLessSleep", "Human,Anthro");
    TTF.Add("NightVision", "Anthro,KeenVision");
    --TTF.Add("Organized", "Human,Anthro");
    --TTF.Add("LowThirst", "Human,Anthro");
    --TTF.Add("Burglar", "Human,Anthro");
    --TTF.Add("FirstAid", "Human,Anthro");
    --TTF.Add("Fishing", "Human,Anthro");
    --TTF.Add("Gardener", "Human,Anthro");
    --TTF.Add("Jogger", "Human,Anthro");
    --TTF.Add("SlowHealer", "Human,Anthro");
    --TTF.Add("SlowLearner", "Human,Anthro");
    --TTF.Add("SlowReader", "Human,Anthro");
    --TTF.Add("NeedsMoreSleep", "Human,Anthro");
    --TTF.Add("Conspicuous", "Human,Anthro");
    --TTF.Add("Disorganized", "Human,Anthro");
    --TTF.Add("HighThirst", "Human,Anthro");
    --TTF.Add("Illiterate", "Human,Anthro");
    --TTF.Add("Insomniac", "Human,Anthro");
    --TTF.Add("Pacifist", "Human,Anthro");
    --TTF.Add("Thinskinned", "Human,Anthro");
    --TTF.Add("Smoker", "Human,Anthro");
    --TTF.Add("Tailor", "Human,Anthro");
    --TTF.Add("Dextrous", "Human,Anthro");
    --TTF.Add("AllThumbs", "Human,Anthro");
    --TTF.Add("Desensitized", "Human,Anthro");
    --TTF.Add("WeakStomach", "Human,Anthro");
    TTF.Add("IronGut", "Anthro,Scavenger");
    --TTF.Add("Hemophobic", "Human,Anthro");
    --TTF.Add("Asthmatic", "Human,Anthro");
    --TTF.Add("Cook", "Human,Anthro");
    --TTF.Add("Cook2", "Human,Anthro");
    --TTF.Add("Herbalist", "Human,Anthro");
    --TTF.Add("Brawler", "Human,Anthro");
    --TTF.Add("Formerscout", "Human,Anthro");
    --TTF.Add("BaseballPlayer", "Human,Anthro");
    --TTF.Add("Hiker", "Human,Anthro");
    --TTF.Add("Hunter", "Human,Anthro");
    --TTF.Add("Gymnast", "Human,Anthro");
    --TTF.Add("Mechanics", "Human,Anthro");
    --TTF.Add("Mechanics2", "Human,Anthro");
---------------------------------------------------------------------------------------------------------------------------------------------------------------

    TraitFactory.addTrait("AT_BeastOfBurden", getText("UI_trait_AT_BeastOfBurden"), 1, getText("UI_trait_AT_BeastOfBurden_desc"), false);
    TTF.Add("AT_NaturalTumbler", "Anthro,Strong");

    TraitFactory.addTrait("AT_Bug-o-ssieur", getText("UI_trait_AT_Bug-o-ssieur"), 1, getText("UI_trait_AT_Bug-o-ssieur_desc"), false);
    --TTF.Add("AT_Bug-o-ssieur", "Human,Anthro");

    TraitFactory.addTrait("AT_BullRush", getText("UI_trait_AT_BullRush"), 1, getText("UI_trait_AT_BullRush_desc"), false);
    TTF.Add("AT_BullRush", "Anthro,Horns");

    TraitFactory.addTrait("AT_Carnivore", getText("UI_trait_AT_Carnivore"), 1, getText("UI_trait_AT_Carnivore_desc"), false);
    TTF.Add("AT_Carnivore", "Anthro,Carnivore");

    TraitFactory.addTrait("AT_CarrionEater", getText("UI_trait_AT_CarrionEater"), 1, getText("UI_trait_AT_CarrionEater_desc"), false);
    TTF.Add("AT_CarrionEater", "Anthro,Carnivore,Scavenger");

    TraitFactory.addTrait("AT_Digitigrade", getText("UI_trait_AT_Digitigrade"), 1, getText("UI_trait_AT_Digitigrade_desc"), false);
    TTF.Add("AT_Digitigrade", "Anthro");

    TraitFactory.addTrait("AT_Exclaimer", getText("UI_trait_AT_Exclaimer"), -1, getText("UI_trait_AT_Exclaimer_desc"), false);
    --TTF.Add("AT_Exclaimer", "Human,Anthro");

    local AT_FeralBody = TraitFactory.addTrait("AT_FeralBody", getText("UI_trait_AT_FeralBody"), 1, getText("UI_trait_AT_FeralBody_desc"), false);
    AT_FeralBody:addXPBoost(Perks.Strength, 1);
    AT_FeralBody:addXPBoost(Perks.Fitness, -1);
    TTF.Add("AT_FeralBody", "Anthro");

    TraitFactory.addTrait("AT_FeralDigestion", getText("UI_trait_AT_FeralDigestion"), -1, getText("UI_trait_AT_FeralDigestion_desc"), false);
    TTF.Add("AT_FeralDigestion", "Anthro");

    TraitFactory.addTrait("AT_FoodMotivated", getText("UI_trait_AT_FoodMotivated"), 1, getText("UI_trait_AT_FoodMotivated_desc"), false);
    TTF.Add("AT_FoodMotivated", "Anthro");

    TraitFactory.addTrait("AT_Herbivore", getText("UI_trait_AT_Herbivore"), 1, getText("UI_trait_AT_Herbivore_desc"), false);
    TTF.Add("AT_Herbivore", "Anthro,Herbivore");

    local AT_Hooves = TraitFactory.addTrait("AT_Hooves", getText("UI_trait_AT_Hooves"), 1, getText("UI_trait_AT_Hooves_desc"), false);
    AT_Hooves:addXPBoost(Perks.Sprinting, 1);
    AT_Hooves:addXPBoost(Perks.Nimble, 1);
    TTF.Add("AT_Hooves", "Anthro,Hooves");

    TraitFactory.addTrait("AT_Immunity", getText("UI_trait_AT_Immunity"), 1, getText("UI_trait_AT_Immunity_desc"), false);
    TTF.Add("AT_Immunity", "Anthro");
    --add ability to ignore this trait if infected by a former (furry) player?

    TraitFactory.addTrait("AT_Lonely", getText("UI_trait_AT_Lonely"), -1, getText("UI_trait_AT_Lonely_desc"), false);
    TTF.Add("AT_Lonely", "Anthro,Social"); --(Xochi suggestion)

    TraitFactory.addTrait("AT_NaturalTumbler", getText("UI_trait_AT_NaturalTumbler"), 1, getText("UI_trait_AT_NaturalTumbler_desc"), false);
    TTF.Add("AT_NaturalTumbler", "Anthro,Agile");

    local AT_Paws = TraitFactory.addTrait("AT_Paws", getText("UI_trait_AT_Paws"), 1, getText("UI_trait_AT_Paws_desc"), false);
    AT_Paws:addXPBoost(Perks.Lightfoot, 1);
    AT_Paws:addXPBoost(Perks.Sneak, 1);
    TTF.Add("AT_Paws", "Anthro,Paws");

    TraitFactory.addTrait("AT_Stinky", getText("UI_trait_AT_Stinky"), -1, getText("UI_trait_AT_Stinky_desc"), false);
    --TTF.Add("AT_Stinky", "Human,Anthro");

    TraitFactory.addTrait("AT_Tail", getText("UI_trait_AT_Tail"), 1, getText("UI_trait_AT_Tail_desc"), false);
    TTF.Add("AT_Tail", "Anthro,Tail");

    TraitFactory.addTrait("AT_Torpor", getText("UI_trait_AT_Torpor"), -1, getText("UI_trait_AT_Torpor_desc"), false);
    TTF.Add("AT_Torpor", "Anthro,Hibernator");

    TraitFactory.addTrait("AT_UnwieldyHands", getText("UI_trait_AT_UnwieldyHands"), -1, getText("UI_trait_AT_UnwieldyHands_desc"), false);
    TTF.Add("AT_UnwieldyHands", "Anthro,ThreeFingers");

    TraitFactory.addTrait("AT_VestigialWings", getText("UI_trait_AT_VestigialWings"), 1, getText("UI_trait_AT_VestigialWings_desc"), false);
    TTF.Add("AT_VestigialWings", "Anthro,Winged");

    -- (see ?lark?)TraitFactory.addTrait("AT_Diurnal", getText("UI_trait_AT_Diurnal"), 1, getText("UI_trait_AT_Diurnal_desc"), false);

    -- (see night owl)TraitFactory.addTrait("AT_Nocturnal", getText("UI_trait_AT_Nocturnal"), 1, getText("UI_trait_AT_Nocturnal_desc"), false);

    --TraitFactory.addTrait("AT_KeenSmell", getText("UI_trait_AT_KeenSmell"), 4, getText("UI_trait_AT_KeenSmell_desc"), false);
    --TTF.Add("AT_KeenSmell", "Anthro,KeenSmell");
    -- (vision can't be updated via lua)TraitFactory.addTrait("AT_KeenEyes", getText("UI_trait_AT_KeenEyes"), 1, getText("UI_trait_AT_KeenEyes_desc"), false);
    -- (vision can't be updated via lua)TraitFactory.addTrait("AT_KeenHearing", getText("UI_trait_AT_KeenHearing"), 1, getText("UI_trait_AT_KeenHearing_desc"), false);

    -- (see shortsighted) TraitFactory.addTrait("AT_BadEyes", getText("UI_trait_AT_BadEyes"), 1, getText("UI_trait_AT_BadEyes_desc"), false);
    -- (see hard of hearing) TraitFactory.addTrait("AT_BadHearing", getText("UI_trait_AT_BadHearing"), 1, getText("UI_trait_AT_BadHearing_desc"), false);

    -- TraitFactory.addTrait("AT_WannaGoCar", getText("UI_trait_AT_WannaGoCar"), 1, getText("UI_trait_AT_WannaGoCar_desc"), false);

    --TraitFactory.addTrait("AT_ColdBlooded", getText("UI_trait_AT_ColdBlooded"), -4, getText("UI_trait_AT_ColdBlooded_desc"), false);

    -- TraitFactory.addTrait("AT_Sly", getText("UI_trait_AT_Sly"), 1, getText("UI_trait_AT_Sly_desc"), false);

    --Can't dynamically change animation speed. It's everyone gets a sped up anim or none.
    --TraitFactory.addTrait("AT_Slinky", getText("UI_trait_AT_Slinky"), 2, getText("UI_trait_AT_Slinky_desc"), false);
    --TTF.Add("AT_Slinky", "Anthro,Agile");

    -- TraitFactory.addTrait("AT_NoThoughts", getText("UI_trait_AT_NoThoughts"), 1, getText("UI_trait_AT_NoThoughts_desc"), false);
    -- TraitFactory.addTrait("AT_NotCute", getText("UI_trait_AT_NotCute"), 1, getText("UI_trait_AT_NotCute_desc"), false);
    -- TraitFactory.addTrait("AT_SelfClean", getText("UI_trait_AT_SelfClean"), 1, getText("UI_trait_AT_SelfClean_desc"), false);
    -- TraitFactory.addTrait("AT_ThickCoat", getText("UI_trait_AT_ThickCoat"), 1, getText("UI_trait_AT_ThickCoat_desc"), false);

    TraitFactory.setMutualExclusive("AT_Paws", "AT_Hooves");
    TraitFactory.setMutualExclusive("AT_Herbivore", "AT_Carnivore");
    TraitFactory.setMutualExclusive("AT_Herbivore", "AT_CarrionEater");
    TraitFactory.setMutualExclusive("AT_NaturalTumbler", "AT_VestigialWings");


end

--Cost modifier

local traitMetatable = __classmetatables[Trait.class].__index
local old_getCost = traitMetatable.getCost
---@param self Trait
traitMetatable.getCost = function(self)
    if self:getType() == "AT_BeastOfBurden"
    then
        return SandboxVars.AnthroTraits.BeastOfBurden_Cost
    elseif self:getType() == "AT_Bug-o-ssieur"
    then
        return SandboxVars.AnthroTraits.Bug_o_ssieur_Cost
    elseif self:getType() == "AT_BullRush"
    then
        return SandboxVars.AnthroTraits.BullRush_Cost
    elseif self:getType() == "AT_Carnivore"
    then
        return SandboxVars.AnthroTraits.Carnivore_Cost
    elseif self:getType() == "AT_CarrionEater"
    then
        return SandboxVars.AnthroTraits.CarrionEater_Cost
    elseif self:getType() == "AT_Digitigrade"
    then
        return SandboxVars.AnthroTraits.Digitigrade_Cost
    elseif self:getType() == "AT_Exclaimer"
    then
        return SandboxVars.AnthroTraits.Exclaimer_Cost
    elseif self:getType() == "AT_FeralBody"
    then
        return SandboxVars.AnthroTraits.FeralBody_Cost
    elseif self:getType() == "AT_FeralDigestion"
    then
        return SandboxVars.AnthroTraits.FeralDigestion_Cost
    elseif self:getType() == "AT_FoodMotivated"
    then
        return SandboxVars.AnthroTraits.FoodMotivated_Cost
    elseif self:getType() == "AT_Herbivore"
    then
        return SandboxVars.AnthroTraits.Herbivore_Cost
    elseif self:getType() == "AT_Hooves"
    then
        return SandboxVars.AnthroTraits.Hooves_Cost
    elseif self:getType() == "AT_Immunity"
    then
        return SandboxVars.AnthroTraits.Immunity_Cost
    elseif self:getType() == "AT_Lonely"
    then
        return SandboxVars.AnthroTraits.Lonely_Cost
    elseif self:getType() == "AT_NaturalTumbler"
    then
        return SandboxVars.AnthroTraits.NaturalTumbler_Cost
    elseif self:getType() == "AT_Paws"
    then
        return SandboxVars.AnthroTraits.Paws_Cost
    elseif self:getType() == "AT_Stinky"
    then
        return SandboxVars.AnthroTraits.Stinky_Cost
    elseif self:getType() == "AT_Tail"
    then
        return SandboxVars.AnthroTraits.Tail_Cost
    elseif self:getType() == "AT_Torpor"
    then
        return SandboxVars.AnthroTraits.Torpor_Cost
    elseif self:getType() == "AT_UnwieldyHands"
    then
        return SandboxVars.AnthroTraits.UnwieldyHands_Cost
    elseif self:getType() == "AT_VestigialWings"
    then
        return SandboxVars.AnthroTraits.VestigialWings_Cost
    end
    return old_getCost(self)
end

local old_getRightLabel = traitMetatable.getRightLabel
---@param self Trait
traitMetatable.getRightLabel = function(self)
    local cost = 0;
    local AT_Trait = false;

    if self:getType() == "AT_BeastOfBurden"
    then
        cost = SandboxVars.AnthroTraits.BeastOfBurden_Cost
        AT_Trait = true;
    elseif self:getType() == "AT_Bug-o-ssieur"
    then
        cost = SandboxVars.AnthroTraits.Bug_o_ssieur_Cost
        AT_Trait = true;
    elseif self:getType() == "AT_BullRush"
    then
        cost = SandboxVars.AnthroTraits.BullRush_Cost
        AT_Trait = true;
    elseif self:getType() == "AT_Carnivore"
    then
        cost = SandboxVars.AnthroTraits.Carnivore_Cost
        AT_Trait = true;
    elseif self:getType() == "AT_CarrionEater"
    then
        cost = SandboxVars.AnthroTraits.CarrionEater_Cost
        AT_Trait = true;
    elseif self:getType() == "AT_Digitigrade"
    then
        cost = SandboxVars.AnthroTraits.Digitigrade_Cost
        AT_Trait = true;
    elseif self:getType() == "AT_Exclaimer"
    then
        cost = SandboxVars.AnthroTraits.Exclaimer_Cost
        AT_Trait = true;
    elseif self:getType() == "AT_FeralBody"
    then
        cost = SandboxVars.AnthroTraits.FeralBody_Cost
        AT_Trait = true;
    elseif self:getType() == "AT_FeralDigestion"
    then
        cost = SandboxVars.AnthroTraits.FeralDigestion_Cost
        AT_Trait = true;
    elseif self:getType() == "AT_FoodMotivated"
    then
        cost = SandboxVars.AnthroTraits.FoodMotivated_Cost
        AT_Trait = true;
    elseif self:getType() == "AT_Herbivore"
    then
        cost = SandboxVars.AnthroTraits.Herbivore_Cost
        AT_Trait = true;
    elseif self:getType() == "AT_Hooves"
    then
        cost = SandboxVars.AnthroTraits.Hooves_Cost
        AT_Trait = true;
    elseif self:getType() == "AT_Immunity"
    then
        cost = SandboxVars.AnthroTraits.Immunity_Cost
        AT_Trait = true;
    elseif self:getType() == "AT_Lonely"
    then
        cost = SandboxVars.AnthroTraits.Lonely_Cost
        AT_Trait = true;
    elseif self:getType() == "AT_NaturalTumbler"
    then
        cost = SandboxVars.AnthroTraits.NaturalTumbler_Cost
        AT_Trait = true;
    elseif self:getType() == "AT_Paws"
    then
        cost = SandboxVars.AnthroTraits.Paws_Cost
        AT_Trait = true;
    elseif self:getType() == "AT_Stinky"
    then
        cost = SandboxVars.AnthroTraits.Stinky_Cost
        AT_Trait = true;
    elseif self:getType() == "AT_Tail"
    then
        cost = SandboxVars.AnthroTraits.Tail_Cost
        AT_Trait = true;
    elseif self:getType() == "AT_Torpor"
    then
        cost = SandboxVars.AnthroTraits.Torpor_Cost
        AT_Trait = true;
    elseif self:getType() == "AT_UnwieldyHands"
    then
        cost = SandboxVars.AnthroTraits.UnwieldyHands_Cost
        AT_Trait = true;
    elseif self:getType() == "AT_VestigialWings"
    then
        cost = SandboxVars.AnthroTraits.VestigialWings_Cost
        AT_Trait = true;
    end

    if AT_Trait == true
    then
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

Events.OnGameBoot.Add(initAnthroTraits);