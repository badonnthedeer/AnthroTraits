local AnthroTraitsServerMain = {};

local ATSU = require("AnthroTraitsServerUtilities");
local ATShU = require "AnthroTraitsSharedUtilities"

local isWinter;

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
				local attackerIsAnthro = IsAnthro(lastAttackedBy)
				local anthroIgnoreImmunity = SandboxVars.AnthroTraits.AT_AnthroImmunityIgnoredByAnthroZombies
                if not anthroIgnoreImmunity or not attackerIsAnthro
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
        --immune to scratches
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

local function playerExclaimerCheck(player)
    local moodles = player:getMoodles();
    local panicLevel = moodles:getMoodleLevel(MoodleType.PANIC)
    local thresholdMultiplier = SandboxVars.AnthroTraits.AT_ExclaimerExclaimThresholdMultiplier;
	local mitigationThreshold = SandboxVars.AnthroTraits.AT_ExclaimerAnthroVoiceMitigation
    local exclaimChance = ZombRand(1,100);

    if panicLevel <= 1 or exclaimChance > (panicLevel * thresholdMultiplier) then
        return;
    end
    local mitigated = false;
    -- check for mitigation
    for trait, _ in pairs(AnthroTraitsGlobals.ExclaimerTraits) do
        if player:hasTrait(trait) then
            mitigated = ZombRand(1, 100) <= mitigationThreshold;
            break;
        end
    end
    if not mitigated then
        local playerSquare = player:getCurrentSquare();
        getWorldSoundManager():addSound(player,
                playerSquare:getX(),
                playerSquare:getY(),
                playerSquare:getZ(),
                20,
                100);
    end
    local playerID = ATShU.getPlayerID(player);
    DebugLog.log(DebugLog.Network, "AT sending server command exclaimerTriggered");
    ATSU.sendServerCommand(AnthroTraitsGlobals.ModID, "exclaimerTriggered", { playerID, mitigated });
end

-- cooldown for stinky comments to prevent players spam commenting
local stinkyCommentCooldowns = {}
local stinkyCommentDefaultCooldown = 0.5    -- in hours

local function playerBeStinky(player)
    local stinkyLoudness = SandboxVars.AnthroTraits.AT_StinkyLoudness
    local stinkyDistance = SandboxVars.AnthroTraits.AT_StinkyDistance
    local stinkyCommentChance = SandboxVars.AnthroTraits.AT_StinkyCommentChance * 100
    local stinkyThreshold = SandboxVars.AnthroTraits.AT_StinkyThreshold
    local playerSquare = player:getCurrentSquare();
    local totalDirtiness = 0;
    local visual = player:getHumanVisual();
    for i = 0, BloodBodyPartType.MAX:index()-1 do
        local bloodBodyPartType = BloodBodyPartType.FromIndex(i)
        totalDirtiness = totalDirtiness + visual:getDirt(bloodBodyPartType);
    end
    if(totalDirtiness < stinkyThreshold) then
        return;
    end
    getWorldSoundManager():addSound(player,
            playerSquare:getX(),
            playerSquare:getY(),
            playerSquare:getZ(),
            stinkyDistance,
            stinkyLoudness);
    local currentTime = GameTime.getInstance():getWorldAgeHours();
    local commentingPlayers = nil;
    ATSU.foreachPlayerDo(function(nearbyPlayer)
        if nearbyPlayer == player then
            return;
        end
        local nearbyPlayerID = ATShU.getPlayerID(nearbyPlayer);
        local cooldown = stinkyCommentCooldowns[nearbyPlayerID] or 0;
        if currentTime < cooldown then
            return;
        end
        if ZombRand(1, 100) > stinkyCommentChance then
            return;
        end
        if nearbyPlayer:isAsleep() or nearbyPlayer:DistTo(player) > stinkyLoudness then
            DebugLog.log("AT stinky asleep or too far away");
            return; 
        end
        local moodles = nearbyPlayer:getMoodles();
        if moodles:getMoodleLevel(MoodleType.PAIN) >= 2 or moodles:getMoodleLevel(MoodleType.PANIC) >= 1 then
            DebugLog.log("AT stinky too pained or panicked");
            return;
        end
        -- 
        stinkyCommentCooldowns[nearbyPlayerID] = currentTime + stinkyCommentDefaultCooldown;
        -- show comment only to stinky player (TODO: maybe show it to everyone?)
        commentingPlayers = commentingPlayers or {};
        table.insert(commentingPlayers, nearbyPlayerID);
    end);
    if commentingPlayers then
        DebugLog.log(DebugLog.Network, "AT sending server command stinkyComments");
        ATSU.sendServerCommand(player, AnthroTraitsGlobals.ModID, "stinkyComments", commentingPlayers);
    end
end

local function playerLonelyCheck(player)
    local currentTime = GameTime.getInstance():getWorldAgeHours();
    local tolerance = SandboxVars.AnthroTraits.AT_LonelyHoursToAffect;
    local lastSeenSomeoneElse = ATSU.getPlayerModDataField(player, "LastSeenSomeoneElse");
    if not lastSeenSomeoneElse then
        lastSeenSomeoneElse = currentTime;
        ATSU.setPlayerModDataField(player, "LastSeenSomeoneElse", lastSeenSomeoneElse);
    end
    local lonelyDistance = SandboxVars.AnthroTraits.AT_StinkyDistance;
    local seenAnyone = false;
    ATSU.foreachPlayerDo(function(otherPlayer)
        -- filter self and by distance
        if otherPlayer == player or player:getDistanceSq(otherPlayer) > lonelyDistance ^ 2 then
            return false;
        end
        -- check if can see other player, NOTE: not sure if this really works as expected... maybe just stick with distance?
        -- local otherSquare = player:getSquare();
        -- if not otherSquare or otherSquare:isBlockedTo(player:getSquare()) then
        --     return false;
        -- end
        seenAnyone = true;
        return true;    -- can cancel loop here
    end);
    if seenAnyone then
        ATSU.setPlayerModDataField(player, "LastSeenSomeoneElse", currentTime);
    elseif currentTime > lastSeenSomeoneElse + tolerance then
        player:getStats():add(CharacterStat.UNHAPPINESS, SandboxVars.AnthroTraits.AT_LonelyHourlyUnhappyIncrease);
        DebugLog.log(DebugLog.Network, "AT sending server command feelingLonely");
        ATSU.sendServerCommand(player, AnthroTraitsGlobals.ModID, "feelingLonely", { ATShU.getPlayerID(player) });
    end
end

-- initialized during server start
local prevLastFallSpeedPlayers;

local function onServerTickPlayer(player)
    local playerID = ATShU.getPlayerID(player);
    -- SP/MP server must process fallspeed and MP client must do the same
    prevLastFallSpeedPlayers[playerID] = ATShU.processFallingPlayer(player, prevLastFallSpeedPlayers[playerID])
    -- server applies torpor => will be periodically sync'ed to clients
    ATShU.applyTorporPlayer(player, isWinter);
end

local function onEveryOneMinutePlayer(player)
	local ATGt = AnthroTraitsGlobals.CharacterTrait;
    if player:hasTrait(ATGt.EXCLAIMER) and not player:isAsleep() then
        playerExclaimerCheck(player);
    end
    if player:hasTrait(ATGt.STINKY) then
        playerBeStinky(player);
    end
end

local function everyHoursPlayer(player)
	local ATGt = AnthroTraitsGlobals.CharacterTrait;
    if player:hasTrait(ATGt.LONELY) then
        playerLonelyCheck(player);
    end
end

function AnthroTraitsServerMain.OnServerTick(tick)
    ATSU.foreachPlayerDo(onServerTickPlayer);
end

function AnthroTraitsServerMain.OnEveryOneMinute()
    ATSU.foreachPlayerDo(onEveryOneMinutePlayer);
end

function AnthroTraitsServerMain.EveryHours()
    ATSU.foreachPlayerDo(everyHoursPlayer);
end

function AnthroTraitsServerMain.EveryDays()
    isWinter = ATShU.checkIfIsWinter();
end

function AnthroTraitsServerMain.OnGameStart()
    prevLastFallSpeedPlayers = {};
    isWinter = ATShU.checkIfIsWinter();
end

-- WTF?! why does PZ load the server folder on an mp client?!
if not isClient() then
    Events.OnTick.Add(AnthroTraitsServerMain.OnServerTick);
    Events.EveryOneMinute.Add(AnthroTraitsServerMain.OnEveryOneMinute);
    Events.OnPlayerGetDamage.Add(AnthroTraitsServerMain.ATPlayerDamageTick);
    Events.EveryHours.Add(AnthroTraitsServerMain.EveryHours);
    Events.EveryDays.Add(AnthroTraitsServerMain.EveryDays);
    Events.OnGameStart.Add(AnthroTraitsServerMain.OnGameStart);
end

return AnthroTraitsServerMain;