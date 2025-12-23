local AnthroTraitsServerMain = {};

local ATU = require("AnthroTraitsServerUtilities");

AnthroTraitsServerMain.HandleInfection = function(player)
	local ATGt = AnthroTraitsGlobals.CharacterTrait
    local biteInfectionChance = SandboxVars.AnthroTraits.AT_AnthroImmunityBiteInfectionChance;
    local lacerationInfectionChance = SandboxVars.AnthroTraits.AT_AnthroImmunityLacerationInfectionChance;
    local scratchInfectionChance = SandboxVars.AnthroTraits.AT_AnthroImmunityScratchInfectionChance;
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
            if player:hasTrait(ATGt.UNGULIGRADE)
            then
                if tostring(bodypart:getType()) == "Foot_L" or tostring(bodypart:getType()) == "Foot_R"
                then
                    if getDebug()
                    then
                        print("AT_Unguligrade foot immunity triggered.");
                    end
                    bodypart:SetInfected(false);
                    player:getBodyDamage():setInfected(false);
                    player:getBodyDamage():setInfectionMortalityDuration(-1);
                    player:getBodyDamage():setInfectionTime(-1);
                    player:getBodyDamage():setInfectionGrowthRate(0);
                end
            end
            if player:hasTrait(ATGt.ANTHROIMMUNITY) 
            then
                local rolledInfectionChance = ZombRand(1, 100);
                local lastAttackedBy = player:getAttackedBy();
                if (not SandboxVars.AnthroTraits.AT_AnthroImmunityIgnoredByAnthroZombies and not ATU.IsAnthro(lastAttackedBy)
                or not SandboxVars.AnthroTraits.AT_AnthroImmunityIgnoredByAnthroZombies and ATU.IsAnthro(lastAttackedBy)
                or SandboxVars.AnthroTraits.AT_AnthroImmunityIgnoredByAnthroZombies and not ATU.IsAnthro(lastAttackedBy))
                then
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
                            if SandboxVars.AnthroTraits.AT_AnthroImmunityBiteGetsRegularInfectionOnDefense
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
                else
                    if getDebug()
                    then
                        print("Not applying Anthro Immunity to infection from anthro. DIE WELL!")
                    end    
                end    
            end 
        end
    end
end

local function UndamageUnbleedBodyPart(bodyPart, damage)
	bodyPart:setBleedingTime(0);
	bodyPart:setBleeding(false);
	bodyPart:AddHealth(damage)
end

AnthroTraitsServerMain.ATPlayerDamageTick = function(player, damageType, damage)
	local ATGt = AnthroTraitsGlobals.CharacterTrait
    local ATM = AnthroTraitsServerMain;

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
        playerData.trulyInfected = ATM.HandleInfection(player);
    end

    if player:hasTrait(ATGt.UNGULIGRADE)
    then
        --immune to scratches, lacerations, bites
        local footL = player:getBodyDamage():getBodyPart(BodyPartType.Foot_L);
        local footR = player:getBodyDamage():getBodyPart(BodyPartType.Foot_R);

        if footL:scratched()
        then
            --casing is inconsistent in the game >:C
			footL:setScratched(false, true);
            footL:setScratchTime(0);
            footL:SetScratchedWeapon(false);
			UndamageUnbleedBodyPart(footL, damage)
        end
        if footR:scratched()
        then
			footR:setScratched(false, true);
            footR:setScratchTime(0);
            footR:SetScratchedWeapon(false);
			UndamageUnbleedBodyPart(footR, damage)
        end
        if footL:isCut()
        then
            footL:setCutTime(0);
            footL:setCut(false, false);
			UndamageUnbleedBodyPart(footL, damage)
        end
        if footR:isCut()
        then
            footR:setCutTime(0);
            footR:setCut(false, false);
			UndamageUnbleedBodyPart(footR, damage)

        end
        if footL:bitten()
        then
            --casing is inconsistent in the game >:C
            footL:setBiteTime(0);
            footL:SetBitten(false, false);
			UndamageUnbleedBodyPart(footL, damage)
        end
        if footR:bitten()
        then
            footR:setBiteTime(0);
            footR:SetBitten(false, false);
			UndamageUnbleedBodyPart(footR, damage)

        end
    elseif player:hasTrait(ATGt.DIGITIGRADE)
    then
        --immune to scratches, lacerations, bites
        local footL = player:getBodyDamage():getBodyPart(BodyPartType.Foot_L);
        local footR = player:getBodyDamage():getBodyPart(BodyPartType.Foot_R);

        if footL:scratched()
        then
            --casing is inconsistent in the game >:C
			footL:setScratched(false, true);
            footL:setScratchTime(0);
            footL:SetScratchedWeapon(false);
			UndamageUnbleedBodyPart(footL, damage)
        end
        if footR:scratched()
        then
			footL:setScratched(false, true);
            footR:setScratchTime(0);
            footR:SetScratchedWeapon(false);
			UndamageUnbleedBodyPart(footR, damage)
        end
    end
end

Events.OnPlayerGetDamage.Add(AnthroTraitsServerMain.ATPlayerDamageTick);

return AnthroTraitsServerMain;