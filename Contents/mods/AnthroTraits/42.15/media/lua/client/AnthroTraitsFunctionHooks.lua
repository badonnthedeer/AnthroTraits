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

local function startsWith(str, prefix, caseInsensitive)
	local prefixLen = string.len(prefix);
	if string.len(str) < prefixLen then
		return false;
	end
	local start = string.sub(str, 1, string.len(prefix));
	local prefixComp = prefix;
	if caseInsensitive then
		return string.lower(start) == string.lower(prefix);
	end
	return start == prefix;
end

-- gets sandbox var via case insensitive search from trait definition

local function GetSandboxVarsTrait(traitDef, addString)
	local locID = Registries.CHARACTER_TRAIT:getLocation(traitDef:getType())
	local optionName;
	-- special case for animal voice traits (shouldn't have a separate cost variable for each)
	if startsWith(locID:getPath(), "AT_Voice", true) then
		optionName = string.lower("AT_VoiceAnimal" .. addString)
	else
		optionName = string.lower(locID:getPath() .. addString)
	end
	for k,v in pairs(SandboxVars.AnthroTraits) do
		if string.lower(k) == optionName
		then
			return v
		end
	end
	return nil
end

local ATM = require("AnthroTraitsMain");
local ATC = require("NPCs/AnthroTraitsCreationMethods");
local ATU = require("AnthroTraitsUtilities");


--Cost modifier

local traitMetatable = __classmetatables[CharacterTraitDefinition.class].__index
local old_getCost = traitMetatable.getCost
---@param self Trait
traitMetatable.getCost = function(self)
	local cost = GetSandboxVarsTrait(self, "_Cost")
    if cost
	--if SandboxVars.AnthroTraits[self:getType():toString().."_Cost"] ~= nil
    then
		return cost
        --return SandboxVars.AnthroTraits[self:getType():toString().."_Cost"]
    else
        return old_getCost(self)
    end
end

local old_getRightLabel = traitMetatable.getRightLabel
---@param self Trait
traitMetatable.getRightLabel = function(self)
	local cost = GetSandboxVarsTrait(self, "_Cost")
	if cost
    --if SandboxVars.AnthroTraits[self:getType():toString().."_Cost"] ~= nil
    then
        --local cost = SandboxVars.AnthroTraits[self:getType():toString().."_Cost"];
        local label = "+"

        if cost > 0
        then
            label = "-"
        elseif cost == 0
        then
            label = ""
        end

        if cost < 0
        then
            cost = cost * -1
        end

        return label..cost

    else
        return old_getRightLabel(self)
    end
end

local oldSOSMD = SandboxOptionsScreen.onOptionMouseDown
SandboxOptionsScreen.onOptionMouseDown = function(...)
    ATC.refundSelectedAffectedTraits();
    oldSOSMD(...);
    ATC.setTraitDescriptions();
    ATC.sortTraits();
end
