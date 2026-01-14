local AnthroTraitsServerMain = {};

--local ATUs = require("AnthroTraitsServerUtilities");

local function IsAnthro(gameCharacter)
    if (getActivatedMods():contains("\\FurryMod") or getActivatedMods():contains("\\FurryApocalypse")) and gameCharacter ~= nil
    then
        local hasFur = false;
        local itemVisuals = gameCharacter:getItemVisuals();
        if itemVisuals ~= nil
        then
            for i=0, itemVisuals:size() - 1
            do
                local itemVisual = itemVisuals:get(i);
                local item =  itemVisual:getScriptItem();
                if item ~= nil and (item:hasTag(ItemTag.get(ResourceLocation.of("FurryMod:Fur"))) or item:hasTag(ItemTag.get(ResourceLocation.of("FurryMod:DeceasedFur"))))
                then
                    hasFur = true;
                    break;
                end
            end;
        end 
        return hasFur;
    else
        return false;
    end
	
	return false
end

AnthroTraitsServerMain.HandleInfection = function(player)
    local ATM = AnthroTraitsServerMain;
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
        local bodyPart = player:getBodyDamage():getBodyParts():get(i);
        if bodyPart:HasInjury() == true and bodyPart:IsInfected() 
        then
            if getDebug()
            then
                print( tostring(bodyPart:getType()) .. " is injured and infected.");
            end
            if player:hasTrait(ATGt.UNGULIGRADE)
            then
                if tostring(bodyPart:getType()) == "Foot_L" or tostring(bodyPart:getType()) == "Foot_R"
                then
                    if getDebug()
                    then
                        print("AT_Unguligrade foot immunity triggered.");
                    end
                    ATM.CureKnoxInfection(player, bodyPart:getType());
                end
            end
            if player:hasTrait(ATGt.ANTHROIMMUNITY) 
            then
                local rolledInfectionChance = ZombRand(1, 100);
                local lastAttackedBy = player:getAttackedBy();
				local attackerIsAnthro = IsAnthro(lastAttackedBy)
				local anthroIgnoreImmunity = SandboxVars.AnthroTraits.AT_AnthroImmunityIgnoredByAnthroZombies
                if not anthroIgnoreImmunity or not attackerIsAnthro
                then
                    if getDebug()
                    then
                        print("Rolled " .. rolledInfectionChance);
                    end
                    if bodyPart:bitten() 
                    then
                        if biteInfectionChance <= rolledInfectionChance 
                        then
                            ATM.CureKnoxInfection(player, bodyPart:getType());
                            if getDebug()
                            then
                                print("Infection defense successful.");
                            end
                            if SandboxVars.AnthroTraits.AT_AnthroImmunityBiteGetsRegularInfectionOnDefense
                            then
                                ATM.InfectWound(bodyPart:getType())
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
                    elseif bodyPart:isCut() --irritatingly, using the function to get laceration doesn't follow the same naming convention
                    then
                        if lacerationInfectionChance <= rolledInfectionChance 
                        then
                            ATM.CureKnoxInfection(player, bodyPart:getType());
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
                    elseif bodyPart:scratched() 
                    then
                        if scratchInfectionChance <= rolledInfectionChance 
                        then
                            ATM.CureKnoxInfection(player, bodyPart:getType());
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

AnthroTraitsServerMain.UndamageUnbleedBodyPart = function(bodyPart, damage)
	bodyPart:setBleedingTime(0);
	bodyPart:setBleeding(false);
	bodyPart:AddHealth(damage)
end

---@param player IsoPlayer
---@param bodyPartType BodyPartType
AnthroTraitsServerMain.CureKnoxInfection = function(player, bodyPartType)
    if not isClient()
    then
        local bodyDmg = player:getBodyDamage();

        bodyDmg:getBodyPart(bodyPartType):SetInfected(false);

        bodyDmg:setInfected(false);
        bodyDmg:setInfectionMortalityDuration(-1);
        bodyDmg:setInfectionTime(-1);
        bodyDmg:setInfectionGrowthRate(0);
    else
        sendClientCommand("AnthroTraits", "CureKnoxInfection", {playerOnlineID = player:getOnlineID(), bodyPartType = bodyPartType})
    end

    DebugLog.log("Knox Infection removed from "..player:getDisplayName())
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
			ATM.UndamageUnbleedBodyPart(footL, damage);
        end
        if footR:scratched()
        then
			footR:setScratched(false, true);
            footR:setScratchTime(0);
            footR:SetScratchedWeapon(false);
			ATM.UndamageUnbleedBodyPart(footR, damage);
        end
        if footL:isCut()
        then
            footL:setCutTime(0);
            footL:setCut(false, false);
			ATM.UndamageUnbleedBodyPart(footL, damage);
        end
        if footR:isCut()
        then
            footR:setCutTime(0);
            footR:setCut(false, false);
			ATM.UndamageUnbleedBodyPart(footR, damage);

        end
        if footL:bitten()
        then
            --casing is inconsistent in the game >:C
            footL:setBiteTime(0);
            footL:SetBitten(false, false);
			ATM.UndamageUnbleedBodyPart(footL, damage);
        end
        if footR:bitten()
        then
            footR:setBiteTime(0);
            footR:SetBitten(false, false);
			ATM.UndamageUnbleedBodyPart(footR, damage);

        end
    elseif player:hasTrait(ATGt.DIGITIGRADE)
    then
        --immune to scratches
        local footL = player:getBodyDamage():getBodyPart(BodyPartType.Foot_L);
        local footR = player:getBodyDamage():getBodyPart(BodyPartType.Foot_R);

        if footL:scratched()
        then
            --casing is inconsistent in the game >:C
			footL:setScratched(false, true);
            footL:setScratchTime(0);
            footL:SetScratchedWeapon(false);
			ATM.UndamageUnbleedBodyPart(footL, damage);
        end
        if footR:scratched()
        then
			footL:setScratched(false, true);
            footR:setScratchTime(0);
            footR:SetScratchedWeapon(false);
			ATM.UndamageUnbleedBodyPart(footR, damage);
        end
    end
end

---Sends commands to the server from the originating client.
---@param module string
---@param command string
---@param args table
AnthroTraitsServerMain.ATOnClientCommand = function(module, command, args)
    if module == "AnthroTraits"
    then
        if command == "KnockdownZombie"
        then
            args.collidee:setBumpType("stagger");
            args.collidee:setVariable("BumpDone", true);
            args.collidee:setVariable("BumpFall", true);
            args.collidee:setVariable("BumpFallType", "pushedbehind");
        elseif command == "CureKnoxInfection"
        then
            local player = getPlayerByOnlineID(args.playerOnlineID);
            local bodyDmg = player:getBodyDamage();

            bodyDmg:getBodyPart(args.bodyPartType):SetInfected(false);

            bodyDmg:setInfected(false);
            bodyDmg:setInfectionMortalityDuration(-1);
            bodyDmg:setInfectionTime(-1);
            bodyDmg:setInfectionGrowthRate(0);
        elseif command == "InfectWound"
        then
            local player = getPlayerByOnlineID(args.playerOnlineID);
            local bodyPart = player:getBodyDamage():getBodyPart(args.bodyPartType);


            bodyPart:setWoundInfectionLevel(1);
        end
    end
end


Events.OnClientCommand.Add(AnthroTraitsServerMain.ATOnClientCommand);
Events.OnPlayerGetDamage.Add(AnthroTraitsServerMain.ATPlayerDamageTick);

return AnthroTraitsServerMain;