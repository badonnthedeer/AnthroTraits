require('NPCs/MainCreationMethods');

local function InitATPlayerData(player)

    local modData = player:getModData();

    if modData.ATPlayerData == nil then
        modData.ATPlayerData = {};
        local atData = modData.ATPlayerData;

        atData.trulyInfected = false;

    end
end

local function ATHandleInfection(player)
    local biteInfectionChance = SandboxVars.AnthroTraits.AnthroImmunityBiteInfectionChance;
    local lacerationInfectionChance = SandboxVars.AnthroTraits.AnthroImmunityLacerationInfectionChance;
    local scratchInfectionChance = SandboxVars.AnthroTraits.AnthroImmunityScratchInfectionChance;

    --print("Handle Infection Triggered");

    --debug
    local bodyDamage = player:getBodyDamage();
    --print(bodypart:getType()); --this causes an error, useful for breakpoints in game
    --end debug

    for i = 0, player:getBodyDamage():getBodyParts():size() - 1 
    do
        local bodypart = player:getBodyDamage():getBodyParts():get(i);
        if bodypart:HasInjury() == true and bodypart:IsInfected() 
        then
            print( tostring(bodypart:getType()) .. " is injured and infected.");
            if player:HasTrait("anthroHooves")
            then
                if tostring(bodypart:getType()) == "Foot_L" or tostring(bodypart:getType()) == "Foot_R"
                then
                    print("anthroHooves foot immunity triggered.");
                    bodypart:SetInfected(false);
                    player:getBodyDamage():setInfected(false);
                    player:getBodyDamage():setInfectionMortalityDuration(-1);
                    player:getBodyDamage():setInfectionTime(-1);
                    player:getBodyDamage():setInfectionLevel(0);
                    player:getBodyDamage():setInfectionGrowthRate(0);
                end
            end
            if player:HasTrait("anthroImmunity")
            then
                local rolledInfectionChance = ZombRand(1, 100);
                print("Rolled " .. rolledInfectionChance)
                if bodypart:bitten() 
                then
                    if biteInfectionChance <= rolledInfectionChance 
                    then
                        bodypart:SetInfected(false);
                        player:getBodyDamage():setInfected(false);
                        player:getBodyDamage():setInfectionMortalityDuration(-1);
                        player:getBodyDamage():setInfectionTime(-1);
                        player:getBodyDamage():setInfectionLevel(0);
                        player:getBodyDamage():setInfectionGrowthRate(0);
                        print("Infection defense successful.")
                        if SandboxVars.AnthroTraits.AnthroImmunityBiteGetsRegularInfectionOnDefense
                        then
                            bodypart:setInfectedWound(true);
                            print("Knox infection substituted with regular infection. Human mouths are septic :S")
                        end
                        return false;
                    else
                        print("Infection defense UNSUCCESSFUL. DIE WELL!");
                        return true;
                    end
                elseif bodypart:isCut() --irritatingly, using the function to get laceration doesn't follow the same naming convention
                then
                    if lacerationInfectionChance <= rolledInfectionChance 
                    then
                        bodypart:SetInfected(false);
                        player:getBodyDamage():setInfected(false);
                        player:getBodyDamage():setInfectionMortalityDuration(-1);
                        player:getBodyDamage():setInfectionTime(-1);
                        player:getBodyDamage():setInfectionLevel(0);
                        player:getBodyDamage():setInfectionGrowthRate(0);
                        print("Infection defense successful.")
                        return false;
                    else
                        print("Infection defense UNSUCCESSFUL. DIE WELL!")
                        return true;
                    end
                elseif bodypart:scratched() 
                then
                    if scratchInfectionChance <= rolledInfectionChance 
                    then
                        bodypart:SetInfected(false);
                        player:getBodyDamage():setInfected(false);
                        player:getBodyDamage():setInfectionMortalityDuration(-1);
                        player:getBodyDamage():setInfectionTime(-1);
                        player:getBodyDamage():setInfectionLevel(0);
                        player:getBodyDamage():setInfectionGrowthRate(0);
                        print("Infection defense successful.")
                        return false;
                    else
                        print("Infection defense UNSUCCESSFUL. DIE WELL!")
                        return true;
                    end
                end
            end 
        end
    end
end

--function MTPlayerHit(player, _, __){
local function ATPlayerDamageTick(player)
    if player:isZombie()
    then
		return
	end
    --print("I'm being damaged!");
    local playerData = player:getModData().ATPlayerData;
    --print(player:getBodyDamage():isInfected())
    --print(playerData.trulyInfected)

    if player:getBodyDamage():isInfected() == true and playerData.trulyInfected == false
    then
        print("Handle Infection about to be triggered");
        playerData.trulyInfected = ATHandleInfection(player);
    end
    
    if player:HasTrait("anthroHooves")
    then
        --immune to scratches, lacerations, bites
        local footL = player:getBodyDamage():getBodyPart(BodyPartType.Foot_L);
        local footR = player:getBodyDamage():getBodyPart(BodyPartType.Foot_R);

        if footL:scratched()
        then
            print("can't scratch me anthroHooves!");
            --casing is inconsistent in the game >:C 
            footL:setScratchTime(0);
			footL:SetScratchedWeapon(false);
            footL:setBleedingTime(0);
            footL:setBleeding(false);
        end
        if footR:scratched()
        then
            print("can't scratch me anthroHooves!");
            footR:setScratchTime(0);
			footR:SetScratchedWeapon(false);
            footR:setBleedingTime(0);
            footR:setBleeding(false);
        end
        if footL:isCut()
        then
            print("can't cut me anthroHooves!");
            footL:setCutTime(0);
            footL:setCut(false, false);
            footL:setBleedingTime(0);
            footL:setBleeding(false);
        end
        if footR:isCut()
        then
            print("can't cut me anthroHooves!");
            footR:setCutTime(0);
            footR:setCut(false, false);
            footR:setBleedingTime(0);
            footR:setBleeding(false);

        end
        if footL:bitten()
        then
            print("can't bite me anthroHooves!");
            --casing is inconsistent in the game >:C 
            footL:setBiteTime(0);
            footL:SetBitten(false, false);
            footL:setBleedingTime(0);
            footL:setBleeding(false);
        end
        if footR:bitten()
        then
            print("can't bite me anthroHooves!");
            footR:setBiteTime(0);
            footR:SetBitten(false, false);
            footR:setBleedingTime(0);
            footR:setBleeding(false);
            
        end

    end
    -- if player:HasTrait("anthroPaws") 
    -- then
    --     --immune to scratches?
    --     for i = 0, player:getBodyDamage():getBodyParts():size() - 1 
    --     do
    --         local bodypart = player:getBodyDamage():getBodyParts():get(i);
    --         print(bodypart);
    --     end
    -- end
end

local ISEatFoodAction:perform = ATOnEatPerform
ATOnEatPerform = function()
    -- code to run before the original
    local foodHungChange = self.item:getHungChange();
    local foodType = self.item.getFoodType();

    if toString(foodType) == "Meat"
    then
        if this.character.GetTraits().contains("anthroCarnivore")
        then
            self.character:Eat(new item{ HungerChange = (foodHungChange * .5)}, 100);
        end
    end
    if toString(foodType) == "Vegetable"
    then
        if this.character.GetTraits().contains("anthroHerbivore")
        then
            self.character:Eat(new item{ HungerChange = (foodHungChange * .5)}, 100);
        end
    end

    ISEatFoodAction:perform()
    -- code to run after the original
    
    if toString(foodType) == "Meat"
    then
        if this.character.GetTraits().contains("anthroHerbivore")
        then
            self.character:Eat(new item{ HungerChange = (foodHungChange * -.5)}, 100);
        end
    end
    if toString(foodType) == "Vegetable"
    then
        if this.character.GetTraits().contains("anthroCarnivore")
        then
            self.character:Eat(new item{ HungerChange = (foodHungChange * -.5)}, 100);
        end
    end

end
Events.OnNewGame.Add(InitATPlayerData);
Events.OnPlayerGetDamage.Add(ATPlayerDamageTick)