local ATSU = require("AnthroTraitsServerUtilities");
local ATShU = require "AnthroTraitsSharedUtilities"

local isWinter;
local usingFurryMod = getActivatedMods():contains("FurryMod");
local usingFurryApocalypse = getActivatedMods():contains("FurryApocalypse");
local function IsAnthro(gameCharacter)
    if (usingFurryMod or usingFurryApocalypse) and gameCharacter ~= nil
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

local bullrushingPlayers = {};

local function getZombiesInRange(player, range, maxCount, predicate)
	local square = player:getSquare();
	if not square then
		return nil;
	end
	local cell = square:getCell();
	if not cell then
		return nil;
	end
    local rangeSq = range * range;
	local zombieList = cell:getZombieList();
    local res = nil;
	for i=0, zombieList:size() - 1 do
		local zombie = zombieList:get(i);
        if zombie:getDistanceSq(player) <= rangeSq and (not predicate or predicate(zombie)) then
            res = res or {};
            table.insert(res, zombie);
            if maxCount and #res >= maxCount then
                break;
            end
        end
	end
	return res;
end

local function calcBullrushPerZombieCost(player)
    local weight0_60 = math.max(math.min(player:getNutrition():getWeight(), 110), 50) - 50;
    local res = 0;
    res = res + 1.0 * player:getPerkLevel(Perks.Fitness) / 10;
    res = res + 1.5 * player:getPerkLevel(Perks.Strength) / 10; -- strength has higher impact on cost calculation
    res = res + 1.0 * weight0_60 / 60;

    res = res / 3.5; -- between 0 and 1
    res = AnthroTraitsGlobals.BULLRUSH_PERZOMBIECOST_MIN + (AnthroTraitsGlobals.BULLRUSH_PERZOMBIECOST_MAX - AnthroTraitsGlobals.BULLRUSH_PERZOMBIECOST_MIN) * res;
    return res * SandboxVars.AnthroTraits.AT_BullRushKnockdownCostMultiplier;
end

local function checkBullrush(player, tick)
    if not player:hasTrait(AnthroTraitsGlobals.CharacterTrait.BULLRUSH) then
        return
    end
    local playerID = ATShU.getPlayerID(player);
    if not player:isSprinting() then
        bullrushingPlayers[playerID] = nil;
        return
    end
    if not bullrushingPlayers[playerID] then
        bullrushingPlayers[playerID] = tick;
    end
    local ticksSinceBRStart =  tick - bullrushingPlayers[playerID];
    -- check for min duration of pulses and only do pulses at certain intervals to save on network traffic in MP
    if ticksSinceBRStart < AnthroTraitsGlobals.BULLRUSH_PUSHSTART and ticksSinceBRStart % AnthroTraitsGlobals.BULLRUSH_PUSHINTERVAL ~= 0 then
        return
    end
    local stats = player:getStats();
    local maxTargets = nil;
    local costPerZombie = calcBullrushPerZombieCost(player);
    if costPerZombie > 0 then
        maxTargets = stats:get(CharacterStat.ENDURANCE) / costPerZombie;
    end
    local targets = getZombiesInRange(player, AnthroTraitsGlobals.BULLRUSH_PUSHRANGE, maxTargets, function(zombie) return not zombie:isKnockedDown(); end);
    if not targets then
        return
    end
    DebugLog.log("AT Bullrush player " .. playerID .. " knocking down " .. #targets .. " zombies down");
    stats:remove(CharacterStat.ENDURANCE, #targets * costPerZombie);
    local targetIDs = {}
    for _, target in ipairs(targets) do
        ATShU.knockdownZombie(target);
        table.insert(targetIDs, ATShU.getZombieID(target));
    end
    targetIDs.player = playerID;
    -- only send command if on MP server, in SP: server already knocked down zombies
    if isServer() then
        DebugLog.log(DebugType.Network, "AT sending server command bullrushZombies");
        ATSU.sendServerCommand(AnthroTraitsGlobals.ModID, "bullrushZombies", targetIDs);
    end
end

local function checkIfIsNewInjury(bodyPartInfo, InjuryName, injuryTime)
    local lastInjuryTime = bodyPartInfo[InjuryName];
    -- injury time decreases over time, so if new injury then injury time should be greater
    return not lastInjuryTime or injuryTime > lastInjuryTime;
end

local injuryTypes =
{
    bite = {
        InfectionChance = SandboxVars.AnthroTraits.AT_AnthroImmunityBiteInfectionChance,
        getInjuryTime = function(bodyPart)
            return bodyPart:getBiteTime();
        end,
    },
    cut = {
        InfectionChance = SandboxVars.AnthroTraits.AT_AnthroImmunityLacerationInfectionChance,
        getInjuryTime = function(bodyPart)
            return bodyPart:getCutTime();
        end,
    },
    scratch = {
        InfectionChance = SandboxVars.AnthroTraits.AT_AnthroImmunityScratchInfectionChance,
        getInjuryTime = function(bodyPart)
            return bodyPart:getScratchTime();
        end,
    },
}

local function checkIfRemoveInfection(player, bodyPart, bodyPartInfo, attackerIsAnthro)
	local ATGt = AnthroTraitsGlobals.CharacterTrait
    if player:hasTrait(ATGt.UNGULIGRADE) and (bodyPart:getType() == BodyPartType.Foot_L or bodyPart:getType() == BodyPartType.Foot_R) then
        DebugLog.log("AT Unguligrade foot immunity triggered");
        return true;
    end
    local anthroIgnoreImmunity = SandboxVars.AnthroTraits.AT_AnthroImmunityIgnoredByAnthroZombies
    if player:hasTrait(ATGt.ANTHROIMMUNITY) and (not anthroIgnoreImmunity or not attackerIsAnthro) then
        local rolledInfectionChance = ZombRand(1, 100);
        local healedAllInfections = true;
        for injuryName, injuryInfo in pairs(injuryTypes) do
            if checkIfIsNewInjury(bodyPartInfo, injuryName, injuryInfo.getInjuryTime(bodyPart)) then
                healedAllInfections = healedAllInfections and rolledInfectionChance >= injuryInfo.InfectionChance;
            end
        end
        DebugLog.log("AT AnthroImmunity rolled " .. rolledInfectionChance .. " against infections");
        return healedAllInfections;
    end
    return false;
end

local function healBodyPart(bodyPart, bodyPartInfo, healScratch, healCut, healBite)
    local healedBleeding = false;
    if bodyPart:getBleedingTime() > 0 then
    	bodyPart:setBleedingTime(0);
	    bodyPart:setBleeding(false);
        healedBleeding = true;
    end
    local healedBite = false;
    if healBite and bodyPart:getBiteTime() > 0 then
		bodyPart:setBiteTime(0);
		bodyPart:SetBitten(false, false);
        healedBite = true;
    end
    local healedScratch = false;
    if healScratch and bodyPart:getScratchTime() > 0 then
        bodyPart:setScratched(false, false);
        bodyPart:setScratchTime(0);
        healedScratch = true;
    end
    local healedCut = false;
    if healCut and bodyPart:getCutTime() > 0 then
        bodyPart:setCutTime(0);
		bodyPart:setCut(false, false);
        healedCut = true;
    end
    if healedBleeding or healedBite or healedScratch or healedCut then
        DebugLog.log("AT healed: bleed " .. tostring(healedBleeding) .. " scratch " .. tostring(healedScratch) .. " cut " .. tostring(healedCut) .. " bite " ..tostring(healedBite));
    end
end

local function processPlayerBodyParts(player, healthInfo, bodyDamage)
    local doInfectionChecks;
    if bodyDamage:isInfected() then
        -- don't check infections again, if defenses already failed before
        doInfectionChecks = not ATSU.getPlayerModDataField(player, "TrulyInfected");
    else
        -- unset field in case player survives and loses infection through other mods
        ATSU.setPlayerModDataField(player, "TrulyInfected", false);
        doInfectionChecks = false;
    end
    
    local bodyDamage = player:getBodyDamage();
    local bodyParts = bodyDamage:getBodyParts()
    local lastAttackedBy = player:getAttackedBy();
    local attackerIsAnthro = IsAnthro(lastAttackedBy)

    local isTrulyInfected = false;
    for i = 0, bodyParts:size() - 1 do
        local bodyPart = bodyParts:get(i);
        local bodyPartIndex = bodyPart:getIndex();
        local bodyPartInfo = healthInfo[bodyPartIndex];
        if not bodyPartInfo then
            bodyPartInfo = {}
            healthInfo[bodyPartIndex] = bodyPartInfo;
        end
        if doInfectionChecks and bodyPart:IsInfected() then
            if not bodyPartInfo.infected then
                if checkIfRemoveInfection(player, bodyPart, bodyPartInfo, attackerIsAnthro) then
                    bodyPart:SetFakeInfected(false);
                    bodyPart:SetInfected(false);
                else
                    bodyPartInfo.infected = true;
                end
            end
        else
            -- still need to track of current infection state of bodypart
            bodyPartInfo.infected = bodyPart:IsInfected();
        end
        isTrulyInfected = isTrulyInfected or bodyPartInfo.infected;
        -- update injury times
        for injuryName, injuryInfo in pairs(injuryTypes) do
            bodyPartInfo[injuryName] = injuryInfo.getInjuryTime(bodyPart);
        end
    end
    if doInfectionChecks then
        if not isTrulyInfected then
            bodyDamage:setInfected(false);
            bodyDamage:setIsFakeInfected(false);
            bodyDamage:setInfectionTime(-1);
            bodyDamage:setInfectionMortalityDuration(-1);
            --bodyDamage:setInfectionGrowthRate(-1);
        else
            ATSU.setPlayerModDataField(player, "TrulyInfected", isTrulyInfected);
            DebugLog.log("AT all infection defenses failed. Die well o7");
        end
    end
    if player:hasTrait(AnthroTraitsGlobals.CharacterTrait.UNGULIGRADE) then
        local footL = bodyDamage:getBodyPart(BodyPartType.Foot_L);
        healBodyPart(footL, healthInfo[footL:getIndex()], true, true, true);
        local footR = bodyDamage:getBodyPart(BodyPartType.Foot_R);
        healBodyPart(footR, healthInfo[footR:getIndex()], true, true, true);
    end
end

local function processPlayerHealth(player)
    local healthInfo = ATSU.getPlayerModDataField(player, "HealthInfo")
    if not healthInfo then
        healthInfo = {}
        ATSU.setPlayerModDataField(player, "HealthInfo", healthInfo);
    end
    local bodyDamage = player:getBodyDamage();
    processPlayerBodyParts(player, healthInfo, bodyDamage);
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
    DebugLog.log(DebugType.Network, "AT sending server command exclaimerTriggered");
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
    local nearbyPlayerFunc = function(nearbyPlayer)
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
    end
    ATSU.foreachPlayerDo(nearbyPlayerFunc, nil, function(nearbyPlayer) return nearbyPlayer ~= player and not nearbyPlayer:isDead(); end);
    if commentingPlayers then
        DebugLog.log(DebugType.Network, "AT sending server command stinkyComments");
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
        DebugLog.log(DebugType.Network, "AT sending server command feelingLonely");
        ATSU.sendServerCommand(player, AnthroTraitsGlobals.ModID, "feelingLonely", { ATShU.getPlayerID(player) });
    end
end

-- initialized during server start
local prevLastFallSpeedPlayers = {};

local function onServerTickPlayer(player, tick)
    local playerID = ATShU.getPlayerID(player);
    -- SP/MP server must process fallspeed and MP client must do the same
    prevLastFallSpeedPlayers[playerID] = ATShU.processFallingPlayer(player, prevLastFallSpeedPlayers[playerID])
    -- server applies torpor => will be periodically sync'ed to clients
    ATShU.applyTorporPlayer(player, isWinter);
    checkBullrush(player, tick);
    processPlayerHealth(player);
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

local function isNotDead(player)
    return not player:isDead();
end

local function onServerTick(tick)
    ATSU.foreachPlayerDo(onServerTickPlayer, tick, isNotDead);
end

local function onWeaponHitCharacter(attacker, target, weapon, damageSplit)
    if not instanceof(attacker, "IsoPlayer") or not attacker:isDoStomp() then
        return;
    end
    local hasUnguligrade = attacker:hasTrait(AnthroTraitsGlobals.CharacterTrait.UNGULIGRADE);
    local hasDigitigrade = attacker:hasTrait(AnthroTraitsGlobals.CharacterTrait.DIGITIGRADE);
    local mult;
    if hasUnguligrade then
        mult = SandboxVars.AnthroTraits.AT_UnguligradeStompDmgPctIncrease
    elseif hasDigitigrade then
        mult = SandboxVars.AnthroTraits.AT_DigitigradeStompDmgPctIncrease;
    else
        return;
    end
    DebugLog.log("AT unguligrade or digitigrade stomp doing additional " .. mult .. " damage");
    local damage = target:processHitDamage(weapon, attacker, damageSplit, false, 1.0) * mult;
	target:hitConsequences(weapon, attacker, false, damage, false);
end

local function onEveryOneMinute()
    ATSU.foreachPlayerDo(onEveryOneMinutePlayer, nil, isNotDead);
end

local function everyHours()
    ATSU.foreachPlayerDo(everyHoursPlayer, nil, isNotDead);
end

local function everyDays()
    isWinter = ATShU.checkIfIsWinter();
end

local function onInitWorld()
    ATShU.initialiseItemTags();
end

local function onGameStart()
    prevLastFallSpeedPlayers = {};
    bullrushingPlayers = {};
    isWinter = ATShU.checkIfIsWinter();
end

-- WTF?! why does PZ load the server folder on an mp client?!
if not isClient() then
    Events.OnTick.Add(onServerTick);
    Events.OnWeaponHitCharacter.Add(onWeaponHitCharacter);
    Events.EveryOneMinute.Add(onEveryOneMinute);
    Events.EveryHours.Add(everyHours);
    Events.EveryDays.Add(everyDays);
    Events.OnInitWorld.Add(onInitWorld);
    Events.OnGameStart.Add(onGameStart);
end

local function updateAllPlayerCarryWeight()
    ATSU.foreachPlayerDo(function(player)
        ATShU.updatePlayerCarryWeight(player);
    end, nil, isNotDead);
end

local function perkLevelPlayer(character, perk, level, increasing)
    if instanceof(character, "IsoPlayer") and not character:isDead() and perk == Perks.Strength then
        -- one minute after strengh perk level changes, recalculate carry weight
        ATShU.queueDelayedEvent(function() ATShU.updatePlayerCarryWeight(character); end, 1);
    end
end

local usingUCWF = getActivatedMods():contains("UnifiedCarryWeightFramework");
if not usingUCWF then
    -- one minute into the hour trigger carry weight recalculation (to overwrite SOTO if active)
    -- should happen both on MP client and server
    ATShU.queueRepeatingDelayedEvent(updateAllPlayerCarryWeight, 1);
    Events.LevelPerk.Add(perkLevelPlayer);
end


