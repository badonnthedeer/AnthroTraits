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

local AnthroTraitsMain = {};
local ATU = require("AnthroTraitsUtilities");
ATU.ImportExclaimerPhrases()

-- C:\Program Files (x86)\Steam\steamapps\common\ProjectZomboid\media\lua | Project Zomboid files
-- C:\Program Files (x86)\Steam\steamapps\common\ProjectZomboid\media\AnimSets\player
-- C:\Program Files (x86)\Steam\steamapps\workshop\content\108600\

-- C:\Users\[user]\Zomboid\mods
-- C:\Users\[user]\Zomboid\Logs


-- AnthroTraitsMain.HandleInfection = function(player)
	-- local ATGt = AnthroTraitsGlobals.CharacterTrait
    -- local biteInfectionChance = SandboxVars.AnthroTraits.AT_AnthroImmunityBiteInfectionChance;
    -- local lacerationInfectionChance = SandboxVars.AnthroTraits.AT_AnthroImmunityLacerationInfectionChance;
    -- local scratchInfectionChance = SandboxVars.AnthroTraits.AT_AnthroImmunityScratchInfectionChance;
    -- if getDebug()
    -- then
        -- print("Handle Infection Triggered");
    -- end

    -- for i = 0, player:getBodyDamage():getBodyParts():size() - 1 
    -- do
        -- local bodypart = player:getBodyDamage():getBodyParts():get(i);
        -- if bodypart:HasInjury() == true and bodypart:IsInfected() 
        -- then
            -- if getDebug()
            -- then
                -- print( tostring(bodypart:getType()) .. " is injured and infected.");
            -- end
            -- if player:hasTrait(ATGt.UNGULIGRADE)
            -- then
                -- if tostring(bodypart:getType()) == "Foot_L" or tostring(bodypart:getType()) == "Foot_R"
                -- then
                    -- if getDebug()
                    -- then
                        -- print("AT_Unguligrade foot immunity triggered.");
                    -- end
                    -- bodypart:SetInfected(false);
                    -- player:getBodyDamage():setInfected(false);
                    -- player:getBodyDamage():setInfectionMortalityDuration(-1);
                    -- player:getBodyDamage():setInfectionTime(-1);
                    -- player:getBodyDamage():setInfectionGrowthRate(0);
                -- end
            -- end
            -- if player:hasTrait(ATGt.ANTHROIMMUNITY) 
            -- then
                -- local rolledInfectionChance = ZombRand(1, 100);
                -- local lastAttackedBy = player:getAttackedBy();
                -- if (not SandboxVars.AnthroTraits.AT_AnthroImmunityIgnoredByAnthroZombies and not ATU.IsAnthro(lastAttackedBy)
                -- or not SandboxVars.AnthroTraits.AT_AnthroImmunityIgnoredByAnthroZombies and ATU.IsAnthro(lastAttackedBy)
                -- or SandboxVars.AnthroTraits.AT_AnthroImmunityIgnoredByAnthroZombies and not ATU.IsAnthro(lastAttackedBy))
                -- then
                    -- if getDebug()
                    -- then
                        -- print("Rolled " .. rolledInfectionChance);
                    -- end
                    -- if bodypart:bitten() 
                    -- then
                        -- if biteInfectionChance <= rolledInfectionChance 
                        -- then
                            -- bodypart:SetInfected(false);
                            -- player:getBodyDamage():setInfected(false);
                            -- player:getBodyDamage():setInfectionMortalityDuration(-1);
                            -- player:getBodyDamage():setInfectionTime(-1);
                            -- player:getBodyDamage():setInfectionLevel(0);
                            -- player:getBodyDamage():setInfectionGrowthRate(0);
                            -- if getDebug()
                            -- then
                                -- print("Infection defense successful.");
                            -- end
                            -- if SandboxVars.AnthroTraits.AT_AnthroImmunityBiteGetsRegularInfectionOnDefense
                            -- then
                                -- bodypart:setInfectedWound(true);
                                -- if getDebug()
                                -- then
                                    -- print("Knox infection substituted with regular infection. Human mouths are septic :S");
                                -- end

                            -- end
                            -- return false;
                        -- else
                            -- if getDebug()
                            -- then
                                -- print("Infection defense UNSUCCESSFUL. DIE WELL!");
                            -- end
                            -- return true;
                        -- end
                    -- elseif bodypart:isCut() --irritatingly, using the function to get laceration doesn't follow the same naming convention
                    -- then
                        -- if lacerationInfectionChance <= rolledInfectionChance 
                        -- then
                            -- bodypart:SetInfected(false);
                            -- player:getBodyDamage():setInfected(false);
                            -- player:getBodyDamage():setInfectionMortalityDuration(-1);
                            -- player:getBodyDamage():setInfectionTime(-1);
                            -- player:getBodyDamage():setInfectionLevel(0);
                            -- player:getBodyDamage():setInfectionGrowthRate(0);
                            -- if getDebug()
                            -- then
                                -- print("Infection defense successful.");
                            -- end
                            -- return false;
                        -- else
                            -- if getDebug()
                            -- then
                                -- print("Infection defense UNSUCCESSFUL. DIE WELL!");
                            -- end
                            -- return true;
                        -- end
                    -- elseif bodypart:scratched() 
                    -- then
                        -- if scratchInfectionChance <= rolledInfectionChance 
                        -- then
                            -- bodypart:SetInfected(false);
                            -- player:getBodyDamage():setInfected(false);
                            -- player:getBodyDamage():setInfectionMortalityDuration(-1);
                            -- player:getBodyDamage():setInfectionTime(-1);
                            -- player:getBodyDamage():setInfectionLevel(0);
                            -- player:getBodyDamage():setInfectionGrowthRate(0);
                            -- if getDebug()
                            -- then
                                -- print("Infection defense successful.");
                            -- end
                            -- return false;
                        -- else
                            -- if getDebug()
                            -- then
                                -- print("Infection defense UNSUCCESSFUL. DIE WELL!");
                            -- end
                            -- return true;
                        -- end
                    -- end
                -- else
                    -- if getDebug()
                    -- then
                        -- print("Not applying Anthro Immunity to infection from anthro. DIE WELL!")
                    -- end    
                -- end    
            -- end 
        -- end
    -- end
-- end



AnthroTraitsMain.ApplyFoodChanges = function(character, foodEaten, percentEaten)
    local foodChanges = ATU.CalculateFoodChanges(character, foodEaten)
    local charStats = character:getStats()
    local charNutrition = character:getNutrition()

    if foodChanges.addHungerChange ~= 0
    then
        charStats:set(CharacterStat.HUNGER, charStats:get(CharacterStat.HUNGER) + (foodChanges.addHungerChange * percentEaten));
    end
    if foodChanges.addThirstChange ~= 0
    then
        charStats:set(CharacterStat.THIRST, charStats:get(CharacterStat.THIRST) + (foodChanges.addThirstChange * percentEaten));
    end
    if foodChanges.addEndChange ~= 0
    then
        charStats:set(CharacterStat.ENDURANCE, charStats:get(CharacterStat.ENDURANCE) + (foodChanges.addEndChange * percentEaten));
    end
    if foodChanges.addStressChange ~= 0
    then
        charStats:set(CharacterStat.STRESS, charStats:get(CharacterStat.STRESS) + (foodChanges.addStressChange * percentEaten));
    end
    if foodChanges.addBoredomChange ~= 0
    then
        charStats:set(CharacterStat.BOREDOM, charStats:get(CharacterStat.BOREDOM) + (foodChanges.addBoredomChange * percentEaten));
    end
    if foodChanges.addUnhappyChange ~= 0
    then
        charStats:set(CharacterStat.UNHAPPINESS, charStats:get(CharacterStat.UNHAPPINESS) + (foodChanges.addUnhappyChange * percentEaten));
    end
    if foodChanges.addCalories ~= 0
    then
        charNutrition:setCalories(charNutrition:getCalories() + (foodChanges.addCalories * percentEaten));
    end
    if foodChanges.addPoison ~= 0
    then
        charStats:set(CharacterStat.POISON, charStats:get(CharacterStat.POISON) + (foodChanges.addPoison * percentEaten));
        --b42 specific. Won't trigger dmg unless sick moodle = lvl 1 or up.
		charStats:set(CharacterStat.FOOD_SICKNESS, 55)
    end
end


AnthroTraitsMain.ApplyAfterEatFoodChanges = function(character, foodEaten, percentEaten, prevPoisonLvl)
	local ATGt = AnthroTraitsGlobals.CharacterTrait
    --local charBodyDmg = character:getBodyDamage()

    if foodEaten:hasTag(AnthroTraitsGlobals.FoodTags.CARNIVORE)
    then
        if (character:hasTrait(ATGt.CARNIVORE) or character:hasTrait(ATGt.CARRIONEATER)) and not foodEaten:isRotten()
        then
            if instanceof(character, "IsoPlayer") and not foodEaten:isPoison()
            then
                character:getModData().ATPlayerData.undoAddedPoison = true;
                character:getModData().ATPlayerData.beforeEatPoisonLvl = prevPoisonLvl;
            end
        elseif foodEaten:isRotten() and character:hasTrait(ATGt.CARRIONEATER)
        then
            if instanceof(character, "IsoPlayer") and not foodEaten:isPoison()
            then
                character:getModData().ATPlayerData.undoAddedPoison = true;
                character:getModData().ATPlayerData.beforeEatPoisonLvl = prevPoisonLvl;
            end
        end
    elseif foodEaten:hasTag(AnthroTraitsGlobals.FoodTags.HERBIVORE)
    then
        if character:hasTrait(ATGt.HERBIVORE)
        then
            if not foodEaten:isRotten()
            then
                if instanceof(character, "IsoPlayer") and not foodEaten:isPoison()
                then
                    character:getModData().ATPlayerData.undoAddedPoison = true;
                    character:getModData().ATPlayerData.beforeEatPoisonLvl = prevPoisonLvl;
                end
            end
        end
    end
end

AnthroTraitsMain.ExclaimerCheck = function(player)
	local ATGt = AnthroTraitsGlobals.CharacterTrait
    local moodles = player:getMoodles();
    local panicLevel = moodles:getMoodleLevel(MoodleType.PANIC)
    local thresholdMultiplier = SandboxVars.AnthroTraits.AT_ExclaimerExclaimThresholdMultiplier;

    local exclaimChance = ZombRand(1,100);

    if (exclaimChance <= (panicLevel * thresholdMultiplier)) and panicLevel > 1
    then
        local phrases = nil
		-- check if any trait-related phrases available
		for trait, phr in pairs(ATU.ExclaimPhrases) do
			if player:hasTrait(trait)
			then
				phrases = phr
				break
			end
		end
		-- otherwise use generic phrases
		if phrases == nil
		then
			phrases = ATU.GenericExclaimPhrases
		end
		local phraseChance = ZombRand(1, #phrases);
        local playerSquare = player:getCurrentSquare();
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
                    if ZombRand(0,1) >= stinkyCommentChance and playerInQuestion:DistTo(player) < stinkyLoudness and playerInQuestion:getMoodles():getMoodleLevel(MoodleType.Pain) < 2 and playerInQuestion:getMoodles():getMoodleLevel(MoodleType.Panic) < 1
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

AnthroTraitsMain.CarryWeightUpdate = function(player)
	local ATGt = AnthroTraitsGlobals.CharacterTrait
    local strength = player:getPerkLevel(Perks.Strength);
    --local traits = player:getTraits();
    local baseWeightChanged = false;
    local defaultMaxWeightBase = 8;

    local newMaxWeightBase = defaultMaxWeightBase;
    if getDebug()
    then
        --print(string.format("Base: %f", newMaxWeightBase));
    end
    -- if getActivatedMods():contains("\\ToadTraits")
    -- then
        -- local MTGlobalMod = SandboxVars.MoreTraits.WeightGlobalMod or 0;
        -- local MTPackMuleBonus = SandboxVars.MoreTraits.WeightPackMule or 2;
        -- local MTPackMouseMalus = SandboxVars.MoreTraits.WeightPackMouse or -2;
        -- local MTDefaultWeight = SandboxVars.MoreTraits.WeightDefault or 8;

        -- defaultMaxWeightBase = MTDefaultWeight;

        -- MTPackMuleBonus = MTPackMuleBonus + math.floor(strength / 5) + MTGlobalMod;
        -- MTPackMouseMalus = MTPackMouseMalus + MTGlobalMod;
        
        -- if player:hasTrait(CharacterTrait.get(ResourceLocation.of("packmule")))
        -- then
            -- baseWeightChanged = true;
            -- newMaxWeightBase =  MTDefaultWeight + MTPackMuleBonus;
            -- if getDebug()
            -- then
                -- print(string.format("packmule: %f", newMaxWeightBase));
            -- end    
        -- elseif player:hasTrait(CharacterTrait.get(ResourceLocation.of("packmouse")))
        -- then
            -- baseWeightChanged = true;
            -- newMaxWeightBase =  MTDefaultWeight + MTPackMouseMalus;
            -- if getDebug()
            -- then
                -- print(string.format("packmouse: %f", newMaxWeightBase));
            -- end    
        -- end
    -- end
    if (getActivatedMods():contains("\\MoreSimpleTraits") 
    or getActivatedMods():contains("\\MoreSimpleTraitsVanilla")
    or getActivatedMods():contains("\\SimpleOverhaulTraitsAndOccupations"))
    then
        local SOTOStrongBackBonus =  2;
        local SOTOWeakBackMalus = -1;
        if player:hasTrait(CharacterTrait.get(ResourceLocation.of("SOTO:StrongBack"))) or player:hasTrait(CharacterTrait.get(ResourceLocation.of("SOTO:StrongBack2")))
        then
            baseWeightChanged = true;
            newMaxWeightBase = newMaxWeightBase + SOTOStrongBackBonus;
            if getDebug()
            then
                print(string.format("StrongBack: %f", newMaxWeightBase));
            end    
        elseif player:hasTrait(CharacterTrait.get(ResourceLocation.of("SOTO:WeakBack")))
        then
            baseWeightChanged = true;
            newMaxWeightBase = newMaxWeightBase + SOTOWeakBackMalus;
            if getDebug()
            then
                print(string.format("WeakBack: %f", newMaxWeightBase));
            end    
        end
    end
    -- if getActivatedMods():contains("\\DracoExpandedTraits")
    -- then
        -- local DracoHoarderPctIncrease = .25;
    -- if player:hasTrait(CharacterTrait.get(ResourceLocation.of("Hoarder")))
        -- then
            -- baseWeightChanged = true;
            -- local hBonus = (math.floor(newMaxWeightBase *  DracoHoarderPctIncrease));
            -- newMaxWeightBase = newMaxWeightBase + hBonus;
            -- if getDebug()
            -- then
                -- print(string.format("Hoarder: %f", newMaxWeightBase));
            -- end    
        -- end
    -- end
    local BobPctIncrease = SandboxVars.AnthroTraits.AT_BeastOfBurdenPctIncrease;
    if player:hasTrait(ATGt.BEASTOFBURDEN)
    then
        baseWeightChanged = true;
        local bobBonus = (math.floor(newMaxWeightBase * BobPctIncrease));
        newMaxWeightBase = newMaxWeightBase + bobBonus;
        if getDebug()
        then
            print(string.format("BOB: %f", newMaxWeightBase));
        end    
    end
    if baseWeightChanged
    then
        --max weight is 50 due to java cap. BASE must be calculated to be slightly less than 50 to allow for hunger bonuses.
        -- 18 here is more or less the equivalent of 50 in max weight i guess. Base weight is weird af.
        if newMaxWeightBase > 18
        then
            newMaxWeightBase = 18
        end
        player:setMaxWeightBase(newMaxWeightBase)
    else
        if getActivatedMods():contains("\\ToadTraits")
        then
            player:setMaxWeightBase(defaultMaxWeightBase + (SandboxVars.MoreTraits.WeightGlobalMod or 0));
        else
            player:setMaxWeightBase(defaultMaxWeightBase);
        end
        
    end
end

--EVENT HANDLERS

AnthroTraitsMain.ATInitPlayerData = function(player)

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


AnthroTraitsMain.ATOnInitWorld = function()
    ATU.AddItemTagToItemsFromSandbox(SandboxVars.AnthroTraits.AT_CarnivoreItems, AnthroTraitsGlobals.FoodTags.CARNIVORE);
    ATU.AddItemTagToItemsFromSandbox(SandboxVars.AnthroTraits.AT_HerbivoreItems, AnthroTraitsGlobals.FoodTags.HERBIVORE);
    ATU.AddItemTagToItemsFromSandbox(SandboxVars.AnthroTraits.AT_Bug_o_ssieurItems, AnthroTraitsGlobals.FoodTags.INSECT);
    ATU.AddItemTagToItemsFromSandbox(SandboxVars.AnthroTraits.AT_FeralDigestionItems, AnthroTraitsGlobals.FoodTags.FERALPOISON);

    if getDebug()
    then
        ATU.ExportFoodGuideFiles();
    end

    Colors["LavenderBlush"] = Color.new(1, 229/255, 229/255, 1);

end


-- AnthroTraitsMain.ATPlayerDamageTick = function(player, damageType, damage)
	-- local ATGt = AnthroTraitsGlobals.CharacterTrait
    -- local ATM = AnthroTraitsMain;
	-- print("AT Damage tick check")

    -- if player:isZombie()
    -- then
        -- return
    -- end

    -- local playerData = player:getModData().ATPlayerData;

    -- if player:getBodyDamage():isInfected() == true and playerData.trulyInfected == false
    -- then
        -- if getDebug()
        -- then
            -- print("Handle Infection about to be triggered");
        -- end
        -- playerData.trulyInfected = ATM.HandleInfection(player);
    -- end

    -- if player:hasTrait(ATGt.UNGULIGRADE)
    -- then
        -- --immune to scratches, lacerations, bites
        -- local footL = player:getBodyDamage():getBodyPart(BodyPartType.Foot_L);
        -- local footR = player:getBodyDamage():getBodyPart(BodyPartType.Foot_R);

        -- if footL:scratched()
        -- then
			-- print("AT_Unguligrade removing foot L damage")
            -- --casing is inconsistent in the game >:C
			-- footL:setScratched(false, true);
            -- footL:setScratchTime(0);
            -- footL:SetScratchedWeapon(false);
            -- footL:setBleedingTime(0);
            -- footL:setBleeding(false);
        -- end
        -- if footR:scratched()
        -- then
			-- print("AT_Unguligrade removing foot R damage")
			-- footR:setScratched(false, true);
            -- footR:setScratchTime(0);
            -- footR:SetScratchedWeapon(false);
            -- footR:setBleedingTime(0);
            -- footR:setBleeding(false);
        -- end
        -- if footL:isCut()
        -- then
            -- footL:setCutTime(0);
            -- footL:setCut(false, false);
            -- footL:setBleedingTime(0);
            -- footL:setBleeding(false);
        -- end
        -- if footR:isCut()
        -- then
            -- footR:setCutTime(0);
            -- footR:setCut(false, false);
            -- footR:setBleedingTime(0);
            -- footR:setBleeding(false);

        -- end
        -- if footL:bitten()
        -- then
            -- --casing is inconsistent in the game >:C
            -- footL:setBiteTime(0);
            -- footL:SetBitten(false, false);
            -- footL:setBleedingTime(0);
            -- footL:setBleeding(false);
        -- end
        -- if footR:bitten()
        -- then
            -- footR:setBiteTime(0);
            -- footR:SetBitten(false, false);
            -- footR:setBleedingTime(0);
            -- footR:setBleeding(false);

        -- end

    -- end
    -- if player:hasTrait(ATGt.DIGITIGRADE)
    -- then
        -- --immune to scratches, lacerations, bites
        -- local footL = player:getBodyDamage():getBodyPart(BodyPartType.Foot_L);
        -- local footR = player:getBodyDamage():getBodyPart(BodyPartType.Foot_R);

        -- if footL:scratched()
        -- then
            -- --casing is inconsistent in the game >:C
            -- footL:setScratchTime(0);
            -- footL:SetScratchedWeapon(false);
            -- footL:setBleedingTime(0);
            -- footL:setBleeding(false);
        -- end
        -- if footR:scratched()
        -- then
            -- footR:setScratchTime(0);
            -- footR:SetScratchedWeapon(false);
            -- footR:setBleedingTime(0);
            -- footR:setBleeding(false);
        -- end
    -- end
-- end


AnthroTraitsMain.ATOnCharacterCollide = function(collider, collidee)
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
            print("ATOnCharacterCollide Triggered");
        end
--        if not collidee:isKnockedDown() and collider:hasTrait(ATGt.BULLRUSH) and collider:isSprinting() and collider:getBeenSprintingFor() >= 10
--        then
            -- if getDebug()
            -- then
                -- print("collidee: "..tostring(collidee));
                -- print("colliderBehindCollidee: "..tostring(colliderBehindCollidee));
                -- print("Is Sprinting: "..tostring(collider:isSprinting()));
                -- print("getBeenSprintingFor(): "..tostring(collider:getBeenSprintingFor()));
                -- print("Tripping: "..tostring(collider:getStats():isTripping()));
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
                    print("Player bump/trip prevented by Tail trait. Rolled Chance:"..rolledChance);
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
                print("Player bump/trip prevented by Tail trait during minute grace period.");
            end
        end
    end
end


AnthroTraitsMain.ATEveryWeaponHitChar = function(attacker, target, weapon, damage)
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
            print(string.format("Applying %s extra damage.", dmgBonus));
        end
    end
end

AnthroTraitsMain.ATOnObjectCollide = function(collider, collidee)
	local ATGt = AnthroTraitsGlobals.CharacterTrait
    if instanceof(collider, "IsoPlayer") and not collider:isZombie() and collider:isLocalPlayer()
    then
        local modData = collider:getModData().ATPlayerData;
        if getDebug()
        then
            print("ATOnObjectCollide Triggered");
            print("Object: "..type(collidee));
            print("collider: "..type(collider));
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
                    print("Player bump/trip prevented by Tail trait. Rolled Chance:"..rolledChance);
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
                print("Player bump/trip prevented by Tail trait during minute grace period.");
            end
        end
    end
end


AnthroTraitsMain.ATEveryOneMinute = function()
	local ATGt = AnthroTraitsGlobals.CharacterTrait
    local ATM = AnthroTraitsMain;
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
                        print("trulyInfected set to false. Anthro Immunity applies again.");
                    end
                end

                if player:hasTrait(ATGt.EXCLAIMER)
                then
                    ATM.ExclaimerCheck(player);
                end
                if player:hasTrait(ATGt.STINKY)
                then
                    ATM.BeStinky(player);
                end
                modData.canTripChecked = false;
                modData.tripSafe = false;
                ATM.CarryWeightUpdate(player);
            end
        end
    end
end

AnthroTraitsMain.ATEveryHours = function()
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
                    player:getBodyDamage():setUnhappynessLevel(player:getBodyDamage():getUnhappynessLevel() + SandboxVars.AnthroTraits.AT_LonelyHourlyUnhappyIncrease);
                end
            end
        --end
    end
end


AnthroTraitsMain.ATEveryDays = function()
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


AnthroTraitsMain.ATPlayerUpdate = function(player)
	local ATGt = AnthroTraitsGlobals.CharacterTrait
    local ATM = AnthroTraitsMain;
    local fallTimeMult = SandboxVars.AnthroTraits.AT_NaturalTumblerFallTimeMult;
    local modData =  player:getModData().ATPlayerData;
    local beforeFallSpeed = modData.oldFallSpeed;
    local endurance = player:getStats():getLastEndurance();
    local rolledChance = ZombRand(0,100);
    if player:hasTrait(ATGt.TORPOR) and modData.torporActive == true
    then
        if endurance > (1.0 - SandboxVars.AnthroTraits.AT_TorporEnduranceDecrease)
        then
            player:getStats():setEndurance(1.0 - SandboxVars.AnthroTraits.AT_TorporEnduranceDecrease);
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
    ATM.LonelyUpdate(player);
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


Events.OnLoad.Add(AnthroTraitsMain.ATInitPlayerData);
Events.OnInitWorld.Add(AnthroTraitsMain.ATOnInitWorld);
Events.OnCreateLivingCharacter.Add(AnthroTraitsMain.ATInitPlayerData)
--[[Events.OnClientCommand.Add(AnthroTraitsMain.ATOnClientCommand)
Events.OnServerCommand.Add(AnthroTraitsMain.ATOnServerCommand)]]
--Events.OnClothingUpdated.Add(AnthroTraitsMain.ATOnClothingUpdated);
Events.OnObjectCollide.Add(AnthroTraitsMain.ATOnObjectCollide);
Events.OnCharacterCollide.Add(AnthroTraitsMain.ATOnCharacterCollide);
Events.OnWeaponHitCharacter.Add(AnthroTraitsMain.ATEveryWeaponHitChar);
Events.EveryDays.Add(AnthroTraitsMain.ATEveryDays);
Events.EveryHours.Add(AnthroTraitsMain.ATEveryHours);
Events.EveryOneMinute.Add(AnthroTraitsMain.ATEveryOneMinute);
--Events.OnPlayerGetDamage.Add(AnthroTraitsMain.ATPlayerDamageTick); --moved to server
Events.OnPlayerUpdate.Add(AnthroTraitsMain.ATPlayerUpdate);




return AnthroTraitsMain;