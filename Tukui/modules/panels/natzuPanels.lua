local T, C, L = unpack(select(2, ...)) -- Import: T - functions, constants, variables; C - config; L - locales

-- INFO BOTTOM (FOR STATS & CASTBAR) //need to be the firstfor cast bar anchor
local ibottom = CreateFrame("Frame", "TukuiInfoBottom", UIParent)
ibottom:CreatePanel("Hydra", (T.buttonsize * 12) + (T.buttonspacing * 13), 23, "BOTTOM", UIParent, "BOTTOM", 0, 2)
ibottom:SetFrameLevel(2)
ibottom:SetFrameStrata("BACKGROUND")

local class
local faction

-- Expand/Open animation
local OnExpandFinished = function(self)
	self:SetScript("OnUpdate", nil)
	
	if self.Minimized then
		self:SetHeight(self.NormalHeight)
		self:SetWidth(self.NormalWidth)
	end
end

local Open = function(self)
	self.Anim = true
	local CurHeight = self:GetHeight()
	local MaxHeight = self.NormalHeight
	
	local CurWidth = self:GetWidth()
	local MaxWidth = self.NormalWidth
	
	if (CurWidth < MaxWidth) then
		if (CurWidth + self.MoveSpeed > MaxWidth) then
			self:SetWidth(CurWidth + 1)
		else
			self:SetWidth(CurWidth + self.MoveSpeed)
		end
	else
		if (CurHeight < MaxHeight) then
			if (CurHeight + self.MoveSpeed > MaxHeight) then
				self:SetHeight(CurHeight + 1)
			else
				self:SetHeight(CurHeight + self.MoveSpeed)
			end
		else
			OnExpandFinished(self)
			self.Anim = false
			self.Minimized = false
		end
	end
end

local Close = function(self)
	self.Anim = true
	local CurHeight = self:GetHeight()
	local MaxHeight = self.MinHeight
	
	local CurWidth = self:GetWidth()
	local MaxWidth = self.MinWidth
	
	if (CurHeight > 1) then
		if (CurHeight - self.MoveSpeed < 1) then
			self:SetHeight(CurHeight - 1)
		else
			self:SetHeight(CurHeight - self.MoveSpeed)
		end
	else
		if (CurWidth > 1) then
			if (CurWidth - self.MoveSpeed < 1) then
				self:SetWidth(CurWidth - 1)
			else
				self:SetWidth(CurWidth - self.MoveSpeed)
			end
		else
			OnExpandFinished(self)
			self:Hide()
			self.Minimized = true
			self.Anim = false
		end
	end
end

local SetExpandParams = function(self, width, height, minwidth, minheight, speed)
	if (not self.ParamsSet) then
		self.NormalWidth = width
		self.MinWidth = minwidth
		self.NormalHeight = height
		self.MinHeight = minheight
		self.MoveSpeed = speed
		self.Anim = false
		self.ParamsSet = true
	end
end

local ToggleExpand = function(self, minimized)
	if (not self.ParamsSet) then
		SetExpandParams(self, self:GetWidth(), self:GetHeight(), 2, 2, true, 10)
	end
	
	self.Minimized = minimized
	
	if self.Minimized then
		self:Show()
		self:SetScript("OnUpdate", Open)
	else
		self:SetScript("OnUpdate", Close)
	end
end

-- Functions
local UIFrameFadeIn = UIFrameFadeIn
local UIFrameFadeOut = UIFrameFadeOut
local RAID_CLASS_COLORS = RAID_CLASS_COLORS
local UnitClass = UnitClass

local CreateGlow = function(self)
	local Shadow = CreateFrame("Frame", nil, self)
	Shadow:SetFrameLevel(1)
	Shadow:SetFrameStrata(self:GetFrameStrata())
	Shadow:Point("TOPLEFT", -3, 3)
	Shadow:Point("BOTTOMLEFT", -3, -3)
	Shadow:Point("TOPRIGHT", 3, 3)
	Shadow:Point("BOTTOMRIGHT", 3, -3)
	Shadow:SetBackdrop({ 
		edgeFile = C["media"].glowTex, edgeSize = T.Scale(3),
		insets = {left = T.Scale(10), right = T.Scale(10), top = T.Scale(10), bottom = T.Scale(10)},
	})
	Shadow:SetBackdropColor(0, 0, 0, 0)
	Shadow:SetBackdropBorderColor(0, 0, 0, 0.5)
	
	return Shadow
end

local CreateGlowObjects = function(self, r, g, b)
	if (not self.Previous) then
		self.Previous = CreateGlow(self)
	end
	
	if (not self.Current) then
		self.Current = CreateGlow(self)
	end
	
	self.Current:SetAlpha(0)
	self.Previous:SetAlpha(1)
	
	self.Previous:SetBackdropBorderColor(r or 1, g or 1, b or 1)
end

local TransformGlow = function(self, r, g, b)
	if (self.Previous:GetAlpha() == 1) then
		self.Current:SetBackdropBorderColor(r or 1, g or 1, b or 1)
		self.Current:SetBackdropColor(r or 1, g or 1, b or 1)
		UIFrameFadeOut(self.Previous, 0.5, 1, 0)
		UIFrameFadeIn(self.Current, 0.5, 0, 1)
	elseif (self.Current:GetAlpha() == 1) then
		self.Previous:SetBackdropBorderColor(r or 1, g or 1, b or 1)
		self.Previous:SetBackdropColor(r or 1, g or 1, b or 1)
		UIFrameFadeOut(self.Current, 0.5, 1, 0)
		UIFrameFadeIn(self.Previous, 0.5, 0, 1)
	end
end

-------------------------------------------------------------------------------------------
------------------------- Addon embedding -------------------------------------------------
-------------------------------------------------------------------------------------------
-- recount hide frame
if IsAddOnLoaded("Recount") then
	local Recount = _G.Recount
	local rhide = CreateFrame("Frame", "NatzUIRecountHide", TukuiInfoLeft)
	rhide:CreatePanel("Default", 23, 23, "LEFT", TukuiInfoLeft, "RIGHT", 2, 0)
	if Recount.MainWindow:IsVisible() then
		rhide:ClearAllPoints()
		rhide:Point("BOTTOMLEFT", Recount.MainWindow, "BOTTOMRIGHT", 2, 0)
	else
		rhide:ClearAllPoints()
		rhide:Point("LEFT", TukuiInfoLeft, "RIGHT", 2, 0)
	end
	rhide:SetAlpha(0)
	rhide:SetScript("OnEnter", function() rhide:SetAlpha(1) end)
	rhide:SetScript("OnLeave", function() rhide:SetAlpha(0) end)
	rhide.Text = rhide:CreateFontString(nil, "OVERLAY")
	rhide.Text:SetFont(C.media.font, 12)
	rhide.Text:Point("CENTER", rhide, 0, 0)
	rhide.Text:SetText("|cff00AAFF <|r")
	rhide.Text:SetShadowColor(0, 0, 0)
	rhide.Text:SetShadowOffset(1.25, -1.25)
	rhide:HookScript("OnMouseDown", function()
		if Recount.MainWindow:IsVisible() then
			Recount.MainWindow.anim:Stop()
			Recount.MainWindow.anim_o:Play()
			rhide:ClearAllPoints()
			rhide.Text:SetText("|cff00AAFF >|r")
			rhide:Point("LEFT", TukuiInfoLeft, "RIGHT", 2, 0)
		else
			Recount.MainWindow.anim_o:Stop()
			Recount.MainWindow:Show()
			Recount.MainWindow.anim:Play()
			rhide:ClearAllPoints()
			rhide.Text:SetText("|cff00AAFF <|r")
			rhide:Point("BOTTOMLEFT", Recount.MainWindow, "BOTTOMRIGHT", 2, 0)
		end
	end)
end

-- skada hide frame
if IsAddOnLoaded("Skada") then
	local shide = CreateFrame("Frame", "NatzUISkadaHide", TukuiInfoLeft)
	shide:CreatePanel("Default", 23, 23, "LEFT", TukuiInfoLeft, "RIGHT", 2, 0)
	if T.Skada:IsVisible() then
		shide:ClearAllPoints()
		shide:Point("BOTTOMLEFT", T.Skada, "BOTTOMRIGHT", 2, 0)
	else
		shide:ClearAllPoints()
		shide:Point("LEFT", TukuiInfoLeft, "RIGHT", 2, 0)
	end
	shide:SetAlpha(0)
	shide:SetScript("OnEnter", function() shide:SetAlpha(1) end)
	shide:SetScript("OnLeave", function() shide:SetAlpha(0) end)
	shide.Text = shide:CreateFontString(nil, "OVERLAY")
	shide.Text:SetFont(C.media.font, 12)
	shide.Text:Point("CENTER", shide, 0, 0)
	shide.Text:SetText("|cff00AAFF <|r")
	shide.Text:SetShadowColor(0, 0, 0)
	shide.Text:SetShadowOffset(1.25, -1.25)
	shide:HookScript("OnMouseDown", function()
		if T.Skada:IsVisible() then
			T.Skada.anim:Stop()
			T.Skada.anim_o:Play()
			shide:ClearAllPoints()
			shide.Text:SetText("|cff00AAFF <|r")
			shide:Point("LEFT", TukuiInfoLeft, "RIGHT", 2, 0)
		else
			T.Skada.anim_o:Stop()
			T.Skada:Show()
			T.Skada.anim:Play()
			shide:ClearAllPoints()
			shide.Text:SetText("|cff00AAFF >|r")
			shide:Point("BOTTOMLEFT", T.Skada, "BOTTOMRIGHT", 2, 0)
		end
	end)
end
-- omen hide frame
if IsAddOnLoaded("Omen") then
	local ohide = CreateFrame("Frame", "NatzUIOmenHide", TukuiInfoRight)
	ohide:CreatePanel("Default", 23, 23, "RIGHT", TukuiInfoRight, "LEFT", -2, 0)
	if OmenAnchor:IsVisible() then
		ohide:ClearAllPoints()
		ohide:Point("BOTTOMRIGHT", OmenAnchor, "BOTTOMLEFT", -2, 0)
	else
		ohide:ClearAllPoints()
		ohide:Point("RIGHT", TukuiInfoRight, "LEFT", -2, 0)
	end
	ohide:SetAlpha(0)
	ohide:SetScript("OnEnter", function() ohide:SetAlpha(1) end)
	ohide:SetScript("OnLeave", function() ohide:SetAlpha(0) end)
	ohide.Text = ohide:CreateFontString(nil, "OVERLAY")
	ohide.Text:SetFont(C.media.font, 12)
	ohide.Text:Point("CENTER", ohide, 0, 0)
	ohide.Text:SetText("|cff00AAFF >|r")
	ohide.Text:SetShadowColor(0, 0, 0)
	ohide.Text:SetShadowOffset(1.25, -1.25)
	ohide:HookScript("OnMouseDown", function()
		if OmenAnchor:IsVisible() then
			OmenAnchor.anim:Stop()
			OmenAnchor.anim_o:Play()
			ohide:ClearAllPoints()
			ohide.Text:SetText("|cff00AAFF <|r")
			ohide:Point("RIGHT", TukuiInfoRight, "LEFT", -2, 0)
		else
			OmenAnchor.anim_o:Stop()
			OmenAnchor:Show()
			OmenAnchor.anim:Play()
			ohide:ClearAllPoints()
			ohide.Text:SetText("|cff00AAFF >|r")
			ohide:Point("BOTTOMRIGHT", OmenAnchor, "BOTTOMLEFT", -2, 0)
		end
	end)
end


----------------------------------------------------------------------------
---------------- Additional datatexts --------------------------------------
----------------------------------------------------------------------------
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
			TukuiInfoTop1:Show()
			TukuiInfoTop1.anim:Play()
			Top1v = true
		elseif Top1v == true then
			TukuiInfoTop1.anim:Stop()
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
			TukuiInfoTop2:Show()
			TukuiInfoTop2.anim:Play()
			Top2v = true
		elseif Top2v == true then
			TukuiInfoTop2.anim:Stop()
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

--------------------------------------------------------------------------------------------------
---------------------------------------- misc buttons --------------------------------------------
--------------------------------------------------------------------------------------------------
-- BUTTON RIGHT (TOGGLE MINIMAP) [Natsu]
local button2 = CreateFrame("Button", "tester2", UIParent)
button2:CreatePanel("Transparent", 60, 10, "RIGHT", TukuiTabsRightBackground, "RIGHT", -3, 0)
button2:EnableMouse(true)
local Text  = TukuiTabsRightBackground:CreateFontString(nil, "LOW")
Text:SetFont(C.media.font, C["datatext"].fontsize)
Text:SetText("|cff00AAFF Minimap|r")
Text:SetHeight(15)
Text:SetPoint("RIGHT", TukuiTabsRightBackground, "RIGHT", -10, 0)
button2:RegisterForClicks("AnyUp")
button2:SetAlpha(0)
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

