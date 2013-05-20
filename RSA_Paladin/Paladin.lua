------------------------------------------------
---- Raeli's Spell Announcer Paladin Module ----
------------------------------------------------
local RSA = LibStub("AceAddon-3.0"):GetAddon("RSA")
local L = LibStub("AceLocale-3.0"):GetLocale("RSA")
local RSA_Paladin = RSA:NewModule("Paladin")
function RSA_Paladin:OnInitialize()
	if RSA.db.profile.General.Class == "PALADIN" then
		RSA_Paladin:SetEnabledState(true)
	else
		RSA_Paladin:SetEnabledState(false)
	end
end -- End OnInitialize
function RSA_Paladin:OnEnable()
local spellinfo
local spelllinkinfo
local extraspellinfo
local extraspellinfolink
RSA.db.profile.Modules.Paladin = true -- Set state to loaded, to know if we should announce when a spell is refreshed.
local pName = UnitName("player")
local RSA_DivineGuardian = false
RSA_ItemSets = {
	["T11 Prot"] = { 60358, 60357, 60356, 60355, 60354, 652288, 65227, 65226, 65225, 65224 }, -- Modifies Guardian of Ancient Kings
}
local RSA_HolyGuardian = CreateFrame("Frame", "RSA:HG")
local RSA_HolyGuardianTimer = CreateFrame("Frame", "RSA:HolyGuardianTimer")
local RSA_HolyGuadianHeals = 0.
local HolyGuardianDuration = 12
local HolyGuardianTimeElapsed = 0.0
local ArdentDefenderHealed = false
local ResTarget = L["Unknown"]
local Ressed
local function Paladin_Spells(_, _, _, event, _, _, source, _, _, destGUID, dest, _, _, spellID, spellName, _, missType, overheal)
	local petName = UnitName("pet")
	if source == pName or source == petName then
		if (event == "SPELL_CAST_SUCCESS" and RSA.db.profile.Modules.Reminders_Loaded == true) then -- Reminder Refreshed
			local ReminderSpell = RSA.db.profile.Paladin.Reminders.SpellName
			if spellName == ReminderSpell and (dest == pName or dest == nil) then
				RSA_Reminder:SetScript("OnUpdate", nil)
				if RSA.db.profile.Reminders.RemindChannels.Chat == true then
					RSA_Print_Self(ReminderSpell .. L[" Refreshed!"])
				end
				if RSA.db.profile.Reminders.RemindChannels.RaidWarn == true then
					RSA_Print_Self_RW(ReminderSpell .. L[" Refreshed!"])
				end
			end
		end -- BUFF REMINDER
		if event == "SPELL_AURA_APPLIED" then
			if spellID == 62124 then -- HAND OF RECKONING
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Paladin.Spells.HandOfReckoning.Messages.Start ~= "" then
					if RSA.db.profile.Paladin.Spells.HandOfReckoning.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.HandOfReckoning.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.HandOfReckoning.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.HandOfReckoning.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Paladin.Spells.HandOfReckoning.CustomChannel.Channel)
					end
					if RSA.db.profile.Paladin.Spells.HandOfReckoning.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.HandOfReckoning.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.HandOfReckoning.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Paladin.Spells.HandOfReckoning.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.HandOfReckoning.Party == true then
						if RSA.db.profile.Paladin.Spells.HandOfReckoning.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.HandOfReckoning.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.HandOfReckoning.Raid == true then
						if RSA.db.profile.Paladin.Spells.HandOfReckoning.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.HandOfReckoning.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- HAND OF RECKONING
			if spellID == 31790 then -- RIGHTEOUS DEFENSE
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Paladin.Spells.RighteousDefense.Messages.Start ~= "" then
					if RSA.db.profile.Paladin.Spells.RighteousDefense.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.RighteousDefense.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.RighteousDefense.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.RighteousDefense.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Paladin.Spells.RighteousDefense.CustomChannel.Channel)
					end
					if RSA.db.profile.Paladin.Spells.RighteousDefense.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.RighteousDefense.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.RighteousDefense.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Paladin.Spells.RighteousDefense.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.RighteousDefense.Party == true then
						if RSA.db.profile.Paladin.Spells.RighteousDefense.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.RighteousDefense.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.RighteousDefense.Raid == true then
						if RSA.db.profile.Paladin.Spells.RighteousDefense.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.RighteousDefense.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- RIGHTEOUS DEFENSE
			if spellID == 25771 then -- FORBEARANCE
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Paladin.Spells.Forbearance.Messages.Start ~= "" then
					if RSA.db.profile.Paladin.Spells.Forbearance.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.Forbearance.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- FORBEARANCE
			if spellID == 10326 then -- TURN EVIL
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Paladin.Spells.TurnEvil.Messages.Start ~= "" then
					if RSA.db.profile.Paladin.Spells.TurnEvil.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.TurnEvil.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.TurnEvil.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.TurnEvil.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Paladin.Spells.TurnEvil.CustomChannel.Channel)
					end
					if RSA.db.profile.Paladin.Spells.TurnEvil.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.TurnEvil.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.TurnEvil.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Paladin.Spells.TurnEvil.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.TurnEvil.Party == true then
						if RSA.db.profile.Paladin.Spells.TurnEvil.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.TurnEvil.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.TurnEvil.Raid == true then
						if RSA.db.profile.Paladin.Spells.TurnEvil.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.TurnEvil.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- TURN EVIL
			if spellID == 853 then -- HAMMER OF JUSTICE
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Paladin.Spells.HammerOfJustice.Messages.Start ~= "" then
					if RSA.db.profile.Paladin.Spells.HammerOfJustice.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.HammerOfJustice.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.HammerOfJustice.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.HammerOfJustice.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Paladin.Spells.HammerOfJustice.CustomChannel.Channel)
					end
					if RSA.db.profile.Paladin.Spells.HammerOfJustice.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.HammerOfJustice.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.HammerOfJustice.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Paladin.Spells.HammerOfJustice.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.HammerOfJustice.Party == true then
						if RSA.db.profile.Paladin.Spells.HammerOfJustice.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.HammerOfJustice.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.HammerOfJustice.Raid == true then
						if RSA.db.profile.Paladin.Spells.HammerOfJustice.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.HammerOfJustice.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- HAMMER OF JUSTICE
			if spellID == 88063 then -- GUARDED BY THE LIGHT
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[AMOUNT]"] = overheal,}
				if RSA.db.profile.Paladin.Spells.GbtL.Messages.Start ~= "" then
					if RSA.db.profile.Paladin.Spells.GbtL.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.GbtL.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.GbtL.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.GbtL.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Paladin.Spells.GbtL.CustomChannel.Channel)
					end
					if RSA.db.profile.Paladin.Spells.GbtL.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.GbtL.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.GbtL.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Paladin.Spells.GbtL.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.GbtL.Party == true then
						if RSA.db.profile.Paladin.Spells.GbtL.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.GbtL.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.GbtL.Raid == true then
						if RSA.db.profile.Paladin.Spells.GbtL.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.GbtL.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- GUARDED BY THE LIGHT
		end -- IF EVENT IS SPELL_AURA_APPLIED
		if event == "SPELL_CAST_SUCCESS" then
			if spellID == 31850 then -- ARDENT DEFENDER
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				ArdentDefenderHealed = false
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Paladin.Spells.ArdentDefender.Messages.Start ~= "" then
					if RSA.db.profile.Paladin.Spells.ArdentDefender.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.ArdentDefender.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.ArdentDefender.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.ArdentDefender.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Paladin.Spells.ArdentDefender.CustomChannel.Channel)
					end
					if RSA.db.profile.Paladin.Spells.ArdentDefender.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.ArdentDefender.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.ArdentDefender.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Paladin.Spells.ArdentDefender.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.ArdentDefender.Party == true then
						if RSA.db.profile.Paladin.Spells.ArdentDefender.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.ArdentDefender.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.ArdentDefender.Raid == true then
						if RSA.db.profile.Paladin.Spells.ArdentDefender.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.ArdentDefender.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- ARDENT DEFENDER
			if spellID == 31821 then -- AURA MASTERY
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Paladin.Spells.AuraMastery.Messages.Start ~= "" then
					if RSA.db.profile.Paladin.Spells.AuraMastery.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.AuraMastery.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.AuraMastery.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.AuraMastery.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Paladin.Spells.AuraMastery.CustomChannel.Channel)
					end
					if RSA.db.profile.Paladin.Spells.AuraMastery.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.AuraMastery.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.AuraMastery.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Paladin.Spells.AuraMastery.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.AuraMastery.Party == true then
						if RSA.db.profile.Paladin.Spells.AuraMastery.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.AuraMastery.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.AuraMastery.Raid == true then
						if RSA.db.profile.Paladin.Spells.AuraMastery.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.AuraMastery.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- AURA MASTERY
			if spellID == 498 then -- DIVINE PROTECTION
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Paladin.Spells.DivineProtection.Messages.Start ~= "" then
					if RSA.db.profile.Paladin.Spells.DivineProtection.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.DivineProtection.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.DivineProtection.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.DivineProtection.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Paladin.Spells.DivineProtection.CustomChannel.Channel)
					end
					if RSA.db.profile.Paladin.Spells.DivineProtection.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.DivineProtection.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.DivineProtection.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Paladin.Spells.DivineProtection.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.DivineProtection.Party == true then
						if RSA.db.profile.Paladin.Spells.DivineProtection.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.DivineProtection.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.DivineProtection.Raid == true then
						if RSA.db.profile.Paladin.Spells.DivineProtection.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.DivineProtection.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- DIVINE PROTECTION
			if spellID == 1044 then -- HAND OF FREEDOM
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Paladin.Spells.HandOfFreedom.Messages.Start ~= "" then
					if RSA.db.profile.Paladin.Spells.HandOfFreedom.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.HandOfFreedom.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.HandOfFreedom.Whisper == true and dest ~= pName and RSA_Whisperable(destGUID) then
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
						RSA_Print_Whisper(string.gsub(RSA.db.profile.Paladin.Spells.HandOfFreedom.Messages.Start, ".%a+.", RSA_String_Replace), dest)
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					end
					if RSA.db.profile.Paladin.Spells.HandOfFreedom.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.HandOfFreedom.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Paladin.Spells.HandOfFreedom.CustomChannel.Channel)
					end
					if RSA.db.profile.Paladin.Spells.HandOfFreedom.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.HandOfFreedom.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.HandOfFreedom.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Paladin.Spells.HandOfFreedom.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.HandOfFreedom.Party == true then
						if RSA.db.profile.Paladin.Spells.HandOfFreedom.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.HandOfFreedom.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.HandOfFreedom.Raid == true then
						if RSA.db.profile.Paladin.Spells.HandOfFreedom.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.HandOfFreedom.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- HAND OF FREEDOM
			if spellID == 1022 then -- HAND OF PROTECTION
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Paladin.Spells.HandOfProtection.Messages.Start ~= "" then
					if RSA.db.profile.Paladin.Spells.HandOfProtection.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.HandOfProtection.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.HandOfProtection.Whisper == true and dest ~= pName and RSA_Whisperable(destGUID) then
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
						RSA_Print_Whisper(string.gsub(RSA.db.profile.Paladin.Spells.HandOfProtection.Messages.Start, ".%a+.", RSA_String_Replace), dest)
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					end
					if RSA.db.profile.Paladin.Spells.HandOfProtection.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.HandOfProtection.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Paladin.Spells.HandOfProtection.CustomChannel.Channel)
					end
					if RSA.db.profile.Paladin.Spells.HandOfProtection.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.HandOfProtection.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.HandOfProtection.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Paladin.Spells.HandOfProtection.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.HandOfProtection.Party == true then
						if RSA.db.profile.Paladin.Spells.HandOfProtection.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.HandOfProtection.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.HandOfProtection.Raid == true then
						if RSA.db.profile.Paladin.Spells.HandOfProtection.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.HandOfProtection.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- HAND OF PROTECTION
			if spellID == 6940 then -- HAND OF SACRIFICE
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Paladin.Spells.HandOfSacrifice.Messages.Start ~= "" then
					if RSA.db.profile.Paladin.Spells.HandOfSacrifice.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.HandOfSacrifice.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.HandOfSacrifice.Whisper == true and dest ~= pName and RSA_Whisperable(destGUID) then
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
						RSA_Print_Whisper(string.gsub(RSA.db.profile.Paladin.Spells.HandOfSacrifice.Messages.Start, ".%a+.", RSA_String_Replace), dest)
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					end
					if RSA.db.profile.Paladin.Spells.HandOfSacrifice.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.HandOfSacrifice.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Paladin.Spells.HandOfSacrifice.CustomChannel.Channel)
					end
					if RSA.db.profile.Paladin.Spells.HandOfSacrifice.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.HandOfSacrifice.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.HandOfSacrifice.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Paladin.Spells.HandOfSacrifice.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.HandOfSacrifice.Party == true then
						if RSA.db.profile.Paladin.Spells.HandOfSacrifice.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.HandOfSacrifice.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.HandOfSacrifice.Raid == true then
						if RSA.db.profile.Paladin.Spells.HandOfSacrifice.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.HandOfSacrifice.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- HAND OF SACRIFICE
			if spellID == 1038 then -- HAND OF SALVATION
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Paladin.Spells.HandOfSalvation.Messages.Start ~= "" then
					if RSA.db.profile.Paladin.Spells.HandOfSalvation.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.HandOfSalvation.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.HandOfSalvation.Whisper == true and dest ~= pName and RSA_Whisperable(destGUID) then
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
						RSA_Print_Whisper(string.gsub(RSA.db.profile.Paladin.Spells.HandOfSalvation.Messages.Start, ".%a+.", RSA_String_Replace), dest)
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					end
					if RSA.db.profile.Paladin.Spells.HandOfSalvation.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.HandOfSalvation.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Paladin.Spells.HandOfSalvation.CustomChannel.Channel)
					end
					if RSA.db.profile.Paladin.Spells.HandOfSalvation.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.HandOfSalvation.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.HandOfSalvation.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Paladin.Spells.HandOfSalvation.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.HandOfSalvation.Party == true then
						if RSA.db.profile.Paladin.Spells.HandOfSalvation.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.HandOfSalvation.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.HandOfSalvation.Raid == true then
						if RSA.db.profile.Paladin.Spells.HandOfSalvation.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.HandOfSalvation.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- HAND OF SALVATION
			if spellID == 20066 then -- REPENTANCE
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Paladin.Spells.Repentance.Messages.Start ~= "" then
					if RSA.db.profile.Paladin.Spells.Repentance.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.Repentance.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.Repentance.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.Repentance.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Paladin.Spells.Repentance.CustomChannel.Channel)
					end
					if RSA.db.profile.Paladin.Spells.Repentance.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.Repentance.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.Repentance.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Paladin.Spells.Repentance.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.Repentance.Party == true then
						if RSA.db.profile.Paladin.Spells.Repentance.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.Repentance.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.Repentance.Raid == true then
						if RSA.db.profile.Paladin.Spells.Repentance.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.Repentance.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- REPENTANCE
			if spellID == 53563 then -- BEACON OF LIGHT
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Paladin.Spells.Beacon.Messages.Start ~= "" then
					if RSA.db.profile.Paladin.Spells.Beacon.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.Beacon.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.Beacon.Whisper == true and dest ~= pName and RSA_Whisperable(destGUID) then
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
						RSA_Print_Whisper(string.gsub(RSA.db.profile.Paladin.Spells.Beacon.Messages.Start, ".%a+.", RSA_String_Replace), dest)
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					end
					if RSA.db.profile.Paladin.Spells.Beacon.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.Beacon.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Paladin.Spells.Beacon.CustomChannel.Channel)
					end
					if RSA.db.profile.Paladin.Spells.Beacon.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.Beacon.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.Beacon.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Paladin.Spells.Beacon.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.Beacon.Party == true then
						if RSA.db.profile.Paladin.Spells.Beacon.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.Beacon.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.Beacon.Raid == true then
						if RSA.db.profile.Paladin.Spells.Beacon.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.Beacon.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- BEACON OF LIGHT
			if spellID == 70940 then -- DIVINE GUARDIAN
				RSA_DivineGuardian = false
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Paladin.Spells.DivineGuardian.Messages.Start ~= "" then
					if RSA.db.profile.Paladin.Spells.DivineGuardian.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.DivineGuardian.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.DivineGuardian.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.DivineGuardian.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Paladin.Spells.DivineGuardian.CustomChannel.Channel)
					end
					if RSA.db.profile.Paladin.Spells.DivineGuardian.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.DivineGuardian.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.DivineGuardian.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Paladin.Spells.DivineGuardian.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.DivineGuardian.Party == true then
						if RSA.db.profile.Paladin.Spells.DivineGuardian.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.DivineGuardian.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.DivineGuardian.Raid == true then
						if RSA.db.profile.Paladin.Spells.DivineGuardian.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.DivineGuardian.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- DIVINE GUARDIAN
			if spellID == 86150 then -- GUARDIAN OF ANCIENT KINGS
				RSA_HolyGuadianHeals = 0.0
				HolyGuardianDuration = 12
				HolyGuardianTimeElapsed = 0.0
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Paladin.Spells.GoAK.Messages.Start ~= "" then
					if RSA.db.profile.Paladin.Spells.GoAK.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.GoAK.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.GoAK.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.GoAK.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Paladin.Spells.GoAK.CustomChannel.Channel)
					end
					if RSA.db.profile.Paladin.Spells.GoAK.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.GoAK.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.GoAK.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Paladin.Spells.GoAK.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.GoAK.Party == true then
						if RSA.db.profile.Paladin.Spells.GoAK.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.GoAK.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.GoAK.Raid == true then
						if RSA.db.profile.Paladin.Spells.GoAK.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.GoAK.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
				---- START GUARDIAN TRACKING ----
				---- Holy Guardian ----
				if RSA_Talents() == tonumber(1) then -- We're Holy
					-- Start Combat Log Monitor to watch for 5 Heals, Also start a Timer for it's duration, whichever occurs first is announced.
					RSA_HolyGuardian:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
						local function HolyGuardian(_, _, _, event, _, _, source, _, _, dest, _, _, spellID, spellName, _, amount, overkill)
							if source == pName and event == "SPELL_HEAL" then
								RSA_HolyGuadianHeals = RSA_HolyGuadianHeals + 1
							end
						end
					RSA_HolyGuardian:SetScript("OnEvent", HolyGuardian)
					-- Start a timer to watch for it's duration. If we reach 5 heals before the timer ends, then we announce and stop everything,
					-- else we wait for the timer before announcing and stopping.
					HolyGuardianTimeElapsed = 0.0
					local function HolyGuardianTimer(self, elapsed)
						HolyGuardianTimeElapsed = HolyGuardianTimeElapsed + elapsed
						if RSA_HolyGuadianHeals > 4 or HolyGuardianTimeElapsed > 29 then
							HolyGuardianTimeElapsed = HolyGuardianTimeElapsed - floor(HolyGuardianTimeElapsed)
							spellinfo = GetSpellInfo(spellID)
							spelllinkinfo = GetSpellLink(spellID)
							RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
							if RSA.db.profile.Paladin.Spells.GoAK.Messages.End ~= "" then
								if RSA.db.profile.Paladin.Spells.GoAK.Local == true then
									RSA_Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.GoAK.Messages.End, ".%a+.", RSA_String_Replace))
								end
								if RSA.db.profile.Paladin.Spells.GoAK.CustomChannel.Enabled == true then
									RSA_Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.GoAK.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Paladin.Spells.GoAK.CustomChannel.Channel)
								end
								if RSA.db.profile.Paladin.Spells.GoAK.Smart.Say == true then
									RSA_Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.GoAK.Messages.End, ".%a+.", RSA_String_Replace))
								end
								if RSA.db.profile.Paladin.Spells.GoAK.Smart.RaidParty == true then
									RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Paladin.Spells.GoAK.Messages.End, ".%a+.", RSA_String_Replace))
								end
								if RSA.db.profile.Paladin.Spells.GoAK.Party == true then
									if RSA.db.profile.Paladin.Spells.GoAK.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
										RSA_Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.GoAK.Messages.End, ".%a+.", RSA_String_Replace))
								end
								if RSA.db.profile.Paladin.Spells.GoAK.Raid == true then
									if RSA.db.profile.Paladin.Spells.GoAK.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
									RSA_Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.GoAK.Messages.End, ".%a+.", RSA_String_Replace))
								end
							end
							RSA_HolyGuardianTimer:SetScript("OnUpdate", nil)
							RSA_HolyGuardian:SetScript("OnEvent", nil)
							RSA_HolyGuardian:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
						end
					end
					RSA_HolyGuardianTimer:SetScript("OnUpdate", HolyGuardianTimer)
				end
				---- Protection Guardian ----
				if RSA_Talents() == tonumber(2) then -- We're Protection
					-- Start a timer for it's duration, there are no other factors at play to it's duration.
					if RSA_SetBonus("T11 Prot") >= 4 then -- Check to see if we have the 4 Piece T11 Bonus.
						HolyGuardianDuration = 18
					else
						HolyGuardianDuration = 12
					end
					HolyGuardianTimeElapsed = 0.0
					local function HolyGuardianTimer(self, elapsed)
						HolyGuardianTimeElapsed = HolyGuardianTimeElapsed + elapsed
						if HolyGuardianTimeElapsed > HolyGuardianDuration then
							HolyGuardianTimeElapsed = HolyGuardianTimeElapsed - floor(HolyGuardianTimeElapsed)
							spellinfo = GetSpellInfo(spellID)
							spelllinkinfo = GetSpellLink(spellID)
							RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
							if RSA.db.profile.Paladin.Spells.GoAK.Messages.End ~= "" then
								if RSA.db.profile.Paladin.Spells.GoAK.Local == true then
									RSA_Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.GoAK.Messages.End, ".%a+.", RSA_String_Replace))
								end
								if RSA.db.profile.Paladin.Spells.GoAK.CustomChannel.Enabled == true then
									RSA_Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.GoAK.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Paladin.Spells.GoAK.CustomChannel.Channel)
								end
								if RSA.db.profile.Paladin.Spells.GoAK.Smart.Say == true then
									RSA_Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.GoAK.Messages.End, ".%a+.", RSA_String_Replace))
								end
								if RSA.db.profile.Paladin.Spells.GoAK.Smart.RaidParty == true then
									RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Paladin.Spells.GoAK.Messages.End, ".%a+.", RSA_String_Replace))
								end
								if RSA.db.profile.Paladin.Spells.GoAK.Party == true then
									if RSA.db.profile.Paladin.Spells.GoAK.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
										RSA_Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.GoAK.Messages.End, ".%a+.", RSA_String_Replace))
								end
								if RSA.db.profile.Paladin.Spells.GoAK.Raid == true then
									if RSA.db.profile.Paladin.Spells.GoAK.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
									RSA_Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.GoAK.Messages.End, ".%a+.", RSA_String_Replace))
								end
							end
							RSA_HolyGuardianTimer:SetScript("OnUpdate", nil)
						end
					end
					RSA_HolyGuardianTimer:SetScript("OnUpdate", HolyGuardianTimer)
				end
				---- Retribution Guardian ----
				if RSA_Talents() == tonumber(3) then -- We're Retribution
					-- Start a timer for it's duration, can it be attacked? If so, we need to watch for that too.
					HolyGuardianTimeElapsed = 0.0
					local function HolyGuardianTimer(self, elapsed)
						HolyGuardianTimeElapsed = HolyGuardianTimeElapsed + elapsed
						if HolyGuardianTimeElapsed > HolyGuardianDuration then
							HolyGuardianTimeElapsed = HolyGuardianTimeElapsed - floor(HolyGuardianTimeElapsed)
							spellinfo = GetSpellInfo(spellID)
							spelllinkinfo = GetSpellLink(spellID)
							RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
							if RSA.db.profile.Paladin.Spells.GoAK.Messages.End ~= "" then
								if RSA.db.profile.Paladin.Spells.GoAK.Local == true then
									RSA_Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.GoAK.Messages.End, ".%a+.", RSA_String_Replace))
								end
								if RSA.db.profile.Paladin.Spells.GoAK.CustomChannel.Enabled == true then
									RSA_Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.GoAK.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Paladin.Spells.GoAK.CustomChannel.Channel)
								end
								if RSA.db.profile.Paladin.Spells.GoAK.Smart.Say == true then
									RSA_Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.GoAK.Messages.End, ".%a+.", RSA_String_Replace))
								end
								if RSA.db.profile.Paladin.Spells.GoAK.Smart.RaidParty == true then
									RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Paladin.Spells.GoAK.Messages.End, ".%a+.", RSA_String_Replace))
								end
								if RSA.db.profile.Paladin.Spells.GoAK.Party == true then
									if RSA.db.profile.Paladin.Spells.GoAK.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
										RSA_Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.GoAK.Messages.End, ".%a+.", RSA_String_Replace))
								end
								if RSA.db.profile.Paladin.Spells.GoAK.Raid == true then
									if RSA.db.profile.Paladin.Spells.GoAK.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
									RSA_Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.GoAK.Messages.End, ".%a+.", RSA_String_Replace))
								end
							end
							RSA_HolyGuardianTimer:SetScript("OnUpdate", nil)
						end
					end
					RSA_HolyGuardianTimer:SetScript("OnUpdate", HolyGuardianTimer)
				end
				---- END GUARDIAN TRACKING ----
			end -- GUARDIAN OF ANCIENT KINGS
			if spellID == 82327 then -- HOLY RADIANCE
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Paladin.Spells.HolyRadiance.Messages.Start ~= "" then
					if RSA.db.profile.Paladin.Spells.HolyRadiance.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.HolyRadiance.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.HolyRadiance.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.HolyRadiance.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Paladin.Spells.HolyRadiance.CustomChannel.Channel)
					end
					if RSA.db.profile.Paladin.Spells.HolyRadiance.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.HolyRadiance.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.HolyRadiance.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Paladin.Spells.HolyRadiance.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.HolyRadiance.Party == true then
						if RSA.db.profile.Paladin.Spells.HolyRadiance.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.HolyRadiance.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.HolyRadiance.Raid == true then
						if RSA.db.profile.Paladin.Spells.HolyRadiance.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.HolyRadiance.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- HOLY RADIANCE
			if spellID == 54428 then -- DIVINE PLEA
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Paladin.Spells.DivinePlea.Messages.Start ~= "" then
					if RSA.db.profile.Paladin.Spells.DivinePlea.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.DivinePlea.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.DivinePlea.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.DivinePlea.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Paladin.Spells.DivinePlea.CustomChannel.Channel)
					end
					if RSA.db.profile.Paladin.Spells.DivinePlea.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.DivinePlea.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.DivinePlea.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Paladin.Spells.DivinePlea.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.DivinePlea.Party == true then
						if RSA.db.profile.Paladin.Spells.DivinePlea.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.DivinePlea.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.DivinePlea.Raid == true then
						if RSA.db.profile.Paladin.Spells.DivinePlea.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.DivinePlea.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- DIVINE PLEA
			if spellID == 20925 then -- HOLY SHIELD
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Paladin.Spells.HolyShield.Messages.Start ~= "" then
					if RSA.db.profile.Paladin.Spells.HolyShield.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.HolyShield.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.HolyShield.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.HolyShield.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Paladin.Spells.HolyShield.CustomChannel.Channel)
					end
					if RSA.db.profile.Paladin.Spells.HolyShield.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.HolyShield.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.HolyShield.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Paladin.Spells.HolyShield.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.HolyShield.Party == true then
						if RSA.db.profile.Paladin.Spells.HolyShield.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.HolyShield.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.HolyShield.Raid == true then
						if RSA.db.profile.Paladin.Spells.HolyShield.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.HolyShield.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- HOLY SHIELD
			if spellID == 642 then -- DIVINE SHIELD
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Paladin.Spells.DivineShield.Messages.Start ~= "" then
					if RSA.db.profile.Paladin.Spells.DivineShield.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.DivineShield.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.DivineShield.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.DivineShield.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Paladin.Spells.DivineShield.CustomChannel.Channel)
					end
					if RSA.db.profile.Paladin.Spells.DivineShield.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.DivineShield.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.DivineShield.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Paladin.Spells.DivineShield.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.DivineShield.Party == true then
						if RSA.db.profile.Paladin.Spells.DivineShield.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.DivineShield.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.DivineShield.Raid == true then
						if RSA.db.profile.Paladin.Spells.DivineShield.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.DivineShield.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- DIVINE SHIELD
			if spellID == 31884 then -- AVENGING WRATH
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Paladin.Spells.AvengingWrath.Messages.Start ~= "" then
					if RSA.db.profile.Paladin.Spells.AvengingWrath.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.AvengingWrath.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.AvengingWrath.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.AvengingWrath.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Paladin.Spells.AvengingWrath.CustomChannel.Channel)
					end
					if RSA.db.profile.Paladin.Spells.AvengingWrath.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.AvengingWrath.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.AvengingWrath.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Paladin.Spells.AvengingWrath.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.AvengingWrath.Party == true then
						if RSA.db.profile.Paladin.Spells.AvengingWrath.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.AvengingWrath.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.AvengingWrath.Raid == true then
						if RSA.db.profile.Paladin.Spells.AvengingWrath.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.AvengingWrath.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- AVENGING WRATH
		end -- IF EVENT IS SPELL_CAST_SUCCESS
		if event == "SPELL_INTERRUPT" then
			if spellID == 96231 then -- REBUKE
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				extraspellinfo = GetSpellInfo(missType)
				extraspellinfolink = GetSpellLink(missType)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[TARSPELL]"] = extraspellinfo, ["[TARLINK]"] = extraspellinfolink,}
				if RSA.db.profile.Paladin.Spells.Rebuke.Messages.Start ~= "" then
					if RSA.db.profile.Paladin.Spells.Rebuke.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.Rebuke.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.Rebuke.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.Rebuke.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Paladin.Spells.Rebuke.CustomChannel.Channel)
					end
					if RSA.db.profile.Paladin.Spells.Rebuke.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.Rebuke.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.Rebuke.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Paladin.Spells.Rebuke.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.Rebuke.Party == true then
						if RSA.db.profile.Paladin.Spells.Rebuke.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.Rebuke.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.Rebuke.Raid == true then
						if RSA.db.profile.Paladin.Spells.Rebuke.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.Rebuke.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- REBUKE
			if spellID == 31935 then -- AVENGERS SHIELD
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				extraspellinfo = GetSpellInfo(missType)
				extraspellinfolink = GetSpellLink(missType)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[TARSPELL]"] = extraspellinfo, ["[TARLINK]"] = extraspellinfolink,}
				if RSA.db.profile.Paladin.Spells.AvengersShield.Messages.Start ~= "" then
					if RSA.db.profile.Paladin.Spells.AvengersShield.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.AvengersShield.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.AvengersShield.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.AvengersShield.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Paladin.Spells.AvengersShield.CustomChannel.Channel)
					end
					if RSA.db.profile.Paladin.Spells.AvengersShield.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.AvengersShield.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.AvengersShield.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Paladin.Spells.AvengersShield.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.AvengersShield.Party == true then
						if RSA.db.profile.Paladin.Spells.AvengersShield.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.AvengersShield.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.AvengersShield.Raid == true then
						if RSA.db.profile.Paladin.Spells.AvengersShield.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.AvengersShield.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- AVENGERS SHIELD
		end -- IF EVENT IS SPELL_INTERRUPT
		if event == "SPELL_DISPEL" then
			if spellID == 4987 then -- CLEANSE
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				extraspellinfo = GetSpellInfo(missType)
				extraspellinfolink = GetSpellLink(missType)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[AURA]"] = extraspellinfo, ["[AURALINK]"] = extraspellinfolink,}
				if RSA.db.profile.Paladin.Spells.Cleanse.Messages.Start ~= "" then
					if RSA.db.profile.Paladin.Spells.Cleanse.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.Cleanse.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.Cleanse.Whisper == true and dest ~= pName and RSA_Whisperable(destGUID) then
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
						RSA_Print_Whisper(string.gsub(RSA.db.profile.Paladin.Spells.Cleanse.Messages.End, ".%a+.", RSA_String_Replace), dest)
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					end
					if RSA.db.profile.Paladin.Spells.Cleanse.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.Cleanse.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Paladin.Spells.Cleanse.CustomChannel.Channel)
					end
					if RSA.db.profile.Paladin.Spells.Cleanse.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.Cleanse.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.Cleanse.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Paladin.Spells.Cleanse.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.Cleanse.Party == true then
						if RSA.db.profile.Paladin.Spells.Cleanse.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.Cleanse.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.Cleanse.Raid == true then
						if RSA.db.profile.Paladin.Spells.Cleanse.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.Cleanse.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- CLEANSE
		end -- IF EVENT IS SPELL_DISPEL
		if event == "SPELL_HEAL" then
			if spellID == 633 then -- LAY ON HANDS
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[AMOUNT]"] = missType - overheal, ["[OVERHEAL]"] = overheal}
				if missType == 0 then return end
				if RSA.db.profile.Paladin.Spells.LayOnHands.Messages.Start ~= "" then
					if RSA.db.profile.Paladin.Spells.LayOnHands.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.LayOnHands.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.LayOnHands.Whisper == true and dest ~= pName and RSA_Whisperable(destGUID) then
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"], ["[AMOUNT]"] = missType,}
						RSA_Print_Whisper(string.gsub(RSA.db.profile.Paladin.Spells.LayOnHands.Messages.Start, ".%a+.", RSA_String_Replace), dest)
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[AMOUNT]"] = missType,}
					end
					if RSA.db.profile.Paladin.Spells.LayOnHands.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.LayOnHands.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Paladin.Spells.LayOnHands.CustomChannel.Channel)
					end
					if RSA.db.profile.Paladin.Spells.LayOnHands.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.LayOnHands.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.LayOnHands.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Paladin.Spells.LayOnHands.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.LayOnHands.Party == true then
						if RSA.db.profile.Paladin.Spells.LayOnHands.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.LayOnHands.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.LayOnHands.Raid == true then
						if RSA.db.profile.Paladin.Spells.LayOnHands.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.LayOnHands.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- LAY ON HANDS
			if spellID == 85673 then -- WORD OF GLORY
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[AMOUNT]"] = missType - overheal, ["[OVERHEAL]"] = overheal}
				if (missType - overheal) >= tonumber(RSA.db.profile.Paladin.Spells.WordOfGlory.Minimum) then
					if RSA.db.profile.Paladin.Spells.WordOfGlory.Messages.Start ~= "" then
						if RSA.db.profile.Paladin.Spells.WordOfGlory.Local == true then
							RSA_Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.WordOfGlory.Messages.Start, ".%a+.", RSA_String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.WordOfGlory.Whisper == true and dest ~= pName and RSA_Whisperable(destGUID) then
							RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"], ["[AMOUNT]"] = missType,}
							RSA_Print_Whisper(string.gsub(RSA.db.profile.Paladin.Spells.WordOfGlory.Messages.Start, ".%a+.", RSA_String_Replace), dest)
							RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[AMOUNT]"] = missType,}
						end
						if RSA.db.profile.Paladin.Spells.WordOfGlory.CustomChannel.Enabled == true then
							RSA_Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.WordOfGlory.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Paladin.Spells.WordOfGlory.CustomChannel.Channel)
						end
						if RSA.db.profile.Paladin.Spells.WordOfGlory.Smart.Say == true then
							RSA_Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.WordOfGlory.Messages.Start, ".%a+.", RSA_String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.WordOfGlory.Smart.RaidParty == true then
							RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Paladin.Spells.WordOfGlory.Messages.Start, ".%a+.", RSA_String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.WordOfGlory.Party == true then
							if RSA.db.profile.Paladin.Spells.WordOfGlory.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
								RSA_Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.WordOfGlory.Messages.Start, ".%a+.", RSA_String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.WordOfGlory.Raid == true then
							if RSA.db.profile.Paladin.Spells.WordOfGlory.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
							RSA_Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.WordOfGlory.Messages.Start, ".%a+.", RSA_String_Replace))
						end
					end
				end
			end -- WORD OF GLORY
			if spellID == 31850 or spellID == 66235 then -- ARDENT DEFENDER
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				ArdentDefenderHealed = true
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[AMOUNT]"] = missType,}
				if RSA.db.profile.Paladin.Spells.ArdentDefender.Messages.Heal ~= "" then
					if RSA.db.profile.Paladin.Spells.ArdentDefender.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.ArdentDefender.Messages.Heal, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.ArdentDefender.Whisper == true and dest ~= pName and RSA_Whisperable(destGUID) then
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"], ["[AMOUNT]"] = missType,}
						RSA_Print_Whisper(string.gsub(RSA.db.profile.Paladin.Spells.ArdentDefender.Messages.Heal, ".%a+.", RSA_String_Replace), dest)
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[AMOUNT]"] = missType,}
					end
					if RSA.db.profile.Paladin.Spells.ArdentDefender.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.ArdentDefender.Messages.Heal, ".%a+.", RSA_String_Replace), RSA.db.profile.Paladin.Spells.ArdentDefender.CustomChannel.Channel)
					end
					if RSA.db.profile.Paladin.Spells.ArdentDefender.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.ArdentDefender.Messages.Heal, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.ArdentDefender.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Paladin.Spells.ArdentDefender.Messages.Heal, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.ArdentDefender.Party == true then
						if RSA.db.profile.Paladin.Spells.ArdentDefender.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.ArdentDefender.Messages.Heal, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.ArdentDefender.Raid == true then
						if RSA.db.profile.Paladin.Spells.ArdentDefender.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.ArdentDefender.Messages.Heal, ".%a+.", RSA_String_Replace))
					end
				end
			end -- ARDENT DEFENDER
		end -- IF EVENT IS SPELL_HEAL
		if event == "SPELL_AURA_REMOVED" then
			if spellID == 31850 and ArdentDefenderHealed == false then -- ARDENT DEFENDER
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Paladin.Spells.ArdentDefender.Messages.End ~= "" then
					if RSA.db.profile.Paladin.Spells.ArdentDefender.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.ArdentDefender.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.ArdentDefender.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.ArdentDefender.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Paladin.Spells.ArdentDefender.CustomChannel.Channel)
					end
					if RSA.db.profile.Paladin.Spells.ArdentDefender.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.ArdentDefender.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.ArdentDefender.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Paladin.Spells.ArdentDefender.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.ArdentDefender.Party == true then
						if RSA.db.profile.Paladin.Spells.ArdentDefender.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.ArdentDefender.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.ArdentDefender.Raid == true then
						if RSA.db.profile.Paladin.Spells.ArdentDefender.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.ArdentDefender.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- ARDENT DEFENDER
			if spellID == 31821 then -- AURA MASTERY
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Paladin.Spells.AuraMastery.Messages.End ~= "" then
					if RSA.db.profile.Paladin.Spells.AuraMastery.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.AuraMastery.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.AuraMastery.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.AuraMastery.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Paladin.Spells.AuraMastery.CustomChannel.Channel)
					end
					if RSA.db.profile.Paladin.Spells.AuraMastery.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.AuraMastery.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.AuraMastery.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Paladin.Spells.AuraMastery.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.AuraMastery.Party == true then
						if RSA.db.profile.Paladin.Spells.AuraMastery.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.AuraMastery.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.AuraMastery.Raid == true then
						if RSA.db.profile.Paladin.Spells.AuraMastery.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.AuraMastery.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- AURA MASTERY
			if spellID == 498 then -- DIVINE PROTECTION
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Paladin.Spells.DivineProtection.Messages.End ~= "" then
					if RSA.db.profile.Paladin.Spells.DivineProtection.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.DivineProtection.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.DivineProtection.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.DivineProtection.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Paladin.Spells.DivineProtection.CustomChannel.Channel)
					end
					if RSA.db.profile.Paladin.Spells.DivineProtection.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.DivineProtection.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.DivineProtection.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Paladin.Spells.DivineProtection.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.DivineProtection.Party == true then
						if RSA.db.profile.Paladin.Spells.DivineProtection.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.DivineProtection.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.DivineProtection.Raid == true then
						if RSA.db.profile.Paladin.Spells.DivineProtection.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.DivineProtection.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- DIVINE PROTECTION
			if spellID == 25771 then -- FORBEARANCE
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Paladin.Spells.Forbearance.Messages.End ~= "" then
					if RSA.db.profile.Paladin.Spells.Forbearance.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.Forbearance.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- FORBEARANCE
			if spellID == 1044 then -- HAND OF FREEDOM
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Paladin.Spells.HandOfFreedom.Messages.End ~= "" then
					if RSA.db.profile.Paladin.Spells.HandOfFreedom.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.HandOfFreedom.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.HandOfFreedom.Whisper == true and dest ~= pName and RSA_Whisperable(destGUID) then
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
						RSA_Print_Whisper(string.gsub(RSA.db.profile.Paladin.Spells.HandOfFreedom.Messages.End, ".%a+.", RSA_String_Replace), dest)
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					end
					if RSA.db.profile.Paladin.Spells.HandOfFreedom.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.HandOfFreedom.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Paladin.Spells.HandOfFreedom.CustomChannel.Channel)
					end
					if RSA.db.profile.Paladin.Spells.HandOfFreedom.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.HandOfFreedom.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.HandOfFreedom.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Paladin.Spells.HandOfFreedom.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.HandOfFreedom.Party == true then
						if RSA.db.profile.Paladin.Spells.HandOfFreedom.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.HandOfFreedom.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.HandOfFreedom.Raid == true then
						if RSA.db.profile.Paladin.Spells.HandOfFreedom.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.HandOfFreedom.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- HAND OF FREEDOM
			if spellID == 1022 then -- HAND OF PROTECTION
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Paladin.Spells.HandOfProtection.Messages.End ~= "" then
					if RSA.db.profile.Paladin.Spells.HandOfProtection.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.HandOfProtection.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.HandOfProtection.Whisper == true and dest ~= pName and RSA_Whisperable(destGUID) then
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
						RSA_Print_Whisper(string.gsub(RSA.db.profile.Paladin.Spells.HandOfProtection.Messages.End, ".%a+.", RSA_String_Replace), dest)
							RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					end
					if RSA.db.profile.Paladin.Spells.HandOfProtection.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.HandOfProtection.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Paladin.Spells.HandOfProtection.CustomChannel.Channel)
					end
					if RSA.db.profile.Paladin.Spells.HandOfProtection.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.HandOfProtection.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.HandOfProtection.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Paladin.Spells.HandOfProtection.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.HandOfProtection.Party == true then
						if RSA.db.profile.Paladin.Spells.HandOfProtection.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.HandOfProtection.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.HandOfProtection.Raid == true then
						if RSA.db.profile.Paladin.Spells.HandOfProtection.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.HandOfProtection.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- HAND OF PROTECTION
			if spellID == 6940 then -- HAND OF SACRIFICE
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Paladin.Spells.HandOfSacrifice.Messages.End ~= "" then
					if RSA.db.profile.Paladin.Spells.HandOfSacrifice.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.HandOfSacrifice.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.HandOfSacrifice.Whisper == true and dest ~= pName and RSA_Whisperable(destGUID) then
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
						RSA_Print_Whisper(string.gsub(RSA.db.profile.Paladin.Spells.HandOfSacrifice.Messages.End, ".%a+.", RSA_String_Replace), dest)
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					end
					if RSA.db.profile.Paladin.Spells.HandOfSacrifice.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.HandOfSacrifice.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Paladin.Spells.HandOfSacrifice.CustomChannel.Channel)
					end
					if RSA.db.profile.Paladin.Spells.HandOfSacrifice.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.HandOfSacrifice.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.HandOfSacrifice.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Paladin.Spells.HandOfSacrifice.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.HandOfSacrifice.Party == true then
						if RSA.db.profile.Paladin.Spells.HandOfSacrifice.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.HandOfSacrifice.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.HandOfSacrifice.Raid == true then
						if RSA.db.profile.Paladin.Spells.HandOfSacrifice.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.HandOfSacrifice.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- HAND OF SACRIFICE
			if spellID == 1038 then -- HAND OF SALVATION
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Paladin.Spells.HandOfSalvation.Messages.End ~= "" then
					if RSA.db.profile.Paladin.Spells.HandOfSalvation.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.HandOfSalvation.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.HandOfSalvation.Whisper == true and dest ~= pName and RSA_Whisperable(destGUID) then
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
						RSA_Print_Whisper(string.gsub(RSA.db.profile.Paladin.Spells.HandOfSalvation.Messages.End, ".%a+.", RSA_String_Replace), dest)
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					end
					if RSA.db.profile.Paladin.Spells.HandOfSalvation.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.HandOfSalvation.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Paladin.Spells.HandOfSalvation.CustomChannel.Channel)
					end
					if RSA.db.profile.Paladin.Spells.HandOfSalvation.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.HandOfSalvation.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.HandOfSalvation.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Paladin.Spells.HandOfSalvation.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.HandOfSalvation.Party == true then
						if RSA.db.profile.Paladin.Spells.HandOfSalvation.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.HandOfSalvation.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.HandOfSalvation.Raid == true then
						if RSA.db.profile.Paladin.Spells.HandOfSalvation.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.HandOfSalvation.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- HAND OF SALVATION
			if spellID == 20066 then -- REPENTANCE
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Paladin.Spells.Repentance.Messages.End ~= "" then
					if RSA.db.profile.Paladin.Spells.Repentance.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.Repentance.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.Repentance.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.Repentance.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Paladin.Spells.Repentance.CustomChannel.Channel)
					end
					if RSA.db.profile.Paladin.Spells.Repentance.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.Repentance.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.Repentance.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Paladin.Spells.Repentance.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.Repentance.Party == true then
						if RSA.db.profile.Paladin.Spells.Repentance.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.Repentance.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.Repentance.Raid == true then
						if RSA.db.profile.Paladin.Spells.Repentance.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.Repentance.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- REPENTANCE
			if spellID == 53563 then -- BEACON OF LIGHT
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Paladin.Spells.Beacon.Messages.End ~= "" then
					if RSA.db.profile.Paladin.Spells.Beacon.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.Beacon.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.Beacon.Whisper == true and dest ~= pName and RSA_Whisperable(destGUID) then
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
						RSA_Print_Whisper(string.gsub(RSA.db.profile.Paladin.Spells.Beacon.Messages.End, ".%a+.", RSA_String_Replace), dest)
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					end
					if RSA.db.profile.Paladin.Spells.Beacon.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.Beacon.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Paladin.Spells.Beacon.CustomChannel.Channel)
					end
					if RSA.db.profile.Paladin.Spells.Beacon.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.Beacon.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.Beacon.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Paladin.Spells.Beacon.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.Beacon.Party == true then
						if RSA.db.profile.Paladin.Spells.Beacon.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.Beacon.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.Beacon.Raid == true then
						if RSA.db.profile.Paladin.Spells.Beacon.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.Beacon.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- BEACON OF LIGHT
			if spellID == 10326 then -- TURN EVIL
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Paladin.Spells.TurnEvil.Messages.End ~= "" then
					if RSA.db.profile.Paladin.Spells.TurnEvil.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.TurnEvil.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.TurnEvil.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.TurnEvil.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Paladin.Spells.TurnEvil.CustomChannel.Channel)
					end
					if RSA.db.profile.Paladin.Spells.TurnEvil.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.TurnEvil.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.TurnEvil.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Paladin.Spells.TurnEvil.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.TurnEvil.Party == true then
						if RSA.db.profile.Paladin.Spells.TurnEvil.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.TurnEvil.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.TurnEvil.Raid == true then
						if RSA.db.profile.Paladin.Spells.TurnEvil.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.TurnEvil.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- TURN EVIL
			if spellID == 82327 then -- HOLY RADIANCE
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Paladin.Spells.HolyRadiance.Messages.End ~= "" then
					if RSA.db.profile.Paladin.Spells.HolyRadiance.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.HolyRadiance.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.HolyRadiance.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.HolyRadiance.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Paladin.Spells.HolyRadiance.CustomChannel.Channel)
					end
					if RSA.db.profile.Paladin.Spells.HolyRadiance.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.HolyRadiance.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.HolyRadiance.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Paladin.Spells.HolyRadiance.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.HolyRadiance.Party == true then
						if RSA.db.profile.Paladin.Spells.HolyRadiance.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.HolyRadiance.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.HolyRadiance.Raid == true then
						if RSA.db.profile.Paladin.Spells.HolyRadiance.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.HolyRadiance.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- HOLY RADIANCE
			if spellID == 54428 then -- DIVINE PLEA
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Paladin.Spells.DivinePlea.Messages.End ~= "" then
					if RSA.db.profile.Paladin.Spells.DivinePlea.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.DivinePlea.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.DivinePlea.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.DivinePlea.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Paladin.Spells.DivinePlea.CustomChannel.Channel)
					end
					if RSA.db.profile.Paladin.Spells.DivinePlea.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.DivinePlea.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.DivinePlea.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Paladin.Spells.DivinePlea.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.DivinePlea.Party == true then
						if RSA.db.profile.Paladin.Spells.DivinePlea.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.DivinePlea.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.DivinePlea.Raid == true then
						if RSA.db.profile.Paladin.Spells.DivinePlea.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.DivinePlea.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- DIVINE PLEA
			if spellID == 853 then -- HAMMER OF JUSTICE
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Paladin.Spells.HammerOfJustice.Messages.End ~= "" then
					if RSA.db.profile.Paladin.Spells.HammerOfJustice.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.HammerOfJustice.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.HammerOfJustice.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.HammerOfJustice.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Paladin.Spells.HammerOfJustice.CustomChannel.Channel)
					end
					if RSA.db.profile.Paladin.Spells.HammerOfJustice.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.HammerOfJustice.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.HammerOfJustice.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Paladin.Spells.HammerOfJustice.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.HammerOfJustice.Party == true then
						if RSA.db.profile.Paladin.Spells.HammerOfJustice.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.HammerOfJustice.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.HammerOfJustice.Raid == true then
						if RSA.db.profile.Paladin.Spells.HammerOfJustice.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.HammerOfJustice.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- HAMMER OF JUSTICE
			if spellID == 20925 then -- HOLY SHIELD
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Paladin.Spells.HolyShield.Messages.End ~= "" then
					if RSA.db.profile.Paladin.Spells.HolyShield.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.HolyShield.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.HolyShield.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.HolyShield.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Paladin.Spells.HolyShield.CustomChannel.Channel)
					end
					if RSA.db.profile.Paladin.Spells.HolyShield.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.HolyShield.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.HolyShield.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Paladin.Spells.HolyShield.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.HolyShield.Party == true then
						if RSA.db.profile.Paladin.Spells.HolyShield.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.HolyShield.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.HolyShield.Raid == true then
						if RSA.db.profile.Paladin.Spells.HolyShield.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.HolyShield.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- HOLY SHIELD
			if spellID == 70940 and RSA_DivineGuardian == false then -- DIVINE GUARDIAN
				RSA_DivineGuardian = true
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Paladin.Spells.DivineGuardian.Messages.End ~= "" then
					if RSA.db.profile.Paladin.Spells.DivineGuardian.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.DivineGuardian.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.DivineGuardian.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.DivineGuardian.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Paladin.Spells.DivineGuardian.CustomChannel.Channel)
					end
					if RSA.db.profile.Paladin.Spells.DivineGuardian.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.DivineGuardian.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.DivineGuardian.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Paladin.Spells.DivineGuardian.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.DivineGuardian.Party == true then
						if RSA.db.profile.Paladin.Spells.DivineGuardian.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.DivineGuardian.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.DivineGuardian.Raid == true then
						if RSA.db.profile.Paladin.Spells.DivineGuardian.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.DivineGuardian.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- DIVINE GUARDIAN
			if spellID == 642 then -- DIVINE SHIELD
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Paladin.Spells.DivineShield.Messages.End ~= "" then
					if RSA.db.profile.Paladin.Spells.DivineShield.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.DivineShield.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.DivineShield.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.DivineShield.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Paladin.Spells.DivineShield.CustomChannel.Channel)
					end
					if RSA.db.profile.Paladin.Spells.DivineShield.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.DivineShield.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.DivineShield.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Paladin.Spells.DivineShield.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.DivineShield.Party == true then
						if RSA.db.profile.Paladin.Spells.DivineShield.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.DivineShield.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.DivineShield.Raid == true then
						if RSA.db.profile.Paladin.Spells.DivineShield.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.DivineShield.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- DIVINE SHIELD
			if spellID == 31884 then -- AVENGING WRATH
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Paladin.Spells.AvengingWrath.Messages.End ~= "" then
					if RSA.db.profile.Paladin.Spells.AvengingWrath.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.AvengingWrath.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.AvengingWrath.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.AvengingWrath.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Paladin.Spells.AvengingWrath.CustomChannel.Channel)
					end
					if RSA.db.profile.Paladin.Spells.AvengingWrath.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.AvengingWrath.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.AvengingWrath.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Paladin.Spells.AvengingWrath.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.AvengingWrath.Party == true then
						if RSA.db.profile.Paladin.Spells.AvengingWrath.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.AvengingWrath.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.AvengingWrath.Raid == true then
						if RSA.db.profile.Paladin.Spells.AvengingWrath.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.AvengingWrath.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- AVENGING WRATH
		end -- IF EVENT IS SPELL_AURA_REMOVED
		if event == "SPELL_MISSED" and missType ~= "IMMUNE" then
			if spellID == 96231 then -- REBUKE
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				if missType == "MISS" then
					missinfo = L["missed"]
				elseif missType ~= "MISS" then
					missinfo = L["was resisted by"]
				end
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = missinfo,}
				if RSA.db.profile.Paladin.Spells.Rebuke.Messages.End ~= "" then
					if RSA.db.profile.Paladin.Spells.Rebuke.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.Rebuke.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.Rebuke.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.Rebuke.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Paladin.Spells.Rebuke.CustomChannel.Channel)
					end
					if RSA.db.profile.Paladin.Spells.Rebuke.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.Rebuke.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.Rebuke.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Paladin.Spells.Rebuke.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.Rebuke.Party == true then
						if RSA.db.profile.Paladin.Spells.Rebuke.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.Rebuke.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.Rebuke.Raid == true then
						if RSA.db.profile.Paladin.Spells.Rebuke.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.Rebuke.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- REBUKE
			if spellID == 31935 then -- AVENGERS SHIELD
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				if missType == "MISS" then
					missinfo = L["missed"]
				elseif missType ~= "MISS" then
					missinfo = L["was resisted by"]
				end
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = missinfo,}
				if RSA.db.profile.Paladin.Spells.AvengersShield.Messages.End ~= "" then
					if RSA.db.profile.Paladin.Spells.AvengersShield.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.AvengersShield.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.AvengersShield.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.AvengersShield.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Paladin.Spells.AvengersShield.CustomChannel.Channel)
					end
					if RSA.db.profile.Paladin.Spells.AvengersShield.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.AvengersShield.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.AvengersShield.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Paladin.Spells.AvengersShield.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.AvengersShield.Party == true then
						if RSA.db.profile.Paladin.Spells.AvengersShield.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.AvengersShield.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.AvengersShield.Raid == true then
						if RSA.db.profile.Paladin.Spells.AvengersShield.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.AvengersShield.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- AVENGERS SHIELD
			if spellID == 62124 then -- HAND OF RECKONING
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				if missType == "MISS" then
					missinfo = L["missed"]
				elseif missType ~= "MISS" then
					missinfo = L["was resisted by"]
				end
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = missinfo,}
				if RSA.db.profile.Paladin.Spells.HandOfReckoning.Messages.End ~= "" then
					if RSA.db.profile.Paladin.Spells.HandOfReckoning.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.HandOfReckoning.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.HandOfReckoning.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.HandOfReckoning.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Paladin.Spells.HandOfReckoning.CustomChannel.Channel)
					end
					if RSA.db.profile.Paladin.Spells.HandOfReckoning.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.HandOfReckoning.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.HandOfReckoning.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Paladin.Spells.HandOfReckoning.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.HandOfReckoning.Party == true then
						if RSA.db.profile.Paladin.Spells.HandOfReckoning.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.HandOfReckoning.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.HandOfReckoning.Raid == true then
						if RSA.db.profile.Paladin.Spells.HandOfReckoning.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.HandOfReckoning.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- HAND OF RECKONING
			if spellID == 31789 then -- RIGHTEOUS DEFENSE
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				if missType == "MISS" then
					missinfo = L["missed"]
				elseif missType ~= "MISS" then
					missinfo = L["was resisted by"]
				end
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = missinfo,}
				if RSA.db.profile.Paladin.Spells.RighteousDefense.Messages.End ~= "" then
					if RSA.db.profile.Paladin.Spells.RighteousDefense.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.RighteousDefense.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.RighteousDefense.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.RighteousDefense.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Paladin.Spells.RighteousDefense.CustomChannel.Channel)
					end
					if RSA.db.profile.Paladin.Spells.RighteousDefense.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.RighteousDefense.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.RighteousDefense.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Paladin.Spells.RighteousDefense.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.RighteousDefense.Party == true then
						if RSA.db.profile.Paladin.Spells.RighteousDefense.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.RighteousDefense.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.RighteousDefense.Raid == true then
						if RSA.db.profile.Paladin.Spells.RighteousDefense.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.RighteousDefense.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- RIGHTEOUS DEFENSE
		end -- IF EVENT IS SPELL_MISSED AND NOT IMMUNE
		if event == "SPELL_MISSED" and missType == "IMMUNE" then
			if spellID == 96231 then -- REBUKE
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = L["Immune"],}
				if RSA.db.profile.Paladin.Spells.Rebuke.Messages.Immune ~= "" then
					if RSA.db.profile.Paladin.Spells.Rebuke.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.Rebuke.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.Rebuke.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.Rebuke.Messages.Immune, ".%a+.", RSA_String_Replace), RSA.db.profile.Paladin.Spells.Rebuke.CustomChannel.Channel)
					end
					if RSA.db.profile.Paladin.Spells.Rebuke.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.Rebuke.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.Rebuke.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Paladin.Spells.Rebuke.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.Rebuke.Party == true then
						if RSA.db.profile.Paladin.Spells.Rebuke.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.Rebuke.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.Rebuke.Raid == true then
						if RSA.db.profile.Paladin.Spells.Rebuke.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.Rebuke.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
				end
			end -- REBUKE
			if spellID == 31935 then -- AVENGERS SHIELD
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = L["Immune"],}
				if RSA.db.profile.Paladin.Spells.AvengersShield.Messages.Immune ~= "" then
					if RSA.db.profile.Paladin.Spells.AvengersShield.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.AvengersShield.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.AvengersShield.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.AvengersShield.Messages.Immune, ".%a+.", RSA_String_Replace), RSA.db.profile.Paladin.Spells.AvengersShield.CustomChannel.Channel)
					end
					if RSA.db.profile.Paladin.Spells.AvengersShield.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.AvengersShield.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.AvengersShield.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Paladin.Spells.AvengersShield.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.AvengersShield.Party == true then
						if RSA.db.profile.Paladin.Spells.AvengersShield.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.AvengersShield.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.AvengersShield.Raid == true then
						if RSA.db.profile.Paladin.Spells.AvengersShield.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.AvengersShield.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
				end
			end -- AVENGERS SHIELD
			if spellID == 62124 then -- HAND OF RECKONING
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = L["Immune"],}
				if RSA.db.profile.Paladin.Spells.HandOfReckoning.Messages.Immune ~= "" then
					if RSA.db.profile.Paladin.Spells.HandOfReckoning.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.HandOfReckoning.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.HandOfReckoning.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.HandOfReckoning.Messages.Immune, ".%a+.", RSA_String_Replace), RSA.db.profile.Paladin.Spells.HandOfReckoning.CustomChannel.Channel)
					end
					if RSA.db.profile.Paladin.Spells.HandOfReckoning.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.HandOfReckoning.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.HandOfReckoning.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Paladin.Spells.HandOfReckoning.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.HandOfReckoning.Party == true then
						if RSA.db.profile.Paladin.Spells.HandOfReckoning.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.HandOfReckoning.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.HandOfReckoning.Raid == true then
						if RSA.db.profile.Paladin.Spells.HandOfReckoning.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.HandOfReckoning.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
				end
			end -- HAND OF RECKONING
			if spellID == 31789 then -- RIGHTEOUS DEFENSE
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = L["Immune"],}
				if RSA.db.profile.Paladin.Spells.RighteousDefense.Messages.Immune ~= "" then
					if RSA.db.profile.Paladin.Spells.RighteousDefense.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.RighteousDefense.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.RighteousDefense.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.RighteousDefense.Messages.Immune, ".%a+.", RSA_String_Replace), RSA.db.profile.Paladin.Spells.RighteousDefense.CustomChannel.Channel)
					end
					if RSA.db.profile.Paladin.Spells.RighteousDefense.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.RighteousDefense.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.RighteousDefense.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Paladin.Spells.RighteousDefense.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.RighteousDefense.Party == true then
						if RSA.db.profile.Paladin.Spells.RighteousDefense.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.RighteousDefense.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.RighteousDefense.Raid == true then
						if RSA.db.profile.Paladin.Spells.RighteousDefense.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.RighteousDefense.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
				end
			end -- RIGHTEOUS DEFENSE
		end -- IF EVENT IS SPELL_MISSED AND IS IMMUNE
	end -- IF SOURCE IS PLAYER
end -- END ENTIRELY
RSA_CombatLogMonitor:SetScript("OnEvent", Paladin_Spells)
------------------------------
---- Resurrection Monitor ----
------------------------------
local function Paladin_Redemption(_, event, source, spell, rank, dest, _)
	if UnitName(source) == pName then
		if spell == GetSpellInfo(7328) and RSA.db.profile.Paladin.Spells.Redemption.Messages.Start ~= "" then -- REDEMPTION
			if event == "UNIT_SPELLCAST_SENT" then
				Ressed = false
				if (dest == L["Unknown"] or dest == nil) then
					if UnitExists("target") ~= 1 or (UnitHealth("target") > 1 and UnitIsDeadOrGhost("target") ~= 1) then
						if GameTooltipTextLeft1:GetText() == nil then
							dest = L["Unknown"]
							ResTarget = L["Unknown"]
						else
							dest = string.gsub(GameTooltipTextLeft1:GetText(), L["Corpse of "], "")
							ResTarget = string.gsub(GameTooltipTextLeft1:GetText(), L["Corpse of "], "")
						end
					else
						dest = UnitName("target")
						ResTarget = UnitName("target")
					end
				else
					ResTarget = dest
				end
				spellinfo = GetSpellInfo(spell) spelllinkinfo = GetSpellLink(spell)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Paladin.Spells.Redemption.Messages.Start ~= "" then
					if RSA.db.profile.Paladin.Spells.Redemption.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.Redemption.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.Redemption.Whisper == true and dest ~= pName then
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
						RSA_Print_Whisper(string.gsub(RSA.db.profile.Paladin.Spells.Redemption.Messages.Start, ".%a+.", RSA_String_Replace), dest)
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					end
					if RSA.db.profile.Paladin.Spells.Redemption.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.Redemption.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Paladin.Spells.Redemption.CustomChannel.Channel)
					end
					if RSA.db.profile.Paladin.Spells.Redemption.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.Redemption.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.Redemption.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Paladin.Spells.Redemption.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.Redemption.Party == true then
						if RSA.db.profile.Paladin.Spells.Redemption.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.Redemption.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.Redemption.Raid == true then
						if RSA.db.profile.Paladin.Spells.Redemption.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.Redemption.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			elseif event == "UNIT_SPELLCAST_SUCCEEDED" and Ressed ~= true then
				dest = ResTarget
				Ressed = true
				if RSA.db.profile.Paladin.Spells.Redemption.Messages.End ~= "" then
					if RSA.db.profile.Paladin.Spells.Redemption.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.Redemption.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.Redemption.Whisper == true and dest ~= pName then
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
						RSA_Print_Whisper(string.gsub(RSA.db.profile.Paladin.Spells.Redemption.Messages.End, ".%a+.", RSA_String_Replace), dest)
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					end
					if RSA.db.profile.Paladin.Spells.Redemption.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.Redemption.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Paladin.Spells.Redemption.CustomChannel.Channel)
					end
					if RSA.db.profile.Paladin.Spells.Redemption.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.Redemption.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.Redemption.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Paladin.Spells.Redemption.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.Redemption.Party == true then
						if RSA.db.profile.Paladin.Spells.Redemption.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.Redemption.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.Redemption.Raid == true then
						if RSA.db.profile.Paladin.Spells.Redemption.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.Redemption.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end
		end -- REDEMPTION
	end
end -- END FUNCTION
RSA_ResMon = CreateFrame("Frame", "RSA:RM")
RSA_ResMon:RegisterEvent("UNIT_SPELLCAST_SENT")
RSA_ResMon:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
RSA_ResMon:SetScript("OnEvent", Paladin_Redemption)
end -- END ON ENABLED
function RSA_Paladin:OnDisable()
RSA_CombatLogMonitor:SetScript("OnEvent", nil)
RSA_ResMon:SetScript("OnEvent", nil)
end