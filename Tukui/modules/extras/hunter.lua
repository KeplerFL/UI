local T, C, L = unpack(select(2, ...))
if (T.myclass ~= "HUNTER") then return end
 --[[
local PetHappiness = CreateFrame("Frame")
PetHappiness.happiness = GetPetHappiness()

local OnEvent = function(self, event, unit)
	local happiness = GetPetHappiness()
	local hunterPet = select(2, HasPetUI())
	
	if (event == "UNIT_HAPPINESS" and happiness and hunterPet and self.happiness ~= happiness) then
		-- happiness has changed
		self.happiness = happiness
		if (happiness == 1) then
			DEFAULT_CHAT_FRAME:AddMessage(tukuilocal.hunter_unhappy, 1, 0, 0)
		elseif (happiness == 2) then
			DEFAULT_CHAT_FRAME:AddMessage(tukuilocal.hunter_content, 1, 1, 0)
		elseif (happiness == 3) then
			DEFAULT_CHAT_FRAME:AddMessage(tukuilocal.hunter_happy, 0, 1, 0)
		end
	elseif (event == "UNIT_PET") then
		self.happiness = happiness
		if (happiness == 1) then
			DEFAULT_CHAT_FRAME:AddMessage(tukuilocal.hunter_unhappy, 1, 0, 0)
		end
	end
end
PetHappiness:RegisterEvent('UNIT_HAPPINESS')
PetHappiness:RegisterEvent("UNIT_PET")
PetHappiness:SetScript("OnEvent", OnEvent)]]--

local hidden = CreateFrame("Frame", "HiddenButton", TukuiTabsLeftBackground)
hidden:CreatePanel("Default", 20, 20, "BOTTOMRIGHT", TukuiTabsLeftBackground, "TOPRIGHT", 0, 4)
local HText  = hidden:CreateFontString(nil, "OVERLAY")
 HText:SetFont(C.media.font, C["datatext"].fontsize)
 HText:SetPoint("CENTER", hidden, -2, 0)
 HText:SetPoint('TOP', hidden, 0, -3)
 HText:SetText("|cffFFFFFF H")
 
 local dragons = CreateFrame("Frame", "DragonButton", TukuiChatBackgroundLeft)
dragons:CreatePanel("Default", 20, 20, "RIGHT", hidden, "LEFT", -2, 0)
local DText  = dragons:CreateFontString(nil, "OVERLAY")
 DText:SetFont(C.media.font, C["datatext"].fontsize)
 DText:SetPoint("CENTER", dragons, -2, 0)
 DText:SetPoint('TOP', dragons, 0, -3)
 DText:SetText("|cffFFFFFF D")
 
  local humanoids = CreateFrame("Frame", "HumanButton", TukuiChatBackgroundLeft)
humanoids:CreatePanel("Default", 20, 20, "RIGHT", dragons, "LEFT", -2, 0)
local UText  = humanoids:CreateFontString(nil, "OVERLAY")
 UText:SetFont(C.media.font, C["datatext"].fontsize)
 UText:SetPoint("CENTER", humanoids, -2, 0)
 UText:SetPoint('TOP', humanoids, 0, -3)
 UText:SetText("|cffFFFFFF U")

   local beast = CreateFrame("Frame", "BeastButton", TukuiChatBackgroundLeft)
beast:CreatePanel("Default", 20, 20, "RIGHT", humanoids, "LEFT", -2, 0)
local BText  = beast:CreateFontString(nil, "OVERLAY")
 BText:SetFont(C.media.font, C["datatext"].fontsize)
 BText:SetPoint("CENTER", beast, -2, 0)
 BText:SetPoint('TOP', beast, 0, -3)
 BText:SetText("|cffFFFFFF B")
 
 hidden:EnableMouse(true)
 dragons:EnableMouse(true)
 humanoids:EnableMouse(true)
 beast:EnableMouse(true)
 
 hidden:HookScript("OnMouseDown", function()
CastSpellByName("Track Hidden")
 end)
 
 dragons:HookScript("OnMousEDown", function()
CastSpellByName("Track Dragonkin")
 end)
 
 humanoids:HookScript("OnMouseDown", function()
CastSpellByName("Track Humanoids")
 end)
 
 beast:HookScript("OnMouseDown", function()
CastSpellByName("Track Beasts")
 end)