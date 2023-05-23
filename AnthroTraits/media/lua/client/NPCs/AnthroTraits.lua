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
            if player:HasTrait("AT_Hooves")
            then
                if tostring(bodypart:getType()) == "Foot_L" or tostring(bodypart:getType()) == "Foot_R"
                then
                    print("AT_Hooves foot immunity triggered.");
                    bodypart:SetInfected(false);
                    player:getBodyDamage():setInfected(false);
                    player:getBodyDamage():setInfectionMortalityDuration(-1);
                    player:getBodyDamage():setInfectionTime(-1);
                    player:getBodyDamage():setInfectionLevel(0);
                    player:getBodyDamage():setInfectionGrowthRate(0);
                end
            end
            if player:HasTrait("AT_Immunity")
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
    
    if player:HasTrait("AT_Hooves")
    then
        --immune to scratches, lacerations, bites
        local footL = player:getBodyDamage():getBodyPart(BodyPartType.Foot_L);
        local footR = player:getBodyDamage():getBodyPart(BodyPartType.Foot_R);

        if footL:scratched()
        then
            print("can't scratch me AT_Hooves!");
            --casing is inconsistent in the game >:C 
            footL:setScratchTime(0);
			footL:SetScratchedWeapon(false);
            footL:setBleedingTime(0);
            footL:setBleeding(false);
        end
        if footR:scratched()
        then
            print("can't scratch me AT_Hooves!");
            footR:setScratchTime(0);
			footR:SetScratchedWeapon(false);
            footR:setBleedingTime(0);
            footR:setBleeding(false);
        end
        if footL:isCut()
        then
            print("can't cut me AT_Hooves!");
            footL:setCutTime(0);
            footL:setCut(false, false);
            footL:setBleedingTime(0);
            footL:setBleeding(false);
        end
        if footR:isCut()
        then
            print("can't cut me AT_Hooves!");
            footR:setCutTime(0);
            footR:setCut(false, false);
            footR:setBleedingTime(0);
            footR:setBleeding(false);

        end
        if footL:bitten()
        then
            print("can't bite me AT_Hooves!");
            --casing is inconsistent in the game >:C 
            footL:setBiteTime(0);
            footL:SetBitten(false, false);
            footL:setBleedingTime(0);
            footL:setBleeding(false);
        end
        if footR:bitten()
        then
            print("can't bite me AT_Hooves!");
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

local function ApplyFoodTypeMod(modifier, character, foodEaten, percentEaten)
getPlayer()
    local foodHungChange = foodEaten:getHungerChange();
    local foodThirstChange = foodEaten:getThirstChange();
    local foodBoredomChange = foodEaten:getBoredomChange();
    local foodUnhappyChange = foodEaten:getUnhappyChange();
    local foodCalories = foodEaten:getCalories();

    local charStats = character:getStats();
    local charBodyDmg = character:getBodyDamage();
    local charNutrition = character:getNutrition();

    if foodHungChange == not nil
    then
        charStats:setHunger(charStats:getHunger() - ((foodHungChange * modifier ) * percentEaten));
    end
    if foodThirstChange == not nil
    then
        charStats:setThirst(charStats:getThirst() - ((foodThirstChange * modifier) * percentEaten));
    end
    if foodBoredomChange == not nil
    then
        charBodyDmg:setBoredomLevel(charBodyDmg:getBoredomLevel() - ((foodBoredomChange * modifier ) * percentEaten));
    end
    if foodUnhappyChange == not nil
    then
        charBodyDmg:setUnhappinessLevel(charBodyDmg:getUnhappinessLevel() - ((foodUnhappyChange * modifier ) * percentEaten));
    end
    if foodCalories == not nil
    then
        charNutrition:setCalories(charNutrition:getCalories() + ((foodCalories * modifier ) * percentEaten));
    end
end

local originalEatPerform = ISEatFoodAction.perform
ISEatFoodAction.perform = function(self)
    -- code to run before the original
    local charTraits = this.character:getTraits();

    local charStats = this.character:getStats();
    local charBodyDmg = this.character:getBodyDamage();
    local charNutrition = this.character:getNutrition();

    local rightFoodBonus = SandboxVars.AnthroTraits.RightFoodBonus;
    local wrongFoodMalus = SandboxVars.AnthroTraits.WrongFoodMalus;
    local carrionEaterBonus = SandboxVars.AnthroTraits.CarrionEaterBonus;
    local foodMotivatedBonus = SandboxVars.AnthroTraits.FoodMotivatedBonus;

    local beforeUnhappiness = charBodyDmg:getUnhappinessLevel();
    local beforeFoodSickness = charBodyDmg:getFoodSicknessLevel();

    local foodEaten = self.item
    local foodPercentEaten = self.percent
    local foodDisplayName = foodEaten:getDisplayName();
    local foodType = foodEaten:getFoodType();


    originalEatPerform()
    -- code to run after the original

    if charTraits.contains("AT_Carnivore")
    then
        if foodType == "Vegetables" or foodType == "Fruits"
        then
            ApplyFoodTypeMod(wrongFoodMalus, this.character, self.item, self.percent);
        elseif charTraits.contains("AT_CarrionEater") and (foodType == "Meat" or foodType == "Seafood") and foodEaten:isRotten()
        then
            ApplyFoodTypeMod((rightFoodBonus + carrionEaterBonus), this.character, self.item, self.percent);
            charBodyDmg:setFoodSicknessLevel(beforeFoodSickness);
        elseif foodType == "Meat" or foodType == "Seafood"
        then
            ApplyFoodTypeMod(rightFoodBonus, this.character, self.item, self.percent);
            if not foodEaten:isRotten()
            then
                charBodyDmg:setFoodSicknessLevel(beforeFoodSickness);
            end
        end

    elseif charTraits.contains("AT_Herbivore") then
        if foodType == "Vegetables" or foodType == "Fruits"
        then
            ApplyFoodTypeMod(rightFoodBonus, this.character, self.item, foodPercentEaten);
            if not foodEaten:isRotten()
            then
                charBodyDmg:setFoodSicknessLevel(beforeFoodSickness);
            end
        elseif foodType == "Meat" or foodType == "Seafood"
        then
            ApplyFoodTypeMod(wrongFoodMalus, this.character, self.item, foodPercentEaten);
        end

    elseif charTraits.contains("AT_CarrionEater")
    then
        if (foodType == "Meat" or foodType == "Seafood") and foodEaten:isRotten()
        then
            ApplyFoodTypeMod(carrionEaterBonus, this.character, self.item, foodPercentEaten);
            charBodyDmg:setFoodSicknessLevel(beforeFoodSickness);
        end
    end

    if charTraits.contains("AT_FoodMotivated")
    then
        charBodyDmg:setBoredomLevel(charBodyDmg:getBoredomLevel() - (foodMotivatedBonus * foodPercentEaten));
        if(foodDisplayName == "Opened Dog Food")
        then
            --50 is unhappiness gain from dog food.
            charBodyDmg:setUnhappinessLevel(charBodyDmg:getUnhappinessLevel() - ((50 + foodMotivatedBonus) * foodPercentEaten));
        else
            charBodyDmg:setUnhappinessLevel(charBodyDmg:getUnhappinessLevel() - (foodMotivatedBonus * foodPercentEaten));
        end

    end
    if charTraits.contains("AT_FeralDigestion")
    then
        local maxPoisonAmt = SandboxVars.AnthroTraits.FeralDigestionPoisonAmt
        if(foodEaten:isAlcoholic() or
                foodDisplayName.contains("Cuppa") or
                foodDisplayName == ("Tea Bag") or
                foodDisplayName == ("Coffee") or
                foodDisplayName == ("Cocoa Powder"))
        then
            charBodyDmg:setPoisonLevel(charBodyDmg:getPoisonLevel() + (maxPoisonAmt * foodPercentEaten))
        elseif (foodDisplayName.contains("Choco") or
                foodDisplayName.contains("Cocoa") or
                foodDisplayName.contains("Pop") or
                foodDisplayName == ("Orange Soda") or
                foodDisplayName == ("Black Forest Cake Slice"))
        then
            charBodyDmg:setPoisonLevel(charBodyDmg:getPoisonLevel() + (maxPoisonAmt / 2 * foodPercentEaten))
        elseif(foodDisplayName == ("Smore") or
                foodDisplayName == ("Gum") or
                foodDisplayName == ("Cookie"))
        then
            charBodyDmg:setPoisonLevel(charBodyDmg:getPoisonLevel() +  (maxPoisonAmt / 4 * foodPercentEaten))
        end
    end
    if charTraits.contains("AT_Bug-o-ssieur")
    then
        if foodEaten:getIcon().contains("Insect")
        then
            charBodyDmg:setUnhappinessLevel(beforeUnhappiness);
        end
    end

end

local function ExclaimerCheck(player)
    local moodles = player:getMoodles();
    local panicLevel = moodles:getMoodleLevel(MoodleType.Panic);
    local thresholdMultiplier = SandboxVars.AnthroTraits.ExclaimerExclaimThresholdMultiplier;

    local exclaimChance = ZombRand(1,100);

    if (exclaimChance >= panicLevel * thresholdMultiplier)
    then
        if player:HasTrait("AT_Hooves")
        then
            player:sayShout("BLEAT!")
        else
            player:sayShout("HAHAHAHAHA!")
        end
    end
end

local function BeStinky(player)
    local stinkyLoudness = SandboxVars.AnthroTraits.StinkyTraitLoudness
    local stinkyCommentChance = SandboxVars.AnthroTraits.StinkyCommentChance
    local playerSquare = player:getCurrentSquare()
    local activePlayers = getNumActivePlayers()-1
    local playerInQuestion = player;

    getWorldSoundManager():addSound(player,
            playerSquare:getX(),
            playerSquare:getY(),
            playerSquare:getZ(),
            stinkyLoudness,
            100);
    if activePlayers > 0
    then
        for playerIndex = 0, activePlayers
        do
            playerInQuestion = getSpecificPlayer(playerIndex)
            if player == not playerInQuestion
            then
                if ZombRand(1,100) >= stinkyCommentChance and playerInQuestion:DistTo() < stinkyLoudness and playerInQuestion:getMoodles():getMoodleLevel("Pain") < 2 and playerInQuestion:getMoodles():getMoodleLevel("Panic") < 1
                then
                    playerInQuestion:Say("Stinky!")
                end
            end
        end
    end
end

local function ATEveryOneMinute()
    local activePlayers = getNumActivePlayers()-1
    if activePlayers >= 0
    then
        for playerIndex = 0, activePlayers
        do
            local player = getSpecificPlayer(playerIndex)
            if player and not player:isDead()
            then
                if player:HasTrait("AT_Exclaimer")
                then
                    ExclaimerCheck(player);
                end
                if player:HasTrait("AT_Stinky")
                then
                    BeStinky(player);
                end
            end

        end

    end

end

local function ATPlayerUpdate(player)
    if player:HasTrait("AT_NaturalTumbler")
    then
        --Fall damage reduced
        player:setFallTime(player:getFallTime() * .5);
    elseif player:HasTrait("AT_ClippedWings")
    then
        --immune to fall damage
        player:setFallTime(0);
    end
end

Events.OnNewGame.Add(InitATPlayerData);
Events.OnPlayerGetDamage.Add(ATPlayerDamageTick);
Events.OnPlayerUpdate.Add(ATPlayerUpdate);
Events.ATEveryOneMinute.Add(ATEveryOneMinute);