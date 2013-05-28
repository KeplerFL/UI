local T, C, L = unpack(select(2, ...)) -- Import: T - functions, constants, variables; C - config; L - locales
-----------------------------------------------------------------------------
-- Copy on chatframes feature
-----------------------------------------------------------------------------

if C["chat"].enable ~= true then return end

local lines = {}
local frame = nil
local editBox = nil
local isf = nil

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

-- Example

local function CreatCopyFrame()
	frame = CreateFrame("Frame", "TukuiChatCopyFrame", UIParent)
	frame:SetTemplate("Default")
	if T.lowversion then
		frame:Width(TukuiBar1:GetWidth() + 10)
	else
		frame:Width((TukuiBar1:GetWidth() * 2) + 20)
	end
	frame:Height(250)
	frame:SetScale(1)
	frame:Point("BOTTOM", UIParent, "BOTTOM", 0, 10)
	frame:Hide()
	frame:SetFrameStrata("DIALOG")
	SetExpandParams(TukuiChatCopyFrame, TukuiChatCopyFrame:GetWidth(), TukuiChatCopyFrame:GetHeight(), 2, 2, 20) --  Set up some information on how we want to expand the frame

	
	local scrollArea = CreateFrame("ScrollFrame", "TukuiChatCopyScroll", frame, "UIPanelScrollFrameTemplate")
	scrollArea:Point("TOPLEFT", frame, "TOPLEFT", 8, -30)
	scrollArea:Point("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -30, 8)

	editBox = CreateFrame("EditBox", "CopyBox", frame)
	editBox:SetMultiLine(true)
	editBox:SetMaxLetters(99999)
	editBox:EnableMouse(true)
	editBox:SetAutoFocus(false)
	editBox:SetFontObject(ChatFontNormal)
	if T.lowversion then
		editBox:Width(TukuiBar1:GetWidth() + 10)
	else
		editBox:Width((TukuiBar1:GetWidth() * 2) + 20)
	end
	editBox:Height(250)
	editBox:SetScript("OnEscapePressed", function() frame.anim:Stop() frame.anim_o:Play() end)

	scrollArea:SetScrollChild(editBox)

	local close = CreateFrame("Button", "CopyCloseButton", frame, "UIPanelCloseButton")
	close:SetPoint("TOPRIGHT", frame, "TOPRIGHT")
	T.SkinCloseButton(close)
	T.SkinScrollBar(TukuiChatCopyScrollScrollBar)

	isf = true
end

local function GetLines(...)
	--[[		Grab all those lines		]]--
	local ct = 1
	for i = select("#", ...), 1, -1 do
		local region = select(i, ...)
		if region:GetObjectType() == "FontString" then
			lines[ct] = tostring(region:GetText())
			ct = ct + 1
		end
	end
	return ct - 1
end

local function Copy(cf)
	local _, size = cf:GetFont()
	FCF_SetChatWindowFontSize(cf, cf, 0.01)
	local lineCt = GetLines(cf:GetRegions())
	local text = table.concat(lines, "\n", 1, lineCt)
	FCF_SetChatWindowFontSize(cf, cf, size)
	if not isf then CreatCopyFrame() end
	if frame:IsShown() then 
	frame.anim:Stop()
	frame.anim_o:Play()
	return end
	frame.anim_o:Stop()
	frame:Show()
	frame.anim:Play()
	editBox:SetText(text)
end

local function ChatCopyButtons()
	for i = 1, NUM_CHAT_WINDOWS do
		local cf = _G[format("ChatFrame%d",  i)]
		local button = CreateFrame("Button", format("TukuiButtonCF%d", i), cf)
		button:SetPoint("TOPRIGHT", 0, 0)
		button:Height(20)
		button:Width(20)
		button:SetNormalTexture(C.media.copyicon)
		button:SetAlpha(0)
		button:SetTemplate("Default")
		button:SetScript("OnClick", function(self)
			if TukuiChatCopyFrame.Anim then
				return
			end
			if TukuiChatCopyFrame.Minimized then
				ToggleExpand(TukuiChatCopyFrame, true)
			else
				ToggleExpand(TukuiChatCopyFrame, false)
			end
		end)

	end
end
ChatCopyButtons()

-- little fix for RealID text copy/paste (real name bug)
for i=1, NUM_CHAT_WINDOWS do
	local editbox = _G["ChatFrame"..i.."EditBox"]
	editbox:HookScript("OnTextChanged", function(self)
		local text = self:GetText()
		
		local new, found = gsub(text, "|Kf(%S+)|k(%S+)%s(%S+)k:%s", "%2 %3: ")
		
		if found > 0 then
			new = new:gsub('|', '')
			self:SetText(new)
		end
	end)
end