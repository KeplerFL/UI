﻿-----------------------------------------------
---- Raeli's Spell Announcer Hunter Module ----
-----------------------------------------------
local RSA = LibStub("AceAddon-3.0"):GetAddon("RSA")
local L = LibStub("AceLocale-3.0"):GetLocale("RSA")
local RSA_Hunter = RSA:NewModule("Hunter")
function RSA_Hunter:OnInitialize()
	if RSA.db.profile.General.Class == "HUNTER" then
		RSA_Hunter:SetEnabledState(true)
	else
		RSA_Hunter:SetEnabledState(false)
	end
end -- End OnInitialize
function RSA_Hunter:OnEnable()
RSA.db.profile.Modules.Hunter = true -- Set state to loaded, to know if we should announce when a spell is refreshed.
local pName = UnitName("player")
local RSA_MD_TAR = nil
local RSA_Misdirection_Damage = 0.0
local RSA_MDPTimer = CreateFrame("Frame", "RSA:MDPTimer")
local MDPTimeElapsed = 0.0
local RSA_MisdirectionTracker = CreateFrame("Frame", "RSA:MDT")
local function Hunter_Spells(_, _, _, event, _, _, source, _, _, destGUID, dest, _, _, spellID, spellName, _, missType)
	local petName = UnitName("pet")
	if source == pName or source == petName then
		if (event == "SPELL_CAST_SUCCESS" and RSA.db.profile.Modules.Reminders_Loaded == true) then -- Reminder Refreshed
			local ReminderSpell = RSA.db.profile.Hunter.Reminders.SpellName
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
			if spellID == 20736 then -- DISTRACTING SHOT
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Hunter.Spells.DistractingShot.Messages.Start ~= "" then
					if RSA.db.profile.Hunter.Spells.DistractingShot.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Hunter.Spells.DistractingShot.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.DistractingShot.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Hunter.Spells.DistractingShot.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Hunter.Spells.DistractingShot.CustomChannel.Channel)
					end
					if RSA.db.profile.Hunter.Spells.DistractingShot.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Hunter.Spells.DistractingShot.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.DistractingShot.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Hunter.Spells.DistractingShot.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.DistractingShot.Party == true then
						if RSA.db.profile.Hunter.Spells.DistractingShot.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Hunter.Spells.DistractingShot.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.DistractingShot.Raid == true then
						if RSA.db.profile.Hunter.Spells.DistractingShot.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Hunter.Spells.DistractingShot.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- DISTRACTING SHOT
			if spellID == 3355 then -- FREEZING TRAP
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Hunter.Spells.FreezingTrap.Messages.Start ~= "" then
					if RSA.db.profile.Hunter.Spells.FreezingTrap.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Hunter.Spells.FreezingTrap.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.FreezingTrap.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Hunter.Spells.FreezingTrap.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Hunter.Spells.FreezingTrap.CustomChannel.Channel)
					end
					if RSA.db.profile.Hunter.Spells.FreezingTrap.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Hunter.Spells.FreezingTrap.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.FreezingTrap.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Hunter.Spells.FreezingTrap.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.FreezingTrap.Party == true then
						if RSA.db.profile.Hunter.Spells.FreezingTrap.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Hunter.Spells.FreezingTrap.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.FreezingTrap.Raid == true then
						if RSA.db.profile.Hunter.Spells.FreezingTrap.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Hunter.Spells.FreezingTrap.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- FREEZING TRAP
			if spellID == 19386 then -- WYVERN STING
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Hunter.Spells.WyvernSting.Messages.Start ~= "" then
					if RSA.db.profile.Hunter.Spells.WyvernSting.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Hunter.Spells.WyvernSting.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.WyvernSting.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Hunter.Spells.WyvernSting.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Hunter.Spells.WyvernSting.CustomChannel.Channel)
					end
					if RSA.db.profile.Hunter.Spells.WyvernSting.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Hunter.Spells.WyvernSting.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.WyvernSting.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Hunter.Spells.WyvernSting.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.WyvernSting.Party == true then
						if RSA.db.profile.Hunter.Spells.WyvernSting.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Hunter.Spells.WyvernSting.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.WyvernSting.Raid == true then
						if RSA.db.profile.Hunter.Spells.WyvernSting.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Hunter.Spells.WyvernSting.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- WYVERN STING
			if spellID == 35079 then -- MISDIRECTION THREAT TRANSFER BUFF
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				dest = RSA_MD_TAR
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Hunter.Spells.Misdirection.Messages.Start ~= "" then
					if RSA.db.profile.Hunter.Spells.Misdirection.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Hunter.Spells.Misdirection.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.Misdirection.Whisper == true and dest ~= pName and RSA_Whisperable(destGUID) then
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
						RSA_Print_Whisper(string.gsub(RSA.db.profile.Hunter.Spells.Misdirection.Messages.Start, ".%a+.", RSA_String_Replace), dest)
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					end
					if RSA.db.profile.Hunter.Spells.Misdirection.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Hunter.Spells.Misdirection.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Hunter.Spells.Misdirection.CustomChannel.Channel)
					end
					if RSA.db.profile.Hunter.Spells.Misdirection.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Hunter.Spells.Misdirection.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.Misdirection.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Hunter.Spells.Misdirection.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.Misdirection.Party == true then
						if RSA.db.profile.Hunter.Spells.Misdirection.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Hunter.Spells.Misdirection.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.Misdirection.Raid == true then
						if RSA.db.profile.Hunter.Spells.Misdirection.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Hunter.Spells.Misdirection.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- MISDIRECTION THREAT TRANSFER BUFF
		end -- IF EVENT IS SPELL_AURA_APPLIED
		if event == "SPELL_CREATE" then
			if spellID == 1499 or spellID == 60202 then -- FREEZING TRAP
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Hunter.Spells.FreezingTrap.Messages.Placement ~= "" then
					if RSA.db.profile.Hunter.Spells.FreezingTrap.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Hunter.Spells.FreezingTrap.Messages.Placement, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.FreezingTrap.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Hunter.Spells.FreezingTrap.Messages.Placement, ".%a+.", RSA_String_Replace), RSA.db.profile.Hunter.Spells.FreezingTrap.CustomChannel.Channel)
					end
					if RSA.db.profile.Hunter.Spells.FreezingTrap.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Hunter.Spells.FreezingTrap.Messages.Placement, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.FreezingTrap.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Hunter.Spells.FreezingTrap.Messages.Placement, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.FreezingTrap.Party == true then
						if RSA.db.profile.Hunter.Spells.FreezingTrap.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Hunter.Spells.FreezingTrap.Messages.Placement, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.FreezingTrap.Raid == true then
						if RSA.db.profile.Hunter.Spells.FreezingTrap.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Hunter.Spells.FreezingTrap.Messages.Placement, ".%a+.", RSA_String_Replace))
					end
				end
			end -- FREEZING TRAP
		end -- IF EVENT IS SPELL_CREATE
		if event == "SPELL_CAST_SUCCESS" then
			if spellID == 82654 then -- WIDOW VENOM
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Hunter.Spells.WidowVenom.Messages.Start ~= "" then
					if RSA.db.profile.Hunter.Spells.WidowVenom.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Hunter.Spells.WidowVenom.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.WidowVenom.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Hunter.Spells.WidowVenom.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Hunter.Spells.WidowVenom.CustomChannel.Channel)
					end
					if RSA.db.profile.Hunter.Spells.WidowVenom.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Hunter.Spells.WidowVenom.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.WidowVenom.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Hunter.Spells.WidowVenom.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.WidowVenom.Party == true then
						if RSA.db.profile.Hunter.Spells.WidowVenom.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Hunter.Spells.WidowVenom.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.WidowVenom.Raid == true then
						if RSA.db.profile.Hunter.Spells.WidowVenom.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Hunter.Spells.WidowVenom.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- WIDOW VENOM
			if spellID == 19503 then -- SCATTER SHOT
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Hunter.Spells.ScatterShot.Messages.Start ~= "" then
					if RSA.db.profile.Hunter.Spells.ScatterShot.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Hunter.Spells.ScatterShot.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.ScatterShot.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Hunter.Spells.ScatterShot.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Hunter.Spells.ScatterShot.CustomChannel.Channel)
					end
					if RSA.db.profile.Hunter.Spells.ScatterShot.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Hunter.Spells.ScatterShot.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.ScatterShot.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Hunter.Spells.ScatterShot.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.ScatterShot.Party == true then
						if RSA.db.profile.Hunter.Spells.ScatterShot.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Hunter.Spells.ScatterShot.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.ScatterShot.Raid == true then
						if RSA.db.profile.Hunter.Spells.ScatterShot.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Hunter.Spells.ScatterShot.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- SCATTER SHOT
			if spellID == 5116 then -- CONCUSSIVE SHOT
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Hunter.Spells.ConcussiveShot.Messages.Start ~= "" then
					if RSA.db.profile.Hunter.Spells.ConcussiveShot.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Hunter.Spells.ConcussiveShot.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.ConcussiveShot.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Hunter.Spells.ConcussiveShot.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Hunter.Spells.ConcussiveShot.CustomChannel.Channel)
					end
					if RSA.db.profile.Hunter.Spells.ConcussiveShot.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Hunter.Spells.ConcussiveShot.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.ConcussiveShot.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Hunter.Spells.ConcussiveShot.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.ConcussiveShot.Party == true then
						if RSA.db.profile.Hunter.Spells.ConcussiveShot.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Hunter.Spells.ConcussiveShot.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.ConcussiveShot.Raid == true then
						if RSA.db.profile.Hunter.Spells.ConcussiveShot.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Hunter.Spells.ConcussiveShot.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- CONCUSSIVE SHOT
			if spellID == 19263 then -- DETERRENCE
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Hunter.Spells.Deterrence.Messages.Start ~= "" then
					if RSA.db.profile.Hunter.Spells.Deterrence.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Hunter.Spells.Deterrence.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.Deterrence.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Hunter.Spells.Deterrence.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Hunter.Spells.Deterrence.CustomChannel.Channel)
					end
					if RSA.db.profile.Hunter.Spells.Deterrence.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Hunter.Spells.Deterrence.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.Deterrence.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Hunter.Spells.Deterrence.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.Deterrence.Party == true then
						if RSA.db.profile.Hunter.Spells.Deterrence.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Hunter.Spells.Deterrence.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.Deterrence.Raid == true then
						if RSA.db.profile.Hunter.Spells.Deterrence.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Hunter.Spells.Deterrence.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- DETERRENCE
			if spellID == 51753 then -- CAMOFLAGE
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Hunter.Spells.Camoflage.Messages.Start ~= "" then
					if RSA.db.profile.Hunter.Spells.Camoflage.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Hunter.Spells.Camoflage.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.Camoflage.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Hunter.Spells.Camoflage.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Hunter.Spells.Camoflage.CustomChannel.Channel)
					end
					if RSA.db.profile.Hunter.Spells.Camoflage.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Hunter.Spells.Camoflage.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.Camoflage.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Hunter.Spells.Camoflage.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.Camoflage.Party == true then
						if RSA.db.profile.Hunter.Spells.Camoflage.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Hunter.Spells.Camoflage.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.Camoflage.Raid == true then
						if RSA.db.profile.Hunter.Spells.Camoflage.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Hunter.Spells.Camoflage.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- CAMOFLAGE
			if spellID == 34477 and dest ~= pName then -- MISDIRECTION PRIMER
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_MD_TAR = dest
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Hunter.Spells.Misdirection.Messages.Primer ~= "" then
					if RSA.db.profile.Hunter.Spells.Misdirection.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Hunter.Spells.Misdirection.Messages.Primer, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.Misdirection.Whisper == true and dest ~= pName and RSA_Whisperable(destGUID) then
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
						RSA_Print_Whisper(string.gsub(RSA.db.profile.Hunter.Spells.Misdirection.Messages.Primer, ".%a+.", RSA_String_Replace), dest)
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					end
					if RSA.db.profile.Hunter.Spells.Misdirection.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Hunter.Spells.Misdirection.Messages.Primer, ".%a+.", RSA_String_Replace), RSA.db.profile.Hunter.Spells.Misdirection.CustomChannel.Channel)
					end
					if RSA.db.profile.Hunter.Spells.Misdirection.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Hunter.Spells.Misdirection.Messages.Primer, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.Misdirection.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Hunter.Spells.Misdirection.Messages.Primer, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.Misdirection.Party == true then
						if RSA.db.profile.Hunter.Spells.Misdirection.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Hunter.Spells.Misdirection.Messages.Primer, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.Misdirection.Raid == true then
						if RSA.db.profile.Hunter.Spells.Misdirection.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Hunter.Spells.Misdirection.Messages.Primer, ".%a+.", RSA_String_Replace))
					end
				end
				---- START MISDIRECTION TRACKING ----
				if string.match(RSA.db.profile.Hunter.Spells.Misdirection.Messages.End, ".AMOUNT.") == "[AMOUNT]" then
					RSA_MisdirectionTracker:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
						local function MisdirectionTracker(_, _, _, event, _, _, source, _, _, destGUID, dest, _, _, spellID, spellName, _, amount, overkill)
							if source == pName then
								if event == "SPELL_DAMAGE" or event == "SPELL_PERIODIC_DAMAGE" or event == "RANGE_DAMAGE" then
									if overkill ~= -1 then
										overkill = 0
									end
									RSA_Misdirection_Damage = RSA_Misdirection_Damage + (amount - overkill)
								elseif event == "SWING_DAMAGE" then
									local amount, overkill = spellID, spellName
									if overkill ~= -1 then
										overkill = 0
									end
									RSA_Misdirection_Damage = RSA_Misdirection_Damage + (spellID - spellName)
								end
							end
						end
					RSA_MisdirectionTracker:SetScript("OnEvent", MisdirectionTracker)
				end
				MDPTimeElapsed = 0.0
				local function SBMDPTimer(self, elapsed)
					MDPTimeElapsed = MDPTimeElapsed + elapsed
					if MDPTimeElapsed < 20 then return end
					MDPTimeElapsed = MDPTimeElapsed - floor(MDPTimeElapsed)
					if RSA_Misdirection_Damage == 0.0 then
						RSA_MisdirectionTracker:SetScript("OnEvent", nil)
					end
					RSA_MDPTimer:SetScript("OnUpdate", nil)
				end
				RSA_MDPTimer:SetScript("OnUpdate", SBMDPTimer)
				---- END OF MISDIRECTION TRACKING ----
			end -- MISDIRECTION PRIMER
			if spellID == 53271 then -- MASTER'S CALL
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Hunter.Spells.MastersCall.Messages.Start ~= "" then
					if RSA.db.profile.Hunter.Spells.MastersCall.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Hunter.Spells.MastersCall.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.MastersCall.Whisper == true and dest ~= pName and RSA_Whisperable(destGUID) then
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
						RSA_Print_Whisper(string.gsub(RSA.db.profile.Hunter.Spells.MastersCall.Messages.Start, ".%a+.", RSA_String_Replace), dest)
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					end
					if RSA.db.profile.Hunter.Spells.MastersCall.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Hunter.Spells.MastersCall.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Hunter.Spells.MastersCall.CustomChannel.Channel)
					end
					if RSA.db.profile.Hunter.Spells.MastersCall.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Hunter.Spells.MastersCall.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.MastersCall.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Hunter.Spells.MastersCall.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.MastersCall.Party == true then
						if RSA.db.profile.Hunter.Spells.MastersCall.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Hunter.Spells.MastersCall.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.MastersCall.Raid == true then
						if RSA.db.profile.Hunter.Spells.MastersCall.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Hunter.Spells.MastersCall.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- MASTER'S CALL
			if spellID == 53480 then -- ROAR OF SACRIFICE
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Hunter.Spells.RoarOfSacrifice.Messages.Start ~= "" then
					if RSA.db.profile.Hunter.Spells.RoarOfSacrifice.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Hunter.Spells.RoarOfSacrifice.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.RoarOfSacrifice.Whisper == true and dest ~= pName and RSA_Whisperable(destGUID) then
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
						RSA_Print_Whisper(string.gsub(RSA.db.profile.Hunter.Spells.RoarOfSacrifice.Messages.Start, ".%a+.", RSA_String_Replace), dest)
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					end
					if RSA.db.profile.Hunter.Spells.RoarOfSacrifice.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Hunter.Spells.RoarOfSacrifice.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Hunter.Spells.RoarOfSacrifice.CustomChannel.Channel)
					end
					if RSA.db.profile.Hunter.Spells.RoarOfSacrifice.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Hunter.Spells.RoarOfSacrifice.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.RoarOfSacrifice.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Hunter.Spells.RoarOfSacrifice.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.RoarOfSacrifice.Party == true then
						if RSA.db.profile.Hunter.Spells.RoarOfSacrifice.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Hunter.Spells.RoarOfSacrifice.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.RoarOfSacrifice.Raid == true then
						if RSA.db.profile.Hunter.Spells.RoarOfSacrifice.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Hunter.Spells.RoarOfSacrifice.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- ROAR OF SACRIFICE
		end -- IF EVENT IS SPELL_CAST_SUCCESS
		if event == "SPELL_INTERRUPT" then
			if spellID == 34490 then -- SILENCING SHOT
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				extraspellinfo = GetSpellInfo(missType)
				extraspellinfolink = GetSpellLink(missType)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[TARSPELL]"] = extraspellinfo, ["[TARLINK]"] = extraspellinfolink,}
				if RSA.db.profile.Hunter.Spells.SilencingShot.Messages.Start ~= "" then
					if RSA.db.profile.Hunter.Spells.SilencingShot.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Hunter.Spells.SilencingShot.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.SilencingShot.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Hunter.Spells.SilencingShot.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Hunter.Spells.SilencingShot.CustomChannel.Channel)
					end
					if RSA.db.profile.Hunter.Spells.SilencingShot.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Hunter.Spells.SilencingShot.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.SilencingShot.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Hunter.Spells.SilencingShot.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.SilencingShot.Party == true then
						if RSA.db.profile.Hunter.Spells.SilencingShot.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Hunter.Spells.SilencingShot.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.SilencingShot.Raid == true then
						if RSA.db.profile.Hunter.Spells.SilencingShot.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Hunter.Spells.SilencingShot.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- SILENCING SHOT
		end -- IF EVENT IS SPELL_INTERRUPT
		if event == "SPELL_DISPEL" then
			if spellID == 19801 then -- TRANQUILIZING SHOT
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				extraspellinfo = GetSpellInfo(missType)
				extraspellinfolink = GetSpellLink(missType)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[AURA]"] = extraspellinfo, ["[AURALINK]"] = extraspellinfolink,}
				if RSA.db.profile.Hunter.Spells.TranquilizingShot.Messages.Start ~= "" then
					if RSA.db.profile.Hunter.Spells.TranquilizingShot.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Hunter.Spells.TranquilizingShot.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.TranquilizingShot.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Hunter.Spells.TranquilizingShot.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Hunter.Spells.TranquilizingShot.CustomChannel.Channel)
					end
					if RSA.db.profile.Hunter.Spells.TranquilizingShot.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Hunter.Spells.TranquilizingShot.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.TranquilizingShot.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Hunter.Spells.TranquilizingShot.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.TranquilizingShot.Party == true then
						if RSA.db.profile.Hunter.Spells.TranquilizingShot.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Hunter.Spells.TranquilizingShot.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.TranquilizingShot.Raid == true then
						if RSA.db.profile.Hunter.Spells.TranquilizingShot.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Hunter.Spells.TranquilizingShot.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- TRANQUILIZING SHOT
		end -- IF EVENT IS SPELL_DISPEL
		if event == "SPELL_DISPEL_FAILED" then
			if spellID == 19801 then -- TRANQUILIZING SHOT
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				extraspellinfo = GetSpellInfo(missType)
				extraspellinfolink = GetSpellLink(missType)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[AURA]"] = extraspellinfo, ["[AURALINK]"] = extraspellinfolink,}
				if RSA.db.profile.Hunter.Spells.TranquilizingShot.Messages.End ~= "" then
					if RSA.db.profile.Hunter.Spells.TranquilizingShot.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Hunter.Spells.TranquilizingShot.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.TranquilizingShot.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Hunter.Spells.TranquilizingShot.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Hunter.Spells.TranquilizingShot.CustomChannel.Channel)
					end
					if RSA.db.profile.Hunter.Spells.TranquilizingShot.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Hunter.Spells.TranquilizingShot.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.TranquilizingShot.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Hunter.Spells.TranquilizingShot.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.TranquilizingShot.Party == true then
						if RSA.db.profile.Hunter.Spells.TranquilizingShot.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Hunter.Spells.TranquilizingShot.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.TranquilizingShot.Raid == true then
						if RSA.db.profile.Hunter.Spells.TranquilizingShot.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Hunter.Spells.TranquilizingShot.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- TRANQUILIZING SHOT
		end -- IF EVENT IS SPELL_DISPEL_FAILED
		if event == "SPELL_AURA_REMOVED" then
			if spellID == 82654 then -- WIDOW VENOM
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Hunter.Spells.WidowVenom.Messages.End ~= "" then
					if RSA.db.profile.Hunter.Spells.WidowVenom.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Hunter.Spells.WidowVenom.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.WidowVenom.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Hunter.Spells.WidowVenom.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Hunter.Spells.WidowVenom.CustomChannel.Channel)
					end
					if RSA.db.profile.Hunter.Spells.WidowVenom.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Hunter.Spells.WidowVenom.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.WidowVenom.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Hunter.Spells.WidowVenom.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.WidowVenom.Party == true then
						if RSA.db.profile.Hunter.Spells.WidowVenom.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Hunter.Spells.WidowVenom.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.WidowVenom.Raid == true then
						if RSA.db.profile.Hunter.Spells.WidowVenom.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Hunter.Spells.WidowVenom.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- WIDOW VENOM
			if spellID == 19503 then -- SCATTER SHOT
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Hunter.Spells.ScatterShot.Messages.End ~= "" then
					if RSA.db.profile.Hunter.Spells.ScatterShot.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Hunter.Spells.ScatterShot.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.ScatterShot.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Hunter.Spells.ScatterShot.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Hunter.Spells.ScatterShot.CustomChannel.Channel)
					end
					if RSA.db.profile.Hunter.Spells.ScatterShot.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Hunter.Spells.ScatterShot.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.ScatterShot.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Hunter.Spells.ScatterShot.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.ScatterShot.Party == true then
						if RSA.db.profile.Hunter.Spells.ScatterShot.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Hunter.Spells.ScatterShot.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.ScatterShot.Raid == true then
						if RSA.db.profile.Hunter.Spells.ScatterShot.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Hunter.Spells.ScatterShot.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- SCATTER SHOT
			if spellID == 5116 then -- CONCUSSIVE SHOT
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Hunter.Spells.ConcussiveShot.Messages.End ~= "" then
					if RSA.db.profile.Hunter.Spells.ConcussiveShot.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Hunter.Spells.ConcussiveShot.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.ConcussiveShot.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Hunter.Spells.ConcussiveShot.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Hunter.Spells.ConcussiveShot.CustomChannel.Channel)
					end
					if RSA.db.profile.Hunter.Spells.ConcussiveShot.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Hunter.Spells.ConcussiveShot.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.ConcussiveShot.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Hunter.Spells.ConcussiveShot.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.ConcussiveShot.Party == true then
						if RSA.db.profile.Hunter.Spells.ConcussiveShot.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Hunter.Spells.ConcussiveShot.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.ConcussiveShot.Raid == true then
						if RSA.db.profile.Hunter.Spells.ConcussiveShot.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Hunter.Spells.ConcussiveShot.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- CONCUSSIVE SHOT
			if spellID == 3355 then -- FREEZING TRAP
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Hunter.Spells.FreezingTrap.Messages.End ~= "" then
					if RSA.db.profile.Hunter.Spells.FreezingTrap.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Hunter.Spells.FreezingTrap.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.FreezingTrap.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Hunter.Spells.FreezingTrap.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Hunter.Spells.FreezingTrap.CustomChannel.Channel)
					end
					if RSA.db.profile.Hunter.Spells.FreezingTrap.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Hunter.Spells.FreezingTrap.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.FreezingTrap.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Hunter.Spells.FreezingTrap.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.FreezingTrap.Party == true then
						if RSA.db.profile.Hunter.Spells.FreezingTrap.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Hunter.Spells.FreezingTrap.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.FreezingTrap.Raid == true then
						if RSA.db.profile.Hunter.Spells.FreezingTrap.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Hunter.Spells.FreezingTrap.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- FREEZING TRAP
			if spellID == 19263 then -- DETERRENCE
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Hunter.Spells.Deterrence.Messages.End ~= "" then
					if RSA.db.profile.Hunter.Spells.Deterrence.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Hunter.Spells.Deterrence.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.Deterrence.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Hunter.Spells.Deterrence.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Hunter.Spells.Deterrence.CustomChannel.Channel)
					end
					if RSA.db.profile.Hunter.Spells.Deterrence.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Hunter.Spells.Deterrence.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.Deterrence.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Hunter.Spells.Deterrence.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.Deterrence.Party == true then
						if RSA.db.profile.Hunter.Spells.Deterrence.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Hunter.Spells.Deterrence.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.Deterrence.Raid == true then
						if RSA.db.profile.Hunter.Spells.Deterrence.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Hunter.Spells.Deterrence.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- DETERRENCE
			if spellID == 51755 then -- CAMOFLAGE
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Hunter.Spells.Camoflage.Messages.End ~= "" then
					if RSA.db.profile.Hunter.Spells.Camoflage.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Hunter.Spells.Camoflage.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.Camoflage.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Hunter.Spells.Camoflage.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Hunter.Spells.Camoflage.CustomChannel.Channel)
					end
					if RSA.db.profile.Hunter.Spells.Camoflage.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Hunter.Spells.Camoflage.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.Camoflage.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Hunter.Spells.Camoflage.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.Camoflage.Party == true then
						if RSA.db.profile.Hunter.Spells.Camoflage.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Hunter.Spells.Camoflage.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.Camoflage.Raid == true then
						if RSA.db.profile.Hunter.Spells.Camoflage.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Hunter.Spells.Camoflage.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- CAMOFLAGE
			if spellID == 19386 then -- WYVERN STING
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Hunter.Spells.WyvernSting.Messages.End ~= "" then
					if RSA.db.profile.Hunter.Spells.WyvernSting.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Hunter.Spells.WyvernSting.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.WyvernSting.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Hunter.Spells.WyvernSting.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Hunter.Spells.WyvernSting.CustomChannel.Channel)
					end
					if RSA.db.profile.Hunter.Spells.WyvernSting.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Hunter.Spells.WyvernSting.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.WyvernSting.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Hunter.Spells.WyvernSting.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.WyvernSting.Party == true then
						if RSA.db.profile.Hunter.Spells.WyvernSting.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Hunter.Spells.WyvernSting.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.WyvernSting.Raid == true then
						if RSA.db.profile.Hunter.Spells.WyvernSting.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Hunter.Spells.WyvernSting.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- WYVERN STING
			if spellID == 35079 then -- MISDIRECTION THREAT TRANSFER BUFF
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				dest = RSA_MD_TAR
				if string.match(RSA.db.profile.Hunter.Spells.Misdirection.Messages.End, ".AMOUNT.") == "[AMOUNT]" then
					RSA_MisdirectionTracker:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
					RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[AMOUNT]"] = RSA_Misdirection_Damage,}
				else
					RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				end
				if RSA.db.profile.Hunter.Spells.Misdirection.Messages.End ~= "" then
					if RSA.db.profile.Hunter.Spells.Misdirection.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Hunter.Spells.Misdirection.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.Misdirection.Whisper == true and dest ~= pName and RSA_Whisperable(destGUID) and dest ~= petName then
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"], ["[AMOUNT]"] = RSA_Misdirection_Damage or 0,}
						RSA_Print_Whisper(string.gsub(RSA.db.profile.Hunter.Spells.Misdirection.Messages.End, ".%a+.", RSA_String_Replace), dest)
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[AMOUNT]"] = RSA_Misdirection_Damage or 0,}
					end
					if RSA.db.profile.Hunter.Spells.Misdirection.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Hunter.Spells.Misdirection.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Hunter.Spells.Misdirection.CustomChannel.Channel)
					end
					if RSA.db.profile.Hunter.Spells.Misdirection.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Hunter.Spells.Misdirection.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.Misdirection.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Hunter.Spells.Misdirection.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.Misdirection.Party == true then
						if RSA.db.profile.Hunter.Spells.Misdirection.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Hunter.Spells.Misdirection.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.Misdirection.Raid == true then
						if RSA.db.profile.Hunter.Spells.Misdirection.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Hunter.Spells.Misdirection.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
				if string.match(RSA.db.profile.Hunter.Spells.Misdirection.Messages.End, ".AMOUNT.") == "[AMOUNT]" then
					RSA_MisdirectionTracker:SetScript("OnEvent", nil)
					RSA_Misdirection_Damage = 0.0
				end
			end -- MISDIRECTION THREAT TRANSFER BUFF
			if spellID == 53480 then -- ROAR OF SACRIFICE
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Hunter.Spells.RoarOfSacrifice.Messages.End ~= "" then
					if RSA.db.profile.Hunter.Spells.RoarOfSacrifice.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Hunter.Spells.RoarOfSacrifice.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.RoarOfSacrifice.Whisper == true and dest ~= pName and RSA_Whisperable(destGUID) then
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
						RSA_Print_Whisper(string.gsub(RSA.db.profile.Hunter.Spells.RoarOfSacrifice.Messages.End, ".%a+.", RSA_String_Replace), dest)
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					end
					if RSA.db.profile.Hunter.Spells.RoarOfSacrifice.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Hunter.Spells.RoarOfSacrifice.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Hunter.Spells.RoarOfSacrifice.CustomChannel.Channel)
					end
					if RSA.db.profile.Hunter.Spells.RoarOfSacrifice.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Hunter.Spells.RoarOfSacrifice.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.RoarOfSacrifice.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Hunter.Spells.RoarOfSacrifice.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.RoarOfSacrifice.Party == true then
						if RSA.db.profile.Hunter.Spells.RoarOfSacrifice.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Hunter.Spells.RoarOfSacrifice.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.RoarOfSacrifice.Raid == true then
						if RSA.db.profile.Hunter.Spells.RoarOfSacrifice.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Hunter.Spells.RoarOfSacrifice.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- ROAR OF SACRIFICE
		end -- IF EVENT IS SPELL_AURA_REMOVED
		if event == "SPELL_MISSED" and missType ~= "IMMUNE" then
			if spellID == 20736 then -- DISTRACTING SHOT
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				if missType == "MISS" then
					missinfo = L["missed"]
				elseif missType ~= "MISS" then
					missinfo = L["was resisted by"]
				end
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = missinfo,}
				if RSA.db.profile.Hunter.Spells.DistractingShot.Messages.End ~= "" then
					if RSA.db.profile.Hunter.Spells.DistractingShot.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Hunter.Spells.DistractingShot.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.DistractingShot.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Hunter.Spells.DistractingShot.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Hunter.Spells.DistractingShot.CustomChannel.Channel)
					end
					if RSA.db.profile.Hunter.Spells.DistractingShot.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Hunter.Spells.DistractingShot.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.DistractingShot.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Hunter.Spells.DistractingShot.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.DistractingShot.Party == true then
						if RSA.db.profile.Hunter.Spells.DistractingShot.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Hunter.Spells.DistractingShot.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.DistractingShot.Raid == true then
						if RSA.db.profile.Hunter.Spells.DistractingShot.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Hunter.Spells.DistractingShot.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- DISTRACTING SHOT
			if spellID == 34490 then -- SILENCING SHOT
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				if missType == "MISS" then
					missinfo = L["missed"]
				elseif missType ~= "MISS" then
					missinfo = L["was resisted by"]
				end
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = missinfo,}
				if RSA.db.profile.Hunter.Spells.SilencingShot.Messages.End ~= "" then
					if RSA.db.profile.Hunter.Spells.SilencingShot.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Hunter.Spells.SilencingShot.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.SilencingShot.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Hunter.Spells.SilencingShot.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Hunter.Spells.SilencingShot.CustomChannel.Channel)
					end
					if RSA.db.profile.Hunter.Spells.SilencingShot.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Hunter.Spells.SilencingShot.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.SilencingShot.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Hunter.Spells.SilencingShot.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.SilencingShot.Party == true then
						if RSA.db.profile.Hunter.Spells.SilencingShot.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Hunter.Spells.SilencingShot.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.SilencingShot.Raid == true then
						if RSA.db.profile.Hunter.Spells.SilencingShot.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Hunter.Spells.SilencingShot.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- SILENCING SHOT
		end -- IF EVENT IS SPELL_MISSED AND NOT IMMUNE
		if event == "SPELL_MISSED" and missType == "IMMUNE" then
			if spellID == 20736 then -- DISTRACTING SHOT
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = L["Immune"],}
				if RSA.db.profile.Hunter.Spells.DistractingShot.Messages.Immune ~= "" then
					if RSA.db.profile.Hunter.Spells.DistractingShot.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Hunter.Spells.DistractingShot.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.DistractingShot.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Hunter.Spells.DistractingShot.Messages.Immune, ".%a+.", RSA_String_Replace), RSA.db.profile.Hunter.Spells.DistractingShot.CustomChannel.Channel)
					end
					if RSA.db.profile.Hunter.Spells.DistractingShot.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Hunter.Spells.DistractingShot.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.DistractingShot.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Hunter.Spells.DistractingShot.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.DistractingShot.Party == true then
						if RSA.db.profile.Hunter.Spells.DistractingShot.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Hunter.Spells.DistractingShot.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.DistractingShot.Raid == true then
						if RSA.db.profile.Hunter.Spells.DistractingShot.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Hunter.Spells.DistractingShot.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
				end
			end -- DISTRACTING SHOT
			if spellID == 34490 then -- SILENCING SHOT
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = L["Immune"],}
				if RSA.db.profile.Hunter.Spells.SilencingShot.Messages.Immune ~= "" then
					if RSA.db.profile.Hunter.Spells.SilencingShot.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Hunter.Spells.SilencingShot.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.SilencingShot.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Hunter.Spells.SilencingShot.Messages.Immune, ".%a+.", RSA_String_Replace), RSA.db.profile.Hunter.Spells.SilencingShot.CustomChannel.Channel)
					end
					if RSA.db.profile.Hunter.Spells.SilencingShot.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Hunter.Spells.SilencingShot.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.SilencingShot.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Hunter.Spells.SilencingShot.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.SilencingShot.Party == true then
						if RSA.db.profile.Hunter.Spells.SilencingShot.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Hunter.Spells.SilencingShot.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Hunter.Spells.SilencingShot.Raid == true then
						if RSA.db.profile.Hunter.Spells.SilencingShot.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Hunter.Spells.SilencingShot.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
				end
			end -- SILENCING SHOT
		end -- IF EVENT IS SPELL_MISSED AND IS IMMUNE
	end -- IF SOURCE IS PLAYER
end -- END ENTIRELY
RSA_CombatLogMonitor:SetScript("OnEvent", Hunter_Spells)
end -- END ON ENABLED
function RSA_Hunter:OnDisable()
RSA_CombatLogMonitor:SetScript("OnEvent", nil)
end