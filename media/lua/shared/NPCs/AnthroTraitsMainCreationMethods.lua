require("NPCs/MainCreationMethods");
local TTF = require("TraitTagFramework");

-- C:\Program Files (x86)\Steam\3steamapps\common\ProjectZomboid\media\lua | Project Zomboid files
-- C:\Program Files (x86)\Steam\steamapps\common\ProjectZomboid\media\AnimSets\player
-- C:\Program Files (x86)\Steam\steamapps\workshop\content\108600\

-- C:\Users\Zach\Zomboid\mods
-- C:\Users\Zach\Zomboid\Logs


local function initAnthroTraits()
    TTF.Add("Axeman", "Vanilla");
    TTF.Add("Handy", "Vanilla");
    TTF.Add("SpeedDemon", "Vanilla");
    TTF.Add("SundayDriver", "Vanilla");
    TTF.Add("Brave", "Vanilla");
    TTF.Add("Cowardly", "Vanilla");
    TTF.Add("Clumsy", "Vanilla");
    TTF.Add("Graceful", "Vanilla");
    TTF.Add("ShortSighted", "Vanilla");
    TTF.Add("HardOfHearing", "Vanilla");
    TTF.Add("Deaf", "Vanilla");
    TTF.Add("KeenHearing", "Vanilla, Anthro,KeenHearing");
    TTF.Add("EagleEyed", "Vanilla, Anthro,KeenVision");
    TTF.Add("HeartyAppitite", "Vanilla");
    TTF.Add("LightEater", "Vanilla");
    TTF.Add("ThickSkinned", "Vanilla,Anthro,Tough");
    TTF.Add("Unfit", "Vanilla");
    TTF.Add("Out of Shape", "Vanilla");
    TTF.Add("Fit", "Vanilla");
    TTF.Add("Athletic", "Vanilla");
    TTF.Add("Nutritionist", "Vanilla");
    TTF.Add("Nutritionist2", "Vanilla");
    TTF.Add("Emaciated", "Vanilla");
    TTF.Add("Very Underweight", "Vanilla");
    TTF.Add("Underweight", "Vanilla");
    TTF.Add("Overweight", "Vanilla");
    TTF.Add("Obese", "Vanilla");
    TTF.Add("Strong", "Vanilla");
    TTF.Add("Stout", "Vanilla");
    TTF.Add("Weak", "Vanilla");
    TTF.Add("Feeble", "Vanilla");
    TTF.Add("Resilient", "Vanilla");
    TTF.Add("ProneToIllness", "Vanilla");
    TTF.Add("Agoraphobic", "Vanilla");
    TTF.Add("Claustophobic", "Vanilla");
    TTF.Add("Lucky", "Vanilla");
    TTF.Add("Unlucky", "Vanilla");
    TTF.Add("Marksman", "Vanilla");
    TTF.Add("NightOwl", "Vanilla");
    TTF.Add("Outdoorsman", "Vanilla");
    TTF.Add("FastHealer", "Vanilla");
    TTF.Add("FastLearner", "Vanilla");
    TTF.Add("FastReader", "Vanilla");
    TTF.Add("AdrenalineJunkie", "Vanilla");
    TTF.Add("Inconspicuous", "Vanilla");
    TTF.Add("NeedsLessSleep", "Vanilla");
    TTF.Add("NightVision", "Vanilla,Anthro,KeenVision");
    TTF.Add("Organized", "Vanilla");
    TTF.Add("LowThirst", "Vanilla");
    TTF.Add("Burglar", "Vanilla");
    TTF.Add("FirstAid", "Vanilla");
    TTF.Add("Fishing", "Vanilla");
    TTF.Add("Gardener", "Vanilla");
    TTF.Add("Jogger", "Vanilla");
    TTF.Add("SlowHealer", "Vanilla");
    TTF.Add("SlowLearner", "Vanilla");
    TTF.Add("SlowReader", "Vanilla");
    TTF.Add("NeedsMoreSleep", "Vanilla");
    TTF.Add("Conspicuous", "Vanilla");
    TTF.Add("Disorganized", "Vanilla");
    TTF.Add("HighThirst", "Vanilla");
    TTF.Add("Illiterate", "Vanilla");
    TTF.Add("Insomniac", "Vanilla");
    TTF.Add("Pacifist", "Vanilla");
    TTF.Add("Thinskinned", "Vanilla");
    TTF.Add("Smoker", "Vanilla");
    TTF.Add("Tailor", "Vanilla");
    TTF.Add("Dextrous", "Vanilla");
    TTF.Add("AllThumbs", "Vanilla");
    TTF.Add("Desensitized", "Vanilla");
    TTF.Add("WeakStomach", "Vanilla");
    TTF.Add("IronGut", "Vanilla,Anthro,Scavenger");
    TTF.Add("Hemophobic", "Vanilla");
    TTF.Add("Asthmatic", "Vanilla");
    TTF.Add("Cook", "Vanilla");
    TTF.Add("Cook2", "Vanilla");
    TTF.Add("Herbalist", "Vanilla");
    TTF.Add("Brawler", "Vanilla");
    TTF.Add("Formerscout", "Vanilla");
    TTF.Add("BaseballPlayer", "Vanilla");
    TTF.Add("Hiker", "Vanilla");
    TTF.Add("Hunter", "Vanilla");
    TTF.Add("Gymnast", "Vanilla");
    TTF.Add("Mechanics", "Vanilla");
    TTF.Add("Mechanics2", "Vanilla");
---------------------------------------------------------------------------------------------------------------------------------------------------------------

    TraitFactory.addTrait("AT_BeastOfBurden", getText("UI_trait_AT_BeastOfBurden"), 1, getText("UI_trait_AT_BeastOfBurden_desc"), false);
    TTF.Add("AT_NaturalTumbler", "AnthroTraits,CostVariable,Anthro,Strong");

    TraitFactory.addTrait("AT_Bug-o-ssieur", getText("UI_trait_AT_Bug-o-ssieur"), 1, getText("UI_trait_AT_Bug-o-ssieur_desc"), false);
    TTF.Add("AT_Bug-o-ssieur", "AnthroTraits,CostVariable");

    TraitFactory.addTrait("AT_BullRush", getText("UI_trait_AT_BullRush"), 1, getText("UI_trait_AT_BullRush_desc"), false);
    TTF.Add("AT_BullRush", "AnthroTraits,CostVariable,Anthro,Horns");

    TraitFactory.addTrait("AT_Carnivore", getText("UI_trait_AT_Carnivore"), 1, getText("UI_trait_AT_Carnivore_desc"), false);
    TTF.Add("AT_Carnivore", "AnthroTraits,CostVariable,Anthro,Carnivore");

    TraitFactory.addTrait("AT_CarrionEater", getText("UI_trait_AT_CarrionEater"), 1, getText("UI_trait_AT_CarrionEater_desc"), false);
    TTF.Add("AT_CarrionEater", "AnthroTraits,CostVariable,Anthro,Carnivore,Scavenger");

    local AT_Digitigrade = TraitFactory.addTrait("AT_Digitigrade", getText("UI_trait_AT_Digitigrade"), 1, getText("UI_trait_AT_Digitigrade_desc"), false);
    AT_Digitigrade:addXPBoost(Perks.Sprinting, 1)
    TTF.Add("AT_Digitigrade", "AnthroTraits,CostVariable,Anthro");

    TraitFactory.addTrait("AT_Exclaimer", getText("UI_trait_AT_Exclaimer"), -1, getText("UI_trait_AT_Exclaimer_desc"), false);
    TTF.Add("AT_Exclaimer", "AnthroTraits,CostVariable");

    local AT_FeralBody = TraitFactory.addTrait("AT_FeralBody", getText("UI_trait_AT_FeralBody"), 1, getText("UI_trait_AT_FeralBody_desc"), false);
    AT_FeralBody:addXPBoost(Perks.Strength, 1);
    AT_FeralBody:addXPBoost(Perks.Fitness, -1);
    TTF.Add("AT_FeralBody", "AnthroTraits,CostVariable,Anthro");

    TraitFactory.addTrait("AT_FeralDigestion", getText("UI_trait_AT_FeralDigestion"), -1, getText("UI_trait_AT_FeralDigestion_desc"), false);
    TTF.Add("AT_FeralDigestion", "AnthroTraits,CostVariable,Anthro");

    TraitFactory.addTrait("AT_FoodMotivated", getText("UI_trait_AT_FoodMotivated"), 1, getText("UI_trait_AT_FoodMotivated_desc"), false);
    TTF.Add("AT_FoodMotivated", "AnthroTraits,CostVariable,Anthro");

    TraitFactory.addTrait("AT_Herbivore", getText("UI_trait_AT_Herbivore"), 1, getText("UI_trait_AT_Herbivore_desc"), false);
    TTF.Add("AT_Herbivore", "AnthroTraits,CostVariable,Anthro,Herbivore");

    local AT_Hooves = TraitFactory.addTrait("AT_Hooves", getText("UI_trait_AT_Hooves"), 1, getText("UI_trait_AT_Hooves_desc"), false);
    AT_Hooves:addXPBoost(Perks.Nimble, 1);
    TTF.Add("AT_Hooves", "AnthroTraits,CostVariable,Anthro,Hooves");

    TraitFactory.addTrait("AT_Immunity", getText("UI_trait_AT_Immunity"), 1, getText("UI_trait_AT_Immunity_desc"), false);
    TTF.Add("AT_Immunity", "AnthroTraits,CostVariable,Anthro");
    --add ability to ignore this trait if infected by a former (furry) player?

    TraitFactory.addTrait("AT_Lonely", getText("UI_trait_AT_Lonely"), -1, getText("UI_trait_AT_Lonely_desc"), false);
    TTF.Add("AT_Lonely", "AnthroTraits,CostVariable,Anthro,Social"); --(Xochi suggestion)

    TraitFactory.addTrait("AT_NaturalTumbler", getText("UI_trait_AT_NaturalTumbler"), 1, getText("UI_trait_AT_NaturalTumbler_desc"), false);
    TTF.Add("AT_NaturalTumbler", "AnthroTraits,CostVariable,Anthro,Agile");

    local AT_Paws = TraitFactory.addTrait("AT_Paws", getText("UI_trait_AT_Paws"), 1, getText("UI_trait_AT_Paws_desc"), false);
    AT_Paws:addXPBoost(Perks.Lightfoot, 1);
    AT_Paws:addXPBoost(Perks.Sneak, 1);
    TTF.Add("AT_Paws", "AnthroTraits,CostVariable,Anthro,Paws");

    TraitFactory.addTrait("AT_Stinky", getText("UI_trait_AT_Stinky"), -1, getText("UI_trait_AT_Stinky_desc"), false);
    TTF.Add("AT_Stinky", "AnthroTraits,CostVariable,");

    TraitFactory.addTrait("AT_Tail", getText("UI_trait_AT_Tail"), 1, getText("UI_trait_AT_Tail_desc"), false);
    TTF.Add("AT_Tail", "AnthroTraits,CostVariable,Anthro,Tail");

    TraitFactory.addTrait("AT_Torpor", getText("UI_trait_AT_Torpor"), -1, getText("UI_trait_AT_Torpor_desc"), false);
    TTF.Add("AT_Torpor", "AnthroTraits,CostVariable,Anthro,Hibernator");

    TraitFactory.addTrait("AT_UnwieldyHands", getText("UI_trait_AT_UnwieldyHands"), -1, getText("UI_trait_AT_UnwieldyHands_desc"), false);
    TTF.Add("AT_UnwieldyHands", "AnthroTraits,CostVariable,Anthro,ThreeFingers");

    TraitFactory.addTrait("AT_VestigialWings", getText("UI_trait_AT_VestigialWings"), 1, getText("UI_trait_AT_VestigialWings_desc"), false);
    TTF.Add("AT_VestigialWings", "AnthroTraits,CostVariable,Anthro,Winged");

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
    --can I use the "CostVariable" tag here, return all traits with that, compare self:getType() against that list, and if so
    --can I grab SandboxVars.AnthroTraits[self:getType().."_cost"]?
    --or maybe SandboxVars.AnthroTraits[self:getType().."_cost"] ~= nil?
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

Events.OnGameBoot.Add(initAnthroTraits);