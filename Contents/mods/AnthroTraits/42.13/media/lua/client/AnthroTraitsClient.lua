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

--Ensure Load Order:
local AT_REQ_FM = require("FurryMod");
local AT_REQ_ET = require("DracoExpandedTraits");
local AT_REQ_MST = require("MoreSimpleTraits");
local AT_REQ_SOTO = require("SimpleOverhaulTraitsAndOccupations");
local AT_REQ_MT = require("ToadTraits");

local AnthroTraitsClient = {};
local ATU = require("AnthroTraitsUtilities");
local AnthroTraitsUtilities = require("Contents.mods.AnthroTraits.42.12.media.lua.client.AnthroTraitsUtilities")
ATU.ImportExclaimerPhrases()

-- C:\Program Files (x86)\Steam\steamapps\common\ProjectZomboid\media\lua | Project Zomboid files
-- C:\Program Files (x86)\Steam\steamapps\common\ProjectZomboid\media\AnimSets\player
-- C:\Program Files (x86)\Steam\steamapps\workshop\content\108600\

-- C:\Users\[user]\Zomboid\mods
-- C:\Users\[user]\Zomboid\Logs


--EVENT HANDLERS
---@param _playerIndex integer
---@param player IsoPlayer
AnthroTraitsClient.ATInitPlayerData = function(_playerIndex, player)
    --run in clients or sp
    if not isServer()
    then
        if player == nil
        then
            player = getPlayer();
        end
        local modData = player:getModData();

        if modData.ATPlayerData == nil then
            modData.ATPlayerData = {};
            local atData = modData.ATPlayerData;

            atData.trulyInfected = false;
            atData.canTripChecked = false;
            atData.undoAddedPoison = false;
            atData.beforeEatPoisonLvl = 0;
            atData.tripSafe = false;
            atData.torporActive = false;
            atData.HoursSinceSeenOthers = 0;
            atData.oldFallSpeed = 0.0;
            atData.oldWetness = 0.0;
        end
    end
end


AnthroTraitsClient.ATOnInitWorld = function()
    ATU.AddItemTagToItemsFromSandbox(SandboxVars.AnthroTraits.AT_CarnivoreItems, AnthroTraitsGlobals.FoodTags.CARNIVORE);
    ATU.AddItemTagToItemsFromSandbox(SandboxVars.AnthroTraits.AT_HerbivoreItems, AnthroTraitsGlobals.FoodTags.HERBIVORE);
    ATU.AddItemTagToItemsFromSandbox(SandboxVars.AnthroTraits.AT_Bug_o_ssieurItems, AnthroTraitsGlobals.FoodTags.INSECT);
    ATU.AddItemTagToItemsFromSandbox(SandboxVars.AnthroTraits.AT_FeralDigestionItems, AnthroTraitsGlobals.FoodTags.FERALPOISON);
    ATU.AddItemTagToItemsFromSandbox(SandboxVars.AnthroTraits.AT_FoodMotivatedItems, AnthroTraitsGlobals.FoodTags.FOODMOTIVATED);

    if getDebug()
    then
        ATU.ExportFoodGuideFiles();
    end

    Colors["LavenderBlush"] = Color.new(1, 229/255, 229/255, 1);

end


---comment
---@param player IsoPlayer
---@param damageType DAMAGETYPE
---@param damage integer
AnthroTraitsClient.ATPlayerDamageTick = function(player, damageType, damage)
	local ATGt = AnthroTraitsGlobals.CharacterTrait
    local ATU = AnthroTraitsUtilities;

    if player:isZombie()
    then
        return
    end

    --single player code
    if not isServer() and not isClient()
    then

        local playerData = player:getModData().ATPlayerData;
        local footL = player:getBodyDamage():getBodyPart(BodyPartType.Foot_L);
        local footR = player:getBodyDamage():getBodyPart(BodyPartType.Foot_R);

        if player:getBodyDamage():isInfected() == true and playerData.trulyInfected == false
        then
            if getDebug()
            then
                DebugLog.log("Handle Infection about to be triggered");
            end
            playerData.trulyInfected = ATU.HandleInfection(player);
        end

        if player:hasTrait(ATGt.UNGULIGRADE) or player:hasTrait(ATGt.DIGITIGRADE)
        then
            --immune to scratches
            if footL:scratched()
            then
                ATU.HealScratch(player:getBodyDamage(), BodyPartType.Foot_L);
            end
            if footR:scratched()
            then
                ATU.HealScratch(player:getBodyDamage(), BodyPartType.Foot_R);
            end
        end
        if player:hasTrait(ATGt.UNGULIGRADE)
        then
            --immune to lacerations and bites
            if footL:isCut()
            then
                ATU.HealLaceration(player:getBodyDamage(), BodyPartType.Foot_L);
            end
            if footR:isCut()
            then
                ATU.HealLaceration(player:getBodyDamage(), BodyPartType.Foot_R);
            end
            if footL:bitten()
            then
                ATU.HealBite(player:getBodyDamage(), BodyPartType.Foot_L);
            end
            if footR:bitten()
            then
                ATU.HealBite(player:getBodyDamage(), BodyPartType.Foot_R);
            end
        end
    end
end


AnthroTraitsClient.ATOnCharacterCollide = function(collider, collidee)
	local ATGt = AnthroTraitsGlobals.CharacterTrait
    if instanceof(collider, "IsoPlayer") and collider:isLocalPlayer()
    then
        -- take the sandbox cost, modify it by the difference between the player's current strength/fitness and the average strength/fitness of 5. Then turn that into a decimal since endurance is a decimal. Pick .01 if the cost is lower.
        -- if you ever figure out math, make it do a percentage taken away instead of a flat number
        local knockdownEndCost = math.max(SandboxVars.AnthroTraits.AT_BullRushKnockdownEndCost - (((collider:getPerkLevel(Perks.Fitness) + collider:getPerkLevel(Perks.Strength)) - 10) / 100), .01)
        local colliderBehindCollidee = collidee:isFacingObject(collider, 0.5);
        local modData = collider:getModData().ATPlayerData;
        if getDebug()
        then
            DebugLog.log("ATOnCharacterCollide Triggered");
        end
--        if not collidee:isKnockedDown() and collider:hasTrait(ATGt.BULLRUSH) and collider:isSprinting() and collider:getBeenSprintingFor() >= 10
--        then
            -- if getDebug()
            -- then
                -- DebugLog.log("collidee: "..tostring(collidee));
                -- DebugLog.log("colliderBehindCollidee: "..tostring(colliderBehindCollidee));
                -- DebugLog.log("Is Sprinting: "..tostring(collider:isSprinting()));
                -- DebugLog.log("getBeenSprintingFor(): "..tostring(collider:getBeenSprintingFor()));
                -- DebugLog.log("Tripping: "..tostring(collider:getStats():isTripping()));
            -- end
            -- if instanceof(collidee, "IsoZombie")
            -- then
                -- collidee:setStaggerBack(true);
                -- collidee:knockDown(colliderBehindCollidee);
                -- if isServer()
                -- then
                    -- collidee:setHitReaction("");
                    -- collidee:setPlayerAttackPosition("FRONT");
                    -- collidee:setHitForce(2.0);
                    -- collidee:reportEvent("wasHit");
                -- end
                -- collider:getStats():setEndurance(collider:getStats():getEndurance() - knockdownEndCost);
                -- collider:setBumpType("");
                -- collider:setBumpStaggered(false);
                -- collider:setBumpFall(false);
            -- elseif instanceof(collidee, "IsoPlayer")
            -- then
                -- if SwipeStatePlayer.checkPVP(collider, collidee) or collidee:isZombie()
                -- then
                    -- collidee:setBumpType("stagger");
                    -- collidee:setVariable("BumpDone", true);
                    -- collidee:setVariable("BumpFall", true);
                    -- if colliderBehindCollidee
                    -- then
                        -- collidee:setVariable("BumpFallType", "pushedbehind");
                    -- else
                        -- collidee:setVariable("BumpFallType", "pushedFront")
                    -- end
                    -- if isServer()
                    -- then
                        -- collidee:setHitReaction("");
                        -- collidee:setPlayerAttackPosition("FRONT");
                        -- collidee:setHitForce(2.0);
                        -- collidee:reportEvent("wasHit");
                    -- end
                    -- --collidee:setBumpStaggered(true);
                    -- --collidee:setKnockedDown(true);
                    -- collider:getStats():setEndurance(collider:getStats():getEndurance() - knockdownEndCost);
                    -- collider:setBumpType("");
                    -- collider:setBumpStaggered(false);
                    -- collider:setBumpFall(false);
                -- end
            -- end
        -- elseif collidee:isKnockedDown() and collider:hasTrait(ATGt.BULLRUSH) and collider:isSprinting() and collider:getBeenSprintingFor() >= 10
        -- then
            -- if instanceof(collidee, "IsoZombie")
            -- then
                -- collidee:setStaggerBack(true);
                -- collidee:knockDown(colliderBehindCollidee);
                -- if isServer()
                -- then
                    -- collidee:setHitReaction("");
                    -- collidee:setPlayerAttackPosition("FRONT");
                    -- collidee:setHitForce(2.0);
                    -- collidee:reportEvent("wasHit");
                -- end
                -- collider:setBumpType("");
                -- collider:setBumpStaggered(false);
                -- collider:setBumpFall(false);
            -- elseif instanceof(collidee, "IsoPlayer")
            -- then
                -- if SwipeStatePlayer.checkPVP(collider, collidee) or collidee:isZombie()
                -- then
                    -- collidee:setBumpType("stagger");
                    -- collidee:setVariable("BumpDone", true);
                    -- collidee:setVariable("BumpFall", true);
                    -- if colliderBehindCollidee
                    -- then
                        -- collidee:setVariable("BumpFallType", "pushedbehind");
                    -- else
                        -- collidee:setVariable("BumpFallType", "pushedFront")
                    -- end
                    -- if isServer()
                    -- then
                        -- collidee:setHitReaction("");
                        -- collidee:setPlayerAttackPosition("FRONT");
                        -- collidee:setHitForce(2.0);
                        -- collidee:reportEvent("wasHit");
                    -- end
                    -- --collidee:setBumpStaggered(true);
                    -- --collidee:setKnockedDown(true);
                    -- collider:setBumpType("");
                    -- collider:setBumpStaggered(false);
                    -- collider:setBumpFall(false);
                -- end
            -- end
        -- elseif collider:hasTrait(CharacterTrait.get(ATGt.TAIL) and modData.canTripChecked == false and (collider:getStats():isTripping() or collider:isBumped())
		if collider:hasTrait(ATGt.TAIL) and modData.canTripChecked == false and (collider:getStats():isTripping() or collider:isBumped())
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
                    DebugLog.log("Player bump/trip prevented by Tail trait. Rolled Chance:"..rolledChance);
                end
            else
                modData.canTripChecked = true;
                modData.tripSafe = false;
            end
        end
        if collider:hasTrait(ATGt.TAIL) and modData.canTripChecked == true and modData.tripSafe == true
        then
            collider:getStats():setTripping(false);
            collider:setBumpFall(false);
            if getDebug()
            then
                DebugLog.log("Player bump/trip prevented by Tail trait during minute grace period.");
            end
        end
    end
end


AnthroTraitsClient.ATEveryWeaponHitChar = function(attacker, target, weapon, damage)
	local ATGt = AnthroTraitsGlobals.CharacterTrait
    local dmgBonus = 0;

    if (attacker:hasTrait(ATGt.DIGITIGRADE) or attacker:hasTrait(ATGt.UNGULIGRADE)) and attacker:isDoStomp()
    then
        if attacker:hasTrait(ATGt.UNGULIGRADE)
        then
            dmgBonus = damage * (SandboxVars.AnthroTraits.AT_DigitigradeStompDmgPctIncrease + SandboxVars.AnthroTraits.AT_UnguligradeStompDmgPctIncrease);
        else
            dmgBonus = damage * (SandboxVars.AnthroTraits.AT_DigitigradeStompDmgPctIncrease);
        end
        --this event doesn't supply a bodypart, and that's sad. We'll have to settle for doing damage to the character's overall health instead.
        target:applyDamage(dmgBonus);
        if getDebug()
        then
            DebugLog.log(string.format("Applying %s extra damage.", dmgBonus));
        end
    end
end

AnthroTraitsClient.ATOnObjectCollide = function(collider, collidee)
	local ATGt = AnthroTraitsGlobals.CharacterTrait
    if instanceof(collider, "IsoPlayer") and not collider:isZombie() and collider:isLocalPlayer()
    then
        local modData = collider:getModData().ATPlayerData;
        if getDebug()
        then
            DebugLog.log("ATOnObjectCollide Triggered");
            DebugLog.log("Object: "..type(collidee));
            DebugLog.log("collider: "..type(collider));
        end
        if collider:hasTrait(ATGt.TAIL) and modData.canTripChecked == false and (collider:getStats():isTripping() or collider:isBumped())
        then
            local rolledChance = ZombRand(0,100);

            if rolledChance <= SandboxVars.AnthroTraits.AT_TailTripReduction
            then
                collider:getStats():setTripping(false);
                collider:setBumpFall(false);
                if getDebug()
                then
                    DebugLog.log("Player bump/trip prevented by Tail trait. Rolled Chance:"..rolledChance);
                end
            else
                modData.canTripChecked = true;
                modData.tripSafe = false;
            end
        end
        if collider:hasTrait(ATGt.TAIL) and modData.canTripChecked == true and modData.tripSafe == true
        then
            collider:getStats():setTripping(false);
            collider:setBumpFall(false);
            if getDebug()
            then
                DebugLog.log("Player bump/trip prevented by Tail trait during minute grace period.");
            end
        end
    end
end


AnthroTraitsClient.ATEveryOneMinute = function()
	local ATGt = AnthroTraitsGlobals.CharacterTrait
    local ATU = AnthroTraitsUtilities;
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
                if modData.undoAddedPoison == true
                then
                    player:getStats():set(CharacterStat.POISON, modData.beforeEatPoisonLvl);
                    modData.undoAddedPoison = false;
                end
                if player:hasTrait(ATGt.ANTHROIMMUNITY) and not player:getBodyDamage():isInfected() and (modData.trulyInfected == true or modData.trulyInfected == nil)
                then
                    --if a player is a cheater/debugging or takes a game-made cure
                    modData.trulyInfected = false;
                    if getDebug
                    then
                        DebugLog.log("trulyInfected set to false. Anthro Immunity applies again.");
                    end
                end

                if player:hasTrait(ATGt.EXCLAIMER) and not player:isAsleep()
                then
                    ATU.ExclaimerCheck(player);
                end
                if player:hasTrait(ATGt.STINKY)
                then
                    ATU.BeStinky(player);
                end
                modData.canTripChecked = false;
                modData.tripSafe = false;
                ATU.CarryWeightUpdate(player);
            end
        end
    end
end

AnthroTraitsClient.ATEveryHours = function()
	local ATGt = AnthroTraitsGlobals.CharacterTrait
    local activePlayers = getNumActivePlayers();
    if activePlayers >= 1
    then
        --for playerIndex = 0, (activePlayers - 1)
        --do
            local player = getSpecificPlayer(0);
            local modData =  player:getModData().ATPlayerData;
            if player:hasTrait(ATGt.LONELY)
            then
                modData.HoursSinceSeenOthers = modData.HoursSinceSeenOthers + 1;
                if modData.HoursSinceSeenOthers > SandboxVars.AnthroTraits.AT_LonelyHoursToAffect
                then
                    player:getStats():add(CharacterStat.UNHAPPINESS, SandboxVars.AnthroTraits.AT_LonelyHourlyUnhappyIncrease);
                end
            end
        --end
    end
end


AnthroTraitsClient.ATEveryDays = function()
	local ATGt = AnthroTraitsGlobals.CharacterTrait
    local activePlayers = getNumActivePlayers();
    local season = getClimateManager():getSeason();

    if activePlayers >= 1
    then
        for playerIndex = 0, (activePlayers - 1)
        do
            local player = getSpecificPlayer(playerIndex);
            local modData =  player:getModData().ATPlayerData;
            local winterInt = zombie.erosion.season.ErosionSeason.SEASON_WINTER;
            --https://demiurgequantified.github.io/ProjectZomboidJavaDocs/constant-values.html#zombie.erosion.season.ErosionSeason.NUM_SEASONS
            if player:hasTrait(ATGt.TORPOR) and season:isSeason(winterInt)
            then
                modData.torporActive = true;
            else
                modData.torporActive = false;
            end
        end
    end
end


AnthroTraitsClient.ATPlayerUpdate = function(player)
	local ATGt = AnthroTraitsGlobals.CharacterTrait
    local ATU = AnthroTraitsUtilities;
    local fallTimeMult = SandboxVars.AnthroTraits.AT_NaturalTumblerFallTimeMult;
    local modData =  player:getModData().ATPlayerData;
    local beforeFallSpeed = modData.oldFallSpeed;
    local endurance = player:getStats():getLastEndurance();
    local rolledChance = ZombRand(0,100);
    if modData.torporActive
    then
        if endurance > (1.0 - SandboxVars.AnthroTraits.AT_TorporEnduranceDecrease)
        then
            player:getStats():set(CharacterStat.ENDURANCE, 1.0 - SandboxVars.AnthroTraits.AT_TorporEnduranceDecrease);
        end
    end
    if player:hasTrait(ATGt.NATURALTUMBLER)
    then
        --Fall damage reduced
        if(beforeFallSpeed < player:getLastFallSpeed())
        then
            player:setLastFallSpeed(beforeFallSpeed + ((player:getLastFallSpeed() - beforeFallSpeed) * fallTimeMult));
        end
        beforeFallSpeed = player:getLastFallSpeed();
    elseif player:hasTrait(ATGt.VESTIGIALWINGS)
    then
        --immune to fall damage
		if(player:getLastFallSpeed() > 2)
		then
			player:setLastFallSpeed(2);
		end
    end
	modData.oldFallSpeed = beforeFallSpeed
    ATU.LonelyUpdate(player);
end

--needed to init player data in sp when launching a new game
Events.OnLoad.Add(AnthroTraitsClient.ATInitPlayerData);
--needed for mp/ creating a second+ character in a sp world
Events.OnCreatePlayer.Add(AnthroTraitsClient.ATInitPlayerData);
--needed for mp/ creating a second+ character in a sp world
Events.OnCreatePlayer.Add(AnthroTraitsClient.ATInitPlayerData);
Events.OnInitWorld.Add(AnthroTraitsClient.ATOnInitWorld);


Events.OnObjectCollide.Add(AnthroTraitsClient.ATOnObjectCollide);
Events.OnCharacterCollide.Add(AnthroTraitsClient.ATOnCharacterCollide);
Events.OnWeaponHitCharacter.Add(AnthroTraitsClient.ATEveryWeaponHitChar);
Events.EveryDays.Add(AnthroTraitsClient.ATEveryDays);
Events.EveryHours.Add(AnthroTraitsClient.ATEveryHours);
Events.EveryOneMinute.Add(AnthroTraitsClient.ATEveryOneMinute);
---@diagnostic disable-next-line: param-type-mismatch
Events.OnPlayerGetDamage.Add(AnthroTraitsClient.ATPlayerDamageTick);
---@diagnostic disable-next-line: param-type-mismatch
Events.OnPlayerGetDamage.Add(AnthroTraitsClient.ATPlayerDamageTick);
Events.OnPlayerUpdate.Add(AnthroTraitsClient.ATPlayerUpdate);




return AnthroTraitsClient;