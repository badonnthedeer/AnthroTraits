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
    local ATCM = AnthroTraitsCreationMethods;

    ATCM.TTF.Add("Axeman", "Vanilla");
    ATCM.TTF.Add("Handy", "Vanilla");
    ATCM.TTF.Add("SpeedDemon", "Vanilla");
    ATCM.TTF.Add("SundayDriver", "Vanilla");
    ATCM.TTF.Add("Brave", "Vanilla");
    ATCM.TTF.Add("Cowardly", "Vanilla");
    ATCM.TTF.Add("Clumsy", "Vanilla");
    ATCM.TTF.Add("Graceful", "Vanilla");
    ATCM.TTF.Add("ShortSighted", "Vanilla");
    ATCM.TTF.Add("HardOfHearing", "Vanilla");
    ATCM.TTF.Add("Deaf", "Vanilla");
    ATCM.TTF.Add("KeenHearing", "Vanilla, Anthro,KeenHearing");
    ATCM.TTF.Add("EagleEyed", "Vanilla, Anthro,KeenVision");
    ATCM.TTF.Add("HeartyAppitite", "Vanilla");
    ATCM.TTF.Add("LightEater", "Vanilla");
    ATCM.TTF.Add("ThickSkinned", "Vanilla,Anthro,Tough");
    ATCM.TTF.Add("Unfit", "Vanilla");
    ATCM.TTF.Add("Out of Shape", "Vanilla");
    ATCM.TTF.Add("Fit", "Vanilla");
    ATCM.TTF.Add("Athletic", "Vanilla");
    ATCM.TTF.Add("Nutritionist", "Vanilla");
    ATCM.TTF.Add("Nutritionist2", "Vanilla");
    ATCM.TTF.Add("Emaciated", "Vanilla");
    ATCM.TTF.Add("Very Underweight", "Vanilla");
    ATCM.TTF.Add("Underweight", "Vanilla");
    ATCM.TTF.Add("Overweight", "Vanilla");
    ATCM.TTF.Add("Obese", "Vanilla");
    ATCM.TTF.Add("Strong", "Vanilla");
    ATCM.TTF.Add("Stout", "Vanilla");
    ATCM.TTF.Add("Weak", "Vanilla");
    ATCM.TTF.Add("Feeble", "Vanilla");
    ATCM.TTF.Add("Resilient", "Vanilla");
    ATCM.TTF.Add("ProneToIllness", "Vanilla");
    ATCM.TTF.Add("Agoraphobic", "Vanilla");
    ATCM.TTF.Add("Claustophobic", "Vanilla");
    ATCM.TTF.Add("Lucky", "Vanilla");
    ATCM.TTF.Add("Unlucky", "Vanilla");
    ATCM.TTF.Add("Marksman", "Vanilla");
    ATCM.TTF.Add("NightOwl", "Vanilla");
    ATCM.TTF.Add("Outdoorsman", "Vanilla");
    ATCM.TTF.Add("FastHealer", "Vanilla");
    ATCM.TTF.Add("FastLearner", "Vanilla");
    ATCM.TTF.Add("FastReader", "Vanilla");
    ATCM.TTF.Add("AdrenalineJunkie", "Vanilla");
    ATCM.TTF.Add("Inconspicuous", "Vanilla");
    ATCM.TTF.Add("NeedsLessSleep", "Vanilla");
    ATCM.TTF.Add("NightVision", "Vanilla,Anthro,KeenVision");
    ATCM.TTF.Add("Organized", "Vanilla");
    ATCM.TTF.Add("LowThirst", "Vanilla");
    ATCM.TTF.Add("Burglar", "Vanilla");
    ATCM.TTF.Add("FirstAid", "Vanilla");
    ATCM.TTF.Add("Fishing", "Vanilla");
    ATCM.TTF.Add("Gardener", "Vanilla");
    ATCM.TTF.Add("Jogger", "Vanilla");
    ATCM.TTF.Add("SlowHealer", "Vanilla");
    ATCM.TTF.Add("SlowLearner", "Vanilla");
    ATCM.TTF.Add("SlowReader", "Vanilla");
    ATCM.TTF.Add("NeedsMoreSleep", "Vanilla");
    ATCM.TTF.Add("Conspicuous", "Vanilla");
    ATCM.TTF.Add("Disorganized", "Vanilla");
    ATCM.TTF.Add("HighThirst", "Vanilla");
    ATCM.TTF.Add("Illiterate", "Vanilla");
    ATCM.TTF.Add("Insomniac", "Vanilla");
    ATCM.TTF.Add("Pacifist", "Vanilla");
    ATCM.TTF.Add("Thinskinned", "Vanilla");
    ATCM.TTF.Add("Smoker", "Vanilla");
    ATCM.TTF.Add("Tailor", "Vanilla");
    ATCM.TTF.Add("Dextrous", "Vanilla");
    ATCM.TTF.Add("AllThumbs", "Vanilla");
    ATCM.TTF.Add("Desensitized", "Vanilla");
    ATCM.TTF.Add("WeakStomach", "Vanilla");
    ATCM.TTF.Add("IronGut", "Vanilla,Anthro,Scavenger");
    ATCM.TTF.Add("Hemophobic", "Vanilla");
    ATCM.TTF.Add("Asthmatic", "Vanilla");
    ATCM.TTF.Add("Cook", "Vanilla");
    ATCM.TTF.Add("Cook2", "Vanilla");
    ATCM.TTF.Add("Herbalist", "Vanilla");
    ATCM.TTF.Add("Brawler", "Vanilla");
    ATCM.TTF.Add("Formerscout", "Vanilla");
    ATCM.TTF.Add("BaseballPlayer", "Vanilla");
    ATCM.TTF.Add("Hiker", "Vanilla");
    ATCM.TTF.Add("Hunter", "Vanilla");
    ATCM.TTF.Add("Gymnast", "Vanilla");
    ATCM.TTF.Add("Mechanics", "Vanilla");
    ATCM.TTF.Add("Mechanics2", "Vanilla");
---------------------------------------------------------------------------------------------------------------------------------------------------------------

    --BEAST OF BURDEN
    TraitFactory.addTrait("AT_BeastOfBurden", getText("UI_trait_AT_BeastOfBurden"), 1, workString, false);
    ATCM.TTF.Add("AT_BeastOfBurden", "AnthroTraits,CostVariable,Anthro,Strong");

    --BUG_O_SSIEUR
    TraitFactory.addTrait("AT_Bug_o_ssieur", getText("UI_trait_AT_Bug_o_ssieur"), 1, getText("UI_trait_AT_Bug_o_ssieur_desc"), false);
    ATCM.TTF.Add("AT_Bug_o_ssieur", "AnthroTraits,CostVariable");

    --BULL RUSH
    --TraitFactory.addTrait("AT_BullRush", getText("UI_trait_AT_BullRush"), 1, workString, false);
    --this.TTF.Add("AT_BullRush", "AnthroTraits,CostVariable,Anthro,Horns");

    --CARNIVORE
    TraitFactory.addTrait("AT_Carnivore", getText("UI_trait_AT_Carnivore"), 1, workString, false);
    ATCM.TTF.Add("AT_Carnivore", "AnthroTraits,CostVariable,Anthro,Carnivore");

    --CARRION EATER
    TraitFactory.addTrait("AT_CarrionEater", getText("UI_trait_AT_CarrionEater"), 1, workString, false);
    ATCM.TTF.Add("AT_CarrionEater", "AnthroTraits,CostVariable,Anthro,Carnivore,Scavenger");

    --DIGITIGRADE
    local AT_Digitigrade = TraitFactory.addTrait("AT_Digitigrade", getText("UI_trait_AT_Digitigrade"), 1, workString, false);
    AT_Digitigrade:addXPBoost(Perks.Sprinting, 1)
    AT_Digitigrade:addXPBoost(Perks.Lightfoot, 1);
    AT_Digitigrade:addXPBoost(Perks.Sneak, 1);
    ATCM.TTF.Add("AT_Digitigrade", "AnthroTraits,CostVariable,Anthro");

    --EXCLAIMER
    TraitFactory.addTrait("AT_Exclaimer", getText("UI_trait_AT_Exclaimer"), -1, workString, false);
    ATCM.TTF.Add("AT_Exclaimer", "AnthroTraits,CostVariable");

    --FERAL BODY
    local AT_FeralBody = TraitFactory.addTrait("AT_FeralBody", getText("UI_trait_AT_FeralBody"), 1, getText("UI_trait_AT_FeralBody_desc"), false);
    AT_FeralBody:addXPBoost(Perks.Strength, 1);
    AT_FeralBody:addXPBoost(Perks.Fitness, -1);
    ATCM.TTF.Add("AT_FeralBody", "AnthroTraits,CostVariable,Anthro");

    --FERAL DIGESTION
    TraitFactory.addTrait("AT_FeralDigestion", getText("UI_trait_AT_FeralDigestion"), -1, workString, false);
    ATCM.TTF.Add("AT_FeralDigestion", "AnthroTraits,CostVariable,Anthro");

    --FOOD MOTIVATED
    TraitFactory.addTrait("AT_FoodMotivated", getText("UI_trait_AT_FoodMotivated"), 1, workString, false);
    ATCM.TTF.Add("AT_FoodMotivated", "AnthroTraits,CostVariable,Anthro");

    --HERBIVORE
    TraitFactory.addTrait("AT_Herbivore", getText("UI_trait_AT_Herbivore"), 1, workString, false);
    ATCM.TTF.Add("AT_Herbivore", "AnthroTraits,CostVariable,Anthro,Herbivore");

    --LONELY
    TraitFactory.addTrait("AT_Lonely", getText("UI_trait_AT_Lonely"), -1, workString, false);
    ATCM.TTF.Add("AT_Lonely", "AnthroTraits,CostVariable,Anthro,Social"); --(Xochi suggestion)

    --NATURAL TUMBLER
    TraitFactory.addTrait("AT_NaturalTumbler", getText("UI_trait_AT_NaturalTumbler"), 1, workString, false);
    ATCM.TTF.Add("AT_NaturalTumbler", "AnthroTraits,CostVariable,Anthro,Agile");

    --STINKY
    TraitFactory.addTrait("AT_Stinky", getText("UI_trait_AT_Stinky"), -1, getText("UI_trait_AT_Stinky_desc"), false);
    ATCM.TTF.Add("AT_Stinky", "AnthroTraits,CostVariable,");

    --TAIL
    TraitFactory.addTrait("AT_Tail", getText("UI_trait_AT_Tail"), 1, workString, false);
    ATCM.TTF.Add("AT_Tail", "AnthroTraits,CostVariable,Anthro,Tail");

    --TORPOR
    TraitFactory.addTrait("AT_Torpor", getText("UI_trait_AT_Torpor"), -1, workString, false);
    ATCM.TTF.Add("AT_Torpor", "AnthroTraits,CostVariable,Anthro,Hibernator");

    --UNGULIGRADE
    local AT_Unguligrade = TraitFactory.addTrait("AT_Unguligrade", getText("UI_trait_AT_Unguligrade"), 1, getText("UI_trait_AT_Unguligrade_desc"), false);
    AT_Unguligrade:addXPBoost(Perks.Sprinting, 1)
    AT_Unguligrade:addXPBoost(Perks.Nimble, 1);
    ATCM.TTF.Add("AT_Unguligrade", "AnthroTraits,CostVariable,Anthro,Unguligrade");

    --UNWIELDY HANDS
    TraitFactory.addTrait("AT_UnwieldyHands", getText("UI_trait_AT_UnwieldyHands"), -1, workString, false);
    ATCM.TTF.Add("AT_UnwieldyHands", "AnthroTraits,CostVariable,Anthro,ThreeFingers");

    --VESTIGIAL WINGS
    TraitFactory.addTrait("AT_VestigialWings", getText("UI_trait_AT_VestigialWings"), 1, getText("UI_trait_AT_VestigialWings_desc"), false);
    ATCM.TTF.Add("AT_VestigialWings", "AnthroTraits,CostVariable,Anthro,Winged");

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

    TraitFactory.setMutualExclusive("AT_Herbivore", "AT_Carnivore");
    TraitFactory.setMutualExclusive("AT_Herbivore", "AT_CarrionEater");
    TraitFactory.setMutualExclusive("AT_NaturalTumbler", "AT_VestigialWings");
    TraitFactory.setMutualExclusive("AT_Digitigrade", "AT_Unguligrade");


    ATCM.setTraitDescriptions();
end

AnthroTraitsCreationMethods.setTraitDescriptions = function ()
    local ATCM = AnthroTraitsCreationMethods;
    local affectedTraits = ATCM.TTF.GetAllTraitsWithTag("AnthroTraits");
    local workString = "";

    for i = 1, #affectedTraits
        do
            local trait = affectedTraits[i];
            
            if trait == TraitFactory.getTrait("AT_BeastOfBurden")
            then
                workString = string.format(getText("UI_trait_AT_BeastOfBurden_desc"), SandboxVars.AnthroTraits.AT_BeastOfBurdenPctIncrease * 100);
                trait:setDescription(workString);
            --[[ elseif trait == TraitFactory.getTrait("AT_BullRush")
            then
                workString = string.format(getText("UI_trait_AT_BullRush_desc"), SandboxVars.AnthroTraits.AT_BullRushKnockdownEndCost);
                trait:setDescription(workString); ]]
            elseif trait == TraitFactory.getTrait("AT_Carnivore")
            then
                workString = string.format(getText("UI_trait_AT_Carnivore_desc"), SandboxVars.AnthroTraits.AT_CarnivoreBonus  * 100, SandboxVars.AnthroTraits.AT_CarnivoreMalus  * 100);
                trait:setDescription(workString);
            elseif trait == TraitFactory.getTrait("AT_CarrionEater")
            then
                workString = string.format(getText("UI_trait_AT_CarrionEater_desc"), SandboxVars.AnthroTraits.AT_CarrionEaterBonus  * 100);
                trait:setDescription(workString);
            elseif trait == TraitFactory.getTrait("AT_Digitigrade")
            then
                workString = string.format(getText("UI_trait_AT_Digitigrade_desc"), SandboxVars.AnthroTraits.AT_DigitigradeStompDmgPctIncrease * 100);
                trait:setDescription(workString);
            elseif trait == TraitFactory.getTrait("AT_Exclaimer")
            then
                workString = string.format(getText("UI_trait_AT_Exclaimer_desc"), SandboxVars.AnthroTraits.AT_ExclaimerExclaimThresholdMultiplier);
                trait:setDescription(workString);
            elseif trait == TraitFactory.getTrait("AT_FeralDigestion")
            then
                workString = string.format(getText("UI_trait_AT_FeralDigestion_desc"), SandboxVars.AnthroTraits.AT_FeralDigestionPoisonAmt);
                trait:setDescription(workString);
            elseif trait == TraitFactory.getTrait("AT_FoodMotivated")
            then
                workString = string.format(getText("UI_trait_AT_FoodMotivated_desc"), SandboxVars.AnthroTraits.AT_FoodMotivatedBonus);
                trait:setDescription(workString);
            elseif trait == TraitFactory.getTrait("AT_Herbivore")
            then
                workString = string.format(getText("UI_trait_AT_Herbivore_desc"), SandboxVars.AnthroTraits.AT_HerbivoreBonus * 100, SandboxVars.AnthroTraits.AT_HerbivoreMalus * 100);
                trait:setDescription(workString);
            elseif trait == TraitFactory.getTrait("AT_AnthroImmunity")
            then
                workString = string.format(getText("UI_trait_AT_AnthroImmunity_desc"), SandboxVars.AnthroTraits.AT_AnthroImmunityBiteInfectionChance, SandboxVars.AnthroTraits.AT_AnthroImmunityLacerationInfectionChance *.25, SandboxVars.AnthroTraits.AT_AnthroImmunityScratchInfectionChance *.07);
                trait:setDescription(workString);
            elseif trait == TraitFactory.getTrait("AT_Lonely")
            then
                workString = string.format(getText("UI_trait_AT_Lonely_desc"), SandboxVars.AnthroTraits.AT_LonelyHoursToAffect, SandboxVars.AnthroTraits.AT_LonelyHourlyUnhappyIncrease * 100);
                trait:setDescription(workString);
            elseif trait == TraitFactory.getTrait("AT_NaturalTumbler")
            then
                workString = string.format(getText("UI_trait_AT_NaturalTumbler_desc"), SandboxVars.AnthroTraits.AT_NaturalTumblerFallTimeMult * 100);
                trait:setDescription(workString);
            elseif trait == TraitFactory.getTrait("AT_Tail")
            then
                workString = string.format(getText("UI_trait_AT_Tail_desc"), SandboxVars.AnthroTraits.AT_TailTripReduction);
                trait:setDescription(workString);
            elseif trait == TraitFactory.getTrait("AT_Torpor")
            then
                workString = string.format(getText("UI_trait_AT_Torpor_desc"), SandboxVars.AnthroTraits.AT_TorporEnduranceDecrease * 100);
                trait:setDescription(workString);
            elseif trait == TraitFactory.getTrait("AT_Unguligrade")
            then
                workString = string.format(getText("UI_trait_AT_Unguligrade_desc"), SandboxVars.AnthroTraits.AT_UnguligradeStompDmgPctIncrease * 100);
                trait:setDescription(workString);
            elseif trait == TraitFactory.getTrait("AT_UnwieldyHands")
            then
                workString = string.format(getText("UI_trait_AT_UnwieldyHands_desc"), SandboxVars.AnthroTraits.AT_UnwieldyHandsTimeIncrease * 100);
                trait:setDescription(workString);
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
            local trait = affectedTraits[i]
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
        local trait = affectedTraits[i]
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