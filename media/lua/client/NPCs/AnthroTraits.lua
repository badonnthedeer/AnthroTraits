require('AnthroTraitsGlobals')
local TTF = require("TraitTagFramework");

--UTILITIES
local function FileExists(path)

    local reader = getModFileReader(AnthroTraitsGlobals.ModID, path, false);
    if not reader
    then
        return false
    else
        reader:close();
        return true
    end
end


local function AddItemTagToItemsFromFile(path, tag)
    if not FileExists(path)
    then
        print("Cannot find file");
        return {};
    end

    local reader = getModFileReader(AnthroTraitsGlobals.ModID, path, false);
    local line;
    local foundItem;
    local itemTags;

    while reader:ready()
    do
        line = reader:readLine();
        foundItem = getScriptManager():getItem(line);
        if foundItem ~= nil
        then
            itemTags = foundItem:getTags()
            if not itemTags:contains(tag)
            then
                itemTags:add(tag);
                if getDebug()
                then
                    print("tag "..tag.." added to "..line);
                end
            end
        else
            print("Cannot find item "..line.." to add tag "..tag)
        end
    end
    reader:close();
end

--[[local function InitTableFromFile(path)
    if not FileExists(path)
    then
        print("Cannot find file");
        return {};
    end

    local reader = getModFileReader(AnthroTraitsGlobals.ModID, path, false);
    local line;
    local returnTable = {}
    local returnTableCurrentIndex = 1;

    while reader:ready()
    do
        line = reader:readLine();
        returnTable[returnTableCurrentIndex] = line;
        returnTableCurrentIndex = returnTableCurrentIndex + 1;
    end
    reader:close();
    return returnTable;
end]]

local function HandleInfection(player)
    local biteInfectionChance = SandboxVars.AnthroTraits.AnthroImmunityBiteInfectionChance;
    local lacerationInfectionChance = SandboxVars.AnthroTraits.AnthroImmunityLacerationInfectionChance;
    local scratchInfectionChance = SandboxVars.AnthroTraits.AnthroImmunityScratchInfectionChance;
    if getDebug()
    then
        print("Handle Infection Triggered");
    end

    for i = 0, player:getBodyDamage():getBodyParts():size() - 1 
    do
        local bodypart = player:getBodyDamage():getBodyParts():get(i);
        if bodypart:HasInjury() == true and bodypart:IsInfected() 
        then
            if getDebug()
            then
                print( tostring(bodypart:getType()) .. " is injured and infected.");
            end
            if player:HasTrait("AT_Hooves")
            then
                if tostring(bodypart:getType()) == "Foot_L" or tostring(bodypart:getType()) == "Foot_R"
                then
                    if getDebug()
                    then
                        print("AT_Hooves foot immunity triggered.");
                    end
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
                if getDebug()
                then
                    print("Rolled " .. rolledInfectionChance)
                end
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
                        if getDebug()
                        then
                            print("Infection defense successful.");
                        end
                        if SandboxVars.AnthroTraits.AnthroImmunityBiteGetsRegularInfectionOnDefense
                        then
                            bodypart:setInfectedWound(true);
                            if getDebug()
                            then
                                print("Knox infection substituted with regular infection. Human mouths are septic :S");
                            end

                        end
                        return false;
                    else
                        if getDebug()
                        then
                            print("Infection defense UNSUCCESSFUL. DIE WELL!");
                        end
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
                        if getDebug()
                        then
                            print("Infection defense successful.");
                        end
                        return false;
                    else
                        if getDebug()
                        then
                            print("Infection defense UNSUCCESSFUL. DIE WELL!");
                        end
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
                        if getDebug()
                        then
                            print("Infection defense successful.");
                        end
                        return false;
                    else
                        if getDebug()
                        then
                            print("Infection defense UNSUCCESSFUL. DIE WELL!");
                        end
                        return true;
                    end
                end
            end 
        end
    end
end


local function NeutralizeFoodPoisoning(charBodyDmg, beforeFoodSickness, beforePoisonLevel)
    if getDebug()
    then
        print("Food Poisoning neutralized.");
    end
    charBodyDmg:setFoodSicknessLevel(beforeFoodSickness);
    charBodyDmg:setPoisonLevel(beforePoisonLevel);
end


local function ApplyFoodTypeMod(modifier, character, foodEaten, percentEaten)
    local foodBaseHunger = foodEaten:getBaseHunger();
    --local foodHungChange = foodEaten:getHungerChange();
    local foodThirstChange = foodEaten:getThirstChange();
    local foodBoredomChange = foodEaten:getBoredomChange();
    local foodUnhappyChange = foodEaten:getUnhappyChange();
    local foodCalories = foodEaten:getCalories();

    local charStats = character:getStats();
    local charBodyDmg = character:getBodyDamage();
    local charNutrition = character:getNutrition();

    if getDebug()
    then
        print("Item| BaseHunger: "..foodBaseHunger..", ThirstChange: "..foodThirstChange..", BoredomChange: "..foodBoredomChange..", UnhappyChange: "..foodUnhappyChange..", Calories: "..foodCalories);
        print("Before Mod| Hunger: "..charStats:getHunger()..", Thirst: "..charStats:getThirst()..", Boredom: "..charBodyDmg:getBoredomLevel()..", Unhappiness: "..charBodyDmg:getUnhappynessLevel()..", Calories:"..charNutrition:getCalories());
    end

    if foodBaseHunger ~= 0
    then
        charStats:setHunger(charStats:getHunger() - ((foodBaseHunger * modifier ) * percentEaten));
    end
    if foodThirstChange ~= 0
    then
        charStats:setThirst(charStats:getThirst() - ((foodThirstChange * modifier) * percentEaten));
    end
    if foodBoredomChange ~= 0
    then
        charBodyDmg:setBoredomLevel(charBodyDmg:getBoredomLevel() - ((foodBoredomChange * modifier ) * percentEaten));
    end
    if foodUnhappyChange ~= 0
    then
        charBodyDmg:setUnhappynessLevel(charBodyDmg:getUnhappynessLevel() - ((foodUnhappyChange * modifier ) * percentEaten));
    end
    if foodCalories ~= 0
    then
        charNutrition:setCalories(charNutrition:getCalories() + ((foodCalories * modifier ) * percentEaten));
    end

    if getDebug()
    then
        print("After Mod| Hunger: "..charStats:getHunger()..", Thirst: "..charStats:getThirst()..", Boredom: "..charBodyDmg:getBoredomLevel()..", Unhappiness: "..charBodyDmg:getUnhappynessLevel()..", Calories:"..charNutrition:getCalories());
    end
end


local function ExclaimerCheck(player)
    local moodles = player:getMoodles();
    local panicLevel = moodles:getMoodleLevel(MoodleType.Panic);
    local playerSquare = player:getCurrentSquare()
    local thresholdMultiplier = SandboxVars.AnthroTraits.ExclaimerExclaimThresholdMultiplier;

    local exclaimChance = ZombRand(1,100);
    local phraseChance = ZombRand(1, #AnthroTraitsGlobals.ExclaimPhrases)

    if (exclaimChance <= (panicLevel * thresholdMultiplier)) and panicLevel > 1
    then
        --if player:HasTrait("AT_Hooves")
        --then
        --    player:SayShout("BLEAT!")
        --else
        --    player:SayShout("HAHAHAHA!")
        --end
        player:SayShout(AnthroTraitsGlobals.ExclaimPhrases[phraseChance])
        getWorldSoundManager():addSound(player,
                playerSquare:getX(),
                playerSquare:getY(),
                playerSquare:getZ(),
                20,
                100);
    end
end


local function BeStinky(player)
    local stinkyLoudness = SandboxVars.AnthroTraits.StinkyLoudness
    local stinkyDistance = SandboxVars.AnthroTraits.StinkyDistance
    local stinkyCommentChance = SandboxVars.AnthroTraits.StinkyCommentChance
    local playerSquare = player:getCurrentSquare()
    local activePlayers = getNumActivePlayers()
    local playerInQuestion = player;

    getWorldSoundManager():addSound(player,
            playerSquare:getX(),
            playerSquare:getY(),
            playerSquare:getZ(),
            stinkyDistance,
            stinkyLoudness);
    if activePlayers > 1
    then
        for playerIndex = 0, activePlayers -1
        do
            playerInQuestion = getSpecificPlayer(playerIndex)
            if player == not playerInQuestion
            then
                if ZombRand(0,1) >= stinkyCommentChance and playerInQuestion:DistTo() < stinkyLoudness and playerInQuestion:getMoodles():getMoodleLevel("Pain") < 2 and playerInQuestion:getMoodles():getMoodleLevel("Panic") < 1
                then
                    playerInQuestion:Say("Stinky!")
                end
            end
        end
    end
end

local function LonelyUpdate(player)
    local lonelyDistance = SandboxVars.AnthroTraits.StinkyDistance
    local modData = player:getModData().ATPlayerData
    local activePlayers = getNumActivePlayers()
    local playerInQuestion = player;

    if activePlayers > 1
    then
        for playerIndex = 0, (activePlayers - 1)
        do
            playerInQuestion = getSpecificPlayer(playerIndex)
            if player == not playerInQuestion and playerInQuestion:DistTo() < lonelyDistance
            then
                modData.HoursSinceSeenOthers = 0;
            end
        end
    end
end

--VANILLA LUA FUNCTION HOOKS

local OriginalEatPerform = ISEatFoodAction.perform;
ISEatFoodAction.perform = function(self)
    -- code to run before the original

    local PC = self.character
    --local charStats = PC:getStats();
    local charBodyDmg = PC:getBodyDamage();
    --local charNutrition = PC:getNutrition();

    local rightFoodBonus = SandboxVars.AnthroTraits.RightFoodBonus;
    local wrongFoodMalus = SandboxVars.AnthroTraits.WrongFoodMalus;
    local carrionEaterBonus = SandboxVars.AnthroTraits.CarrionEaterBonus;
    local foodMotivatedBonus = SandboxVars.AnthroTraits.FoodMotivatedBonus;
    local maxPoisonAmt = SandboxVars.AnthroTraits.FeralDigestionPoisonAmt

    local beforeUnhappiness = charBodyDmg:getUnhappynessLevel();
    local beforeFoodSickness = charBodyDmg:getFoodSicknessLevel();
    local beforePoisonLevel = charBodyDmg:getPoisonLevel();


    local foodEaten = self.item
    local foodPercentEaten = self.percentage
    local foodDisplayName = foodEaten:getDisplayName();

    OriginalEatPerform(self)
    -- code to run after the original

    if PC:HasTrait("AT_Carnivore")
    then
        if foodEaten:hasTag("ATHerbivore")
        then
            ApplyFoodTypeMod(wrongFoodMalus, PC, foodEaten, foodPercentEaten);
        elseif PC:HasTrait("AT_CarrionEater") and foodEaten:isRotten() and foodEaten:hasTag("ATCarnivore")
        then
            ApplyFoodTypeMod((rightFoodBonus + carrionEaterBonus), PC, foodEaten, foodPercentEaten);
            NeutralizeFoodPoisoning(charBodyDmg, beforeFoodSickness, beforePoisonLevel);
        elseif foodEaten:hasTag("ATCarnivore")
        then
            ApplyFoodTypeMod(rightFoodBonus, PC, foodEaten, foodPercentEaten);
            if not foodEaten:isRotten() and foodEaten:getPoisonPower() == 0
            then
                NeutralizeFoodPoisoning(charBodyDmg, beforeFoodSickness, beforePoisonLevel);
            end
        end

    elseif PC:HasTrait("AT_Herbivore") then
        if foodEaten:hasTag("ATHerbivore")
        then
            ApplyFoodTypeMod(rightFoodBonus, PC, foodEaten, foodPercentEaten);
            if not foodEaten:isRotten() and foodEaten:getPoisonPower() == 0
            then
                NeutralizeFoodPoisoning(charBodyDmg, beforeFoodSickness, beforePoisonLevel);
            end
        elseif foodEaten:hasTag("ATCarnivore")
        then
            ApplyFoodTypeMod(wrongFoodMalus, PC, foodEaten, foodPercentEaten);
        end
        --Necessary if a PC has carrion eater but not carnivore.
    elseif PC:HasTrait("AT_CarrionEater")
    then
        if foodEaten:hasTag("ATCarnivore")
        then
            ApplyFoodTypeMod(carrionEaterBonus, PC, foodEaten, foodPercentEaten);
            NeutralizeFoodPoisoning(charBodyDmg, beforeFoodSickness, beforePoisonLevel)

        end
    end

    if PC:HasTrait("AT_FoodMotivated")
    then
        charBodyDmg:setBoredomLevel(charBodyDmg:getBoredomLevel() - (foodMotivatedBonus * foodPercentEaten));
        if(foodDisplayName == "Opened Dog Food")
        then
            --50 is unhappiness gain from dog food.
            charBodyDmg:setUnhappynessLevel(charBodyDmg:getUnhappynessLevel() - ((50 + foodMotivatedBonus) * foodPercentEaten));
        else
            charBodyDmg:setUnhappynessLevel(charBodyDmg:getUnhappynessLevel() - (foodMotivatedBonus * foodPercentEaten));
        end

    end
    if PC:HasTrait("AT_FeralDigestion") and foodEaten:hasTag("ATFeralPoison")
    then
        charBodyDmg:setPoisonLevel(charBodyDmg:getPoisonLevel() + ((maxPoisonAmt) * foodPercentEaten))
    end
    if PC:HasTrait("AT_Bug-o-ssieur") and foodEaten:hasTag("ATInsect")
    then
        charBodyDmg:setUnhappynessLevel(beforeUnhappiness);
    end

end


local OriginalTimedActionCreate = ISBaseTimedAction.create;
ISBaseTimedAction.create = function(self)
    OriginalTimedActionCreate(self);
    if self.character:HasTrait("AT_UnwieldyHands")
    then
        for _, action in pairs(AnthroTraitsGlobals.UnwieldyHandsAffectedTimedActions)
        do
            if self.Type == action
            then
                local newTime = self.maxTime * (1 + SandboxVars.AnthroTraits.UnwieldyHandsTimeIncrease)
                if getDebug()
                then
                    print("UnwieldyHands activated. Old time: "..tostring(self.maxTime).." New time: "..tostring(newTime));
                end
                self.maxTime = newTime;
                break;
            end
        end
    end
end

--poison gui update?
--[[local originalRefreshContainer = ISInventoryPane.refreshContainer;
ISInventoryPane.refreshContainer = function(self)
    --before original
    originalRefreshContainer(self);
    --after original

    local it = self.inventory:getItems();
    for i = 0, it:size()-1 do
        local item = it:get(i);
        local itemName = item:getName();
        if item:IsFood() and item:getHerbalistType() and item:getHerbalistType() ~= "" then
            if playerObj:isRecipeKnown("Herbalist") then
                if item:getHerbalistType() == "Berry" then
                    itemName = (item:getPoisonPower() > 0) and getText("IGUI_PoisonousBerry") or getText("IGUI_Berry")
                end
                if item:getHerbalistType() == "Mushroom" then
                    itemName = (item:getPoisonPower() > 0) and getText("IGUI_PoisonousMushroom") or getText("IGUI_Mushroom")
                end
            else
                if item:getHerbalistType() == "Berry"  then
                    itemName = getText("IGUI_UnknownBerry")
                end
                if item:getHerbalistType() == "Mushroom" then
                    itemName = getText("IGUI_UnknownMushroom")
                end
            end
            if itemName ~= item:getDisplayName() then
                item:setName(itemName);
            end
            itemName = item:getName()
        end
    end
end]]


--Accessing trait gui for tags, maybe?
--[[local OriginalStatsScreenPopulateTraits = ISPlayerStatsChooseTraitUI.create
ISPlayerStatsChooseTraitUI.create = function(self)
    OriginalStatsScreenPopulateTraits(self);

    for i=0,TraitFactory.getTraits():size()-1
    do
        local trait = TraitFactory.getTraits():get(i);
        if not self.chr:getTraits():contains(trait:getType())
        then
            if trait:getCost() >= 0
            then
                table.Remove(self.goodTraits, trait)
            else
                table.Remove(self.badTraits, trait)
            end
        end
    end
end]]


--EVENT HANDLERS

local function ATInitPlayerData(player)

    local modData = player:getModData();

    if modData.ATPlayerData == nil then
        modData.ATPlayerData = {};
        local atData = modData.ATPlayerData;

        atData.trulyInfected = false;
        atData.canTripChecked = false;
        atData.tripSafe = false;
        atData.torporActive = false;
        atData.UnmoddedMaxWeightBase =  player:getMaxWeightBase();
        atData.HoursSinceSeenOthers = 0;
        atData.oldFallTime = 0.0;
        atData.oldWetness = 0.0;
    end
end


function ATOnInitWorld()
    AddItemTagToItemsFromFile("ATCarnivoreItemTag.txt", "ATCarnivore")
    AddItemTagToItemsFromFile("ATHerbivoreItemTag.txt", "ATHerbivore")
    AddItemTagToItemsFromFile("ATInsectItemTag.txt", "ATInsect")
    AddItemTagToItemsFromFile("ATFeralPoisonItemTag.txt", "ATFeralPoison")
end


local function ATPlayerDamageTick(player)
    if player:isZombie()
    then
        return
    end

    local playerData = player:getModData().ATPlayerData;

    if player:getBodyDamage():isInfected() == true and playerData.trulyInfected == false
    then
        if getDebug()
        then
            print("Handle Infection about to be triggered");
        end
        playerData.trulyInfected = HandleInfection(player);
    end

    if player:HasTrait("AT_Hooves")
    then
        --immune to scratches, lacerations, bites
        local footL = player:getBodyDamage():getBodyPart(BodyPartType.Foot_L);
        local footR = player:getBodyDamage():getBodyPart(BodyPartType.Foot_R);

        if footL:scratched()
        then
            --casing is inconsistent in the game >:C
            footL:setScratchTime(0);
            footL:SetScratchedWeapon(false);
            footL:setBleedingTime(0);
            footL:setBleeding(false);
        end
        if footR:scratched()
        then
            footR:setScratchTime(0);
            footR:SetScratchedWeapon(false);
            footR:setBleedingTime(0);
            footR:setBleeding(false);
        end
        if footL:isCut()
        then
            footL:setCutTime(0);
            footL:setCut(false, false);
            footL:setBleedingTime(0);
            footL:setBleeding(false);
        end
        if footR:isCut()
        then
            footR:setCutTime(0);
            footR:setCut(false, false);
            footR:setBleedingTime(0);
            footR:setBleeding(false);

        end
        if footL:bitten()
        then
            --casing is inconsistent in the game >:C
            footL:setBiteTime(0);
            footL:SetBitten(false, false);
            footL:setBleedingTime(0);
            footL:setBleeding(false);
        end
        if footR:bitten()
        then
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


local function ATOnCharacterCollide(collider, collidee)
    if instanceof(collider, "IsoPlayer")
    then
        -- take the sandbox cost, modify it by the difference between the player's current strength/fitness and the average strength/fitness of 5. Then turn that into a decimal since endurance is a decimal. Pick .01 if the cost is lower.
        -- if you ever figure out math, make it do a percentage taken away instead of a flat number
        local knockdownEndCost = math.max(SandboxVars.AnthroTraits.BullRushKnockdownEndCost - (((collider:getPerkLevel(Perks.Fitness) + collider:getPerkLevel(Perks.Strength)) - 10) / 100), .01)
        local colliderBehindCollidee = collidee:isFacingObject(collider, 0.5);
        local modData = collider:getModData().ATPlayerData;
        if getDebug()
        then
            print("ATOnCharacterCollide Triggered");
        end
        if not collidee:isKnockedDown() and collider:HasTrait("AT_BullRush") and collider:isSprinting() and collider:getBeenSprintingFor() >= 10
        then
            if getDebug()
            then
                print("collidee: "..tostring(collidee));
                print("colliderBehindCollidee: "..tostring(colliderBehindCollidee));
                print("Is Sprinting: "..tostring(collider:isSprinting()));
                print("getBeenSprintingFor(): "..tostring(collider:getBeenSprintingFor()));
                print("Tripping: "..tostring(collider:getStats():isTripping()))
            end
            if instanceof(collidee, "IsoZombie")
            then
                collidee:setStaggerBack(true);
                collidee:knockDown(colliderBehindCollidee);
                collider:getStats():setEndurance(collider:getStats():getEndurance() - knockdownEndCost);
                collider:setBumpType("");
                collider:setBumpStaggered(false);
                collider:setBumpFall(false);
            elseif instanceof(collidee, "IsoPlayer") and ((collider:getCoopPVP() == true and collidee:getCoopPVP() == true) or collidee.isZombie())
            then
                collidee:setBumpStaggered(true)
                collidee:setKnockedDown(true);
                collider:getStats():setEndurance(collider:getStats():getEndurance() - knockdownEndCost)
                collider:setBumpType("");
                collider:setBumpStaggered(false);
                collider:setBumpFall(false);
            end
        elseif collidee:isKnockedDown() and collider:HasTrait("AT_BullRush") and collider:isSprinting() and collider:getBeenSprintingFor() >= 10
        then
            if instanceof(collidee, "IsoZombie")
            then
                collidee:setStaggerBack(true);
                collidee:knockDown(colliderBehindCollidee);
                collider:setBumpType("");
                collider:setBumpStaggered(false);
                collider:setBumpFall(false);
            elseif instanceof(collidee, "IsoPlayer") and ((collider:getCoopPVP() == true and collidee:getCoopPVP() == true) or collidee.isZombie())
            then
                collidee:setBumpStaggered(true)
                collidee:setKnockedDown(true);
                collider:setBumpType("");
                collider:setBumpStaggered(false);
                collider:setBumpFall(false);
            end
        elseif collider:HasTrait("AT_Tail") and modData.canTripChecked == false and (collider:getStats():isTripping() or collider:isBumped())
        then
            local a = collider:getStats():isTripping()
            local b = collider:isBumped()
            local a2 = modData.canTripChecked

            local rolledChance = ZombRand(0,100);

            if rolledChance <= SandboxVars.AnthroTraits.TailTripReduction
            then
                modData.canTripChecked = true;
                modData.tripSafe = true;
                collider:getStats():setTripping(false);
                collider:setBumpFall(false);
                if getDebug()
                then
                    print("Player bump/trip prevented by Tail trait. Rolled Chance:"..rolledChance);
                end
            else
                modData.canTripChecked = true;
                modData.tripSafe = false;
            end
        end
        if collider:HasTrait("AT_Tail") and modData.canTripChecked == true and modData.tripSafe == true
        then
            collider:getStats():setTripping(false);
            collider:setBumpFall(false);
            if getDebug()
            then
                print("Player bump/trip prevented by Tail trait during minute grace period.");
            end
        end
    end
end

local function ATOnObjectCollide(collider, collidee)
    if instanceof(collider, "IsoPlayer")
    then
        print("Object: "..type(object));
        print("collider: "..type(collider));
        local modData = collider:getModData().ATPlayerData;
        if getDebug()
        then
            print("ATOnObjectCollide Triggered");
        end
        if collider:HasTrait("AT_Tail") and modData.canTripChecked == false and (collider:getStats():isTripping() or collider:isBumped())
        then
            local rolledChance = ZombRand(0,100);

            if rolledChance <= SandboxVars.AnthroTraits.TailTripReduction
            then
                collider:getStats():setTripping(false);
                collider:setBumpFall(false);
                if getDebug()
                then
                    print("Player bump/trip prevented by Tail trait. Rolled Chance:"..rolledChance);
                end
            else
                modData.canTripChecked = true;
                modData.tripSafe = false;
            end
        end
        if collider:HasTrait("AT_Tail") and modData.canTripChecked == true and modData.tripSafe == true
        then
            collider:getStats():setTripping(false);
            collider:setBumpFall(false);
            if getDebug()
            then
                print("Player bump/trip prevented by Tail trait during minute grace period.");
            end
        end
    end
end


local function ATOnClothingUpdated(gameChar)
    if instanceof(gameChar, "IsoPlayer")
    then
        local player = gameChar
        local shoes = player:getClothingItem_Feet();

        if shoes ~= nil then
            local vanillaShoes = InventoryItemFactory.CreateItem(shoes:getFullType())
            local vanillaStomp = vanillaShoes:getStompPower();
            local digitigradeMultiplier = 1 + SandboxVars.AnthroTraits.DigitigradeStompPowerPctIncrease;
            if player:HasTrait("AT_Digitigrade")
            then
                shoes:setStompPower(vanillaStomp * digitigradeMultiplier);
            else
                shoes:setStompPower(vanillaStomp)
            end
        else
            if player:HasTrait("AT_Digitigrade")
            then
                --???? do something I guess
                --shoes:setStompPower(vanillaShoe:getStompPower() * (1 + SandboxVars.AnthroTraits.DigitigradeStompPowerPctIncrease));
            else
                --shoes:setStompPower(vanillaShoe:getStompPower())
            end
        end
    end
end


local function ATEveryOneMinute()
    local activePlayers = getNumActivePlayers()
    if activePlayers >= 1
    then
        for playerIndex = 0, (activePlayers - 1)
        do
            local player = getSpecificPlayer(playerIndex)
            local modData =  player:getModData().ATPlayerData;
            if player and not player:isDead()
            then
                --add random test functions here:

                --
                if player:HasTrait("AT_Immunity") and not player:getBodyDamage():isInfected() and modData.trulyInfected == true
                then
                    --if a player is a cheater/debugging or takes a game-made cure
                    modData.trulyInfected = false;
                end

                if player:HasTrait("AT_Exclaimer")
                then
                    ExclaimerCheck(player);
                end
                if player:HasTrait("AT_Stinky")
                then
                    BeStinky(player);
                end
                modData.canTripChecked = false;
                modData.tripSafe = false;
            end
        end
    end
end


local function ATEveryHours()
    local activePlayers = getNumActivePlayers()
    if activePlayers >= 1
    then
        --for playerIndex = 0, (activePlayers - 1)
        --do
            local player = getSpecificPlayer(0)
            local modData =  player:getModData().ATPlayerData;
            if player:HasTrait("AT_Lonely")
            then
                modData.HoursSinceSeenOthers = modData.HoursSinceSeenOthers + 1;
                if modData.HoursSinceSeenOthers > SandboxVars.AnthroTraits.LonelyHoursToAffect
                then
                    player:getBodyDamage():setUnhappynessLevel(player:getBodyDamage():getUnhappynessLevel() + SandboxVars.AnthroTraits.LonelyHourlyUnhappyIncrease)
                end
            end
        --end
    end
end


local function ATEveryDays()
    local activePlayers = getNumActivePlayers()
    local season = getClimateManager():getSeason():getSeasonName();

    if activePlayers >= 1
    then
        for playerIndex = 0, (activePlayers - 1)
        do
            local player = getSpecificPlayer(playerIndex)
            local modData =  player:getModData().ATPlayerData;
            if player:HasTrait("AT_Torpor") and season:lower():contains("winter")
            then
                modData.torporActive = true;
            elseif player:HasTrait("AT_Torpor") and not season:contains("winter")
            then
                modData.torporActive = false;
            end
        end
    end
end


local function ATLevelPerk(char, perk, level, increased)
    if instanceof(char, "IsoPlayer")
    then
        local player = char;
        local modData = player:getModData().ATData;
        if perk == "Strength" and increased == true
        then
            --for beast of burden, mostly. But I should keep this accurate just in case.
            modData.UnmoddedMaxWeightBase = modData.UnmoddedMaxWeightBase + 1;
        end
    end
end



local function ATPlayerUpdate(player)
    local fallTimeMult = SandboxVars.AnthroTraits.NaturalTumblerFallTimeMult;
    local modData =  player:getModData().ATPlayerData;
    local beforeFallTime = modData.oldFallTime;
    local endurance = player:getStats():getEndurance()
    --local beforeWetness = modData.oldWetness;
    local rolledChance = ZombRand(0,100);
    -- wetness experiments
    --print("Projec. Difference: "..tostring(GameTime.getMultiplier() * WetnessIncrease));
    --print("Wetness Difference: "..tostring(player:getBodyDamage():getWetness() - modData.oldWetness));
    --
    --print("Temp: "..tostring(player:getBodyDamage():getTemperature()))
    if player:HasTrait("AT_BeastOfBurden")
    then
        player:setMaxWeightBase(math.floor(modData.UnmoddedMaxWeightBase * (1 + SandboxVars.AnthroTraits.BeastOfBurdenPctIncrease)));
    else
        player:setMaxWeightBase(math.floor(modData.UnmoddedMaxWeightBase));
    end
    if player:HasTrait("AT_Torpor") and modData.torporActive == true
    then
        if endurance > (1.0 - SandboxVars.AnthroTraits.TorporEnduranceDecrease)
        then
            player:getStats():setEndurance(1.0 - SandboxVars.AnthroTraits.TorporEnduranceDecrease)
        end
    end
    if player:HasTrait("AT_NaturalTumbler")
    then
        --Fall damage reduced
        if(beforeFallTime < player:getFallTime())
        then
            player:setFallTime(beforeFallTime + ((player:getFallTime() - beforeFallTime) * fallTimeMult));
        end
        if getDebug() and player:getFallTime() > 0
        then
            print("FallTime (Natural Tumbler): "..player:getFallTime())
        end
        beforeFallTime = player:getFallTime();
    elseif player:HasTrait("AT_VestigialWings")
    then
        --immune to fall damage
        if(beforeFallTime < player:getFallTime())
        then
            player:setFallTime(10);
        end
        if getDebug() and player:getFallTime() > 0
        then
            print("FallTime (Vestigial Wings): "..player:getFallTime())
        end
        beforeFallTime = player:getFallTime();
    else
        if getDebug() and player:getFallTime() > 0
        then
            print("FallTime: "..player:getFallTime())
        end
    end
    LonelyUpdate(player);
    --[[if player:HasTrait("AT_ColdBlooded")
    then
        player:getBodyDamage():getThermoregulator():setMetabolicTarget(Metabolics.Sleeping);
    end]]

    --update oldWetness
    --modData.oldWetness = player:getBodyDamage():getWetness();
end


Events.OnNewGame.Add(ATInitPlayerData);
Events.OnInitWorld.Add(ATOnInitWorld);
Events.OnClothingUpdated.Add(ATOnClothingUpdated);
Events.OnObjectCollide.Add(ATOnObjectCollide);
Events.OnCharacterCollide.Add(ATOnCharacterCollide);
Events.LevelPerk.Add(ATLevelPerk)
Events.EveryDays.Add(ATEveryDays);
Events.EveryHours.Add(ATEveryHours)
Events.EveryOneMinute.Add(ATEveryOneMinute);
Events.OnPlayerGetDamage.Add(ATPlayerDamageTick);
Events.OnPlayerUpdate.Add(ATPlayerUpdate);