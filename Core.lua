local t = {
	SetUnitAura = UnitAura,
	SetUnitBuff = UnitBuff,
	SetUnitDebuff = UnitDebuff,
}

for k,v in pairs(t) do
	hooksecurefunc(GameTooltip, k, function( self, unit, index, filter )
		local a = {UnitAura(unit, index, filter)}
		if a[11] then
			for i = 1, C_MountJournal.GetNumMounts() do
				local creatureName, spellID, icon, active, isUsable, sourceType, isFavorite, isFactionSpecific, faction, hideOnChar, isCollected, mountID = C_MountJournal.GetDisplayedMountInfo(i)
				if spellID == a[11] then
					local creatureDisplayID, descriptionText, sourceText, isSelfMount = C_MountJournal.GetMountInfoExtraByID(mountID)
					self:AddLine("\n|cffA3C3F0MountInfo|r (SpellID: "..spellID..")", 1, 1, 1)
					if isCollected then
						self:AddLine(COLLECTED, RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b)
					else
						self:AddLine(NOT_COLLECTED, GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b)
					end
					self:AddLine(sourceText, 1, 1, 1)
					self:Show()
				end
			end
		end
	end)
end
