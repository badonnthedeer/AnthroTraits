--
--                                  @*x/||x8
--                                   %8%n&v]`Ic
--                                     *)   }``W
--                                     *>&  1``n
--                                  &@ tI1/^`"@
--                                 &11\]"``^v
--                                M"`````,[&@@@@@
--                            &#cv(`:[/];"`````^r%
--                        @z);^`^;}"~}"........;&
--                 @WM##n~;+"`^^^.<[}}+,`'''`:tB
--                 #*xj<;).`i"``"l}}}}}}}%@B
--                 j^'..`+..,}}}}}}}}}}}(
--                  /,'.'...I}}}}}}}}}}}r
--                    @Muj/x*c"`'';}}}}}n
--                           !..'!}}}}}}x
--                          r`^;[}}}}}}}t                        @|M
--                         8{}}}}}}}}}}}{&                       B?>|@
--                         \}}}}}}}}}}}}})W                      x}?'<
--                        v}}}}}}}}}}}}}}}}/v#&%B  @@          Bj}}:.`
--                        :,}}}}}}}}}}}}}}}}}}}}}}}{{{1)(|/jnzr{}+"..-
--                        :.;}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}]l,;_c
--                        (.:}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}t
--                      &r_^']}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}+*
--                   Mt-I,,,^`[}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}"W
--               *\+;,,,,,,,,",}}}}}}}}}}}]??]]}}}}}}}}}}}}}}}]""*
--             c;,,,,:;+{rW8BBB!+}}}}}}}}}>,:;!}}}}}}}}}}}}-"^`"l\%
--             W:,,,?@         n'+}}}}}}}?:,,,:[}}}}}}}}}}}:.,,,+|f@
--              /,,,i8          ,"}}}}}}|vnrrrrt}}}}}}}}}}}"`,,,:1|\v@
--               xI,,;rB%%B     [:}}}}{u        c(}}}}}}}}},`,,,,;}||/8
--                @fl]trrrrr    *}}}}}t           &vf(}}}}}]`:,,,,,?||t
--                  @*rrrrrx    *}}}}})@              &/}}}}-nxj\{[)|||xc#
--                     Mrrrv    v}}}}}c                 u}}}}}}r   8t|||||8
--                      8nr*    x}}}}n                   j}}}}}v    Bj|||?t
--                        &B    r}}}\                    %}}}}>%     &_]}:u
--                              j}}}z                    _"~l`1    Bx<,,,;B
--                              njxt@                @z}"....!   z[;;;;:;}
--                           %MvnnnnM               *~"^^^``iB  B*xrrrffrrB
--                         Wunnnnnnn*             &cnnnnnnnv   @*z*****zz#
--                        &MWWWWWWMWB            WMWWWWWWMWB
------------------------------------------------------------------------------------------------------
-- AUTHOR: Badonn the Deer
-- LICENSE: MIT
-- REFERENCES: Albion and Collide's work with variable trait costs
-- Did this code help you write your own mod? Consider donating to me at https://ko-fi.com/badonnthedeer!
-- I'm in financial need and every little bit helps!!
--
-- Have a problem or question? Reach me on Discord: badonn
------------------------------------------------------------------------------------------------------

local function round(num, decimals)
	local res = num * 10 ^ (decimals or 0);
	res = math.floor(res + 0.5);
	return res / 10 ^ (decimals or 0);
end

local AnthroTraitDescriptionInfos = { }
local function createDescVar(name, multiplier, decimals)
	return {
		Name = name,
		Multiplier = multiplier or 1,
		Decimals = decimals or 0,
		getValue = function(self)
			return round(SandboxVars.AnthroTraits[self.Name] * self.Multiplier, self.Decimals);
		end,
	}
end

local function createDescInfo(trait, name, variables, addendum)
	AnthroTraitDescriptionInfos[trait] = { Name = name, Variables = variables, Addendum = addendum }
end

local AnthroTraitsCreationMethods = {}
AnthroTraitsCreationMethods.TTF = require("TraitTagFramework");

AnthroTraitsCreationMethods.initAnthroTraits = function()
	local ATGt = AnthroTraitsGlobals.CharacterTrait
    local ATCM = AnthroTraitsCreationMethods;
	local allTraits = Registries.CHARACTER_TRAIT:values()
	-- take all currently registered traits and add "Vanilla" tag to all with default namespace ("base")
	for i=0, allTraits:size()-1 do
		local trait = allTraits:get(i)
		local locID = Registries.CHARACTER_TRAIT:getLocation(trait)
		if locID:getNamespace() == ResourceLocation.DEFAULT_NAMESPACE
		then
			ATCM.TTF.Add(locID, "Vanilla");
		end
	end	
	
	-- add additional tags to vanilla traits
	ATCM.TTF.Add("Base:EagleEyed", "Anthro,KeenVision");
	ATCM.TTF.Add("Base:KeenHearing", "Anthro,KeenHearing");
    ATCM.TTF.Add("Base:ThickSkinned", "Anthro,Tough");
    ATCM.TTF.Add("Base:NightVision", "Anthro,KeenVision");
    ATCM.TTF.Add("Base:IronGut", "Anthro,Scavenger");
	
---------------------------------------------------------------------------------------------------------------------------------------------------------------

    --ANTHRO IMMUNITY
	local AT_AnthroImmunity = CharacterTraitDefinition.addCharacterTraitDefinition(ATGt.ANTHROIMMUNITY,
		"UI_trait_AT_AnthroImmunity", 1, "UI_trait_AT_AnthroImmunity_desc", false)
    ATCM.TTF.Add("AnthroTraits:AT_AnthroImmunity", "AnthroTraits,CostVariable,Anthro");
	createDescInfo(AT_AnthroImmunity, "AT_AnthroImmunity",
		{ createDescVar("AT_AnthroImmunityBiteInfectionChance"), createDescVar("AT_AnthroImmunityLacerationInfectionChance", 0.25, 2), createDescVar("AT_AnthroImmunityScratchInfectionChance", 0.07, 2)},
		"_anthro_addendum")
	

    --BEAST OF BURDEN
	local AT_BeastOfBurden = CharacterTraitDefinition.addCharacterTraitDefinition(ATGt.BEASTOFBURDEN,
		"UI_trait_AT_BeastOfBurden", 1, "UI_trait_AT_BeastOfBurden_desc", false)
    ATCM.TTF.Add("AnthroTraits:AT_BeastOfBurden", "AnthroTraits,CostVariable,Anthro,Strong");
	createDescInfo(AT_BeastOfBurden, "AT_BeastOfBurden",
		{ createDescVar("AT_BeastOfBurdenPctIncrease", 100) }
	)

    --BUG_O_SSIEUR
	local AT_Bug_o_ssieur = CharacterTraitDefinition.addCharacterTraitDefinition(ATGt.BUG_O_SSIEUR,
		"UI_trait_AT_Bug_o_ssieur", 1, "UI_trait_AT_Bug_o_ssieur_desc", false)
    ATCM.TTF.Add("AnthroTraits:AT_Bug_o_ssieur", "AnthroTraits,CostVariable");
	createDescInfo(AT_Bug_o_ssieur, "AT_Bug_o_ssieur",
		{ createDescVar("AT_Bug_o_ssieurBonus"), createDescVar("AT_Bug_o_ssieurForageBonus") }
	)

    --BULL RUSH
	local AT_BullRush = CharacterTraitDefinition.addCharacterTraitDefinition(ATGt.BULLRUSH,
		"UI_trait_AT_BullRush", 1, "UI_trait_AT_BullRush_desc", false, false)	--NOTE: disabled bullrush in MP for now since I can't get the client to consistently identify the zombies knocked down on the server :(
    ATCM.TTF.Add("AnthroTraits:AT_BullRush", "AnthroTraits,CostVariable,Anthro,Horns");
	createDescInfo(AT_BullRush, "AT_BullRush",
		{ }
	)

    --CARNIVORE
	local AT_Carnivore = CharacterTraitDefinition.addCharacterTraitDefinition(ATGt.CARNIVORE,
		"UI_trait_AT_Carnivore", 1, "UI_trait_AT_Carnivore_desc", false)
    ATCM.TTF.Add("AnthroTraits:AT_Carnivore", "AnthroTraits,CostVariable,Anthro,Carnivore");
	createDescInfo(AT_Carnivore, "AT_Carnivore",
		{ createDescVar("AT_CarnivoreBonus", 100), createDescVar("AT_CarnivoreMalus", 100), createDescVar("AT_CarnivoreForageBonus") }
	)
	

    --CARRION EATER
	local AT_CarrionEater = CharacterTraitDefinition.addCharacterTraitDefinition(ATGt.CARRIONEATER,
		"UI_trait_AT_CarrionEater", 1, "UI_trait_AT_CarrionEater_desc", false)
    ATCM.TTF.Add("AnthroTraits:AT_CarrionEater", "AnthroTraits,CostVariable,Anthro,Carnivore,Scavenger");
	createDescInfo(AT_CarrionEater, "AT_CarrionEater",
		{ createDescVar("AT_CarrionEaterBonus", 100), createDescVar("AT_CarrionEaterForageBonus") }
	)
	
    --DIGITIGRADE
	local AT_Digitigrade = CharacterTraitDefinition.addCharacterTraitDefinition(ATGt.DIGITIGRADE,
		"UI_trait_AT_Digitigrade", 1, "UI_trait_AT_Digitigrade_desc", false)
    AT_Digitigrade:addXPBoost(Perks.Sprinting, 1)
    AT_Digitigrade:addXPBoost(Perks.Lightfoot, 1);
    AT_Digitigrade:addXPBoost(Perks.Sneak, 1);
    ATCM.TTF.Add("AnthroTraits:AT_Digitigrade", "AnthroTraits,CostVariable,Anthro");
	createDescInfo(AT_Digitigrade, "AT_Digitigrade",
		{ createDescVar("AT_DigitigradeStompDmgPctIncrease", 100), createDescVar("AT_DigitigradeCarryWeightMalus", 100) }
	)

    --EXCLAIMER
	local AT_Exclaimer = CharacterTraitDefinition.addCharacterTraitDefinition(ATGt.EXCLAIMER,
		"UI_trait_AT_Exclaimer", -1, "UI_trait_AT_Exclaimer_desc", false)
    ATCM.TTF.Add("AnthroTraits:AT_Exclaimer", "AnthroTraits,CostVariable");
	createDescInfo(AT_Exclaimer, "AT_Exclaimer",
		{ createDescVar("AT_ExclaimerExclaimThresholdMultiplier") }
	)

    --FERAL BODY
	local AT_FeralBody = CharacterTraitDefinition.addCharacterTraitDefinition(ATGt.FERALBODY,
		"UI_trait_AT_FeralBody", 1, "UI_trait_AT_FeralBody_desc", false)
    -- AT_FeralBody:addXPBoost(Perks.Strength, 1);
    -- AT_FeralBody:addXPBoost(Perks.Fitness, -1);
    ATCM.TTF.Add("AnthroTraits:AT_FeralBody", "AnthroTraits,CostVariable,Anthro");

    --FERAL DIGESTION
	local AT_FeralDigestion = CharacterTraitDefinition.addCharacterTraitDefinition(ATGt.FERALDIGESTION,
		"UI_trait_AT_FeralDigestion", -1, "UI_trait_AT_FeralDigestion_desc", false)
    ATCM.TTF.Add("AnthroTraits:AT_FeralDigestion", "AnthroTraits,CostVariable,Anthro");
	createDescInfo(AT_FeralDigestion, "AT_FeralDigestion",
		{ createDescVar("AT_FeralDigestionPoisonAmt") }
	)

    --FOOD MOTIVATED
	local AT_FoodMotivated = CharacterTraitDefinition.addCharacterTraitDefinition(ATGt.FOODMOTIVATED,
		"UI_trait_AT_FoodMotivated", 1, "UI_trait_AT_FoodMotivated_desc", false)
    ATCM.TTF.Add("AnthroTraits:AT_FoodMotivated", "AnthroTraits,CostVariable,Anthro");
	createDescInfo(AT_FoodMotivated, "AT_FoodMotivated",
		{ createDescVar("AT_FoodMotivatedBonus") }
	)

    --HERBIVORE
	local AT_Herbivore = CharacterTraitDefinition.addCharacterTraitDefinition(ATGt.HERBIVORE,
		"UI_trait_AT_Herbivore", -1, "UI_trait_AT_Herbivore_desc", false)
    ATCM.TTF.Add("AnthroTraits:AT_Herbivore", "AnthroTraits,CostVariable,Anthro,Herbivore");
	createDescInfo(AT_Herbivore, "AT_Herbivore",
		{ createDescVar("AT_HerbivoreBonus", 100), createDescVar("AT_HerbivoreMalus", 100), createDescVar("AT_HerbivoreForageBonus") }
	)

    --LONELY
	local AT_Lonely = CharacterTraitDefinition.addCharacterTraitDefinition(ATGt.LONELY,
		"UI_trait_AT_Lonely", -1, "UI_trait_AT_Lonely_desc", false)
    ATCM.TTF.Add("AnthroTraits:AT_Lonely", "AnthroTraits,CostVariable,Anthro,Social"); --(Xochi suggestion)
	createDescInfo(AT_Lonely, "AT_Lonely",
		{ createDescVar("AT_LonelyHoursToAffect"), createDescVar("AT_LonelyHourlyUnhappyIncrease", 100) }
	)

	--LOW END HUNTER
	local AT_LowEndHunter = CharacterTraitDefinition.addCharacterTraitDefinition(ATGt.LOWENDHUNTER,
		"UI_trait_AT_LowEndHunter", -1, "UI_trait_AT_LowEndHunter_desc", false)
    AT_LowEndHunter:addXPBoost(Perks.Sneak, 1);
    AT_LowEndHunter:addXPBoost(Perks.Sprinting, 1);
    AT_LowEndHunter:addXPBoost(Perks.Fitness, -1);
    ATCM.TTF.Add("AnthroTraits:AT_LowEndHunter", "AnthroTraits,CostVariable,Anthro");
	createDescInfo(AT_LowEndHunter, "AT_LowEndHunter",
		{ createDescVar("AT_LowEndHunterEndRecoMalus") }
	)

    --NATURAL TUMBLER
	local AT_NaturalTumbler = CharacterTraitDefinition.addCharacterTraitDefinition(ATGt.NATURALTUMBLER,
		"UI_trait_AT_NaturalTumbler", 1, "UI_trait_AT_NaturalTumbler_desc", false)
    ATCM.TTF.Add("AnthroTraits:AT_NaturalTumbler", "AnthroTraits,CostVariable,Anthro,Agile");
	createDescInfo(AT_NaturalTumbler, "AT_NaturalTumbler",
		{ createDescVar("AT_NaturalTumblerFallTimeMult", 100) }
	)

    --STINKY
	local AT_Stinky = CharacterTraitDefinition.addCharacterTraitDefinition(ATGt.STINKY,
		"UI_trait_AT_Stinky", -1, "UI_trait_AT_Stinky_desc", false)
    ATCM.TTF.Add("AnthroTraits:AT_Stinky", "AnthroTraits,CostVariable,");

    --TAIL
	local AT_Tail = CharacterTraitDefinition.addCharacterTraitDefinition(ATGt.TAIL,
		"UI_trait_AT_Tail", 1, "UI_trait_AT_Tail_desc", false)
    ATCM.TTF.Add("AnthroTraits:AT_Tail", "AnthroTraits,CostVariable,Anthro,Tail");
	createDescInfo(AT_Tail, "AT_Tail",
		{ createDescVar("AT_TailTripReduction") }
	)

    --TORPOR
	local AT_Torpor = CharacterTraitDefinition.addCharacterTraitDefinition(ATGt.TORPOR,
		"UI_trait_AT_Torpor", -1, "UI_trait_AT_Torpor_desc", false)
    ATCM.TTF.Add("AnthroTraits:AT_Torpor", "AnthroTraits,CostVariable,Anthro,Hibernator");
	createDescInfo(AT_Torpor, "AT_Torpor",
		{ createDescVar("AT_TorporEnduranceDecrease", 100) }
	)

    --UNGULIGRADE
	local AT_Unguligrade = CharacterTraitDefinition.addCharacterTraitDefinition(ATGt.UNGULIGRADE,
		"UI_trait_AT_Unguligrade", 1, "UI_trait_AT_Unguligrade_desc", false)
    AT_Unguligrade:addXPBoost(Perks.Sprinting, 1)
    AT_Unguligrade:addXPBoost(Perks.Nimble, 1);
    ATCM.TTF.Add("AnthroTraits:AT_Unguligrade", "AnthroTraits,CostVariable,Anthro,Unguligrade");
	createDescInfo(AT_Unguligrade, "AT_Unguligrade",
		{ createDescVar("AT_UnguligradeStompDmgPctIncrease", 100), createDescVar("AT_UnguligradeCarryWeightMalus", 100) }
	)
    --UNWIELDY HANDS
	local AT_UnwieldyHands = CharacterTraitDefinition.addCharacterTraitDefinition(ATGt.UNWIELDYHANDS,
		"UI_trait_AT_UnwieldyHands", -1, "UI_trait_AT_UnwieldyHands_desc", false)
    ATCM.TTF.Add("AnthroTraits:AT_UnwieldyHands", "AnthroTraits,CostVariable,Anthro,ThreeFingers");
	createDescInfo(AT_UnwieldyHands, "AT_UnwieldyHands",
		{ createDescVar("AT_UnwieldyHandsTimeIncrease", 100) }
	)

    --VESTIGIAL WINGS
	local AT_VestigialWings = CharacterTraitDefinition.addCharacterTraitDefinition(ATGt.VESTIGIALWINGS,
		"UI_trait_AT_VestigialWings", 1, "UI_trait_AT_VestigialWings_desc", false)
    ATCM.TTF.Add("AnthroTraits:AT_VestigialWings", "AnthroTraits,CostVariable,Anthro,Winged");

    --VOICE AVIAN
	local AT_VoiceAvian = CharacterTraitDefinition.addCharacterTraitDefinition(ATGt.VOICEAVIAN,
		"UI_trait_AT_VoiceAvian", 1, "UI_trait_AT_VoiceAvian_desc", false)
    ATCM.TTF.Add("AnthroTraits:AT_VoiceAvian", "AnthroTraits,CostVariable,Anthro");
	createDescInfo(AT_VoiceAvian, "AT_VoiceAvian",
		{ createDescVar("AT_ExclaimerAnthroVoiceMitigation") }
	)

	--VOICE FELINE
	local AT_VoiceFeline = CharacterTraitDefinition.addCharacterTraitDefinition(ATGt.VOICEFELINE,
		"UI_trait_AT_VoiceFeline", 1, "UI_trait_AT_VoiceFeline_desc", false)
    ATCM.TTF.Add("AnthroTraits:AT_VoiceFeline", "AnthroTraits,CostVariable,Anthro");
	createDescInfo(AT_VoiceFeline, "AT_VoiceFeline",
		{ createDescVar("AT_ExclaimerAnthroVoiceMitigation") }
	)

    --VOICE SHEEP
	local AT_VoiceSheep = CharacterTraitDefinition.addCharacterTraitDefinition(ATGt.VOICESHEEP,
		"UI_trait_AT_VoiceSheep", 1, "UI_trait_AT_VoiceSheep_desc", false)
    ATCM.TTF.Add("AnthroTraits:AT_VoiceSheep", "AnthroTraits,CostVariable,Anthro");
	createDescInfo(AT_VoiceSheep, "AT_VoiceSheep",
		{ createDescVar("AT_ExclaimerAnthroVoiceMitigation") }
	)


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

	CharacterTraitDefinition.setMutualExclusive(ATGt.HERBIVORE, ATGt.CARNIVORE)
	CharacterTraitDefinition.setMutualExclusive(ATGt.HERBIVORE, ATGt.CARRIONEATER)
	CharacterTraitDefinition.setMutualExclusive(ATGt.NATURALTUMBLER, ATGt.VESTIGIALWINGS)
	CharacterTraitDefinition.setMutualExclusive(ATGt.DIGITIGRADE, ATGt.UNGULIGRADE)
	CharacterTraitDefinition.setMutualExclusive(ATGt.VOICEAVIAN, ATGt.VOICESHEEP)
	CharacterTraitDefinition.setMutualExclusive(ATGt.VOICEAVIAN, ATGt.VOICEFELINE)
	CharacterTraitDefinition.setMutualExclusive(ATGt.VOICEFELINE, ATGt.VOICESHEEP)

    ATCM.setTraitDescriptions();
end

AnthroTraitsCreationMethods.setTraitDescriptions = function ()
	local ATGt = AnthroTraitsGlobals.CharacterTrait
    local ATCM = AnthroTraitsCreationMethods;
    local affectedTraits = ATCM.TTF.GetAllTraitsWithTag("AnthroTraits");
    local workString = "";

    for i = 1, #affectedTraits do
		local trait = affectedTraits[i];
		local traitDef = CharacterTraitDefinition.getCharacterTraitDefinition(trait)

		local descInfo = AnthroTraitDescriptionInfos[traitDef];
		if descInfo then
			local workString;
			if descInfo.Variables and #descInfo.Variables > 0 then
				local values = {}
				for _, variable in ipairs(descInfo.Variables) do
					table.insert(values, variable:getValue());
				end
				if #values == 1 then
					workString = getText("UI_trait_" .. descInfo.Name .. "_desc", values[1]);
				elseif #values == 2 then
					workString = getText("UI_trait_" .. descInfo.Name .. "_desc", values[1], values[2]);
				elseif #values == 3 then
					workString = getText("UI_trait_" .. descInfo.Name .. "_desc", values[1], values[2], values[3]);
				elseif #values == 4 then
					workString = getText("UI_trait_" .. descInfo.Name .. "_desc", values[1], values[2], values[3], values[4]);
				end
			else
				workString = getText("UI_trait_" .. descInfo.Name .. "_desc");
			end
			if descInfo.Addendum then
				workString = workString .. getText("UI_trait_" .. descInfo.Name .. descInfo.Addendum);
			end
			traitDef:setDescription(workString);
		end
	end
end

AnthroTraitsCreationMethods.refundSelectedAffectedTraits = function()
    local ATCM = AnthroTraitsCreationMethods;
    local ccp = MainScreen.instance.charCreationProfession
    local affectedTraits = ATCM.TTF.GetAllTraitsWithTag("CostVariable");
    local selectedItems = ccp.listboxTraitSelected.items

    if selectedItems ~= nil
    then
        for i = 1, #affectedTraits
        do
            local trait = CharacterTraitDefinition.characterTraitDefinitions:get(affectedTraits[i])
            local label = trait:getLabel()
            local newItem;
            --remove traits in selected box
            for j = 1, #selectedItems do
                if selectedItems[j].item == trait then
                    ccp.pointToSpend = ccp.pointToSpend - tonumber(trait:getRightLabel());
                    ccp.listboxTraitSelected:removeItem(label);
                    if trait:getCost() > 0
                    then
                        newItem = ccp.listboxTrait:addItem(label, trait)
                    else
                        newItem = ccp.listboxBadTrait:addItem(label, trait)
                    end
                    break
                end
            end
        end
    end
end

AnthroTraitsCreationMethods.sortTraits = function()
    local ATCM = AnthroTraitsCreationMethods;
    local ccp = MainScreen.instance.charCreationProfession;
    local affectedTraits = ATCM.TTF.GetAllTraitsWithTag("CostVariable");

    for i = 1, #affectedTraits
    do
		local trait = CharacterTraitDefinition.characterTraitDefinitions:get(affectedTraits[i])
        local label = trait:getLabel()
        local newItem;

        --remove beforehand, since traits can not be removed
        --from the other list if the new value is *-1
        ccp.listboxTrait:removeItem(label)
        ccp.listboxBadTrait:removeItem(label)

        if tonumber(trait:getRightLabel()) < 0
        then
            newItem = ccp.listboxTrait:addItem(label, trait)
            newItem.tooltip = trait:getDescription();
        else
            newItem = ccp.listboxBadTrait:addItem(label, trait)
            newItem.tooltip = trait:getDescription();
        end
    end
    CharacterCreationMain.sort(ccp.listboxTrait.items)
    CharacterCreationMain.invertSort(ccp.listboxBadTrait.items)
    CharacterCreationMain.sort(ccp.listboxTraitSelected.items)
end



Events.OnGameBoot.Add(AnthroTraitsCreationMethods.initAnthroTraits);


return AnthroTraitsCreationMethods;