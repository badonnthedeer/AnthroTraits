--NOTE: following UCWF_server_excample.lua in the "Unified Carry Weight Framework" by MusicManiac

local function gameMode()
	if not isClient() and not isServer() then
		return "SP"
	elseif isClient() then
		return "MP_Client"
	end
	return "MP_Server"
end

local gameMode = gameMode()

if gameMode == "MP_Client" then
	return
end

require("UnifiedCarryWeightFramework")

UnifiedCarryWeightFramework.registerMaxModifier({
	id = "AnthroTraits.CarryWeightChangingTraits",

	resolve = function(ctx)
		local player = ctx.player -- context will always have player object so you should access it from there.
        local res = {}

		if player:hasTrait(AnthroTraitsGlobals.CharacterTrait.BEASTOFBURDEN) then
            res.mult = SandboxVars.AnthroTraits.AT_BeastOfBurdenPctIncrease;
        end
        if player:hasTrait(AnthroTraitsGlobals.CharacterTrait.DIGITIGRADE) then
            res.mult = (res.mult or 0) - SandboxVars.AnthroTraits.AT_DigitigradeCarryWeightMalus;
        elseif player:hasTrait(AnthroTraitsGlobals.CharacterTrait.UNGULIGRADE) then
            res.mult = (res.mult or 0) - SandboxVars.AnthroTraits.AT_UnguligradeCarryWeightMalus;
        end
        if res.mult then
            res.mult = res.mult + 1;
        end
		return res;
	end,
})

-- Framework by default calculates carry weight on character load and every hour afterwards. But what happens if you need to recalculate carry weight from your side? You can just call the recomputeAll function and pass in the player object, and it will recalculate carry weight applying all modifiers in the correct order.
