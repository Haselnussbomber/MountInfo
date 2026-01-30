hooksecurefunc(GameTooltip, "SetUnitBuffByAuraInstanceID", function(self, unit, auraInstanceID)
	local auraData = C_UnitAuras.GetAuraDataByAuraInstanceID(unit, auraInstanceID);
	if (auraData == nil or issecretvalue(auraData)) then
		return;
	end

	local mountId = C_MountJournal.GetMountFromSpell(auraData.spellId);
	if (mountId == nil or issecretvalue(mountId)) then
		return;
	end

	self:AddLine("\n|cffA3C3F0MountInfo|r", 1, 1, 1);

	local isCollected = select(11, C_MountJournal.GetMountInfoByID(mountId));
	if (isCollected) then
		self:AddLine(COLLECTED, GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b);
	else
		self:AddLine(NOT_COLLECTED, RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b);
	end

	local sourceText = select(3, C_MountJournal.GetMountInfoExtraByID(mountId));
	sourceText = sourceText:gsub("|n$", ""):gsub("|n$", "");
	if (sourceText ~= nil and sourceText ~= "") then
		self:AddLine(sourceText, 1, 1, 1);
	end

	self:Show();
end);
