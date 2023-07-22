local AnthroTraitsMainCreationMethods = {}
AnthroTraitsMainCreationMethods.TTF = require("TraitTagFramework");

AnthroTraitsMainCreationMethods.initAnthroTraits = function()
    local this = AnthroTraitsMainCreationMethods;

    this.TTF.Add("Axeman", "Vanilla");
    this.TTF.Add("Handy", "Vanilla");
    this.TTF.Add("SpeedDemon", "Vanilla");
    this.TTF.Add("SundayDriver", "Vanilla");
    this.TTF.Add("Brave", "Vanilla");
    this.TTF.Add("Cowardly", "Vanilla");
    this.TTF.Add("Clumsy", "Vanilla");
    this.TTF.Add("Graceful", "Vanilla");
    this.TTF.Add("ShortSighted", "Vanilla");
    this.TTF.Add("HardOfHearing", "Vanilla");
    this.TTF.Add("Deaf", "Vanilla");
    this.TTF.Add("KeenHearing", "Vanilla, Anthro,KeenHearing");
    this.TTF.Add("EagleEyed", "Vanilla, Anthro,KeenVision");
    this.TTF.Add("HeartyAppitite", "Vanilla");
    this.TTF.Add("LightEater", "Vanilla");
    this.TTF.Add("ThickSkinned", "Vanilla,Anthro,Tough");
    this.TTF.Add("Unfit", "Vanilla");
    this.TTF.Add("Out of Shape", "Vanilla");
    this.TTF.Add("Fit", "Vanilla");
    this.TTF.Add("Athletic", "Vanilla");
    this.TTF.Add("Nutritionist", "Vanilla");
    this.TTF.Add("Nutritionist2", "Vanilla");
    this.TTF.Add("Emaciated", "Vanilla");
    this.TTF.Add("Very Underweight", "Vanilla");
    this.TTF.Add("Underweight", "Vanilla");
    this.TTF.Add("Overweight", "Vanilla");
    this.TTF.Add("Obese", "Vanilla");
    this.TTF.Add("Strong", "Vanilla");
    this.TTF.Add("Stout", "Vanilla");
    this.TTF.Add("Weak", "Vanilla");
    this.TTF.Add("Feeble", "Vanilla");
    this.TTF.Add("Resilient", "Vanilla");
    this.TTF.Add("ProneToIllness", "Vanilla");
    this.TTF.Add("Agoraphobic", "Vanilla");
    this.TTF.Add("Claustophobic", "Vanilla");
    this.TTF.Add("Lucky", "Vanilla");
    this.TTF.Add("Unlucky", "Vanilla");
    this.TTF.Add("Marksman", "Vanilla");
    this.TTF.Add("NightOwl", "Vanilla");
    this.TTF.Add("Outdoorsman", "Vanilla");
    this.TTF.Add("FastHealer", "Vanilla");
    this.TTF.Add("FastLearner", "Vanilla");
    this.TTF.Add("FastReader", "Vanilla");
    this.TTF.Add("AdrenalineJunkie", "Vanilla");
    this.TTF.Add("Inconspicuous", "Vanilla");
    this.TTF.Add("NeedsLessSleep", "Vanilla");
    this.TTF.Add("NightVision", "Vanilla,Anthro,KeenVision");
    this.TTF.Add("Organized", "Vanilla");
    this.TTF.Add("LowThirst", "Vanilla");
    this.TTF.Add("Burglar", "Vanilla");
    this.TTF.Add("FirstAid", "Vanilla");
    this.TTF.Add("Fishing", "Vanilla");
    this.TTF.Add("Gardener", "Vanilla");
    this.TTF.Add("Jogger", "Vanilla");
    this.TTF.Add("SlowHealer", "Vanilla");
    this.TTF.Add("SlowLearner", "Vanilla");
    this.TTF.Add("SlowReader", "Vanilla");
    this.TTF.Add("NeedsMoreSleep", "Vanilla");
    this.TTF.Add("Conspicuous", "Vanilla");
    this.TTF.Add("Disorganized", "Vanilla");
    this.TTF.Add("HighThirst", "Vanilla");
    this.TTF.Add("Illiterate", "Vanilla");
    this.TTF.Add("Insomniac", "Vanilla");
    this.TTF.Add("Pacifist", "Vanilla");
    this.TTF.Add("Thinskinned", "Vanilla");
    this.TTF.Add("Smoker", "Vanilla");
    this.TTF.Add("Tailor", "Vanilla");
    this.TTF.Add("Dextrous", "Vanilla");
    this.TTF.Add("AllThumbs", "Vanilla");
    this.TTF.Add("Desensitized", "Vanilla");
    this.TTF.Add("WeakStomach", "Vanilla");
    this.TTF.Add("IronGut", "Vanilla,Anthro,Scavenger");
    this.TTF.Add("Hemophobic", "Vanilla");
    this.TTF.Add("Asthmatic", "Vanilla");
    this.TTF.Add("Cook", "Vanilla");
    this.TTF.Add("Cook2", "Vanilla");
    this.TTF.Add("Herbalist", "Vanilla");
    this.TTF.Add("Brawler", "Vanilla");
    this.TTF.Add("Formerscout", "Vanilla");
    this.TTF.Add("BaseballPlayer", "Vanilla");
    this.TTF.Add("Hiker", "Vanilla");
    this.TTF.Add("Hunter", "Vanilla");
    this.TTF.Add("Gymnast", "Vanilla");
    this.TTF.Add("Mechanics", "Vanilla");
    this.TTF.Add("Mechanics2", "Vanilla");
---------------------------------------------------------------------------------------------------------------------------------------------------------------

    TraitFactory.addTrait("AT_BeastOfBurden", getText("UI_trait_AT_BeastOfBurden"), 1, getText("UI_trait_AT_BeastOfBurden_desc"), false);
    this.TTF.Add("AT_BeastOfBurden", "AnthroTraits,CostVariable,Anthro,Strong");

    TraitFactory.addTrait("AT_Bug_o_ssieur", getText("UI_trait_AT_Bug_o_ssieur"), 1, getText("UI_trait_AT_Bug_o_ssieur_desc"), false);
    this.TTF.Add("AT_Bug_o_ssieur", "AnthroTraits,CostVariable");

    TraitFactory.addTrait("AT_BullRush", getText("UI_trait_AT_BullRush"), 1, getText("UI_trait_AT_BullRush_desc"), false);
    this.TTF.Add("AT_BullRush", "AnthroTraits,CostVariable,Anthro,Horns");

    TraitFactory.addTrait("AT_Carnivore", getText("UI_trait_AT_Carnivore"), 1, getText("UI_trait_AT_Carnivore_desc"), false);
    this.TTF.Add("AT_Carnivore", "AnthroTraits,CostVariable,Anthro,Carnivore");

    TraitFactory.addTrait("AT_CarrionEater", getText("UI_trait_AT_CarrionEater"), 1, getText("UI_trait_AT_CarrionEater_desc"), false);
    this.TTF.Add("AT_CarrionEater", "AnthroTraits,CostVariable,Anthro,Carnivore,Scavenger");

    local AT_Digitigrade = TraitFactory.addTrait("AT_Digitigrade", getText("UI_trait_AT_Digitigrade"), 1, getText("UI_trait_AT_Digitigrade_desc"), false);
    AT_Digitigrade:addXPBoost(Perks.Sprinting, 1)
    this.TTF.Add("AT_Digitigrade", "AnthroTraits,CostVariable,Anthro");

    TraitFactory.addTrait("AT_Exclaimer", getText("UI_trait_AT_Exclaimer"), -1, getText("UI_trait_AT_Exclaimer_desc"), false);
    this.TTF.Add("AT_Exclaimer", "AnthroTraits,CostVariable");

    local AT_FeralBody = TraitFactory.addTrait("AT_FeralBody", getText("UI_trait_AT_FeralBody"), 1, getText("UI_trait_AT_FeralBody_desc"), false);
    AT_FeralBody:addXPBoost(Perks.Strength, 1);
    AT_FeralBody:addXPBoost(Perks.Fitness, -1);
    this.TTF.Add("AT_FeralBody", "AnthroTraits,CostVariable,Anthro");

    TraitFactory.addTrait("AT_FeralDigestion", getText("UI_trait_AT_FeralDigestion"), -1, getText("UI_trait_AT_FeralDigestion_desc"), false);
    this.TTF.Add("AT_FeralDigestion", "AnthroTraits,CostVariable,Anthro");

    TraitFactory.addTrait("AT_FoodMotivated", getText("UI_trait_AT_FoodMotivated"), 1, getText("UI_trait_AT_FoodMotivated_desc"), false);
    this.TTF.Add("AT_FoodMotivated", "AnthroTraits,CostVariable,Anthro");

    TraitFactory.addTrait("AT_Herbivore", getText("UI_trait_AT_Herbivore"), 1, getText("UI_trait_AT_Herbivore_desc"), false);
    this.TTF.Add("AT_Herbivore", "AnthroTraits,CostVariable,Anthro,Herbivore");

    local AT_Hooves = TraitFactory.addTrait("AT_Hooves", getText("UI_trait_AT_Hooves"), 1, getText("UI_trait_AT_Hooves_desc"), false);
    AT_Hooves:addXPBoost(Perks.Nimble, 1);
    this.TTF.Add("AT_Hooves", "AnthroTraits,CostVariable,Anthro,Hooves");

    TraitFactory.addTrait("AT_Immunity", getText("UI_trait_AT_Immunity"), 1, getText("UI_trait_AT_Immunity_desc"), false);
    this.TTF.Add("AT_Immunity", "AnthroTraits,CostVariable,Anthro");
    --add ability to ignore this trait if infected by a former (furry) player?

    TraitFactory.addTrait("AT_Lonely", getText("UI_trait_AT_Lonely"), -1, getText("UI_trait_AT_Lonely_desc"), false);
    this.TTF.Add("AT_Lonely", "AnthroTraits,CostVariable,Anthro,Social"); --(Xochi suggestion)

    TraitFactory.addTrait("AT_NaturalTumbler", getText("UI_trait_AT_NaturalTumbler"), 1, getText("UI_trait_AT_NaturalTumbler_desc"), false);
    this.TTF.Add("AT_NaturalTumbler", "AnthroTraits,CostVariable,Anthro,Agile");

    local AT_Paws = TraitFactory.addTrait("AT_Paws", getText("UI_trait_AT_Paws"), 1, getText("UI_trait_AT_Paws_desc"), false);
    AT_Paws:addXPBoost(Perks.Lightfoot, 1);
    AT_Paws:addXPBoost(Perks.Sneak, 1);
    this.TTF.Add("AT_Paws", "AnthroTraits,CostVariable,Anthro,Paws");

    TraitFactory.addTrait("AT_Stinky", getText("UI_trait_AT_Stinky"), -1, getText("UI_trait_AT_Stinky_desc"), false);
    this.TTF.Add("AT_Stinky", "AnthroTraits,CostVariable,");

    TraitFactory.addTrait("AT_Tail", getText("UI_trait_AT_Tail"), 1, getText("UI_trait_AT_Tail_desc"), false);
    this.TTF.Add("AT_Tail", "AnthroTraits,CostVariable,Anthro,Tail");

    TraitFactory.addTrait("AT_Torpor", getText("UI_trait_AT_Torpor"), -1, getText("UI_trait_AT_Torpor_desc"), false);
    this.TTF.Add("AT_Torpor", "AnthroTraits,CostVariable,Anthro,Hibernator");

    TraitFactory.addTrait("AT_UnwieldyHands", getText("UI_trait_AT_UnwieldyHands"), -1, getText("UI_trait_AT_UnwieldyHands_desc"), false);
    this.TTF.Add("AT_UnwieldyHands", "AnthroTraits,CostVariable,Anthro,ThreeFingers");

    TraitFactory.addTrait("AT_VestigialWings", getText("UI_trait_AT_VestigialWings"), 1, getText("UI_trait_AT_VestigialWings_desc"), false);
    this.TTF.Add("AT_VestigialWings", "AnthroTraits,CostVariable,Anthro,Winged");

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

AnthroTraitsMainCreationMethods.refundSelectedAffectedTraits = function()
    local this = AnthroTraitsMainCreationMethods;
    local ccp = MainScreen.instance.charCreationProfession
    local affectedTraits = this.TTF.GetAllTraitsWithTag("CostVariable");
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

AnthroTraitsMainCreationMethods.sortTraits = function()
    local this = AnthroTraitsMainCreationMethods;
    local ccp = MainScreen.instance.charCreationProfession;
    local affectedTraits = this.TTF.GetAllTraitsWithTag("CostVariable");

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
        else
            ccp.listboxBadTrait:addItem(label, trait)
        end
    end
    CharacterCreationMain.sort(ccp.listboxTrait.items)
    CharacterCreationMain.invertSort(ccp.listboxBadTrait.items)
    CharacterCreationMain.sort(ccp.listboxTraitSelected.items)
end

Events.OnGameBoot.Add(AnthroTraitsMainCreationMethods.initAnthroTraits);
Events.OnConnected.Add(AnthroTraitsMainCreationMethods.refreshTraitCosts);

return AnthroTraitsMainCreationMethods;