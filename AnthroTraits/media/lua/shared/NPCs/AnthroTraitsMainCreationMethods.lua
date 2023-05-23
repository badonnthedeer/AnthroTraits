require('NPCs/MainCreationMethods');
-- C:\Program Files (x86)\Steam\steamapps\common\ProjectZomboid\media\lua | Project Zomboid files
-- C:\Program Files (x86)\Steam\steamapps\workshop\content\108600\2730251452\mods | Expanded Traits
-- C:\Program Files (x86)\Steam\steamapps\workshop\content\108600\1299328280\mods | More Traits
-- C:\Program Files (x86)\Steam\steamapps\workshop\content\108600\2792245343\mods | More Simple Traits

--C:\Users\Zach\Zomboid\mods
-- C:\Users\Zach\Zomboid\Logs


local function initAnthroTraits()

    local AT_Hooves = TraitFactory.addTrait("AT_Hooves", getText("UI_trait_AT_Hooves"), 2, getText("UI_trait_AT_Hooves_desc"), false);
    AT_Hooves:addXPBoost(Perks.Sprinting, 1);
    AT_Hooves:addXPBoost(Perks.Nimble, 1);

    local AT_Paws = TraitFactory.addTrait("AT_Paws", getText("UI_trait_AT_Paws"), 2, getText("UI_trait_AT_Paws_desc"), false);
    AT_Paws:addXPBoost(Perks.Lightfoot, 1);
    AT_Paws:addXPBoost(Perks.Sneak, 1);

    local AT_Body = TraitFactory.addTrait("AT_FeralBody", getText("UI_trait_AT_FeralBody"), 2, getText("UI_trait_AT_FeralBody_desc"), false);
    AT_Body:addXPBoost(Perks.Strength, 1);
    AT_Body:addXPBoost(Perks.Fitness, -1);

    --see handy?
    local AT_Carpenter = TraitFactory.addTrait("AT_Carpenter", getText("UI_trait_AT_Carpenter"), 2, getText("UI_trait_AT_Carpenter_desc"), false);
    AT_Carpenter:addXPBoost(Perks.Woodwork, 1)

    TraitFactory.addTrait("AT_Immunity", getText("UI_trait_AT_Immunity"), 4, getText("UI_trait_AT_Immunity_desc"), false);

    TraitFactory.addTrait("AT_Herbivore", getText("UI_trait_AT_Herbivore"), 2, getText("UI_trait_AT_Herbivore_desc"), false);
    TraitFactory.addTrait("AT_Carnivore", getText("UI_trait_AT_Carnivore"), 2, getText("UI_trait_AT_Carnivore_desc"), false);
    TraitFactory.addTrait("AT_CarrionEater", getText("UI_trait_AT_CarrionEater"), 3, getText("UI_trait_AT_CarrionEater_desc"), false);
    TraitFactory.addTrait("AT_FoodMotivated", getText("UI_trait_AT_FoodMotivated"), 1, getText("UI_trait_AT_FoodMotivated_desc"), false);
    TraitFactory.addTrait("AT_FeralDigestion", getText("UI_trait_AT_FeralDigestion"), -4, getText("UI_trait_AT_FeralDigestion_desc"), false);
    TraitFactory.addTrait("AT_Bug-o-ssieur", getText("UI_trait_AT_Bug-o-ssieur"), 1, getText("UI_trait_AT_Bug-o-ssieur_desc"), false);

    -- (see ?lark?)TraitFactory.addTrait("AT_Diurnal", getText("UI_trait_AT_Diurnal"), 1, getText("UI_trait_AT_Diurnal_desc"), false);
    -- (see night owl)TraitFactory.addTrait("AT_Nocturnal", getText("UI_trait_AT_Nocturnal"), 1, getText("UI_trait_AT_Nocturnal_desc"), false);
    -- TraitFactory.addTrait("AT_Hibernator", getText("UI_trait_AT_Hibernator"), 1, getText("UI_trait_AT_Hibernator_desc"), false);

    --TraitFactory.addTrait("AT_KeenSmell", getText("UI_trait_AT_KeenSmell"), 1, getText("UI_trait_AT_KeenSmell_desc"), false);
    -- (vision can't be updated via lua)TraitFactory.addTrait("AT_KeenEyes", getText("UI_trait_AT_KeenEyes"), 1, getText("UI_trait_AT_KeenEyes_desc"), false);
    -- (vision can't be updated via lua)TraitFactory.addTrait("AT_KeenHearing", getText("UI_trait_AT_KeenHearing"), 1, getText("UI_trait_AT_KeenHearing_desc"), false);

    -- (see shortsighted) TraitFactory.addTrait("AT_BadEyes", getText("UI_trait_AT_BadEyes"), 1, getText("UI_trait_AT_BadEyes_desc"), false);
    -- (see hard of hearing) TraitFactory.addTrait("AT_BadHearing", getText("UI_trait_AT_BadHearing"), 1, getText("UI_trait_AT_BadHearing_desc"), false);

    -- TraitFactory.addTrait("AT_ColdBlooded", getText("UI_trait_AT_ColdBlooded"), 1, getText("UI_trait_AT_ColdBlooded_desc"), false);
    TraitFactory.addTrait("AT_Stinky", getText("UI_trait_AT_Stinky"), 1, getText("UI_trait_AT_Stinky_desc"), false);
    TraitFactory.addTrait("AT_Exclaimer", getText("UI_trait_AT_Exclaimer"), -6, getText("UI_trait_AT_Exclaimer_desc"), false);
    -- TraitFactory.addTrait("AT_Sly", getText("UI_trait_AT_Sly"), 1, getText("UI_trait_AT_Sly_desc"), false);
    -- TraitFactory.addTrait("AT_Slinky", getText("UI_trait_AT_Slinky"), 1, getText("UI_trait_AT_Slinky_desc"), false);
    TraitFactory.addTrait("AT_NaturalTumbler", getText("UI_trait_AT_NaturalTumbler"), 3, getText("UI_trait_AT_NaturalTumbler_desc"), false);
    TraitFactory.addTrait("AT_VestigialWings", getText("UI_trait_AT_VestigialWings"), 5, getText("UI_trait_AT_VestigialWings_desc"), false);
    -- (see stout) TraitFactory.addTrait("AT_BeastOfBurden", getText("UI_trait_AT_BeastOfBurden"), 1, getText("UI_trait_AT_BeastOfBurden_desc"), false);
    -- TraitFactory.addTrait("AT_HornedCharger", getText("UI_trait_AT_HornedCharger"), 1, getText("UI_trait_AT_HornedCharger_desc"), false);
    -- TraitFactory.addTrait("AT_NoThoughts", getText("UI_trait_AT_NoThoughts"), 1, getText("UI_trait_AT_NoThoughts_desc"), false);
    -- TraitFactory.addTrait("AT_NotCute", getText("UI_trait_AT_NotCute"), 1, getText("UI_trait_AT_NotCute_desc"), false);
    -- TraitFactory.addTrait("AT_SelfClean", getText("UI_trait_AT_SelfClean"), 1, getText("UI_trait_AT_SelfClean_desc"), false);
    -- TraitFactory.addTrait("AT_ThickCoat", getText("UI_trait_AT_ThickCoat"), 1, getText("UI_trait_AT_ThickCoat_desc"), false);

    TraitFactory.setMutualExclusive("AT_Paws", "AT_Hooves");
    TraitFactory.setMutualExclusive("AT_Herbivore", "AT_Carnivore");
    TraitFactory.setMutualExclusive("AT_NaturalTumbler", "AT_VestigialWings");

end

Events.OnGameBoot.Add(initAnthroTraits);