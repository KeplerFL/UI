local T, C, L = unpack(select(2, ...)) -- Import: T - functions, constants, variables; C - config; L - locales

-- INFO BOTTOM (FOR STATS & CASTBAR) //need to be the firstfor cast bar anchor
local ibottom = CreateFrame("Frame", "TukuiInfoBottom", UIParent)
ibottom:CreatePanel("Hydra", (T.buttonsize * 12) + (T.buttonspacing * 13), 23, "BOTTOM", UIParent, "BOTTOM", 0, 2)
ibottom:SetFrameLevel(2)
ibottom:SetFrameStrata("BACKGROUND")

local class

if T.myclass == "DEATHKNIGHT" then
		class = "Interface\\AddOns\\Tukui\\medias\\textures\\class\\DEATHKNIGHT" 
	elseif T.myclass == "DRUID" then
		class = "Interface\\AddOns\\Tukui\\medias\\textures\\class\\DRUID"
	elseif T.myclass == "HUNTER" then
		class = "Interface\\AddOns\\Tukui\\medias\\textures\\class\\HUNTER"
	elseif T.myclass == "MAGE" then
		class = "Interface\\AddOns\\Tukui\\medias\\textures\\class\\MAGE"
	elseif T.myclass == "PALADIN" then
		class = "Interface\\AddOns\\Tukui\\medias\\textures\\class\\PALADIN"
	elseif T.myclass == "PRIEST" then
		class = "Interface\\AddOns\\Tukui\\medias\\textures\\class\\PRIEST"
	elseif T.myclass == "ROGUE" then
		class = "Interface\\AddOns\\Tukui\\medias\\textures\\class\\ROGUE"
	elseif T.myclass == "SHAMAN" then
		class = "Interface\\AddOns\\Tukui\\medias\\textures\\class\\SHAMAN"
	elseif T.myclass == "WARLOCK" then
		class = "Interface\\AddOns\\Tukui\\medias\\textures\\class\\WARLOCK"
	elseif T.myclass == "WARRIOR" then
		class = "Interface\\AddOns\\Tukui\\medias\\textures\\class\\WARRIOR"
	end

	ChatFrame1:AddMessage(T.myfaction)
	
if T.myfaction == "Alliance" then
	faction = "Interface\\AddOns\\Tukui\\medias\\textures\\alliance" 
elseif T.myfaction == "Horde" then
	faction = "Interface\\AddOns\\Tukui\\medias\\textures\\horde"
end
		
local TukuiBar1 = CreateFrame("Frame", "TukuiBar1", UIParent, "SecureHandlerStateTemplate")
TukuiBar1:CreatePanel("Default", 1, 1, "BOTTOM", ibottom, "TOP", 0, 2)
TukuiBar1:SetWidth((T.buttonsize * 12) + (T.buttonspacing * 13))
TukuiBar1:SetHeight((T.buttonsize * 2) + (T.buttonspacing * 3))
TukuiBar1:SetFrameStrata("BACKGROUND")
TukuiBar1:SetFrameLevel(1)

local TukuiBar2 = CreateFrame("Frame", "TukuiBar2", UIParent)
TukuiBar2:CreatePanel("Default", 1, 1, "BOTTOMRIGHT", TukuiBar1, "BOTTOMLEFT", -6, 0)
TukuiBar2:SetWidth((T.buttonsize * 6) + (T.buttonspacing * 7))
TukuiBar2:SetHeight((T.buttonsize * 2) + (T.buttonspacing * 3))
TukuiBar2:SetFrameStrata("BACKGROUND")
TukuiBar2:SetFrameLevel(2)
TukuiBar2:SetAlpha(0)
if T.lowversion then
	TukuiBar2:SetAlpha(0)
else
	TukuiBar2:SetAlpha(1)
end

local TukuiBar3 = CreateFrame("Frame", "TukuiBar3", UIParent)
TukuiBar3:CreatePanel("Default", 1, 1, "BOTTOMLEFT", TukuiBar1, "BOTTOMRIGHT", 6, 0)
TukuiBar3:SetWidth((T.buttonsize * 6) + (T.buttonspacing * 7))
TukuiBar3:SetHeight((T.buttonsize * 2) + (T.buttonspacing * 3))
TukuiBar3:SetFrameStrata("BACKGROUND")
TukuiBar3:SetFrameLevel(2)
if T.lowversion then
	TukuiBar3:SetAlpha(0)
else
	TukuiBar3:SetAlpha(1)
end

local TukuiBar4 = CreateFrame("Frame", "TukuiBar4", UIParent)
TukuiBar4:CreatePanel("Default", 1, 1, "BOTTOM", ibottom, "TOP", 0, 2)
TukuiBar4:SetWidth((T.buttonsize * 12) + (T.buttonspacing * 13))
TukuiBar4:SetHeight((T.buttonsize * 2) + (T.buttonspacing * 3))
TukuiBar4:SetFrameStrata("BACKGROUND")
TukuiBar4:SetFrameLevel(2)
TukuiBar4:SetAlpha(0)

local TukuiBar5 = CreateFrame("Frame", "TukuiBar5", UIParent)
TukuiBar5:CreatePanel("Default", 1, (T.buttonsize * 12) + (T.buttonspacing * 13), "RIGHT", UIParent, "RIGHT", -23, -14)
TukuiBar5:SetWidth((T.buttonsize * 1) + (T.buttonspacing * 2))
TukuiBar5:SetFrameStrata("BACKGROUND")
TukuiBar5:SetFrameLevel(2)
TukuiBar5:SetAlpha(0)

local TukuiBar6 = CreateFrame("Frame", "TukuiBar6", UIParent)
TukuiBar6:SetWidth((T.buttonsize * 1) + (T.buttonspacing * 2))
TukuiBar6:SetHeight((T.buttonsize * 12) + (T.buttonspacing * 13))
TukuiBar6:SetPoint("LEFT", TukuiBar5, "LEFT", 0, 0)
TukuiBar6:SetFrameStrata("BACKGROUND")
TukuiBar6:SetFrameLevel(2)
TukuiBar6:SetAlpha(0)

local TukuiBar7 = CreateFrame("Frame", "TukuiBar7", UIParent)
TukuiBar7:SetWidth((T.buttonsize * 1) + (T.buttonspacing * 2))
TukuiBar7:SetHeight((T.buttonsize * 12) + (T.buttonspacing * 13))
TukuiBar7:SetPoint("TOP", TukuiBar5, "TOP", 0 , 0)
TukuiBar7:SetFrameStrata("BACKGROUND")
TukuiBar7:SetFrameLevel(2)
TukuiBar7:SetAlpha(0)



local petbg = CreateFrame("Frame", "TukuiPetBar", UIParent, "SecureHandlerStateTemplate")
petbg:CreatePanel("Default", T.petbuttonsize + (T.petbuttonspacing * 2), (T.petbuttonsize * 10) + (T.petbuttonspacing * 11), "RIGHT", TukuiBar5, "LEFT", -6, 0)

local ltpetbg1 = CreateFrame("Frame", "TukuiLineToPetActionBarBackground", petbg)
ltpetbg1:CreatePanel("Default", 24, 265, "LEFT", petbg, "RIGHT", 0, 0)
ltpetbg1:SetParent(petbg)
ltpetbg1:SetFrameStrata("BACKGROUND")
ltpetbg1:SetFrameLevel(0)

-- INVISIBLE FRAME COVERING BOTTOM ACTIONBARS JUST TO PARENT UF CORRECTLY
local invbarbg = CreateFrame("Frame", "InvTukuiActionBarBackground", UIParent)
if T.lowversion then
	invbarbg:SetPoint("TOPLEFT", TukuiBar1)
	invbarbg:SetPoint("BOTTOMRIGHT", TukuiBar1)
	TukuiBar2:Hide()
	TukuiBar3:Hide()
else
	invbarbg:SetPoint("TOPLEFT", TukuiBar2)
	invbarbg:SetPoint("BOTTOMRIGHT", TukuiBar3)
end

-- LEFT VERTICAL LINE
local ileftlv = CreateFrame("Frame", "TukuiInfoLeftLineVertical", TukuiBar1)
ileftlv:CreatePanel("Default", 2, 130, "BOTTOMLEFT", UIParent, "BOTTOMLEFT", 22, 30)
ileftlv:Hide();

-- RIGHT VERTICAL LINE
local irightlv = CreateFrame("Frame", "TukuiInfoRightLineVertical", TukuiBar1)
irightlv:CreatePanel("Default", 2, 130, "BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -22, 30)
irightlv:Hide()

if not C.chat.background then
	-- CUBE AT LEFT, ACT AS A BUTTON (CHAT MENU)
	local cubeleft = CreateFrame("Frame", "TukuiCubeLeft", TukuiBar1)
	cubeleft:CreatePanel("Default", 10, 10, "BOTTOM", ileftlv, "TOP", 0, 0)
	cubeleft:EnableMouse(true)
	cubeleft:SetScript("OnMouseDown", function(self, btn)
		if TukuiInfoLeftBattleGround and UnitInBattleground("player") then
			if btn == "RightButton" then
				if TukuiInfoLeftBattleGround:IsShown() then
					TukuiInfoLeftBattleGround:Hide()
				else
					TukuiInfoLeftBattleGround:Show()
				end
			end
		end
		
		if btn == "LeftButton" then	
			ToggleFrame(ChatMenu)
		end
	end)

	-- CUBE AT RIGHT, ACT AS A BUTTON (CONFIGUI or BG'S)
	local cuberight = CreateFrame("Frame", "TukuiCubeRight", TukuiBar1)
	cuberight:CreatePanel("Default", 10, 10, "BOTTOM", irightlv, "TOP", 0, 0)
	if C["bags"].enable then
		cuberight:EnableMouse(true)
		cuberight:SetScript("OnMouseDown", function(self)
			if T.toc < 40200 then ToggleKeyRing() else ToggleAllBags() end
		end)
	end
end

-- HORIZONTAL LINE LEFT
local ltoabl = CreateFrame("Frame", "TukuiLineToABLeft", TukuiBar1)
ltoabl:CreatePanel("Default", 5, 2, "BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", 0, 0)
ltoabl:ClearAllPoints()
ltoabl:Point("BOTTOMLEFT", ileftlv, "BOTTOMLEFT", 0, 0)
ltoabl:Point("RIGHT", TukuiBar1, "BOTTOMLEFT", -1, 17)
ltoabl:SetFrameStrata("BACKGROUND")
ltoabl:SetFrameLevel(1)
ltoabl:Hide()

-- HORIZONTAL LINE RIGHT
local ltoabr = CreateFrame("Frame", "TukuiLineToABRight", TukuiBar1)
ltoabr:CreatePanel("Default", 5, 2, "BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", 0, 0)
ltoabr:ClearAllPoints()
ltoabr:Point("LEFT", TukuiBar1, "BOTTOMRIGHT", 1, 17)
ltoabr:Point("BOTTOMRIGHT", irightlv, "BOTTOMRIGHT", 0, 0)
ltoabr:SetFrameStrata("BACKGROUND")
ltoabr:SetFrameLevel(1)
ltoabr:Hide()

-- MOVE/HIDE SOME ELEMENTS IF CHAT BACKGROUND IS ENABLED
local movechat = 0
if C.chat.background then movechat = 10 ileftlv:SetAlpha(0) irightlv:SetAlpha(0) end

-- INFO LEFT (FOR STATS)
local ileft = CreateFrame("Frame", "TukuiInfoLeft", TukuiBar1)
ileft:CreatePanel("Default", T.InfoLeftRightWidth, 23, "BOTTOMLEFT", UIParent, "BOTTOMLEFT", 2, 2)
ileft:SetFrameLevel(2)
ileft:SetFrameStrata("BACKGROUND")

-- INFO RIGHT (FOR STATS)
local iright = CreateFrame("Frame", "TukuiInfoRight", TukuiBar1)
iright:CreatePanel("Default", T.InfoLeftRightWidth, 23, "BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -2, 2)
iright:SetFrameLevel(2)
iright:SetFrameStrata("BACKGROUND")

----------------------------------------------------------------------------
---------------- Additional datatexts -------------------------------------
--INFO TOP 1 (FOR STATS)
local Top1v=false
local itop1 = CreateFrame("Frame", "TukuiInfoTop1", UIParent)
itop1:CreatePanel("Default", 125, 23, "TOPLEFT", UIParent, "TOPLEFT", 10, -10)
local itop1v = CreateFrame("Frame", "TukuiInfoTop1v", UIParent)
itop1v:CreatePanel("Default", 125, 23, "TOPLEFT", UIParent, "TOPLEFT", 10, -10)
itop1v:SetAlpha(0)
itop1v:EnableMouse(true)
itop1:SetFrameLevel(2)
itop1:Hide()
T.set_anim(TukuiInfoTop1, true, 0, 60, 0.6)
itop1v:SetScript("OnMouseDown", function(self, btn)
		if Top1v == false then
			TukuiInfoTop1.anim_o:Stop()
			--MsBar.anim_o:Stop()
			--MsBar:Show()
			TukuiInfoTop1:Show()
			TukuiInfoTop1.anim:Play()
			--MsBar.anim:Play()
			Top1v = true
		elseif Top1v == true then
			TukuiInfoTop1.anim:Stop()
			--MsBar.anim:Stop()
			--MsBar.anim_o:Play()
			TukuiInfoTop1.anim_o:Play()
			Top1v= false
		end
	
end)

--INFO TOP 2 (FOR STATS)
local Top2v=false
local itop2 = CreateFrame("Frame", "TukuiInfoTop2", UIParent)
itop2:CreatePanel("Default", 125, 23, "TOPLEFT", UIParent, "TOPLEFT", 139, -10)
local itop2v = CreateFrame("Frame", "TukuiInfoTop2v", UIParent)
itop2v:CreatePanel("Default", 125, 23, "TOPLEFT", UIParent, "TOPLEFT", 139, -10)
itop2v:SetAlpha(0)
itop2v:EnableMouse(true)
itop2:SetFrameLevel(2)
itop2:Hide()
T.set_anim(TukuiInfoTop2, true, 0, 60, .6)
itop2v:SetScript("OnMouseDown", function(self, btn)
		if Top2v == false then
			TukuiInfoTop2.anim_o:Stop()
			--FpsBar.anim_o:Stop()
			--FpsBar:Show()
			TukuiInfoTop2:Show()
			TukuiInfoTop2.anim:Play()
			--FpsBar.anim:Play()
			Top2v = true
		elseif Top2v == true then
			TukuiInfoTop2.anim:Stop()
			--FpsBar.anim:Stop()
			--FpsBar.anim_o:Play()
			TukuiInfoTop2.anim_o:Play()
			Top2v= false
		end
	
end)

--INFO TOP 3 (FOR STATS)
local Top3v=false
local itop3 = CreateFrame("Frame", "TukuiInfoTop3", UIParent)
itop3:CreatePanel("Default", 125, 23, "TOPLEFT", UIParent, "TOPLEFT", 268, -10)
local itop3v = CreateFrame("Frame", "TukuiInfoTop3v", UIParent)
itop3v:CreatePanel("Default", 125, 23, "TOPLEFT", UIParent, "TOPLEFT", 268, -10)
itop3v:SetAlpha(0)
itop3v:EnableMouse(true)
itop3:SetFrameLevel(2)
itop3:Hide()
T.set_anim(TukuiInfoTop3, true, 0, 60, .6)
itop3v:SetScript("OnMouseDown", function(self, btn)
		if Top3v == false then
			TukuiInfoTop3.anim_o:Stop()
			TukuiInfoTop3:Show()
			TukuiInfoTop3.anim:Play()
			Top3v = true
		elseif Top3v == true then
			TukuiInfoTop3.anim:Stop()
			TukuiInfoTop3.anim_o:Play()
			Top3v= false
		end
	
end)

if C.chat.background then
	-- Alpha horizontal lines because all panels is dependent on this frame.
	ltoabl:SetAlpha(0)
	ltoabr:SetAlpha(0)
	
	-- CHAT BG LEFT
	local chatleftbg = CreateFrame("Frame", "TukuiChatBackgroundLeft", TukuiInfoLeft)
	chatleftbg:CreatePanel("Transparent", T.InfoLeftRightWidth, 116, "BOTTOM", TukuiInfoLeft, "TOP", 0, 2)
	T.set_anim(TukuiChatBackgroundLeft, true, -500, 0, .6)

	-- CHAT BG RIGHT
	local chatrightbg = CreateFrame("Frame", "TukuiChatBackgroundRight", TukuiInfoRight)
	chatrightbg:CreatePanel("Transparent", T.InfoLeftRightWidth, 116, "BOTTOM", TukuiInfoRight, "TOP", 0, 2)
	T.set_anim(TukuiChatBackgroundRight, true, 500, 0, .6)
	
	if C.chat.classbg == true then
	chatrightbg:SetAlpha(.8)
	chatrightbg:SetBackdrop({
	  bgFile = class, 
	  edgeFile = Blank, 
	  tile = false, tileSize = 0, edgeSize = 3,
	})
	chatleftbg:SetAlpha(.8)
	chatleftbg:SetBackdrop({
	  bgFile = faction, 
	  edgeFile = Blank, 
	  tile = false, tileSize = 0, edgeSize = 3,
	})
	
	end
	
	-- LEFT TAB PANEL
	local tabsbgleft = CreateFrame("Frame", "TukuiTabsLeftBackground", TukuiBar1)
	tabsbgleft:CreatePanel("Transparent", T.InfoLeftRightWidth , 19, "BOTTOM", chatleftbg, "TOP", 0, 2)
	tabsbgleft:SetFrameLevel(2)
	tabsbgleft:SetFrameStrata("BACKGROUND")
	T.set_anim(TukuiTabsLeftBackground, true, -500, 0, .6)
		
	-- RIGHT TAB PANEL
	local tabsbgright = CreateFrame("Frame", "TukuiTabsRightBackground", TukuiBar1)
	tabsbgright:CreatePanel("Transparent", T.InfoLeftRightWidth, 19, "BOTTOM", chatrightbg, "TOP", 0, 2)
	tabsbgright:SetFrameLevel(2)
	tabsbgright:SetFrameStrata("BACKGROUND")
	T.set_anim(TukuiTabsRightBackground, true, 500, 0, .6)
	
	-- [[ Create new horizontal line for chat background ]] --
	-- HORIZONTAL LINE LEFT
	local ltoabl2 = CreateFrame("Frame", "TukuiLineToABLeftAlt", TukuiBar1)
	ltoabl2:CreatePanel("Default", 5, 2, "BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", 0, 0)
	ltoabl2:ClearAllPoints()
	ltoabl2:Point("RIGHT", TukuiBar1, "LEFT", 0, 16)
	ltoabl2:Point("BOTTOMLEFT", chatleftbg, "BOTTOMRIGHT", 0, 16)
	ltoabl2:Hide()

	-- HORIZONTAL LINE RIGHT
	local ltoabr2 = CreateFrame("Frame", "TukuiLineToABRightAlt", TukuiBar1)
	ltoabr2:CreatePanel("Default", 5, 2, "BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", 0, 0)
	ltoabr2:ClearAllPoints()
	ltoabr2:Point("LEFT", TukuiBar1, "RIGHT", 0, 16)
	ltoabr2:Point("BOTTOMRIGHT", chatrightbg, "BOTTOMLEFT", 0, 16)
	ltoabr2:Hide()
	
end
-- BUTTON LEFT (TOGGLE CHATS) [Natsu]
local hidechat = CreateFrame("Button", "chathide", UIParent)
hidechat:CreatePanel("Transparent", 20, 20, "TOPRIGHT", TukuiInfoLeft, "TOPRIGHT", -3, -3)
hidechat:EnableMouse(true)
hidechat:HookScript("OnEnter", function(self)
	GameTooltip:SetOwner(hidechat);
	GameTooltip:ClearAllPoints()
	GameTooltip:SetPoint("BOTTOM", self, "TOP", 0, 0)
	GameTooltip:ClearLines()
	GameTooltip:AddDoubleLine("Hide Chat frames")
	GameTooltip:Show()
end)
hidechat:SetAlpha(0)
hidechat:HookScript("OnLeave", function(self)
	self:SetBackdropBorderColor(.2,.2,.2,1)
	GameTooltip:Hide()
end)
if IsAddOnLoaded("Recount") then
	local Recount = _G.Recount
end
--[[local Texthide  = TukuiInfoLeft:CreateFontString(nil, "LOW")
Texthide:SetFont(C.media.font, C["datatext"].fontsize)
Texthide:SetText("|cff00AAFF V|r")
Texthide:SetHeight(15)
Texthide:SetPoint("RIGHT", hidechat, "RIGHT", 0, 0)]]
hidechat:RegisterForClicks("AnyUp")
hidechat:SetScript("OnClick", function()

	if(TukuiChatBackgroundLeft:IsVisible()) then
		TukuiChatBackgroundRight.anim:Stop()
		TukuiChatBackgroundLeft.anim:Stop()
		TukuiTabsLeftBackground.anim:Stop()
		TukuiTabsRightBackground.anim:Stop()
		TukuiShiftBar.anim:Stop()
		for i = 1, NUM_CHAT_WINDOWS do
			_G["ChatFrame"..i].anim:Stop()
			_G["ChatFrame"..i.."TabText"].anim:Stop()
		end
		TukuiChatBackgroundRight.anim_o:Play()
		TukuiChatBackgroundLeft.anim_o:Play()
		TukuiTabsLeftBackground.anim_o:Play()
		TukuiTabsRightBackground.anim_o:Play()
		TukuiShiftBar.anim_o:Play()
		for i = 1, NUM_CHAT_WINDOWS do
			_G["ChatFrame"..i].anim_o:Play()
			_G["ChatFrame"..i.."TabText"].anim_o:Play()
		end
		if IsAddOnLoaded("Recount") then
			
			Recount.MainWindow.anim:Stop()
			Recount.MainWindow.anim_o:Play()
		end
		if IsAddOnLoaded("Omen") then
			OmenAnchor.anim:Stop()
			OmenAnchor.anim_o:Play()
		end
		if IsAddOnLoaded("Skada") then
			T.skada.anim:Stop()
			T.skada.anim_o:Play()
		end
	else
		TukuiChatBackgroundRight.anim_o:Stop()
		TukuiChatBackgroundLeft.anim_o:Stop()
		TukuiTabsLeftBackground.anim_o:Stop()
		TukuiTabsRightBackground.anim_o:Stop()
		TukuiShiftBar.anim_o:Stop()
		for i = 1, NUM_CHAT_WINDOWS do
			_G["ChatFrame"..i].anim_o:Stop()
			_G["ChatFrame"..i.."TabText"].anim_o:Stop()
		end
		TukuiChatBackgroundRight:Show()
		TukuiChatBackgroundLeft:Show()
		TukuiTabsLeftBackground:Show()
		TukuiTabsRightBackground:Show()
		TukuiShiftBar:Show()
		ChatFrame1:Show()
		ChatFrame4:Show()
		for i = 1, NUM_CHAT_WINDOWS do
		_G["ChatFrame"..i.."TabText"]:Show()
		end
		TukuiChatBackgroundRight.anim:Play()
		TukuiChatBackgroundLeft.anim:Play()
		TukuiTabsLeftBackground.anim:Play()
		TukuiTabsRightBackground.anim:Play()
		TukuiShiftBar.anim:Play()
		for i = 1, NUM_CHAT_WINDOWS do
			_G["ChatFrame"..i].anim:Play()
			_G["ChatFrame"..i.."TabText"].anim:Play()
		end
		if IsAddOnLoaded("Recount") then
			
			Recount.MainWindow.anim_o:Stop()
			Recount.MainWindow:Show()
			Recount.MainWindow.anim:Play()
		end
		if IsAddOnLoaded("Omen") then
			OmenAnchor.anim_o:Stop()
			OmenAnchor:Show()
			OmenAnchor.anim:Play()
		end
		if IsAddOnLoaded("Skada") then
			T.skada.anim_o:Stop()
			T.skada:Show()
			T.skada.anim:Play()
		end
	end
	
end)

-- BUTTON RIGHT (TOGGLE MINIMAP) [Natsu]
local button2 = CreateFrame("Button", "tester2", UIParent)
button2:CreatePanel("Transparent", 60, 10, "RIGHT", TukuiTabsRightBackground, "RIGHT", -3, 0)
button2:EnableMouse(true)
button2:HookScript("OnEnter", function(self)
	GameTooltip:SetOwner(button2);
	GameTooltip:ClearAllPoints()
	GameTooltip:SetPoint("BOTTOM", self, "TOP", 0, 0)
	GameTooltip:ClearLines()
	GameTooltip:AddDoubleLine("Toggle Minimap")
	GameTooltip:Show()
end)
button2:SetAlpha(0)
button2:HookScript("OnLeave", function(self)
	self:SetBackdropBorderColor(.2,.2,.2,1)
	GameTooltip:Hide()
end)
local Text  = TukuiTabsRightBackground:CreateFontString(nil, "LOW")
Text:SetFont(C.media.font, C["datatext"].fontsize)
Text:SetText("|cff00AAFF Minimap|r")
Text:SetHeight(15)
Text:SetPoint("RIGHT", TukuiTabsRightBackground, "RIGHT", -10, 0)
button2:RegisterForClicks("AnyUp")
button2:SetScript("OnClick", function()

	if(TukuiMinimap:IsVisible()) then
		TukuiMinimap:Hide()
		Minimap:Hide()
		TukuiAurasPlayerBuffs:SetPoint("TOPRIGHT", UIParent, -5, -5)
	else
		TukuiMinimap:Show()
		Minimap:Show()
		TukuiAurasPlayerBuffs:SetPoint("TOPRIGHT", UIParent, -184, -5)
	end
	
end)

--[[if TukuiMinimap then  --LEAVING HERE IF YOU LIKE, REMEMBER TO CHANGE FUNCTIONS.LUA 
	local minimapstatsleft = CreateFrame("Frame", "TukuiMinimapStatsLeft", TukuiMinimap)
	minimapstatsleft:CreatePanel("Default", ((TukuiMinimap:GetWidth() + 4) / 2) -3, 19, "TOPLEFT", TukuiMinimap, "BOTTOMLEFT", 0, -2)

	local minimapstatsright = CreateFrame("Frame", "TukuiMinimapStatsRight", TukuiMinimap)
	minimapstatsright:CreatePanel("Default", ((TukuiMinimap:GetWidth() + 4) / 2) -3, 19, "TOPRIGHT", TukuiMinimap, "BOTTOMRIGHT", 0, -2)
end--]]

--BATTLEGROUND STATS FRAME
if C["datatext"].battleground == true then
	local bgframe = CreateFrame("Frame", "TukuiInfoLeftBattleGround", UIParent)
	bgframe:CreatePanel("Default", 1, 1, "TOPLEFT", UIParent, "BOTTOMLEFT", 0, 0)
	bgframe:SetAllPoints(ileft)
	bgframe:SetFrameStrata("LOW")
	bgframe:SetFrameLevel(0)
	bgframe:EnableMouse(true)
end
