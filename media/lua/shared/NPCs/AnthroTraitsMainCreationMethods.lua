require("NPCs/MainCreationMethods");
require("TraitTagFramework")

-- C:\Program Files (x86)\Steam\steamapps\common\ProjectZomboid\media\lua | Project Zomboid files
-- C:\Program Files (x86)\Steam\steamapps\workshop\content\108600\2730251452\mods | Expanded Traits
-- C:\Program Files (x86)\Steam\steamapps\workshop\content\108600\1299328280\mods | More Traits
-- C:\Program Files (x86)\Steam\steamapps\workshop\content\108600\2792245343\mods | More Simple Traits

--C:\Users\Zach\Zomboid\mods
-- C:\Users\Zach\Zomboid\Logs


local function initAnthroTraits()

    TraitTags:add("Axeman", "Human,Anthro");
    TraitTags:add("Handy", "Human,Anthro");
    TraitTags:add("SpeedDemon", "Human,Anthro");
    TraitTags:add("SundayDriver", "Human,Anthro");
    TraitTags:add("Brave", "Human,Anthro");
    TraitTags:add("Cowardly", "Human,Anthro");
    TraitTags:add("Clumsy", "Human,Anthro");
    TraitTags:add("Graceful", "Human,Anthro");
    TraitTags:add("ShortSighted", "Human,Anthro");
    TraitTags:add("HardOfHearing", "Human,Anthro");
    TraitTags:add("Deaf", "Human,Anthro");
    TraitTags:add("KeenHearing", "Anthro,KeenHearing");
    TraitTags:add("EagleEyed", "Anthro,KeenVision");
    TraitTags:add("HeartyAppitite", "Human,Anthro");
    TraitTags:add("LightEater", "Human,Anthro");
    TraitTags:add("ThickSkinned", "Anthro,Tough");
    TraitTags:add("Unfit", "Human,Anthro");
    TraitTags:add("Out of Shape", "Human,Anthro");
    TraitTags:add("Fit", "Human,Anthro");
    TraitTags:add("Athletic", "Human,Anthro");
    TraitTags:add("Nutritionist", "Human,Anthro");
    TraitTags:add("Nutritionist2", "Human,Anthro");
    TraitTags:add("Emaciated", "Human,Anthro");
    TraitTags:add("Very Underweight", "Human,Anthro");
    TraitTags:add("Underweight", "Human,Anthro");
    TraitTags:add("Overweight", "Human,Anthro");
    TraitTags:add("Obese", "Human,Anthro");
    TraitTags:add("Strong", "Human,Anthro");
    TraitTags:add("Stout", "Human,Anthro");
    TraitTags:add("Weak", "Human,Anthro");
    TraitTags:add("Feeble", "Human,Anthro");
    TraitTags:add("Resilient", "Human,Anthro");
    TraitTags:add("ProneToIllness", "Human,Anthro");
    TraitTags:add("Agoraphobic", "Human,Anthro");
    TraitTags:add("Claustophobic", "Human,Anthro");
    TraitTags:add("Lucky", "Human,Anthro");
    TraitTags:add("Unlucky", "Human,Anthro");
    TraitTags:add("Marksman", "Human,Anthro");
    TraitTags:add("NightOwl", "Human,Anthro");
    TraitTags:add("Outdoorsman", "Human,Anthro");
    TraitTags:add("FastHealer", "Human,Anthro");
    TraitTags:add("FastLearner", "Human,Anthro");
    TraitTags:add("FastReader", "Human,Anthro");
    TraitTags:add("AdrenalineJunkie", "Human,Anthro");
    TraitTags:add("Inconspicuous", "Human,Anthro");
    TraitTags:add("NeedsLessSleep", "Human,Anthro");
    TraitTags:add("NightVision", "Anthro,KeenVision");
    TraitTags:add("Organized", "Human,Anthro");
    TraitTags:add("LowThirst", "Human,Anthro");
    TraitTags:add("Burglar", "Human,Anthro");
    TraitTags:add("FirstAid", "Human,Anthro");
    TraitTags:add("Fishing", "Human,Anthro");
    TraitTags:add("Gardener", "Human,Anthro");
    TraitTags:add("Jogger", "Human,Anthro");
    TraitTags:add("SlowHealer", "Human,Anthro");
    TraitTags:add("SlowLearner", "Human,Anthro");
    TraitTags:add("SlowReader", "Human,Anthro");
    TraitTags:add("NeedsMoreSleep", "Human,Anthro");
    TraitTags:add("Conspicuous", "Human,Anthro");
    TraitTags:add("Disorganized", "Human,Anthro");
    TraitTags:add("HighThirst", "Human,Anthro");
    TraitTags:add("Illiterate", "Human,Anthro");
    TraitTags:add("Insomniac", "Human,Anthro");
    TraitTags:add("Pacifist", "Human,Anthro");
    TraitTags:add("Thinskinned", "Human,Anthro");
    TraitTags:add("Smoker", "Human,Anthro");
    TraitTags:add("Tailor", "Human,Anthro");
    TraitTags:add("Dextrous", "Human,Anthro");
    TraitTags:add("AllThumbs", "Human,Anthro");
    TraitTags:add("Desensitized", "Human,Anthro");
    TraitTags:add("WeakStomach", "Human,Anthro");
    TraitTags:add("IronGut", "Anthro,Scavenger");
    TraitTags:add("Hemophobic", "Human,Anthro");
    TraitTags:add("Asthmatic", "Human,Anthro");
    TraitTags:add("Cook", "Human,Anthro");
    TraitTags:add("Cook2", "Human,Anthro");
    TraitTags:add("Herbalist", "Human,Anthro");
    TraitTags:add("Brawler", "Human,Anthro");
    TraitTags:add("Formerscout", "Human,Anthro");
    TraitTags:add("BaseballPlayer", "Human,Anthro");
    TraitTags:add("Hiker", "Human,Anthro");
    TraitTags:add("Hunter", "Human,Anthro");
    TraitTags:add("Gymnast", "Human,Anthro");
    TraitTags:add("Mechanics", "Human,Anthro");
    TraitTags:add("Mechanics2", "Human,Anthro");
---------------------------------------------------------------------------------------------------------------------------------------------------------------

    local AT_Hooves = TraitFactory.addTrait("AT_Hooves", getText("UI_trait_AT_Hooves"), 2, getText("UI_trait_AT_Hooves_desc"), false);
    AT_Hooves:addXPBoost(Perks.Sprinting, 1);
    AT_Hooves:addXPBoost(Perks.Nimble, 1);
    TraitTags:add("AT_Hooves", "Anthro,Hooves");

    local AT_Paws = TraitFactory.addTrait("AT_Paws", getText("UI_trait_AT_Paws"), 2, getText("UI_trait_AT_Paws_desc"), false);
    AT_Paws:addXPBoost(Perks.Lightfoot, 1);
    AT_Paws:addXPBoost(Perks.Sneak, 1);
    TraitTags:add("AT_Paws", "Anthro,Paws");

    local AT_Body = TraitFactory.addTrait("AT_FeralBody", getText("UI_trait_AT_FeralBody"), 1, getText("UI_trait_AT_FeralBody_desc"), false);
    AT_Body:addXPBoost(Perks.Strength, 1);
    AT_Body:addXPBoost(Perks.Fitness, -1);
    TraitTags:add("AT_Body", "Anthro");

    --see handy?
    local AT_Carpenter = TraitFactory.addTrait("AT_Carpenter", getText("UI_trait_AT_Carpenter"), 2, getText("UI_trait_AT_Carpenter_desc"), false);
    AT_Carpenter:addXPBoost(Perks.Woodwork, 1)
    TraitTags:add("AT_Carpenter", "Human,Anthro,HabitatBuilder");

    TraitFactory.addTrait("AT_Tail", getText("UI_trait_AT_Tail"), 2, getText("UI_trait_AT_Tail_desc"), false);
    TraitTags:add("AT_Tail", "Anthro,Tail");

    TraitFactory.addTrait("AT_Immunity", getText("UI_trait_AT_Immunity"), 4, getText("UI_trait_AT_Immunity_desc"), false);
    TraitTags:add("AT_Immunity", "Anthro");

    TraitFactory.addTrait("AT_Herbivore", getText("UI_trait_AT_Herbivore"), 2, getText("UI_trait_AT_Herbivore_desc"), false);
    TraitTags:add("AT_Herbivore", "Anthro,Herbivore");
    TraitFactory.addTrait("AT_Carnivore", getText("UI_trait_AT_Carnivore"), 2, getText("UI_trait_AT_Carnivore_desc"), false);
    TraitTags:add("AT_Carnivore", "Anthro,Carnivore");
    TraitFactory.addTrait("AT_CarrionEater", getText("UI_trait_AT_CarrionEater"), 3, getText("UI_trait_AT_CarrionEater_desc"), false);
    TraitTags:add("AT_CarrionEater", "Anthro,Carnivore,Scavenger");
    TraitFactory.addTrait("AT_FoodMotivated", getText("UI_trait_AT_FoodMotivated"), 1, getText("UI_trait_AT_FoodMotivated_desc"), false);
    TraitTags:add("AT_FoodMotivated", "Anthro");
    TraitFactory.addTrait("AT_FeralDigestion", getText("UI_trait_AT_FeralDigestion"), -4, getText("UI_trait_AT_FeralDigestion_desc"), false);
    TraitTags:add("AT_FeralDigestion", "Anthro");
    TraitFactory.addTrait("AT_Bug-o-ssieur", getText("UI_trait_AT_Bug-o-ssieur"), 1, getText("UI_trait_AT_Bug-o-ssieur_desc"), false);
    TraitTags:add("AT_Bug-o-ssieur", "Human,Anthro");
    -- (see ?lark?)TraitFactory.addTrait("AT_Diurnal", getText("UI_trait_AT_Diurnal"), 1, getText("UI_trait_AT_Diurnal_desc"), false);
    -- (see night owl)TraitFactory.addTrait("AT_Nocturnal", getText("UI_trait_AT_Nocturnal"), 1, getText("UI_trait_AT_Nocturnal_desc"), false);
    -- TraitFactory.addTrait("AT_Hibernator", getText("UI_trait_AT_Hibernator"), 1, getText("UI_trait_AT_Hibernator_desc"), false);

    TraitFactory.addTrait("AT_KeenSmell", getText("UI_trait_AT_KeenSmell"), 4, getText("UI_trait_AT_KeenSmell_desc"), false);
    TraitTags:add("AT_KeenSmell", "Anthro,KeenSmell");
    -- (vision can't be updated via lua)TraitFactory.addTrait("AT_KeenEyes", getText("UI_trait_AT_KeenEyes"), 1, getText("UI_trait_AT_KeenEyes_desc"), false);
    -- (vision can't be updated via lua)TraitFactory.addTrait("AT_KeenHearing", getText("UI_trait_AT_KeenHearing"), 1, getText("UI_trait_AT_KeenHearing_desc"), false);

    -- (see shortsighted) TraitFactory.addTrait("AT_BadEyes", getText("UI_trait_AT_BadEyes"), 1, getText("UI_trait_AT_BadEyes_desc"), false);
    -- (see hard of hearing) TraitFactory.addTrait("AT_BadHearing", getText("UI_trait_AT_BadHearing"), 1, getText("UI_trait_AT_BadHearing_desc"), false);

    -- TraitFactory.addTrait("AT_WannaGoCar", getText("UI_trait_AT_WannaGoCar"), 1, getText("UI_trait_AT_WannaGoCar_desc"), false);

    --TraitFactory.addTrait("AT_ColdBlooded", getText("UI_trait_AT_ColdBlooded"), -4, getText("UI_trait_AT_ColdBlooded_desc"), false);
    TraitFactory.addTrait("AT_Stinky", getText("UI_trait_AT_Stinky"), -4, getText("UI_trait_AT_Stinky_desc"), false);
    TraitTags:add("AT_Stinky", "Human,Anthro");
    TraitFactory.addTrait("AT_Exclaimer", getText("UI_trait_AT_Exclaimer"), -6, getText("UI_trait_AT_Exclaimer_desc"), false);
    TraitTags:add("AT_Exclaimer", "Human,Anthro");
    -- TraitFactory.addTrait("AT_Sly", getText("UI_trait_AT_Sly"), 1, getText("UI_trait_AT_Sly_desc"), false);
    TraitFactory.addTrait("AT_Slinky", getText("UI_trait_AT_Slinky"), 2, getText("UI_trait_AT_Slinky_desc"), false);
    TraitTags:add("AT_Slinky", "Anthro,Agile");
    TraitFactory.addTrait("AT_UnwieldyHands", getText("UI_trait_AT_UnwieldyHands"), -4, getText("UI_trait_AT_UnwieldyHands_desc"), false);
    TraitTags:add("AT_UnwieldyHands", "Anthro,ThreeFingers");
    TraitFactory.addTrait("AT_NaturalTumbler", getText("UI_trait_AT_NaturalTumbler"), 3, getText("UI_trait_AT_NaturalTumbler_desc"), false);
    TraitTags:add("AT_NaturalTumbler", "Anthro,Agile");
    TraitFactory.addTrait("AT_VestigialWings", getText("UI_trait_AT_VestigialWings"), 5, getText("UI_trait_AT_VestigialWings_desc"), false);
    TraitTags:add("AT_VestigialWings", "Anthro,Winged");
    -- (see stout) TraitFactory.addTrait("AT_BeastOfBurden", getText("UI_trait_AT_BeastOfBurden"), 1, getText("UI_trait_AT_BeastOfBurden_desc"), false);
    TraitFactory.addTrait("AT_BullRush", getText("UI_trait_AT_BullRush"), 6, getText("UI_trait_AT_BullRush_desc"), false);
    TraitTags:add("AT_BullRush", "Anthro,Horns");
    -- TraitFactory.addTrait("AT_NoThoughts", getText("UI_trait_AT_NoThoughts"), 1, getText("UI_trait_AT_NoThoughts_desc"), false);
    -- TraitFactory.addTrait("AT_NotCute", getText("UI_trait_AT_NotCute"), 1, getText("UI_trait_AT_NotCute_desc"), false);
    -- TraitFactory.addTrait("AT_SelfClean", getText("UI_trait_AT_SelfClean"), 1, getText("UI_trait_AT_SelfClean_desc"), false);
    -- TraitFactory.addTrait("AT_ThickCoat", getText("UI_trait_AT_ThickCoat"), 1, getText("UI_trait_AT_ThickCoat_desc"), false);

    TraitFactory.setMutualExclusive("AT_Paws", "AT_Hooves");
    TraitFactory.setMutualExclusive("AT_Herbivore", "AT_Carnivore");
    TraitFactory.setMutualExclusive("AT_Herbivore", "AT_CarrionEater");
    TraitFactory.setMutualExclusive("AT_NaturalTumbler", "AT_VestigialWings");

end

Events.OnGameBoot.Add(initAnthroTraits);