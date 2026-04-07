
local originalCreateIconsForZone = ISSearchManager.createIconsForZone;

-- need to temporarily save the current player so the forageSystem (adjusted by AT) can change spawn rates depending on player traits
function ISSearchManager:createIconsForZone(_zoneData, _recreate)
    forageSystem.AT_CallingPlayerIndex = self.player;
    originalCreateIconsForZone(self, _zoneData, _recreate);
end