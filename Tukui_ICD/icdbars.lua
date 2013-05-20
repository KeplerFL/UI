local addon, T = ...;
local class = select(2, UnitClass("player"));
local active, fdata = {}, nil;
local UnitAura, GetTime, CreateFrame, CooldownFrame_SetTimer, GetInventoryItemID, GetItemIcon = UnitAura, GetTime, CreateFrame, CooldownFrame_SetTimer, GetInventoryItemID, GetItemIcon;
local pairs, tinsert, tremove = pairs, tinsert, tremove;

local icdb = CreateFrame("Frame", "icdb1", UIParent);
icdb:SetWidth(300);
icdb:SetHeight(20);
icdb:RegisterEvent("ADDON_LOADED");

local function t_insertifnotexists(t, val)
	for k, v in pairs(t) do
		if(v == val) then
			return false;
		end;
	end;

	tinsert(t, val);
	return true;
end;

local function t_removebyval(t, val)
	for k, v in pairs(t) do
		if(v == val) then
			tremove(t, k);
			return true;
		end;
	end;

	return false;
end;

local function t_contains(t, val)
	for k, v in pairs(t) do
		if(v == val) then
			return true;
		end;
	end;

	return false;
end;

local function updatepositions(f)
	local bar = nil;
	local active, fdata, dir = active, fdata, fdata.Direction;

	for i = 1, #active, 1 do
		bar = f.bars[active[i]];

		if(i == 1) then
			if(dir == "DOWN") then
				bar:SetPoint("TOP", f);
			elseif(dir == "UP") then
				bar:SetPoint("BOTTOM", f);
			elseif(dir == "LEFT") then
				bar:SetPoint("RIGHT", f);
			else
				bar:SetPoint("LEFT", f);
			end;
		else
			if(dir == "DOWN") then
				bar:SetPoint("TOP", f.bars[active[i - 1]], "BOTTOM", 0, -fdata.Margin);
			elseif(dir == "UP") then
				bar:SetPoint("BOTTOM", f.bars[active[i - 1]], "TOP", 0, fdata.Margin);
			elseif(dir == "LEFT") then
				bar:SetPoint("RIGHT", f.bars[active[i - 1]], "LEFT", -fdata.Margin, 0);
			else
				bar:SetPoint("LEFT", f.bars[active[i - 1]], "RIGHT", fdata.Margin, 0);
			end;
		end;

	end;
end;

local function OnUpdate(self, elapsed)
  self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;

  if(self.TimeSinceLastUpdate > 1) then
		local time = 0;

		if(self.duration > 0) then
			time = self.expirationTime + (self.icd - self.duration) - GetTime();
		else
			time = self.expirationTime - GetTime();
		end;

		if(time < 0) then
			self:Hide();
			self:SetScript("OnUpdate", nil);
			t_removebyval(active, self:GetName());
			updatepositions(self:GetParent());
		elseif(fdata.Mode == "BAR") then
			self.statusbar:SetValue(time);
			self.time:SetFormattedText("%d s", time);
		end;

    self.TimeSinceLastUpdate = 0;
  end;
end;

local function create_bar(f, id)
	local bar = CreateFrame("Frame", "icd_"..id, f);
	bar:SetTemplate("Default")
	bar:CreateShadow("Default")
	bar:SetWidth(fdata.size);
	bar:SetHeight(fdata.size);
	bar:SetScale(fdata.scale);

	if(fdata.Mode == "BAR") then
		bar.icon = bar:CreateTexture(nil, "BACKGROUND");
		bar.icon:SetAllPoints();
		bar.icon:SetTexCoord(0.07, 0.93, 0.07, 0.93);
		bar.statusbar = CreateFrame("StatusBar", nil, bar);
		bar.statusbar:SetWidth(fdata.barWidth);
		bar.statusbar:SetHeight(fdata.size);
		bar.statusbar:SetStatusBarTexture("Interface\\AddOns\\icdbars\\Textures\\statusbar");
		bar.statusbar:SetStatusBarColor(0.3, 0.5, 1, 1);--(classcolor.r, classcolor.g, classcolor.b, 1);
		bar.statusbar:SetPoint("LEFT", bar, "RIGHT");
		bar.statusbar:SetMinMaxValues(0, 1);
		bar.statusbar:SetValue(0);
		bar.statusbar.background = bar.statusbar:CreateTexture(nil, "BACKGROUND");
		bar.statusbar.background:SetAllPoints();
		bar.statusbar.background:SetTexture("Interface\\AddOns\\icdbars\\Textures\\statusbar");
		bar.statusbar.background:SetVertexColor(0.4, 0.4, 0.4, 0.3);
		bar.time = bar.statusbar:CreateFontString(nil, "ARTWORK", "GameFontHighlightRight");
		bar.time:SetPoint("RIGHT", bar.statusbar, -2, 1);
		bar.spellname = bar.statusbar:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall");
		bar.spellname:SetPoint("LEFT", bar.statusbar, 2, 1);
		bar.spellname:SetPoint("RIGHT", bar.time, "LEFT");
		bar.spellname:SetJustifyH("CENTER");
	else
		bar.icon = bar:CreateTexture("$parentIcon", "ARTWORK");
		bar.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9);
		bar.icon:SetPoint("TOPLEFT", 2, -2);
		bar.icon:SetPoint("BOTTOMRIGHT", -2, 2);

		bar.cooldown = CreateFrame("Cooldown", nil, bar, "CooldownFrameTemplate");
		bar.cooldown:SetAllPoints(bar.icon);
		bar.cooldown:SetReverse();
	end;

	return bar;
end;

local function update_bar(f, bar, name, icon, icd, expirationTime, duration)
	local n, fdata, dir = #active, fdata, fdata.Direction;

	if(not t_contains(active, bar:GetName())) then
		if(n == 0) then
			if(dir == "DOWN") then
				bar:SetPoint("TOP", f);
			elseif(dir == "UP") then
				bar:SetPoint("BOTTOM", f);
			elseif(dir == "LEFT") then
				bar:SetPoint("RIGHT", f);
			else
				bar:SetPoint("LEFT", f);
			end;
		else
			if(dir == "DOWN") then
				bar:SetPoint("TOP", f.bars[active[n]], "BOTTOM", 0, -fdata.Margin);
			elseif(dir == "UP") then
				bar:SetPoint("BOTTOM", f.bars[active[n]], "TOP", 0, fdata.Margin);
			elseif(dir == "LEFT") then
				bar:SetPoint("RIGHT", f.bars[active[n]], "LEFT", -fdata.Margin, 0);
			else
				bar:SetPoint("LEFT", f.bars[active[n]], "RIGHT", fdata.Margin, 0);
			end;
		end;
	end;

	bar.icd = icd;
	bar.expirationTime = expirationTime;
	bar.duration = duration;
	bar.TimeSinceLastUpdate = 0;
	bar.icon:SetTexture(icon);

	if(fdata.Mode == "BAR") then
		bar.spellName = name;
		bar.spellname:SetText("ICD:"..name);
		bar.statusbar:SetMinMaxValues(0, icd);

		local time = expirationTime + (icd - duration) - GetTime();
		bar.statusbar:SetValue(time);
		bar.time:SetFormattedText("%d s", time);
	else
		if(duration > 0) then
			CooldownFrame_SetTimer(bar.cooldown, expirationTime - duration, icd, 1);
		else
			CooldownFrame_SetTimer(bar.cooldown, expirationTime - icd, icd, 1);
		end;
	end;
end;

local l_eq_change = 0;
function icdb:PLAYER_EQUIPMENT_CHANGED(slot)
	--Throttle due to item-sets, might cause the item we want to not get caught
	local start = GetTime();
	if(start - l_eq_change < 1) then return; end;
	l_eq_change = start;
	local fdata = fdata;

	local itemid = GetInventoryItemID("player", slot);

	if(not itemid) then return; end;
	local id, data = 0, nil;
	local bar = nil;

	for i = 1, #fdata, 1 do
		data = fdata[i];

		if(data.item and data.item == itemid) then
			id = i;
			break;
		end;
	end;

	if(id == 0) then return; end;

	if(not t_contains(active, "icd_"..id)) then
		bar = create_bar(self, id);
		self.bars["icd_"..id] = bar;
	else
		bar = self.bars["icd_"..id];
	end;

	update_bar(self, bar, fdata[id].spellName, GetItemIcon(fdata[id].item), fdata[id].icd, start + fdata[id].icd, 0);
	t_insertifnotexists(active, "icd_"..id);

	bar:Show();
	bar:SetScript("OnUpdate", OnUpdate);
end;

function icdb:UNIT_AURA(unit)
	local data, name, icon, duration, expirationTime, _;
	local bar, n = nil, 0;
	local fdata = fdata;

	if(unit ~= "player") then return end;

	for i = 1, #fdata, 1 do
		--skip if the bar is already active
		if(not t_contains(active, "icd_"..i)) then
			data = fdata[i];
			name, _, icon, _, _, duration, expirationTime, _, _ = UnitAura("player", data.spellName, nil, ((data.debuff == 1) and "HARMFUL" or "HELPFUL"));

			if(duration and duration > 0) then
				if(not self.bars["icd_"..i]) then
					bar = create_bar(self, i);

					self.bars["icd_"..i] = bar;
				else
					bar = self.bars["icd_"..i];
				end;

				if(not data.itemicon and data.item and data.item > 0) then
					icon = GetItemIcon(data.item);
					data.itemicon = icon;
				elseif(data.itemicon) then
					icon = data.itemicon;
				end;

				update_bar(self, bar, name, icon, data.icd, expirationTime, duration);
				t_insertifnotexists(active, "icd_"..i);

				bar:Show();
				bar:SetScript("OnUpdate", OnUpdate);
			end;
		end;
	end;
end;

icdb:SetScript("OnEvent", function(self, event, ...)
	self[event](self, ...)
end);

local function validate_fdata()
	if(not fdata.Mode) then fdata.Mode = "BAR"; end;
	if(not fdata.Direction) then fdata.Direction = "DOWN"; end;
	if(not fdata.Margin) then fdata.Margin = 0; end;
	if(not fdata.size) then fdata.size = 18; end;
	if(not fdata.scale) then fdata.scale = 1; end;
	if(not fdata.barWidth) then fdata.barWidth = 120; end;
	if(not fdata.posx) then fdata.posx = 0; end;
	if(not fdata.posy) then fdata.posy = 0; end;

	if(fdata.Mode == "BAR" and (fdata.Direction ~= "DOWN" or fdata.Direction ~= "UP")) then
		fdata.Direction = "DOWN";
	end;
end;

function icdb:ADDON_LOADED(v)
	if(v ~= "Tukui_ICD") then return end;

	if(T.icd_spells and T.icd_spells[class]) then
		fdata = T.icd_spells[class][1];
		validate_fdata();

		icdb.bars = {};
		icdb:SetPoint("CENTER", fdata.posx, fdata.posy);
		icdb:RegisterEvent("UNIT_AURA");

		if(T.icd_track_equip_changes) then
			icdb:RegisterEvent("PLAYER_EQUIPMENT_CHANGED");
		end;
	end;
end;