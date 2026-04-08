--NOTE: while TimedActions are apparently only executed on client, they are still in the shared folder. Therefore, moved this code to shared folder as well in case server might access maxTime for some reason

require "TimedActions/ISBaseTimedAction"

-- NOTE: overwriting create() didn't seem to work since after the original create(), the game probably already called getDuration() to get the required time
-- instead, adjustMaxTime() is called first thing in create()
local originalAdjustMaxTime = ISBaseTimedAction.adjustMaxTime;
ISBaseTimedAction.adjustMaxTime = function(self, maxTime)
    local maxTime = originalAdjustMaxTime(self, maxTime);
    -- maxTime -1 seems to hold special meaning, maxTime 1 is used for instant actions
    if maxTime > 1 and self.character:hasTrait(AnthroTraitsGlobals.CharacterTrait.UNWIELDYHANDS) then
        for i = 1, #AnthroTraitsGlobals.UnwieldyHandsAffectedTimedActions do
            if self.Type == AnthroTraitsGlobals.UnwieldyHandsAffectedTimedActions[i] then
                local newTime = maxTime * (1 + SandboxVars.AnthroTraits.AT_UnwieldyHandsTimeIncrease);
                DebugLog.log("AT UnwieldyHands activated. Old time: "..tostring(maxTime).." New time: "..tostring(newTime));
                maxTime = newTime;
                break;
            end
        end
    end
    return maxTime;
end

