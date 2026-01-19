-- idea to define globals here inspired by "Simple Overhaul: Traits and Occupations" by hea
AnthroTraitsGlobals = AnthroTraitsGlobals or {}

AnthroTraitsGlobals.ModID = "AnthroTraits"
AnthroTraitsGlobals.WorkshopID = 3025679944
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
AnthroTraitsGlobals.FoodCharacterStatInfo = {}

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
AnthroTraitsGlobals.FoodTags.FOODMOTIVATED = ItemTag.register("AnthroTraits:ATFoodMotivated")
AnthroTraitsGlobals.EvolvedRecipeFoodTags = { AnthroTraitsGlobals.FoodTags.CARNIVORE, AnthroTraitsGlobals.FoodTags.HERBIVORE }

-- modifiers (boni/mali) only apply to good changes
-- good changes are identified by the sign
-- food related traits will deal with these stats (plus calories)

AnthroTraitsGlobals.FoodCharacterStatInfo[CharacterStat.HUNGER] = { Sign = -1, TooltipName = "Hunger", TooltipFactor = 100 }
AnthroTraitsGlobals.FoodCharacterStatInfo[CharacterStat.THIRST] = { Sign = -1, TooltipName = "Thirst", TooltipFactor = 100 }
AnthroTraitsGlobals.FoodCharacterStatInfo[CharacterStat.FATIGUE] = { Sign = -1, TooltipName = "Fatigue", TooltipFactor = 100 }
AnthroTraitsGlobals.FoodCharacterStatInfo[CharacterStat.ENDURANCE] = { Sign = 1, TooltipName = "Endurance", TooltipFactor = 100 }
AnthroTraitsGlobals.FoodCharacterStatInfo[CharacterStat.STRESS] = { Sign = -1, TooltipName = "Stress", TooltipFactor = 1 }
AnthroTraitsGlobals.FoodCharacterStatInfo[CharacterStat.BOREDOM] = { Sign = -1, TooltipName = "Boredom", TooltipFactor = 1 }
AnthroTraitsGlobals.FoodCharacterStatInfo[CharacterStat.UNHAPPINESS] = { Sign = -1, TooltipName = "Unhappiness", TooltipFactor = 1 }
-- food stats processed by CARRIONEATER (plus calories)
AnthroTraitsGlobals.CarrionFoodCharacterStats = { CharacterStat.HUNGER, CharacterStat.THIRST }