require "Foraging/forageSystem";
-- see vanilla lua/shared/Foraging/forageSystem.lua for more info

--NOTE: not sure if we can use Sandboxvars here. The forageSystem might initialise before the Sandboxvars are configured by the user.
--NOTE2: apparently these values don't actually improve spawn rates but rather how good the player is at detecting/identifying them >.<
local function generateAT_FoodTraitDefs(forageSystem)
	local traits = {
		AT_Carnivore = 
		{
			name                    = "AnthroTraits:AT_Carnivore",
			type                    = "trait",
			visionBonus             = 0,
			weatherEffect           = 0,
			darknessEffect          = 0,
			specialisations         = {
				["DeadAnimals"]     = 30,
			},
		},
		AT_CarrionEater = 
		{
			name                    = "AnthroTraits:AT_CarrionEater",
			type                    = "trait",
			visionBonus             = 0,
			weatherEffect           = 0,
			darknessEffect          = 0,
			specialisations         = {
				["DeadAnimals"]     = 50,
			},
		},
		AT_Herbivore = 
		{
			name                    = "AnthroTraits:AT_Herbivore",
			type                    = "trait",
			visionBonus             = 0,
			weatherEffect           = 0,
			darknessEffect          = 0,
			specialisations         = {
				["Vegetables"]      = 30,
			},
		},
		AT_Bug_o_ssieur = 
		{
			name                    = "AnthroTraits:AT_Bug_o_ssieur",
			type                    = "trait",
			visionBonus             = 0,
			weatherEffect           = 0,
			darknessEffect          = 0,
			specialisations         = {
				["Insects"]     	= 30,
			},
		},
	};
	for _, def in ipairs(traits) do
		forageSystem.addSkillDef(def);
	end
end

Events.preAddSkillDefs.Add(generateAT_FoodTraitDefs)
