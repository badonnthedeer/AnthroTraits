-- idea to define globals here inspired by "Simple Overhaul: Traits and Occupations" by hea
AnthroTraitsGlobals = AnthroTraitsGlobals or {}

AnthroTraitsGlobals.ModID = "AnthroTraits"
AnthroTraitsGlobals.WorkshopID =  2987213113
AnthroTraitsGlobals.ModVersion = 2.0
AnthroTraitsGlobals.UnwieldyHandsAffectedTimedActions = {"ISBuildAction", "ISCureFliesAction", "ISCureMildewAction", "ISHarvestPlantAction", "ISSeedAction",
                                         "ISAddItemInRecipe", "ISAddWaterFromItemAction", "ISBarricadeAction", "ISCraftAction", "ISCutHair",
                                         "ISDismantleAction", "ISDyeHair", "ISEjectMagazine", "ISFixAction", "ISFixGenerator", "ISInsertMagazine",
                                         "ISLoadBulletsInMagazine", "ISPickupBrokenGlass", "ISPlaceTrap", "ISPlumbItem", "ISRackFirearm",
                                         "ISReloadWeaponAction", "ISRemoveBrokenGlass", "ISRemoveBullet", "ISRemoveWeaponUpgrade", "ISStitch",
                                         "ISTakePillAction" , "ISTrimBeard", "ISUnbarricadeAction", "ISUnloadBulletsFromFirearm",
                                         "ISUnloadBulletsFromMagazine", "ISUpgradeWeapon"}
AnthroTraitsGlobals.CharacterTrait = {}
AnthroTraitsGlobals.FoodTags = {}
AnthroTraitsGlobals.EvolvedRecipeFoodTags = {}


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
AnthroTraitsGlobals.CharacterTrait.VOICESHEEP = CharacterTrait.register("AnthroTraits:AT_VoiceSheep")

AnthroTraitsGlobals.FoodTags.CARNIVORE = ItemTag.register("AnthroTraits:ATCarnivore")
AnthroTraitsGlobals.FoodTags.HERBIVORE = ItemTag.register("AnthroTraits:ATHerbivore")
AnthroTraitsGlobals.FoodTags.INSECT = ItemTag.register("AnthroTraits:ATInsect")
AnthroTraitsGlobals.FoodTags.FERALPOISON = ItemTag.register("AnthroTraits:ATFeralPoison")
AnthroTraitsGlobals.EvolvedRecipeFoodTags = { AnthroTraitsGlobals.FoodTags.CARNIVORE, AnthroTraitsGlobals.FoodTags.HERBIVORE }
