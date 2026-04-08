local ATU = require "AnthroTraitsUtilities"

local function initAnthroTraits()
    ATU.ImportExclaimerPhrases();
end

Events.OnGameBoot.Add(initAnthroTraits);
