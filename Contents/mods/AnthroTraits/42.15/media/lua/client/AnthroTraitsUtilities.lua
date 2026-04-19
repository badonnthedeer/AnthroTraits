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
-- REFERENCES: Named Literature (Chuckleberry Finn)
-- Did this code help you write your own mod? Consider donating to me at https://ko-fi.com/badonnthedeer!
-- I'm in financial need and every little bit helps!!
--
-- Have a problem or question? Reach me on Discord: badonn
------------------------------------------------------------------------------------------------------

local ATShU = require "AnthroTraitsSharedUtilities"

local function Sign(number)
	return (number > 0 and 1) or (number == 0 and 0) or -1
end

local AnthroTraitsUtilities = {}
-- fallback exclaimer phrases
AnthroTraitsUtilities.GenericExclaimPhrases = {"AAAH!", "AAAH!", "AAAH!!", "AEIEEEE!", "EAAH!", "AAAGH!"}
AnthroTraitsUtilities.ExclaimPhrases = { }
-- moved to AT_ExclaimerPhrases.txt: allows defining phrases for any trait
--yeen = {"HAHAHAHAHA!", "HAHAHAHAHA!", "HAHAHAHAHA!!", "HUHEHEHEHAHA!", "HAAAAH!", "HEEEHEEEHAHAHAHA!"},
--avian = { "!!♩♪-♩♪-♩♪!!", "!!♫♩♪-♫♩♪!!", "!!♪♫♩-♪♫♩!!", "!!♫♫♩♫!!" } sadly these symbols don't work in-game :(

--UTILITIES
AnthroTraitsUtilities.FileExists = function(path)
    local reader = getModFileReader(AnthroTraitsGlobals.ModID, path, false);
    if not reader
    then
        return false
    else
        reader:close();
        return true
    end
end

AnthroTraitsUtilities.ImportExclaimerPhrases = function()
    for trait, name in pairs(AnthroTraitsGlobals.ExclaimerTraits) do
        local line = getTextOrNull("IGUI_ExclaimerPhrases_" .. name)
        if line then
            local phrases = { }
            ATShU.splitSemicolonListString(line, function(word) table.insert(phrases, word); end);
            if #phrases > 0 then
                AnthroTraitsUtilities.ExclaimPhrases[trait] = phrases
            end
        end
    end
end

local function writeToGuideFile(items, file)
    local writer = getModFileWriter(AnthroTraitsGlobals.ModID, file, false, false);
    if not writer then
        return;
    end
    for i = 0, items:size() -1
    do
        local line = items:get(i):getFullName()..";";
        writer:writeln(line);
    end
    writer:close();
end

AnthroTraitsUtilities.ExportFoodGuideFiles = function()

    local allItems = getScriptManager():getAllItems();
    local unusedFood = {};

    local CarnItems = getScriptManager():getItemsTag(AnthroTraitsGlobals.FoodTags.CARNIVORE);
    local HerbItems = getScriptManager():getItemsTag(AnthroTraitsGlobals.FoodTags.HERBIVORE);
    local BugItems = getScriptManager():getItemsTag(AnthroTraitsGlobals.FoodTags.INSECT);
    local PoisItems = getScriptManager():getItemsTag(AnthroTraitsGlobals.FoodTags.FERALPOISON);

    for i = 0, allItems:size() -1
    do
        local foundItem = allItems:get(i);
        if foundItem:getItemType() == ItemType.FOOD --(foundItem:getDisplayCategory() == "Food" or foundItem:getItemType() == ItemType.FOOD)
        then
            if CarnItems:contains(foundItem)
            then
            elseif HerbItems:contains(foundItem)
            then
            elseif BugItems:contains(foundItem)
            then
            elseif PoisItems:contains(foundItem)
            then
            else
                table.insert(unusedFood, foundItem);
            end
        end
    end
    writeToGuideFile(CarnItems, "AT_Carnivore_Items.txt");
    writeToGuideFile(HerbItems, "AT_Herbivore_Items.txt");
    writeToGuideFile(BugItems, "AT_Insect_Items.txt");
    writeToGuideFile(PoisItems, "AT_FeralPoison_Items.txt");

    local writer = getModFileWriter(AnthroTraitsGlobals.ModID, "Unused_Food_Items.txt", false, false);
    if writer then
        for _, tableEntry in ipairs(unusedFood)
        do
            local line = tableEntry:getFullName()..";";
            writer:writeln(line);
        end;
        writer:close();
    end
end


-- AnthroTraitsUtilities.IsAnthro = function(gameCharacter)
    -- -- if (getActivatedMods():contains("\\FurryMod") or getActivatedMods():contains("\\FurryApocalypse")) and gameCharacter ~= nil
    -- -- then
        -- -- local hasFur = false;
        -- -- local itemVisuals = gameCharacter:getItemVisuals();
        -- -- if itemVisuals ~= nil
        -- -- then
            -- -- for i=0, itemVisuals:size() - 1
            -- -- do
                -- -- local itemVisual = itemVisuals:get(i);
                -- -- local item =  itemVisual:getScriptItem();
                -- -- if item ~= nil and (item:hasTag("Fur") or item:hasTag("DeceasedFur"))
                -- -- then
                    -- -- hasFur = true;
                    -- -- break;
                -- -- end
            -- -- end;
        -- -- end 
        -- -- return hasFur;
    -- -- else
        -- -- return false;
    -- -- end
	
	-- return false
-- end

return AnthroTraitsUtilities;