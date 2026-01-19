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
	CharacterTraitDefinition.addCharacterTraitDefinition(ATGt.ANTHROIMMUNITY,
		"UI_trait_AT_AnthroImmunity", 1, "UI_trait_AT_AnthroImmunity_desc", false)
    ATCM.TTF.Add("AnthroTraits:AT_AnthroImmunity", "AnthroTraits,CostVariable,Anthro");
	

    --BEAST OF BURDEN
	CharacterTraitDefinition.addCharacterTraitDefinition(ATGt.BEASTOFBURDEN,
		"UI_trait_AT_BeastOfBurden", 1, "UI_trait_AT_BeastOfBurden_desc", false)
    ATCM.TTF.Add("AnthroTraits:AT_BeastOfBurden", "AnthroTraits,CostVariable,Anthro,Strong");

    --BUG_O_SSIEUR
	CharacterTraitDefinition.addCharacterTraitDefinition(ATGt.BUG_O_SSIEUR,
		"UI_trait_AT_Bug_o_ssieur", 1, "UI_trait_AT_Bug_o_ssieur_desc", false)
    ATCM.TTF.Add("AnthroTraits:AT_Bug_o_ssieur", "AnthroTraits,CostVariable");

    --BULL RUSH
	--CharacterTraitDefinition.addCharacterTraitDefinition(ATGt.BULLRUSH,
	--	"UI_trait_AT_BullRush", 1, "UI_trait_AT_BullRush_desc", false)
    --this.TTF.Add("AnthroTraits:AT_BullRush", "AnthroTraits,CostVariable,Anthro,Horns");

    --CARNIVORE
	local AT_Carnivore = CharacterTraitDefinition.addCharacterTraitDefinition(ATGt.CARNIVORE,
		"UI_trait_AT_Carnivore", 1, "UI_trait_AT_Carnivore_desc", false)
    ATCM.TTF.Add("AnthroTraits:AT_Carnivore", "AnthroTraits,CostVariable,Anthro,Carnivore");

    --CARRION EATER
	local AT_CarrionEater = CharacterTraitDefinition.addCharacterTraitDefinition(ATGt.CARRIONEATER,
		"UI_trait_AT_CarrionEater", 1, "UI_trait_AT_CarrionEater_desc", false)
    ATCM.TTF.Add("AnthroTraits:AT_CarrionEater", "AnthroTraits,CostVariable,Anthro,Carnivore,Scavenger");

    --DIGITIGRADE
	local AT_Digitigrade = CharacterTraitDefinition.addCharacterTraitDefinition(ATGt.DIGITIGRADE,
		"UI_trait_AT_Digitigrade", 1, "UI_trait_AT_Digitigrade_desc", false)
    AT_Digitigrade:addXPBoost(Perks.Sprinting, 1)
    AT_Digitigrade:addXPBoost(Perks.Lightfoot, 1);
    AT_Digitigrade:addXPBoost(Perks.Sneak, 1);
    ATCM.TTF.Add("AnthroTraits:AT_Digitigrade", "AnthroTraits,CostVariable,Anthro");

    --EXCLAIMER
	CharacterTraitDefinition.addCharacterTraitDefinition(ATGt.EXCLAIMER,
		"UI_trait_AT_Exclaimer", -1, "UI_trait_AT_Exclaimer_desc", false)
    ATCM.TTF.Add("AnthroTraits:AT_Exclaimer", "AnthroTraits,CostVariable");

    --FERAL BODY
	local AT_FeralBody = CharacterTraitDefinition.addCharacterTraitDefinition(ATGt.FERALBODY,
		"UI_trait_AT_FeralBody", 1, "UI_trait_AT_FeralBody_desc", false)
    AT_FeralBody:addXPBoost(Perks.Strength, 1);
    AT_FeralBody:addXPBoost(Perks.Fitness, -1);
    ATCM.TTF.Add("AnthroTraits:AT_FeralBody", "AnthroTraits,CostVariable,Anthro");

    --FERAL DIGESTION
	CharacterTraitDefinition.addCharacterTraitDefinition(ATGt.FERALDIGESTION,
		"UI_trait_AT_FeralDigestion", -1, "UI_trait_AT_FeralDigestion_desc", false)
    ATCM.TTF.Add("AnthroTraits:AT_FeralDigestion", "AnthroTraits,CostVariable,Anthro");

    --FOOD MOTIVATED
	CharacterTraitDefinition.addCharacterTraitDefinition(ATGt.FOODMOTIVATED,
		"UI_trait_AT_FoodMotivated", 1, "UI_trait_AT_FoodMotivated_desc", false)
    ATCM.TTF.Add("AnthroTraits:AT_FoodMotivated", "AnthroTraits,CostVariable,Anthro");

    --HERBIVORE
	local AT_Herbivore = CharacterTraitDefinition.addCharacterTraitDefinition(ATGt.HERBIVORE,
		"UI_trait_AT_Herbivore", -1, "UI_trait_AT_Herbivore_desc", false)
    ATCM.TTF.Add("AnthroTraits:AT_Herbivore", "AnthroTraits,CostVariable,Anthro,Herbivore");

    --LONELY
	CharacterTraitDefinition.addCharacterTraitDefinition(ATGt.LONELY,
		"UI_trait_AT_Lonely", -1, "UI_trait_AT_Lonely_desc", false)
    ATCM.TTF.Add("AnthroTraits:AT_Lonely", "AnthroTraits,CostVariable,Anthro,Social"); --(Xochi suggestion)

    --NATURAL TUMBLER
	local AT_NaturalTumbler = CharacterTraitDefinition.addCharacterTraitDefinition(ATGt.NATURALTUMBLER,
		"UI_trait_AT_NaturalTumbler", 1, "UI_trait_AT_NaturalTumbler_desc", false)
    ATCM.TTF.Add("AnthroTraits:AT_NaturalTumbler", "AnthroTraits,CostVariable,Anthro,Agile");

    --STINKY
	CharacterTraitDefinition.addCharacterTraitDefinition(ATGt.STINKY,
		"UI_trait_AT_Stinky", -1, "UI_trait_AT_Stinky_desc", false)
    ATCM.TTF.Add("AnthroTraits:AT_Stinky", "AnthroTraits,CostVariable,");

    --TAIL
	CharacterTraitDefinition.addCharacterTraitDefinition(ATGt.TAIL,
		"UI_trait_AT_Tail", 1, "UI_trait_AT_Tail_desc", false)
    ATCM.TTF.Add("AnthroTraits:AT_Tail", "AnthroTraits,CostVariable,Anthro,Tail");

    --TORPOR
	CharacterTraitDefinition.addCharacterTraitDefinition(ATGt.TORPOR,
		"UI_trait_AT_Torpor", -1, "UI_trait_AT_Torpor_desc", false)
    ATCM.TTF.Add("AnthroTraits:AT_Torpor", "AnthroTraits,CostVariable,Anthro,Hibernator");

    --UNGULIGRADE
	local AT_Unguligrade = CharacterTraitDefinition.addCharacterTraitDefinition(ATGt.UNGULIGRADE,
		"UI_trait_AT_Unguligrade", 1, "UI_trait_AT_Unguligrade_desc", false)
    AT_Unguligrade:addXPBoost(Perks.Sprinting, 1)
    AT_Unguligrade:addXPBoost(Perks.Nimble, 1);
    ATCM.TTF.Add("AnthroTraits:AT_Unguligrade", "AnthroTraits,CostVariable,Anthro,Unguligrade");

    --UNWIELDY HANDS
	CharacterTraitDefinition.addCharacterTraitDefinition(ATGt.UNWIELDYHANDS,
		"UI_trait_AT_UnwieldyHands", -1, "UI_trait_AT_UnwieldyHands_desc", false)
    ATCM.TTF.Add("AnthroTraits:AT_UnwieldyHands", "AnthroTraits,CostVariable,Anthro,ThreeFingers");

    --VESTIGIAL WINGS
	local AT_VestigialWings = CharacterTraitDefinition.addCharacterTraitDefinition(ATGt.VESTIGIALWINGS,
		"UI_trait_AT_VestigialWings", 1, "UI_trait_AT_VestigialWings_desc", false)
    ATCM.TTF.Add("AnthroTraits:AT_VestigialWings", "AnthroTraits,CostVariable,Anthro,Winged");

    --VOICE AVIAN
	local AT_VoiceAvian = CharacterTraitDefinition.addCharacterTraitDefinition(ATGt.VOICEAVIAN,
		"UI_trait_AT_VoiceAvian", 1, "UI_trait_AT_VoiceAvian_desc", false)
    ATCM.TTF.Add("AnthroTraits:AT_VoiceAvian", "AnthroTraits,CostVariable,Anthro");

    --VOICE SHEEP
	local AT_VoiceSheep = CharacterTraitDefinition.addCharacterTraitDefinition(ATGt.VOICESHEEP,
		"UI_trait_AT_VoiceSheep", 1, "UI_trait_AT_VoiceSheep_desc", false)
    ATCM.TTF.Add("AnthroTraits:AT_VoiceSheep", "AnthroTraits,CostVariable,Anthro");


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
		
		if trait == ATGt.ANTHROIMMUNITY
		then
			if SandboxVars.AnthroTraits.AT_AnthroImmunityIgnoredByAnthroZombies == true
			then
				workString = string.format(getText("UI_trait_AT_AnthroImmunity_desc")..getText("UI_trait_AT_AnthroImmunity_anthro_addendum"), SandboxVars.AnthroTraits.AT_AnthroImmunityBiteInfectionChance, SandboxVars.AnthroTraits.AT_AnthroImmunityLacerationInfectionChance *.25, SandboxVars.AnthroTraits.AT_AnthroImmunityScratchInfectionChance *.07);
			else
				workString = string.format(getText("UI_trait_AT_AnthroImmunity_desc"), SandboxVars.AnthroTraits.AT_AnthroImmunityBiteInfectionChance, SandboxVars.AnthroTraits.AT_AnthroImmunityLacerationInfectionChance *.25, SandboxVars.AnthroTraits.AT_AnthroImmunityScratchInfectionChance *.07);
			end
			traitDef:setDescription(workString);
		elseif trait == ATGt.BEASTOFBURDEN
		then
			workString = string.format(getText("UI_trait_AT_BeastOfBurden_desc"), SandboxVars.AnthroTraits.AT_BeastOfBurdenPctIncrease * 100);
			traitDef:setDescription(workString);
		--[[ elseif trait == TraitFactory.getTrait("AT_BullRush")
		then
			workString = string.format(getText("UI_trait_AT_BullRush_desc"), SandboxVars.AnthroTraits.AT_BullRushKnockdownEndCost);
			trait:setDescription(workString); ]]
		elseif trait == ATGt.CARNIVORE
		then
			workString = string.format(getText("UI_trait_AT_Carnivore_desc"), SandboxVars.AnthroTraits.AT_CarnivoreBonus  * 100, SandboxVars.AnthroTraits.AT_CarnivoreMalus  * 100);
			traitDef:setDescription(workString);
		elseif trait == ATGt.CARRIONEATER
		then
			workString = string.format(getText("UI_trait_AT_CarrionEater_desc"), SandboxVars.AnthroTraits.AT_CarrionEaterBonus  * 100);
			traitDef:setDescription(workString);
		elseif trait == ATGt.DIGITIGRADE
		then
			workString = string.format(getText("UI_trait_AT_Digitigrade_desc"), SandboxVars.AnthroTraits.AT_DigitigradeStompDmgPctIncrease * 100);
			traitDef:setDescription(workString);
		elseif trait == ATGt.EXCLAIMER
		then
			workString = string.format(getText("UI_trait_AT_Exclaimer_desc"), SandboxVars.AnthroTraits.AT_ExclaimerExclaimThresholdMultiplier);
			traitDef:setDescription(workString);
		elseif trait == ATGt.FERALDIGESTION
		then
			workString = string.format(getText("UI_trait_AT_FeralDigestion_desc"), SandboxVars.AnthroTraits.AT_FeralDigestionPoisonAmt);
			traitDef:setDescription(workString);
		elseif trait == ATGt.FOODMOTIVATED
		then
			workString = string.format(getText("UI_trait_AT_FoodMotivated_desc"), SandboxVars.AnthroTraits.AT_FoodMotivatedBonus);
			traitDef:setDescription(workString);
		elseif trait == ATGt.HERBIVORE
		then
			workString = string.format(getText("UI_trait_AT_Herbivore_desc"), SandboxVars.AnthroTraits.AT_HerbivoreBonus * 100, SandboxVars.AnthroTraits.AT_HerbivoreMalus * 100);
			traitDef:setDescription(workString);
		elseif trait == ATGt.LONELY
		then
			workString = string.format(getText("UI_trait_AT_Lonely_desc"), SandboxVars.AnthroTraits.AT_LonelyHoursToAffect, SandboxVars.AnthroTraits.AT_LonelyHourlyUnhappyIncrease * 100);
			traitDef:setDescription(workString);
		elseif trait == ATGt.NATURALTUMBLER
		then
			workString = string.format(getText("UI_trait_AT_NaturalTumbler_desc"), SandboxVars.AnthroTraits.AT_NaturalTumblerFallTimeMult * 100);
			traitDef:setDescription(workString);
		elseif trait == ATGt.TAIL
		then
			workString = string.format(getText("UI_trait_AT_Tail_desc"), SandboxVars.AnthroTraits.AT_TailTripReduction);
			traitDef:setDescription(workString);
		elseif trait == ATGt.TORPOR
		then
			workString = string.format(getText("UI_trait_AT_Torpor_desc"), SandboxVars.AnthroTraits.AT_TorporEnduranceDecrease * 100);
			traitDef:setDescription(workString);
		elseif trait == ATGt.UNGULIGRADE
		then
			workString = string.format(getText("UI_trait_AT_Unguligrade_desc"), SandboxVars.AnthroTraits.AT_UnguligradeStompDmgPctIncrease * 100);
			traitDef:setDescription(workString);
		elseif trait == ATGt.UNWIELDYHANDS
		then
			workString = string.format(getText("UI_trait_AT_UnwieldyHands_desc"), SandboxVars.AnthroTraits.AT_UnwieldyHandsTimeIncrease * 100);
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