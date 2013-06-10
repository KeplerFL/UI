local T, C, L = unpack(select(2, ...)) -- Import: T - functions, constants, variables; C - config; L - locales

local myPlayerRealm = GetCVar("realmName")
local myPlayerName  = UnitName("player")

-- create button function --thanks to Kacaos
local function CreateUIButton(name, parent, text)
	local b = CreateFrame("Button", name, parent, "SecureActionButtonTemplate")
	b:Size (120, 30)
	b:StripTextures(true)
	b:SetTemplate("Default")
	b:SetBackdropColor(27/255, 224/255, 27/255)
	b:EnableMouse(true)
	b:RegisterForClicks("AnyUp")
	
	b:HookScript("OnEnter", function(self)
		self:SetBackdropBorderColor(148/255, 130/255, 201/255, 1)
	end)
	b:HookScript("OnLeave", function(self)
		self:SetBackdropBorderColor(51/255, 51/255, 51/255)
	end)
	
	b:FontString(nil, C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
	b.text:SetText(text)
	b.text:SetPoint("CENTER", b)
end

local refresh = function()
	if C["datatext"].armor and C["datatext"].armor > 0 then
		T.ArmorText()
	end
	if C["datatext"].avoidance and C["datatext"].avoidance > 0 then
		T.AvoidanceText()
	end
	if C["datatext"].bags and C["datatext"].bags > 0 then
		T.BagText()
	end
	if C["datatext"].calltoarms and C["datatext"].calltoarms > 0 then
		T.CTAText()
	end
	if C["datatext"].crit and C["datatext"].crit > 0 then
		T.CritText()
	end
	if C["datatext"].currency and C["datatext"].currency > 0 then
		T.CurrencyText()
	end
	if C["datatext"].dps_text and C["datatext"].dps_text > 0 then
		T.DpsText()
	end
	if C["datatext"].dur and C["datatext"].dur > 0 then
		T.DurText()
	end
	if C["datatext"].fps_ms and C["datatext"].fps_ms > 0 then
		T.FpsText()
	end
	if C["datatext"].friends and C["datatext"].friends > 0 then
		T.FriendText()
	end
	if C["datatext"].gold and C["datatext"].gold > 0 then
		T.GoldText()
	end
	if C["datatext"].guild and C["datatext"].guild > 0 then
		T.GuildText()
	end
	if C["datatext"].haste and C["datatext"].haste > 0 then
		T.HasteText()
	end
	if C["datatext"].hit and C["datatext"].hit > 0 then
		T.HitText()
	end
	if C["datatext"].hps_text and C["datatext"].hps_text > 0 then
		T.HpsText()
	end
	if C["datatext"].mastery and C["datatext"].mastery > 0 then
		T.MasteryText()
	end
	if C["datatext"].micromenu and C["datatext"].micromenu > 0 then
		T.MicroText()
	end
	if C["datatext"].power and C["datatext"].power > 0 then
		T.PowerText()
	end
	if C["datatext"].regen and C["datatext"].regen > 0 then
		T.RegenText()
	end
	if C["datatext"].system and C["datatext"].system > 0 then
		T.SystemText()
	end
	if C["datatext"].talent and C["datatext"].talent > 0 then
		T.TalentText()
	end
	if C["datatext"].wowtime and C["datatext"].wowtime > 0 then
		T.TimeText()
	end
end

local NewButton = function(text,parent)
	
	local result = CreateFrame("Button", nil, parent)
	local label = result:CreateFontString(nil,"OVERLAY",nil)
	label:SetFont(C.media.font,12)
	label:SetText(text)
	result:SetWidth(label:GetWidth())
	result:SetHeight(label:GetHeight())
	result:SetFontString(label)

	return result
end

local function Local(o)
	local string = o
	for option, value in pairs(L) do
		if option == o then
			string = value
		end
	end
	
	return string
end

local function SetValue(group,option,value)		
	--Determine if we should be copying our default settings to our player settings, this only happens if we're not using player settings by default
	local mergesettings
	if TukuiConfigPrivate == TukuiConfigPublic then
		mergesettings = true
	else
		mergesettings = false
	end

	if TukuiConfigAll[myPlayerRealm][myPlayerName] == true then
		if not TukuiConfigPrivate then TukuiConfigPrivate = {} end	
		if not TukuiConfigPrivate[group] then TukuiConfigPrivate[group] = {} end
		TukuiConfigPrivate[group][option] = value
	else
		--Set PerChar settings to the same as our settings if theres no per char settings
		if mergesettings == true then
			if not TukuiConfigPrivate then TukuiConfigPrivate = {} end	
			if not TukuiConfigPrivate[group] then TukuiConfigPrivate[group] = {} end
			TukuiConfigPrivate[group][option] = value
		end
		
		if not TukuiConfigPublic then TukuiConfigPublic = {} end
		if not TukuiConfigPublic[group] then TukuiConfigPublic[group] = {} end
		TukuiConfigPublic[group][option] = value
	end
end

-- menu button
local menu = CreateFrame("Button", "RTime", UIParent)

local assign = function(n, d)	
	C["datatext"][n] = d
	SetValue("datatext", n, d)
	refresh()
end

local setToZero = function()
	
	for group in pairs(C["datatext"]) do
		if group ~= "fontsize" and group ~= "time24" and group ~= "localtime" and group ~= "battleground" then
			assign(group, 20)
		end
	end	
	
end

local createMenu = function(f)
	local menubg = CreateFrame("Frame", "MenuBG", f)
	menubg:CreatePanel("Default", 130, 50, "BOTTOMRIGHT", f, "TOPLEFT", 0, 150)
	menubg:SetFrameLevel(50)
	menubg:SetClampedToScreen(true)
	local offset=5
	for group in pairs(C["datatext"]) do
		if group ~= "fontsize" and group ~= "time24" and group ~= "localtime" and group ~= "battleground" then
			local o = "DTSelect-"..group
			local translate = Local(group)
			local button = NewButton(translate, menubg)
			button:SetHeight(16)
			button:SetWidth(125)
			button:SetPoint("TOPLEFT", 5, -offset)
			button:SetScript("OnClick", function(self) menubg:Kill() assign(tostring(self:GetText()), f.value)end)		
			menubg:Height(offset + 40)
			offset=offset+20
		end
	end	
	
	local cbutton = NewButton("Close", menubg)
	cbutton:SetHeight(16)
	cbutton:SetWidth(125)
	cbutton:SetPoint("TOPLEFT", 5, -offset)
	cbutton:SetScript("OnClick", function(self) menubg:Kill() end)		
	menubg:Height(offset + 35)
end

local iter = {}
local crea = function()
	local re = CreateFrame("Frame", "ZeroFrame", UIParent)
	re:EnableMouse(true)
	re.value=20
	re:HookScript("OnMouseDown", setToZero)
	re:CreatePanel("Default", 120, 35, "CENTER", UIParent, "CENTER", 0, 0)
	re:Hide()
	local r = NewButton("Reset", re)
	r:SetHeight(16)
	r:SetWidth(125)
	r:SetPoint("TOPLEFT", 5, -5)
	re:Width(r:GetWidth() +10)
	re:Height(r:GetHeight() + 10)
	r:SetScript("OnClick", setToZero)
	local i =0
	while i<13 do
			local fr = CreateFrame("Frame", nil, UIParent)
			fr:EnableMouse(true)
			fr.value = i
			fr:HookScript("OnMouseDown", createMenu)
			if i ==1 then
				fr:CreatePanel("Transparent", TukuiInfoLeft:GetWidth()/3-1, TukuiInfoLeft:GetHeight(), "LEFT", TukuiInfoLeft, "LEFT", 2, 0)
			elseif i == 2 then
				fr:CreatePanel("Transparent", TukuiInfoLeft:GetWidth()/3-1, TukuiInfoLeft:GetHeight(), "CENTER", TukuiInfoLeft, "CENTER", 0, 0)
			elseif i == 3 then
				fr:CreatePanel("Transparent", TukuiInfoLeft:GetWidth()/3-1, TukuiInfoLeft:GetHeight(), "RIGHT", TukuiInfoLeft, "RIGHT", -2, 0)
			elseif i ==4 then
				fr:CreatePanel("Transparent", TukuiInfoLeft:GetWidth()/3-1, TukuiInfoLeft:GetHeight(), "LEFT", TukuiInfoRight, "LEFT", 2, 0)
			elseif i == 5 then
				fr:CreatePanel("Transparent", TukuiInfoLeft:GetWidth()/3-1, TukuiInfoLeft:GetHeight(), "CENTER", TukuiInfoRight, "CENTER", 0, 0)
			elseif i == 6 then
				fr:CreatePanel("Transparent", TukuiInfoLeft:GetWidth()/3-1, TukuiInfoLeft:GetHeight(), "RIGHT", TukuiInfoRight, "RIGHT", -2, 0)
			elseif i ==7 then
				fr:CreatePanel("Transparent", TukuiInfoLeft:GetWidth()/3-1, TukuiInfoLeft:GetHeight(), "LEFT", TukuiInfoBottom, "LEFT", 2, 0)
			elseif i == 8 then
				fr:CreatePanel("Transparent", TukuiInfoLeft:GetWidth()/3-1, TukuiInfoLeft:GetHeight(), "CENTER", TukuiInfoBottom, "CENTER", 0, 0)
			elseif i == 9 then
				fr:CreatePanel("Transparent", TukuiInfoLeft:GetWidth()/3-1, TukuiInfoLeft:GetHeight(), "RIGHT", TukuiInfoBottom, "RIGHT", -2, 0)
			elseif i == 10 then
				fr:CreatePanel("Transparent", TukuiInfoLeft:GetWidth()/3-1, TukuiInfoLeft:GetHeight(), "CENTER", TukuiInfoTop1, "CENTER", 0, 0)
			elseif i == 11 then
				fr:CreatePanel("Transparent", TukuiInfoLeft:GetWidth()/3-1, TukuiInfoLeft:GetHeight(), "CENTER", TukuiInfoTop2, "CENTER", 0, 0)
			elseif i == 12 then
				fr:CreatePanel("Transparent", TukuiInfoLeft:GetWidth()/3-1, TukuiInfoLeft:GetHeight(), "CENTER", TukuiInfoTop3, "CENTER", 0, 0)
			end
			fr:SetFrameLevel(50)
			fr:SetBackdropColor(27/255, 224/255, 27/255, .4)
			fr:Hide()
			iter[i] = fr
		i = i + 1
		
	end
end

crea()
local mostra = function()
local i = 0
ZeroFrame:Show()
	while i<13 do
		iter[i]:Show()
		i = i+1
	end
end

local hide = function()
local i = 0
ZeroFrame:Hide()
	while i<13 do
		iter[i]:Hide()
		i = i+1
	end
end
SLASH_DTMOVE1 = "/dtmove"
SlashCmdList.DTMOVE = function() if iter[1]:IsVisible() then hide() else mostra() end end