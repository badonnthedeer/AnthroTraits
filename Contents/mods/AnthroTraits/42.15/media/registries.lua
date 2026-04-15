-- idea to define globals here inspired by "Simple Overhaul: Traits and Occupations" by hea
AnthroTraitsGlobals = AnthroTraitsGlobals or {}

AnthroTraitsGlobals.ModID = "AnthroTraits"
AnthroTraitsGlobals.WorkshopID = 3025679944
AnthroTraitsGlobals.ModVersion = 2.0
AnthroTraitsGlobals.UnwieldyHandsAffectedTimedActions =
{
    -- animal related
    "ISAttachAnimalToPlayer", "ISAttachAnimalToTree", "ISHutchGrabEgg", "ISMilkAnimal",
    -- fishing related
    "AIAttachLureAction", "AIRemoveLureAction",
    -- misc (from lua/shared/TimedActions) folder; client TimedActions are primarily for showing infos to players (nothing that really requires dexterity)
    "ISAddItemInRecipe", "ISApplyBandage", "ISApplyMakeUp", "ISBarricadeAction", "ISBBQInsertPropaneTank", "ISConnectCarBatteryToChargerAction",
    "ISCraftAction", "ISCutHair", "ISDeviceBatteryAction", "ISDismantleAction", "ISDyeHair", "ISFixAction", "ISFixGenerator",
    "ISFixVehiclePartAction", "ISLockDoor", "ISPadlockAction", "ISPadlockByCodeAction",
    "ISPickupBrokenGlass", "ISPlaceTrap", "ISPlugGenerator", "ISPlumbItem", "ISRemoveBrokenGlass",
    "ISRemoveBullet", "ISRemoveCarBatteryFromChargerAction", "ISRemoveWeaponUpgrade", "ISRepairClothing", "ISSplint", "ISStitch", "ISTakePillAction",
    "ISTakeTrap", "ISTrimBeard", "ISUnbarricadeAction", "ISUpgradeWeapon",
    -- building related
    "ISBuildAction", "ISMultiStageBuild", "ISPaintAction", "ISPaintSignAction", "ISPlasterAction", "ISWallpaperAction",
    -- farming related
    "ISCurePlantAction", "ISHarvestPlantAction", "ISSeedActionNew",
    -- moveable related
    "ISMoveablesAction",
    -- vehicles related
    "ISHotwireVehicle", "ISInstallVehiclePart", "ISRepairEngine", "ISRepairLightbar", "ISTakeEngineParts", "ISUninstallVehiclePart",
    -- entity (?) related
    "ISHandcraftAction",
}
-- not working because special time calculations: "ISEjectMagazine", "ISInsertMagazine", "ISLoadBulletsInMagazine", "ISRackFirearm", "ISReloadWeaponAction", "ISUnloadBulletsFromFirearm", "ISUnloadBulletsFromMagazine"

AnthroTraitsGlobals.CharacterTrait = {}
AnthroTraitsGlobals.FoodTags = {}
AnthroTraitsGlobals.FoodCharacterStatInfo = {}

AnthroTraitsGlobals.VESTIGIALWINGS_MAXFALLSPEED = 2;    -- 2 looks like a plausible fallspeed for someone with kinda (not) working wings
AnthroTraitsGlobals.BULLRUSH_PUSHSTART = 15;    -- player starts pushing zombies over after this many ticks
AnthroTraitsGlobals.BULLRUSH_PUSHINTERVAL = 8;
AnthroTraitsGlobals.BULLRUSH_PUSHRANGE = 1;
AnthroTraitsGlobals.BULLRUSH_PERZOMBIECOST_MIN = 0.001;
AnthroTraitsGlobals.BULLRUSH_PERZOMBIECOST_MAX = 0.02;

AnthroTraitsGlobals.CharacterTrait.ANTHROIMMUNITY = CharacterTrait.register("AnthroTraits:AT_AnthroImmunity")
AnthroTraitsGlobals.CharacterTrait.BEASTOFBURDEN = CharacterTrait.register("AnthroTraits:AT_BeastOfBurden")
AnthroTraitsGlobals.CharacterTrait.BUG_O_SSIEUR = CharacterTrait.register("AnthroTraits:AT_Bug_o_ssieur")
AnthroTraitsGlobals.CharacterTrait.BULLRUSH = CharacterTrait.register("AnthroTraits:AT_BullRush")
AnthroTraitsGlobals.CharacterTrait.CARNIVORE = CharacterTrait.register("AnthroTraits:AT_Carnivore")
AnthroTraitsGlobals.CharacterTrait.CARRIONEATER = CharacterTrait.register("AnthroTraits:AT_CarrionEater")
AnthroTraitsGlobals.CharacterTrait.DIGITIGRADE = CharacterTrait.register("AnthroTraits:AT_Digitigrade")
AnthroTraitsGlobals.CharacterTrait.EXCLAIMER = CharacterTrait.register("AnthroTraits:AT_Exclaimer")
AnthroTraitsGlobals.CharacterTrait.FERALBODY = CharacterTrait.register("AnthroTraits:AT_FeralBody")
AnthroTraitsGlobals.CharacterTrait.FERALDIGESTION = CharacterTrait.register("AnthroTraits:AT_FeralDigestion")
AnthroTraitsGlobals.CharacterTrait.FOODMOTIVATED = CharacterTrait.register("AnthroTraits:AT_FoodMotivated")
AnthroTraitsGlobals.CharacterTrait.HERBIVORE = CharacterTrait.register("AnthroTraits:AT_Herbivore")
AnthroTraitsGlobals.CharacterTrait.LONELY = CharacterTrait.register("AnthroTraits:AT_Lonely")
AnthroTraitsGlobals.CharacterTrait.NATURALTUMBLER = CharacterTrait.register("AnthroTraits:AT_NaturalTumbler")
AnthroTraitsGlobals.CharacterTrait.STINKY = CharacterTrait.register("AnthroTraits:AT_Stinky")
AnthroTraitsGlobals.CharacterTrait.TAIL = CharacterTrait.register("AnthroTraits:AT_Tail")
AnthroTraitsGlobals.CharacterTrait.TORPOR = CharacterTrait.register("AnthroTraits:AT_Torpor")
AnthroTraitsGlobals.CharacterTrait.UNGULIGRADE = CharacterTrait.register("AnthroTraits:AT_Unguligrade")
AnthroTraitsGlobals.CharacterTrait.UNWIELDYHANDS = CharacterTrait.register("AnthroTraits:AT_UnwieldyHands")
AnthroTraitsGlobals.CharacterTrait.VESTIGIALWINGS = CharacterTrait.register("AnthroTraits:AT_VestigialWings")
AnthroTraitsGlobals.CharacterTrait.VOICEAVIAN = CharacterTrait.register("AnthroTraits:AT_VoiceAvian")
AnthroTraitsGlobals.CharacterTrait.VOICEFELINE = CharacterTrait.register("AnthroTraits:AT_VoiceFeline")
AnthroTraitsGlobals.CharacterTrait.VOICESHEEP = CharacterTrait.register("AnthroTraits:AT_VoiceSheep")

AnthroTraitsGlobals.ExclaimerTraits = {}
AnthroTraitsGlobals.ExclaimerTraits[AnthroTraitsGlobals.CharacterTrait.VOICEAVIAN] = "AnthroTraits:AT_VoiceAvian";
AnthroTraitsGlobals.ExclaimerTraits[AnthroTraitsGlobals.CharacterTrait.VOICEFELINE] = "AnthroTraits:AT_VoiceFeline";
AnthroTraitsGlobals.ExclaimerTraits[AnthroTraitsGlobals.CharacterTrait.VOICESHEEP] = "AnthroTraits:AT_VoiceSheep";

AnthroTraitsGlobals.FoodTraits = { }
-- rotten stats are affected by food age and will be counteracted by e.g. carrion eater (technically, Hunger is also affected by age but carrion eater already gives hunger bonus)
AnthroTraitsGlobals.FoodTraits.ROTTENSTATS = { "Boredom", "Endurance", "Stress", "Unhappiness", "Food_Sickness" }
AnthroTraitsGlobals.FoodTraits.NUTRITIONSTATS = { "Hunger", "Carbohydrates", "Lipids", "Proteins", "Calories" }
AnthroTraitsGlobals.FoodTraits.FOODMOTIVATEDSTATS = { "Boredom", "Stress", "Unhappiness" }

AnthroTraitsGlobals.FoodTags.CARNIVORE = ItemTag.register("AnthroTraits:ATCarnivore")
AnthroTraitsGlobals.FoodTags.HERBIVORE = ItemTag.register("AnthroTraits:ATHerbivore")
AnthroTraitsGlobals.FoodTags.INSECT = ItemTag.register("AnthroTraits:ATInsect")
AnthroTraitsGlobals.FoodTags.FERALPOISON = ItemTag.register("AnthroTraits:ATFeralPoison")
AnthroTraitsGlobals.FoodTags.FOODMOTIVATED = ItemTag.register("AnthroTraits:ATFoodMotivated")
