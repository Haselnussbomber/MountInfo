local function processTooltip(self, spellID)
	local mountIDs = C_MountJournal.GetMountIDs();
	for _, mountID in ipairs(mountIDs) do
		local _, mountSpellID, _, _, _, _, _, _, _, _, isCollected = C_MountJournal.GetMountInfoByID(mountID);
		if (mountSpellID == spellID) then
			self:AddLine("\n|cffA3C3F0MountInfo|r", 1, 1, 1);

			if (isCollected) then
				self:AddLine(COLLECTED, GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b);
			else
				self:AddLine(NOT_COLLECTED, RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b);
			end

			local _, _, sourceText = C_MountJournal.GetMountInfoExtraByID(mountID);
			sourceText = sourceText:gsub("|n$", ""):gsub("|n$", "");
			if (sourceText ~= nil and sourceText ~= "") then
				self:AddLine(sourceText, 1, 1, 1);
			end

			self:Show();
			break;
		end
	end
end

local function hook(self, unit, index, filter)
	local buffSpellID = select(10, UnitAura(unit, index, filter));
	if (not buffSpellID) then
		return;
	end
	processTooltip(self, buffSpellID);
end

hooksecurefunc(GameTooltip, "SetUnitAura", hook);
hooksecurefunc(GameTooltip, "SetUnitBuff", hook);
hooksecurefunc(GameTooltip, "SetUnitDebuff", hook);

local function hookInstance(self, unit, auraInstanceID)
	local aura = C_UnitAuras.GetAuraDataByAuraInstanceID(unit, auraInstanceID);
	if (not aura or not aura.spellId) then
		return;
	end
	processTooltip(self, aura.spellId);
end

hooksecurefunc(GameTooltip, "SetUnitBuffByAuraInstanceID", hookInstance);
hooksecurefunc(GameTooltip, "SetUnitDebuffByAuraInstanceID", hookInstance);
