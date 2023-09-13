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
-- REFERENCES: More Simple Traits (hea), More Traits (HypnoToadTrance), Others?
-- Did this code help you write your own mod? Consider donating to me at https://ko-fi.com/badonnthedeer!
-- I'm in financial need and every little bit helps!!
--
-- Have a problem or question? Reach me on Discord: badonn
------------------------------------------------------------------------------------------------------

local AnthroTraitsMain = {};
local ATU = require("AnthroTraitsUtilities");

-- C:\Program Files (x86)\Steam\steamapps\common\ProjectZomboid\media\lua | Project Zomboid files
-- C:\Program Files (x86)\Steam\steamapps\common\ProjectZomboid\media\AnimSets\player
-- C:\Program Files (x86)\Steam\steamapps\workshop\content\108600\

-- C:\Users\[user]\Zomboid\mods
-- C:\Users\[user]\Zomboid\Logs


AnthroTraitsMain.ExclaimPhrases = {
    generic = {"AAAH!", "AAAH!", "AAAH!!", "AEIEEEE!", "EAAH!", "AAAGH!"},
    yeen = {"HAHAHAHAHA!", "HAHAHAHAHA!", "HAHAHAHAHA!!", "HUHEHEHEHAHA!", "HAAAAH!", "HEEEHEEEHAHAHAHA!"},
    bleater = {"BLEAT!", "BLEAT!", "BLEAT!!", "BLEAAAAT!", "BLEE-EAT!", "EEEEP!"}
}


AnthroTraitsMain.HandleInfection = function(player)
    local biteInfectionChance = SandboxVars.AnthroTraits.AT_ImmunityBiteInfectionChance;
    local lacerationInfectionChance = SandboxVars.AnthroTraits.AT_ImmunityLacerationInfectionChance;
    local scratchInfectionChance = SandboxVars.AnthroTraits.AT_ImmunityScratchInfectionChance;
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
                    print("Rolled " .. rolledInfectionChance);
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
                        if SandboxVars.AnthroTraits.AT_ImmunityBiteGetsRegularInfectionOnDefense
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


AnthroTraitsMain.NeutralizeFoodPoisoning = function(charBodyDmg, beforeFoodSickness, beforePoisonLevel)
    if getDebug()
    then
        print("Food Poisoning neutralized.");
    end
    charBodyDmg:setFoodSicknessLevel(beforeFoodSickness);
    charBodyDmg:setPoisonLevel(beforePoisonLevel);
end


AnthroTraitsMain.ApplyFoodChanges = function(character, foodEaten, percentEaten)
    local foodChanges = ATU.CalculateFoodChanges(character, foodEaten)
    local charStats = character:getStats()
    local charBodyDmg = character:getBodyDamage()
    local charNutrition = character:getNutrition()

    local beforeFoodSickness = charBodyDmg:getFoodSicknessLevel();
    local beforePoisonLevel = charBodyDmg:getPoisonLevel();

    if foodChanges.addHungerChange ~= 0
    then
        charStats:setHunger(charStats:getHunger() + (foodChanges.addHungerChange * percentEaten) );
    end
    if foodChanges.addThirstChange ~= 0
    then
        charStats:setThirst(charStats:getThirst() + (foodChanges.addThirstChange * percentEaten));
    end
    if foodChanges.addEndChange ~= 0
    then
        charStats:setEndurance(charStats:getEndurance() + (foodChanges.addEndChange * percentEaten));
    end
    if foodChanges.addStressChange ~= 0
    then
        charStats:setStress(charStats:getStress() + (foodChanges.addStressChange * percentEaten));
    end
    if foodChanges.addBoredomChange ~= 0
    then
        charBodyDmg:setBoredomLevel(charBodyDmg:getBoredomLevel() + (foodChanges.addBoredomChange * percentEaten));
    end
    if foodChanges.addUnhappyChange ~= 0
    then
        charBodyDmg:setUnhappynessLevel(charBodyDmg:getUnhappynessLevel() + (foodChanges.addUnhappyChange * percentEaten));
    end
    if foodChanges.addCalories ~= 0
    then
        charNutrition:setCalories(charNutrition:getCalories() + (foodChanges.addCalories * percentEaten));
    end
    if foodChanges.addPoison ~= 0
    then
        charBodyDmg:setPoisonLevel(charBodyDmg:getPoisonLevel() + (foodChanges.addPoison * percentEaten))
    end


    if foodEaten:hasTag("ATCarnivore") and foodEaten:getPoisonPower() <= 0
    then
        if (character:HasTrait("AT_Carnivore") or character:HasTrait("AT_CarrionEater")) and not foodEaten:isRotten()
        then
            AnthroTraitsMain.NeutralizeFoodPoisoning(charBodyDmg, beforeFoodSickness, beforePoisonLevel);
        elseif foodEaten:isRotten() and character:HasTrait("AT_CarrionEater")
        then
            AnthroTraitsMain.NeutralizeFoodPoisoning(charBodyDmg, beforeFoodSickness, beforePoisonLevel);
        end
    elseif foodEaten:hasTag("ATHerbivore") and foodEaten:getPoisonPower() <= 0
    then
        if character:HasTrait("AT_Herbivore")
        then
            if not foodEaten:isRotten()
            then
                AnthroTraitsMain.NeutralizeFoodPoisoning(charBodyDmg, beforeFoodSickness, beforePoisonLevel);
            end
        end
    end
end


AnthroTraitsMain.ExclaimerCheck = function(player)
    local moodles = player:getMoodles();
    local panicLevel = moodles:getMoodleLevel(MoodleType.Panic);
    local thresholdMultiplier = SandboxVars.AnthroTraits.AT_ExclaimerExclaimThresholdMultiplier;

    local exclaimChance = ZombRand(1,100);

    if (exclaimChance <= (panicLevel * thresholdMultiplier)) and panicLevel > 1
    then
        local phrases = AnthroTraitsMain.ExclaimPhrases.generic
        local phraseChance = ZombRand(1, #phrases);
        local playerSquare = player:getCurrentSquare();
        --if player:HasTrait("AT_Hooves");
        --then
        --    player:SayShout("BLEAT!");
        --else
        --    player:SayShout("HAHAHAHA!");
        --end
        player:SayShout(phrases[phraseChance]);
        getWorldSoundManager():addSound(player,
                playerSquare:getX(),
                playerSquare:getY(),
                playerSquare:getZ(),
                20,
                100);
    end
end


AnthroTraitsMain.BeStinky = function(player)
    local stinkyLoudness = SandboxVars.AnthroTraits.AT_StinkyLoudness
    local stinkyDistance = SandboxVars.AnthroTraits.AT_StinkyDistance
    local stinkyCommentChance = SandboxVars.AnthroTraits.AT_StinkyCommentChance
    local stinkyThreshold = SandboxVars.AnthroTraits.AT_StinkyThreshold
    local playerSquare = player:getCurrentSquare();
    local activePlayers = getNumActivePlayers();
    local playerInQuestion = player;
    local bloodBodyPartType = BloodBodyPartType.FromIndex(0)
    local totalDirtiness = 0;
    local visual = player:getHumanVisual();

    for i = 0, BloodBodyPartType.MAX:index()-1 do
        bloodBodyPartType = BloodBodyPartType.FromIndex(i)
        totalDirtiness = totalDirtiness + visual:getDirt(bloodBodyPartType);
    end

    if(totalDirtiness >= stinkyThreshold)
    then
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
                        playerInQuestion:Say("Stinky!");
                    end
                end
            end
        end
    end
end

AnthroTraitsMain.LonelyUpdate = function(player)
    local lonelyDistance = SandboxVars.AnthroTraits.AT_StinkyDistance
    local modData = player:getModData().ATPlayerData
    local activePlayers = getNumActivePlayers();
    local playerInQuestion = player;

    if activePlayers > 1
    then
        for playerIndex = 0, (activePlayers - 1)
        do
            playerInQuestion = getSpecificPlayer(playerIndex);
            if player == not playerInQuestion and playerInQuestion:DistTo() < lonelyDistance
            then
                modData.HoursSinceSeenOthers = 0;
            end
        end
    end
end


--EVENT HANDLERS

AnthroTraitsMain.ATInitPlayerData = function(player)

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


AnthroTraitsMain.ATOnInitWorld = function()
    ATU.AddItemTagToItemsFromSandbox(SandboxVars.AnthroTraits.AT_Carnivore_Items, "ATCarnivore");
    ATU.AddItemTagToItemsFromSandbox(SandboxVars.AnthroTraits.AT_Herbivore_Items, "ATHerbivore");
    ATU.AddItemTagToItemsFromSandbox(SandboxVars.AnthroTraits.AT_Bug_o_ssieur_Items, "ATInsect");
    ATU.AddItemTagToItemsFromSandbox(SandboxVars.AnthroTraits.AT_FeralDigestion_Items, "ATFeralPoison");

    Colors["LavenderBlush"] = Color.new(1, 229/255, 229/255, 1);
end


AnthroTraitsMain.ATPlayerDamageTick = function(player)
    local this = AnthroTraitsMain;

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
        playerData.trulyInfected = this.HandleInfection(player);
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
    -- Tough Feet Trait?
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


AnthroTraitsMain.ATOnCharacterCollide = function(collider, collidee)
    if instanceof(collider, "IsoPlayer") and collider:isLocalPlayer()
    then
        -- take the sandbox cost, modify it by the difference between the player's current strength/fitness and the average strength/fitness of 5. Then turn that into a decimal since endurance is a decimal. Pick .01 if the cost is lower.
        -- if you ever figure out math, make it do a percentage taken away instead of a flat number
        local knockdownEndCost = math.max(SandboxVars.AnthroTraits.AT_BullRushKnockdownEndCost - (((collider:getPerkLevel(Perks.Fitness) + collider:getPerkLevel(Perks.Strength)) - 10) / 100), .01)
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
                print("Tripping: "..tostring(collider:getStats():isTripping()));
            end
            if instanceof(collidee, "IsoZombie")
            then
                collidee:setStaggerBack(true);
                collidee:knockDown(colliderBehindCollidee);
                if isServer()
                then
                    collidee:setHitReaction("");
                    collidee:setPlayerAttackPosition("FRONT");
                    collidee:setHitForce(2.0);
                    collidee:reportEvent("wasHit");
                end
                collider:getStats():setEndurance(collider:getStats():getEndurance() - knockdownEndCost);
                collider:setBumpType("");
                collider:setBumpStaggered(false);
                collider:setBumpFall(false);
            elseif instanceof(collidee, "IsoPlayer")
            then
                if SwipeStatePlayer.checkPVP(collider, collidee) or collidee:isZombie()
                then
                    collidee:setBumpType("stagger");
                    collidee:setVariable("BumpDone", true);
                    collidee:setVariable("BumpFall", true);
                    if colliderBehindCollidee
                    then
                        collidee:setVariable("BumpFallType", "pushedbehind");
                    else
                        collidee:setVariable("BumpFallType", "pushedFront")
                    end
                    if isServer()
                    then
                        collidee:setHitReaction("");
                        collidee:setPlayerAttackPosition("FRONT");
                        collidee:setHitForce(2.0);
                        collidee:reportEvent("wasHit");
                    end
                    --collidee:setBumpStaggered(true);
                    --collidee:setKnockedDown(true);
                    collider:getStats():setEndurance(collider:getStats():getEndurance() - knockdownEndCost);
                    collider:setBumpType("");
                    collider:setBumpStaggered(false);
                    collider:setBumpFall(false);
                end
            end
        elseif collidee:isKnockedDown() and collider:HasTrait("AT_BullRush") and collider:isSprinting() and collider:getBeenSprintingFor() >= 10
        then
            if instanceof(collidee, "IsoZombie")
            then
                collidee:setStaggerBack(true);
                collidee:knockDown(colliderBehindCollidee);
                if isServer()
                then
                    collidee:setHitReaction("");
                    collidee:setPlayerAttackPosition("FRONT");
                    collidee:setHitForce(2.0);
                    collidee:reportEvent("wasHit");
                end
                collider:setBumpType("");
                collider:setBumpStaggered(false);
                collider:setBumpFall(false);
            elseif instanceof(collidee, "IsoPlayer")
            then
                if SwipeStatePlayer.checkPVP(collider, collidee) or collidee:isZombie()
                then
                    collidee:setBumpType("stagger");
                    collidee:setVariable("BumpDone", true);
                    collidee:setVariable("BumpFall", true);
                    if colliderBehindCollidee
                    then
                        collidee:setVariable("BumpFallType", "pushedbehind");
                    else
                        collidee:setVariable("BumpFallType", "pushedFront")
                    end
                    if isServer()
                    then
                        collidee:setHitReaction("");
                        collidee:setPlayerAttackPosition("FRONT");
                        collidee:setHitForce(2.0);
                        collidee:reportEvent("wasHit");
                    end
                    --collidee:setBumpStaggered(true);
                    --collidee:setKnockedDown(true);
                    collider:setBumpType("");
                    collider:setBumpStaggered(false);
                    collider:setBumpFall(false);
                end
            end
        elseif collider:HasTrait("AT_Tail") and modData.canTripChecked == false and (collider:getStats():isTripping() or collider:isBumped())
        then
            local a = collider:getStats():isTripping();
            local b = collider:isBumped();
            local a2 = modData.canTripChecked

            local rolledChance = ZombRand(0,100);

            if rolledChance <= SandboxVars.AnthroTraits.AT_TailTripReduction
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


AnthroTraitsMain.ATOnObjectCollide = function(collider, collidee)
    if instanceof(collider, "IsoPlayer") and not collider:isZombie() and collider:isLocalPlayer()
    then
        local modData = collider:getModData().ATPlayerData;
        if getDebug()
        then
            print("ATOnObjectCollide Triggered");
            print("Object: "..type(collidee));
            print("collider: "..type(collider));
        end
        if collider:HasTrait("AT_Tail") and modData.canTripChecked == false and (collider:getStats():isTripping() or collider:isBumped())
        then
            local rolledChance = ZombRand(0,100);

            if rolledChance <= SandboxVars.AnthroTraits.AT_TailTripReduction
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


AnthroTraitsMain.ATOnClothingUpdated = function(character)
    if instanceof(character, "IsoPlayer")
    then
        local wornShoes = character:getClothingItem_Feet();
        local vanillaStomp;
        if wornShoes ~= nil
        then
            vanillaStomp = InventoryItemFactory.CreateItem(wornShoes:getFullType()):getStompPower();
        end
        local digitigradeMultiplier = 1 + SandboxVars.AnthroTraits.AT_DigitigradeStompPowerPctIncrease;

        if character:HasTrait("AT_Digitigrade")
        then
            if wornShoes ~= nil
            then
                wornShoes:setStompPower(vanillaStomp * digitigradeMultiplier);
            else
                if character:HasTrait("AT_Hooves")
                then
                    character:setClothingItem_Feet(InventoryItemFactory.CreateItem("Base.DigitigradeHoofers"))
                else
                    character:setClothingItem_Feet(InventoryItemFactory.CreateItem("Base.DigitigradePaws"))
                end

            end
        else
            if wornShoes ~= nil
            then
                wornShoes:setStompPower(vanillaStomp);
            else
                --do nothing
            end

        end
    end
end


AnthroTraitsMain.ATEveryOneMinute = function()
    local this = AnthroTraitsMain;
    local activePlayers = getNumActivePlayers()
    if activePlayers >= 1
    then
        for playerIndex = 0, (activePlayers - 1)
        do
            local player = getSpecificPlayer(playerIndex);
            if player ~= nil and not player:isDead()
            then
                local modData =  player:getModData().ATPlayerData;
                --add random test functions here:

                --
                if player:HasTrait("AT_Immunity") and not player:getBodyDamage():isInfected() and modData.trulyInfected == true
                then
                    --if a player is a cheater/debugging or takes a game-made cure
                    modData.trulyInfected = false;
                end

                if player:HasTrait("AT_Exclaimer")
                then
                    this.ExclaimerCheck(player);
                end
                if player:HasTrait("AT_Stinky")
                then
                    this.BeStinky(player);
                end
                modData.canTripChecked = false;
                modData.tripSafe = false;
            end
        end
    end
end


AnthroTraitsMain.ATEveryHours = function()
    local activePlayers = getNumActivePlayers();
    if activePlayers >= 1
    then
        --for playerIndex = 0, (activePlayers - 1)
        --do
            local player = getSpecificPlayer(0);
            local modData =  player:getModData().ATPlayerData;
            if player:HasTrait("AT_Lonely")
            then
                modData.HoursSinceSeenOthers = modData.HoursSinceSeenOthers + 1;
                if modData.HoursSinceSeenOthers > SandboxVars.AnthroTraits.AT_LonelyHoursToAffect
                then
                    player:getBodyDamage():setUnhappynessLevel(player:getBodyDamage():getUnhappynessLevel() + SandboxVars.AnthroTraits.AT_LonelyHourlyUnhappyIncrease);
                end
            end
        --end
    end
end


AnthroTraitsMain.ATEveryDays = function()
    local activePlayers = getNumActivePlayers();
    local season = getClimateManager():getSeason():getSeasonName();

    if activePlayers >= 1
    then
        for playerIndex = 0, (activePlayers - 1)
        do
            local player = getSpecificPlayer(playerIndex);
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


AnthroTraitsMain.ATLevelPerk = function(char, perk, level, increased)
    if instanceof(char, "IsoPlayer")
    then
        local player = char;
        local modData = player:getModData().ATPlayerData;
        if perk == "Strength" and increased == true
        then
            --for beast of burden, mostly. But I should keep this accurate just in case.
            modData.UnmoddedMaxWeightBase = modData.UnmoddedMaxWeightBase + 1;
            --does this up automatically? I would be able to subtract umoddedMaxWeightBase + mod to get the difference and
            --set it here
        end
    end
end


AnthroTraitsMain.ATPlayerUpdate = function(player)
    local this = AnthroTraitsMain;
    local fallTimeMult = SandboxVars.AnthroTraits.AT_NaturalTumblerFallTimeMult;
    local modData =  player:getModData().ATPlayerData;
    local beforeFallTime = modData.oldFallTime;
    local endurance = player:getStats():getEndurance();
    local rolledChance = ZombRand(0,100);
    if player:HasTrait("AT_BeastOfBurden")
    then
        player:setMaxWeightBase(math.floor(modData.UnmoddedMaxWeightBase * (1 + SandboxVars.AnthroTraits.AT_BeastOfBurdenPctIncrease)));
    else
        player:setMaxWeightBase(math.floor(modData.UnmoddedMaxWeightBase));
    end
    if player:HasTrait("AT_Torpor") and modData.torporActive == true
    then
        if endurance > (1.0 - SandboxVars.AnthroTraits.AT_TorporEnduranceDecrease)
        then
            player:getStats():setEndurance(1.0 - SandboxVars.AnthroTraits.AT_TorporEnduranceDecrease);
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
    this.LonelyUpdate(player);
end

--[[AnthroTraitsMain.ATOnClientCommand = function(module, command, args)
    if module == "AnthroTraits"
    then
        if command == "knockdownZombie"
        then
            args.collidee:setBumpType("stagger");
            args.collidee:setVariable("BumpDone", true);
            args.collidee:setVariable("BumpFall", true);
            args.collidee:setVariable("BumpFallType", "pushedbehind");
        end
    end
end]]



Events.OnNewGame.Add(AnthroTraitsMain.ATInitPlayerData);
Events.OnInitWorld.Add(AnthroTraitsMain.ATOnInitWorld);
--[[Events.OnClientCommand.Add(AnthroTraitsMain.ATOnClientCommand)
Events.OnServerCommand.Add(AnthroTraitsMain.ATOnServerCommand)]]
Events.OnClothingUpdated.Add(AnthroTraitsMain.ATOnClothingUpdated);
Events.OnObjectCollide.Add(AnthroTraitsMain.ATOnObjectCollide);
Events.OnCharacterCollide.Add(AnthroTraitsMain.ATOnCharacterCollide);
Events.LevelPerk.Add(AnthroTraitsMain.ATLevelPerk);
Events.EveryDays.Add(AnthroTraitsMain.ATEveryDays);
Events.EveryHours.Add(AnthroTraitsMain.ATEveryHours);
Events.EveryOneMinute.Add(AnthroTraitsMain.ATEveryOneMinute);
Events.OnPlayerGetDamage.Add(AnthroTraitsMain.ATPlayerDamageTick);
Events.OnPlayerUpdate.Add(AnthroTraitsMain.ATPlayerUpdate);


return AnthroTraitsMain;