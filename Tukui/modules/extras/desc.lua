local T, C, L = unpack(select(2, ...))

local nathelp = CreateFrame("Button", "NatzUIHelpFrame", UIParent)
nathelp:SetSize(490, 560)
nathelp:SetPoint("CENTER")
nathelp:SetTemplate("Transparent")
nathelp:CreateShadow("Default")
nathelp:SetFrameStrata("HIGH")
nathelp:FontString("Text", C.media.font, 13)
nathelp.Text:SetPoint("TOPLEFT", 9, -50)
nathelp.Text:SetText("ciaociaociao")
nathelp:Hide()
nathelp:SetMovable(true)
nathelp:SetScript("OnMouseDown", function() nathelp:ClearAllPoints() nathelp:StartMoving() end)
nathelp:SetScript("OnMouseUp", function() nathelp:StopMovingOrSizing() end)

local nathelp_logo = CreateFrame("Button", "NatzUIHelpFrameLogo", NatzUIHelpFrame)
nathelp_logo:SetSize(130, 38)
nathelp_logo:SetPoint("TOPLEFT", NatzUIHelpFrame, "TOPRIGHT", -100, 42)
nathelp_logo:SetTemplate("Transparent")
nathelp_logo:CreateShadow("Default")
nathelp_logo:SetFrameLevel(NatzUIHelpFrame:GetFrameLevel() + 1)
nathelp_logo:FontString("Text", C.media.font, 16)
nathelp_logo.Text:SetPoint("CENTER")
nathelp_logo.Text:SetText("NatzUI Help Frame")

local natuihelp_pic = CreateFrame("Button", "KacaosUIPic", NatzUIHelpFrame)
natuihelp_pic:SetSize(326, 70)
natuihelp_pic:SetPoint("TOPLEFT", NatzUIHelpFrame, "TOPLEFT", -30, 42)
natuihelp_pic:SetTemplate("Default")
natuihelp_pic:CreateShadow("Default")
natuihelp_pic:SetFrameLevel(NatzUIHelpFrame:GetFrameLevel() + 1)

local natui_pic_tex = natuihelp_pic:CreateTexture(nil, "OVERLAY")
natui_pic_tex:SetTexture(C.media.natzu)
natui_pic_tex:SetPoint("TOPLEFT", natuihelp_pic, "TOPLEFT", 2, -2)
natui_pic_tex:SetPoint("BOTTOMRIGHT", natuihelp_pic, "BOTTOMRIGHT", -2, 2)

SLASH_NATUIHELP1 = "/natuihelp"
SlashCmdList.NATUIHELP = function() if nathelp:IsShown() then nathelp:Hide() else nathelp:Show() end end