local ATShU = require "AnthroTraitsSharedUtilities"
--NOTE: following UCWF_server_excample.lua in the "Unified Carry Weight Framework" by MusicManiac

-- optional integration of UCWF
if not getActivatedMods():contains("UnifiedCarryWeightFramework") then
	return;
end

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

UnifiedCarryWeightFramework.registerBaseModifier({
	id = "AnthroTraits.CarryWeightChangingTraits",
	resolve = function(ctx)
        return { mult = ATShU.calcCarryWeightMultiplier(ctx.player) };
	end,
})

-- Framework by default calculates carry weight on character load and every hour afterwards. But what happens if you need to recalculate carry weight from your side? You can just call the recomputeAll function and pass in the player object, and it will recalculate carry weight applying all modifiers in the correct order.
