local function hook(self, unit, index, filter)
	local buffSpellID = select(10, UnitAura(unit, index, filter));
	if (not buffSpellID) then
		return;
	end

	local mountIDs = C_MountJournal.GetMountIDs();
	for _, mountID in ipairs(mountIDs) do
		local _, spellID, _, _, _, _, _, _, _, _, isCollected = C_MountJournal.GetMountInfoByID(mountID);
		if (spellID == buffSpellID) then
			local _, _, sourceText = C_MountJournal.GetMountInfoExtraByID(mountID);
			self:AddLine("\n|cffA3C3F0MountInfo|r", 1, 1, 1);
			if (isCollected) then
				self:AddLine(COLLECTED, RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b);
			else
				self:AddLine(NOT_COLLECTED, GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b);
			end

			local _, _, sourceText = C_MountJournal.GetMountInfoExtraByID(mountID);
			sourceText = strtrim(sourceText);
			if (sourceText ~= nil and sourceText ~= "") then
				self:AddLine(sourceText, 1, 1, 1);
			end

			self:Show();
			break
		end
	end
end

hooksecurefunc(GameTooltip, "SetUnitAura", hook);
hooksecurefunc(GameTooltip, "SetUnitBuff", hook);
hooksecurefunc(GameTooltip, "SetUnitDebuff", hook);
