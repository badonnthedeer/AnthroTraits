require('NPCs/MainCreationMethods');
-- C:\Program Files (x86)\Steam\steamapps\common\ProjectZomboid\media\lua | Project Zomboid files
-- C:\Program Files (x86)\Steam\steamapps\workshop\content\108600\2730251452\mods | Expanded Traits
-- C:\Program Files (x86)\Steam\steamapps\workshop\content\108600\1299328280\mods | More Traits
-- C:\Program Files (x86)\Steam\steamapps\workshop\content\108600\2792245343\mods | More Simple Traits

--C:\Users\Zach\Zomboid\mods
-- C:\Users\Zach\Zomboid\Logs


local function initAnthroTraits()

    TraitFactory.addTrait("Axeman", getText("UI_trait_axeman"), 0, getText("UI_trait_axemandesc"), true);
    TraitFactory.addTrait("Handy", getText("UI_trait_handy"), 8, getText("UI_trait_handydesc"), false);

    TraitFactory.addTrait("SpeedDemon", getText("UI_trait_SpeedDemon"), 1, getText("UI_trait_SpeedDemonDesc"), false);
    TraitFactory.addTrait("SundayDriver", getText("UI_trait_SundayDriver"), -1, getText("UI_trait_SundayDriverDesc"), false);
    TraitFactory.addTrait("Brave", getText("UI_trait_brave"), 4, getText("UI_trait_bravedesc"), false);
    TraitFactory.addTrait("Cowardly", getText("UI_trait_cowardly"), -2, getText("UI_trait_cowardlydesc"), false);
    TraitFactory.addTrait("Clumsy", getText("UI_trait_clumsy"), -2, getText("UI_trait_clumsydesc"), false);
    TraitFactory.addTrait("Graceful", getText("UI_trait_graceful"), 4, getText("UI_trait_gracefuldesc"), false);
    TraitFactory.addTrait("ShortSighted", getText("UI_trait_shortsigh"), -2, getText("UI_trait_shortsighdesc"), false);
    TraitFactory.addTrait("HardOfHearing", getText("UI_trait_hardhear"), -4, getText("UI_trait_hardheardesc"), false);
    TraitFactory.addTrait("Deaf", getText("UI_trait_deaf"), -12, getText("UI_trait_deafdesc"), false);
    TraitFactory.addTrait("KeenHearing", getText("UI_trait_keenhearing"), 6, getText("UI_trait_keenhearingdesc"), false);
    TraitFactory.addTrait("EagleEyed", getText("UI_trait_eagleeyed"), 6, getText("UI_trait_eagleeyeddesc"), false);
    TraitFactory.addTrait("HeartyAppitite", getText("UI_trait_heartyappetite"), -4, getText("UI_trait_heartyappetitedesc"), false);
    TraitFactory.addTrait("LightEater", getText("UI_trait_lighteater"), 4, getText("UI_trait_lighteaterdesc"), false);
    TraitFactory.addTrait("ThickSkinned", getText("UI_trait_thickskinned"), 8, getText("UI_trait_thickskinneddesc"), false);
    TraitFactory.addTrait("Unfit", getText("UI_trait_unfit"), -10, getText("UI_trait_unfitdesc"), false);
    TraitFactory.addTrait("Out of Shape", getText("UI_trait_outofshape"), -6, getText("UI_trait_outofshapedesc"), false);
    TraitFactory.addTrait("Fit", getText("UI_trait_fit"), 6, getText("UI_trait_fitdesc"), false);
    TraitFactory.addTrait("Athletic", getText("UI_trait_athletic"), 10, getText("UI_trait_athleticdesc"), false);
    TraitFactory.addTrait("Nutritionist", getText("UI_trait_nutritionist"), 4, getText("UI_trait_nutritionistdesc"), false);
    TraitFactory.addTrait("Nutritionist2", getText("UI_trait_nutritionist"), 0, getText("UI_trait_nutritionistdesc"), true);
    TraitFactory.addTrait("Emaciated", getText("UI_trait_emaciated"), -10, getText("UI_trait_emaciateddesc"), true);
    TraitFactory.addTrait("Very Underweight", getText("UI_trait_veryunderweight"), -10, getText("UI_trait_veryunderweightdesc"), false);
    TraitFactory.addTrait("Underweight", getText("UI_trait_underweight"), -6, getText("UI_trait_underweightdesc"), false);
    TraitFactory.addTrait("Overweight", getText("UI_trait_overweight"), -6, getText("UI_trait_overweightdesc"), false);
    TraitFactory.addTrait("Obese", getText("UI_trait_obese"), -10, getText("UI_trait_obesedesc"), false);
    TraitFactory.addTrait("Strong", getText("UI_trait_strong"), 10, getText("UI_trait_strongdesc"), false);
    TraitFactory.addTrait("Stout", getText("UI_trait_stout"), 6, getText("UI_trait_stoutdesc"), false);
    TraitFactory.addTrait("Weak", getText("UI_trait_weak"), -10, getText("UI_trait_weakdesc"), false);
    TraitFactory.addTrait("Feeble", getText("UI_trait_feeble"), -6, getText("UI_trait_feebledesc"), false);
    TraitFactory.addTrait("Resilient", getText("UI_trait_resilient"), 4, getText("UI_trait_resilientdesc"), false);
    TraitFactory.addTrait("ProneToIllness", getText("UI_trait_pronetoillness"), -4, getText("UI_trait_pronetoillnessdesc"), false);
    TraitFactory.addTrait("Agoraphobic", getText("UI_trait_agoraphobic"), -4, getText("UI_trait_agoraphobicdesc"), false);
    TraitFactory.addTrait("Claustophobic", getText("UI_trait_claustro"), -4, getText("UI_trait_claustrodesc"), false);
    TraitFactory.addTrait("Lucky", getText("UI_trait_lucky"), 4, getText("UI_trait_luckydesc"), false, true);
    TraitFactory.addTrait("Unlucky", getText("UI_trait_unlucky"), -4, getText("UI_trait_unluckydesc"), false, true);
    TraitFactory.addTrait("Marksman", getText("UI_trait_marksman"), 0, getText("UI_trait_marksmandesc"), true);
    TraitFactory.addTrait("NightOwl", getText("UI_trait_nightowl"), 0, getText("UI_trait_nightowldesc"), true);

    TraitFactory.addTrait("Outdoorsman", getText("UI_trait_outdoorsman"), 2, getText("UI_trait_outdoorsmandesc"), false);

    local sleepOK = (isClient() or isServer()) and getServerOptions():getBoolean("SleepAllowed") and getServerOptions():getBoolean("SleepNeeded")

    TraitFactory.addTrait("FastHealer", getText("UI_trait_FastHealer"), 6, getText("UI_trait_FastHealerDesc"), false);
    TraitFactory.addTrait("FastLearner", getText("UI_trait_FastLearner"), 6, getText("UI_trait_FastLearnerDesc"), false);
    TraitFactory.addTrait("FastReader", getText("UI_trait_FastReader"), 2, getText("UI_trait_FastReaderDesc"), false);
    TraitFactory.addTrait("AdrenalineJunkie", getText("UI_trait_AdrenalineJunkie"), 8, getText("UI_trait_AdrenalineJunkieDesc"), false);
    TraitFactory.addTrait("Inconspicuous", getText("UI_trait_Inconspicuous"), 4, getText("UI_trait_InconspicuousDesc"), false);
    TraitFactory.addTrait("NeedsLessSleep", getText("UI_trait_LessSleep"), 2, getText("UI_trait_LessSleepDesc"), false, not sleepOK);
    TraitFactory.addTrait("NightVision", getText("UI_trait_NightVision"), 2, getText("UI_trait_NightVisionDesc"), false);
    TraitFactory.addTrait("Organized", getText("UI_trait_Packmule"), 6, getText("UI_trait_PackmuleDesc"), false);
    TraitFactory.addTrait("LowThirst", getText("UI_trait_LowThirst"), 6, getText("UI_trait_LowThirstDesc"), false);
    TraitFactory.addTrait("Burglar", getText("UI_prof_Burglar"), 0, getText("UI_trait_BurglarDesc"), true);

    TraitFactory.addTrait("FirstAid", getText("UI_trait_FirstAid"), 4, getText("UI_trait_FirstAidDesc"), false);

    TraitFactory.addTrait("Fishing", getText("UI_trait_Fishing"), 4, getText("UI_trait_FishingDesc"), false);

    TraitFactory.addTrait("Gardener", getText("UI_trait_Gardener"), 4, getText("UI_trait_GardenerDesc"), false);

    TraitFactory.addTrait("Jogger", getText("UI_trait_Jogger"), 4, getText("UI_trait_JoggerDesc"), false);

    TraitFactory.addTrait("SlowHealer", getText("UI_trait_SlowHealer"), -6, getText("UI_trait_SlowHealerDesc"), false);
    TraitFactory.addTrait("SlowLearner", getText("UI_trait_SlowLearner"), -6, getText("UI_trait_SlowLearnerDesc"), false);
    TraitFactory.addTrait("SlowReader", getText("UI_trait_SlowReader"), -2, getText("UI_trait_SlowReaderDesc"), false);
    TraitFactory.addTrait("NeedsMoreSleep", getText("UI_trait_MoreSleep"), -4, getText("UI_trait_MoreSleepDesc"), false, not sleepOK);
    TraitFactory.addTrait("Conspicuous", getText("UI_trait_Conspicuous"), -4, getText("UI_trait_ConspicuousDesc"), false);
    TraitFactory.addTrait("Disorganized", getText("UI_trait_Disorganized"), -4, getText("UI_trait_DisorganizedDesc"), false);
    TraitFactory.addTrait("HighThirst", getText("UI_trait_HighThirst"), -6, getText("UI_trait_HighThirstDesc"), false);
    TraitFactory.addTrait("Illiterate", getText("UI_trait_Illiterate"), -8, getText("UI_trait_IlliterateDesc"), false);
    TraitFactory.addTrait("Insomniac", getText("UI_trait_Insomniac"), -6, getText("UI_trait_InsomniacDesc"), false, not sleepOK);
    TraitFactory.addTrait("Pacifist", getText("UI_trait_Pacifist"), -4, getText("UI_trait_PacifistDesc"), false);
    TraitFactory.addTrait("Thinskinned", getText("UI_trait_ThinSkinned"), -8, getText("UI_trait_ThinSkinnedDesc"), false);
    TraitFactory.addTrait("Smoker", getText("UI_trait_Smoker"), -4, getText("UI_trait_SmokerDesc"), false);
    TraitFactory.addTrait("Tailor", getText("UI_trait_Tailor"), 4, getText("UI_trait_TailorDesc"), false);


    TraitFactory.addTrait("Dextrous", getText("UI_trait_Dexterous"), 2, getText("UI_trait_DexterousDesc"), false);
    TraitFactory.addTrait("AllThumbs", getText("UI_trait_AllThumbs"), -2, getText("UI_trait_AllThumbsDesc"), false);

    TraitFactory.addTrait("Desensitized", getText("UI_trait_Desensitized"), 0, getText("UI_trait_DesensitizedDesc"), true);
    TraitFactory.addTrait("WeakStomach", getText("UI_trait_WeakStomach"), -3, getText("UI_trait_WeakStomachDesc"), false);
    TraitFactory.addTrait("IronGut", getText("UI_trait_IronGut"), 3, getText("UI_trait_IronGutDesc"), false);
    TraitFactory.addTrait("Hemophobic", getText("UI_trait_Hemophobic"), -5, getText("UI_trait_HemophobicDesc"), false);
    TraitFactory.addTrait("Asthmatic", getText("UI_trait_Asthmatic"), -5, getText("UI_trait_AsthmaticDesc"), false);

    TraitFactory.addTrait("Cook", getText("UI_trait_Cook"), 6, getText("UI_trait_CookDesc"), false);
    TraitFactory.addTrait("Cook2", getText("UI_trait_Cook"), 0, getText("UI_trait_Cook2Desc"), true);

    TraitFactory.addTrait("Herbalist", getText("UI_trait_Herbalist"), 6, getText("UI_trait_HerbalistDesc"), false);

    TraitFactory.addTrait("Brawler", getText("UI_trait_BarFighter"), 6, getText("UI_trait_BarFighterDesc"), false);

    TraitFactory.addTrait("Formerscout", getText("UI_trait_Scout"), 6, getText("UI_trait_ScoutDesc"), false);

    TraitFactory.addTrait("BaseballPlayer", getText("UI_trait_PlaysBaseball"), 4, getText("UI_trait_PlaysBaseballDesc"), false);


    TraitFactory.addTrait("Hiker", getText("UI_trait_Hiker"), 6, getText("UI_trait_HikerDesc"), false);


    TraitFactory.addTrait("Hunter", getText("UI_trait_Hunter"), 8, getText("UI_trait_HunterDesc"), false);


    TraitFactory.addTrait("Gymnast", getText("UI_trait_Gymnast"), 5, getText("UI_trait_GymnastDesc"), false);

    TraitFactory.addTrait("Mechanics", getText("UI_trait_Mechanics"), 5, getText("UI_trait_MechanicsDesc"), false);

    TraitFactory.addTrait("Mechanics2", getText("UI_trait_Mechanics"), 0, getText("UI_trait_Mechanics2Desc"), true);
---------------------------------------------------------------------------------------------------------------------------------------------------------------

    local AT_Hooves = TraitFactory.addTrait("AT_Hooves", getText("UI_trait_AT_Hooves"), 2, getText("UI_trait_AT_Hooves_desc"), false);
    AT_Hooves:addXPBoost(Perks.Sprinting, 1);
    AT_Hooves:addXPBoost(Perks.Nimble, 1);

    local AT_Paws = TraitFactory.addTrait("AT_Paws", getText("UI_trait_AT_Paws"), 2, getText("UI_trait_AT_Paws_desc"), false);
    AT_Paws:addXPBoost(Perks.Lightfoot, 1);
    AT_Paws:addXPBoost(Perks.Sneak, 1);

    local AT_Body = TraitFactory.addTrait("AT_FeralBody", getText("UI_trait_AT_FeralBody"), 1, getText("UI_trait_AT_FeralBody_desc"), false);
    AT_Body:addXPBoost(Perks.Strength, 1);
    AT_Body:addXPBoost(Perks.Fitness, -1);

    --see handy?
    local AT_Carpenter = TraitFactory.addTrait("AT_Carpenter", getText("UI_trait_AT_Carpenter"), 2, getText("UI_trait_AT_Carpenter_desc"), false);
    AT_Carpenter:addXPBoost(Perks.Woodwork, 1)

    TraitFactory.addTrait("AT_Tail", getText("UI_trait_AT_Tail"), 2, getText("UI_trait_AT_Tail_desc"), false);

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

    TraitFactory.addTrait("AT_KeenSmell", getText("UI_trait_AT_KeenSmell"), 4, getText("UI_trait_AT_KeenSmell_desc"), false);
    -- (vision can't be updated via lua)TraitFactory.addTrait("AT_KeenEyes", getText("UI_trait_AT_KeenEyes"), 1, getText("UI_trait_AT_KeenEyes_desc"), false);
    -- (vision can't be updated via lua)TraitFactory.addTrait("AT_KeenHearing", getText("UI_trait_AT_KeenHearing"), 1, getText("UI_trait_AT_KeenHearing_desc"), false);

    -- (see shortsighted) TraitFactory.addTrait("AT_BadEyes", getText("UI_trait_AT_BadEyes"), 1, getText("UI_trait_AT_BadEyes_desc"), false);
    -- (see hard of hearing) TraitFactory.addTrait("AT_BadHearing", getText("UI_trait_AT_BadHearing"), 1, getText("UI_trait_AT_BadHearing_desc"), false);

    -- TraitFactory.addTrait("AT_WannaGoCar", getText("UI_trait_AT_WannaGoCar"), 1, getText("UI_trait_AT_WannaGoCar_desc"), false);

    --TraitFactory.addTrait("AT_ColdBlooded", getText("UI_trait_AT_ColdBlooded"), -4, getText("UI_trait_AT_ColdBlooded_desc"), false);
    TraitFactory.addTrait("AT_Stinky", getText("UI_trait_AT_Stinky"), -4, getText("UI_trait_AT_Stinky_desc"), false);
    TraitFactory.addTrait("AT_Exclaimer", getText("UI_trait_AT_Exclaimer"), -6, getText("UI_trait_AT_Exclaimer_desc"), false);
    -- TraitFactory.addTrait("AT_Sly", getText("UI_trait_AT_Sly"), 1, getText("UI_trait_AT_Sly_desc"), false);
    TraitFactory.addTrait("AT_Slinky", getText("UI_trait_AT_Slinky"), 2, getText("UI_trait_AT_Slinky_desc"), false);
    TraitFactory.addTrait("AT_UnwieldyHands", getText("UI_trait_AT_UnwieldyHands"), -4, getText("UI_trait_AT_UnwieldyHands_desc"), false);
    TraitFactory.addTrait("AT_NaturalTumbler", getText("UI_trait_AT_NaturalTumbler"), 3, getText("UI_trait_AT_NaturalTumbler_desc"), false);
    TraitFactory.addTrait("AT_VestigialWings", getText("UI_trait_AT_VestigialWings"), 5, getText("UI_trait_AT_VestigialWings_desc"), false);
    -- (see stout) TraitFactory.addTrait("AT_BeastOfBurden", getText("UI_trait_AT_BeastOfBurden"), 1, getText("UI_trait_AT_BeastOfBurden_desc"), false);
    TraitFactory.addTrait("AT_BullRush", getText("UI_trait_AT_BullRush"), 6, getText("UI_trait_AT_BullRush_desc"), false);
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