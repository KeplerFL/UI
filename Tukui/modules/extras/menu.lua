local T, C, L = unpack(select(2, ...)) -- Import: T - functions, constants, variables; C - config; L - locales
-- create button function --thanks to Kacaos
local function CreateUIButton(name, parent, text)
	local b = CreateFrame("Button", name, parent, "SecureActionButtonTemplate")
	b:Size (120, 30)
	b:StripTextures(true)
	b:SetTemplate("Default")
	b:SetBackdropColor(.06,.06,.06)
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
			self.text:Show()
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
		SetExpandParams(self, self:GetWidth(), self:GetHeight(), 2, 2, true, 20)
	end
	
	self.Minimized = minimized
	
	if self.Minimized then
		self:Show()
		self.text:Hide()
		self:SetScript("OnUpdate", Open)
	else
		self.text:Hide()
		self:SetScript("OnUpdate", Close)
	end
end

local toggle = function()
	if MUIButton.Anim then
		return
	end

	if MUIButton.Minimized then
		ToggleExpand(MUIButton, true)
		ToggleExpand(CButton, true)
		ToggleExpand(TButton, true)
		ToggleExpand(RButton, true)
		ToggleExpand(CLButton, true)
	else
		ToggleExpand(MUIButton, false)
		ToggleExpand(CButton, false)
		ToggleExpand(TButton, false)
		ToggleExpand(RButton, false)
		ToggleExpand(CLButton, false)
	end
end

-- menu button
local menu = CreateFrame("Button", "MenuButton", TukuiTabsLeftBackground)
menu:Size(60, 15)
menu:SetTemplate("Transparent")
menu:Point("RIGHT", -3, 0)
menu:SetBackdropBorderColor(19/255, 19/255, 19/255, .7)
menu.Text = menu:CreateFontString(nil, "OVERLAY")
menu.Text:SetFont(C.media.font, 12)
menu.Text:Point("CENTER", menu, 0, 0)
menu.Text:SetText("|cff00AAFF Menu|r")
menu.Text:SetShadowColor(0, 0, 0)
menu.Text:SetShadowOffset(1.25, -1.25)

menu:SetScript("OnClick", function(self)
	toggle()
end)
-- move ui button
CreateUIButton("MUIButton", UIParent, "Move UI")
MUIButton:SetAttribute("type1", "macro")
MUIButton:SetAttribute("macrotext1", "/moveui")
MUIButton.text:SetFont(C.media.font, C["datatext"].fontsize)
MUIButton.text:SetShadowOffset(0,0)
MUIButton:Point("CENTER", UIParent, "CENTER", 0, 50)
MUIButton:EnableMouse(true)
MUIButton:HookScript("OnEnter", function(self)
          GameTooltip:SetOwner(self, "ANCHOR_TOPRIGHT", -75, -4)
          GameTooltip:AddLine("Move Ui", .6, .6, .6, .6, .6, 1)
          GameTooltip:AddLine("Click to toggle move some elements", 1, 1, 1, 1, 1, 1)
          GameTooltip:Show()
        end)
MUIButton:HookScript("OnLeave", function(self) GameTooltip:Hide() end)
MUIButton:Hide()
MUIButton.Minimized=true
MUIButton.Anim=false
SetExpandParams(MUIButton, MUIButton:GetWidth(), MUIButton:GetHeight(), 2, 2, 20) --  Set up some information on how we want to expand the frame
--tukui config button
CreateUIButton("CButton", UIParent, "Config")
CButton:SetAttribute("type1", "macro")
CButton:SetAttribute("macrotext1", "/tukui")
CButton.text:SetFont(C.media.font, C["datatext"].fontsize)
CButton.text:SetShadowOffset(0,0)
CButton:Point("TOP", MUIButton, "BOTTOM", 0, -3)
CButton:SetFrameLevel(3)
CButton:EnableMouse(true)
CButton:HookScript("OnEnter", function(self)
          GameTooltip:SetOwner(self, "ANCHOR_TOPRIGHT", -75, 3)
		  GameTooltip:AddLine("ConfigUi", .6, .6, .6, .6, .6, 1)
          GameTooltip:AddLine("Click to open the ingame config for Tukui", 1, 1, 1, 1, 1, 1)
          GameTooltip:Show()
        end)
CButton:Hide()
CButton:HookScript("OnLeave", function(self) GameTooltip:Hide() end)
SetExpandParams(CButton, CButton:GetWidth(), CButton:GetHeight(), 2, 2, 20) --  Set up some information on how we want to expand the frame

-- test ui button (will test every frame-combination)
CreateUIButton("TButton", UIParent, "Test UI")
TButton.text:SetFont(C.media.font, C["datatext"].fontsize)
TButton.text:SetShadowOffset(0,0)
TButton:SetAttribute("type1", "macro")
TButton:SetAttribute("macrotext1", "/testui")
TButton:Point("TOP", CButton, "BOTTOM", 0, -3)
TButton:SetFrameLevel(3)
TButton:EnableMouse(true)
TButton:HookScript("OnEnter", function(self)
          GameTooltip:SetOwner(self, "ANCHOR_TOPRIGHT", -75, 3)
		  GameTooltip:AddLine("Test UI", .6, .6, .6, .6, .6, 1)
          GameTooltip:AddLine("Click to toggle test frames [Arena-boss-buffs]", 1, 1, 1, 1, 1, 1)
          GameTooltip:Show()
        end)
TButton:HookScript("OnLeave", function(self) GameTooltip:Hide() end)
TButton:Hide()
SetExpandParams(TButton, TButton:GetWidth(), TButton:GetHeight(), 2, 2, 20) --  Set up some information on how we want to expand the frame

-- test ui button (will test every frame-combination)
CreateUIButton("RButton", UIParent, "Reload UI")
RButton.text:SetFont(C.media.font, C["datatext"].fontsize)
RButton.text:SetShadowOffset(0,0)
RButton:SetAttribute("type1", "macro")
RButton:SetAttribute("macrotext1", "/reload")
RButton:Point("TOP", TButton, "BOTTOM", 0, -3)
RButton:SetFrameLevel(3)
RButton:EnableMouse(true)
RButton:HookScript("OnEnter", function(self)
          GameTooltip:SetOwner(self, "ANCHOR_TOPRIGHT", -75, 3)
		  GameTooltip:AddLine("Reload UI", .6, .6, .6, .6, .6, 1)
          GameTooltip:AddLine("Click to Reload UI", 1, 1, 1, 1, 1, 1)
          GameTooltip:Show()
        end)
RButton:HookScript("OnLeave", function(self) GameTooltip:Hide() end)
RButton:Hide()
SetExpandParams(RButton, RButton:GetWidth(), RButton:GetHeight(), 2, 2, 20) --  Set up some information on how we want to expand the frame

-- close button
-- test ui button (will test every frame-combination)
CreateUIButton("CLButton", UIParent, "Close")
CLButton.text:SetFont(C.media.font, C["datatext"].fontsize)
CLButton.text:SetShadowOffset(0,0)
CLButton:Point("TOP", RButton, "BOTTOM", 0, -3)
CLButton:SetFrameLevel(3)
CLButton:EnableMouse(true)
CLButton:HookScript("OnEnter", function(self)
          GameTooltip:SetOwner(self, "ANCHOR_TOPRIGHT", -75, 3)
		  GameTooltip:AddLine("Close Menu", .6, .6, .6, .6, .6, 1)
          GameTooltip:AddLine("Click to Close the menu", 1, 1, 1, 1, 1, 1)
          GameTooltip:Show()
        end)
CLButton:HookScript("OnLeave", function(self) GameTooltip:Hide() end)
CLButton:HookScript("OnMouseDown", toggle)
CLButton:Hide()
SetExpandParams(CLButton, CLButton:GetWidth(), CLButton:GetHeight(), 2, 2, 20) --  Set up some information on how we want to expand the frame