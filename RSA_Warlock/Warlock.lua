------------------------------------------------
---- Raeli's Spell Announcer Warlock Module ----
------------------------------------------------
local RSA = LibStub("AceAddon-3.0"):GetAddon("RSA")
local L = LibStub("AceLocale-3.0"):GetLocale("RSA")
local RSA_Warlock = RSA:NewModule("Warlock")
function RSA_Warlock:OnInitialize()
	if RSA.db.profile.General.Class == "WARLOCK" then
		RSA_Warlock:SetEnabledState(true)
	else
		RSA_Warlock:SetEnabledState(false)
	end
end -- End OnInitialize
function RSA_Warlock:OnEnable()
local spellinfo
local spelllinkinfo
local extraspellinfo
local extraspellinfolink
RSA.db.profile.Modules.Warlock = true -- Set state to loaded, to know if we should announce when a spell is refreshed.
local pName = UnitName("player")
local RSA_HowlOfTerror = false
local ResTarget = L["Unknown"]
local Ressed
local CastingSS
local function Warlock_Spells(_, _, _, event, _, _, source, _, _, destGUID, dest, _, _, spellID, spellName, _, missType)
	local petName = UnitName("pet")
	if source == pName or source == petName then
		if (event == "SPELL_CAST_SUCCESS" and RSA.db.profile.Modules.Reminders_Loaded == true) then -- Reminder Refreshed
			local ReminderSpell = RSA.db.profile.Warlock.Reminders.SpellName
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
			if spellID == 17735 then -- SUFFERING
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Warlock.Spells.Suffering.Messages.Start ~= "" then
					if RSA.db.profile.Warlock.Spells.Suffering.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Warlock.Spells.Suffering.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.Suffering.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Warlock.Spells.Suffering.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Warlock.Spells.Suffering.CustomChannel.Channel)
					end
					if RSA.db.profile.Warlock.Spells.Suffering.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Warlock.Spells.Suffering.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.Suffering.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Warlock.Spells.Suffering.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.Suffering.Party == true then
						if RSA.db.profile.Warlock.Spells.Suffering.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Warlock.Spells.Suffering.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.Suffering.Raid == true then
						if RSA.db.profile.Warlock.Spells.Suffering.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Warlock.Spells.Suffering.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- SUFFERING
			if spellID == 710 then -- BANISH
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Warlock.Spells.Banish.Messages.Start ~= "" then
					if RSA.db.profile.Warlock.Spells.Banish.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Warlock.Spells.Banish.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.Banish.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Warlock.Spells.Banish.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Warlock.Spells.Banish.CustomChannel.Channel)
					end
					if RSA.db.profile.Warlock.Spells.Banish.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Warlock.Spells.Banish.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.Banish.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Warlock.Spells.Banish.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.Banish.Party == true then
						if RSA.db.profile.Warlock.Spells.Banish.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Warlock.Spells.Banish.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.Banish.Raid == true then
						if RSA.db.profile.Warlock.Spells.Banish.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Warlock.Spells.Banish.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- BANISH
			if spellID == 5782 then -- FEAR
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Warlock.Spells.Fear.Messages.Start ~= "" then
					if RSA.db.profile.Warlock.Spells.Fear.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Warlock.Spells.Fear.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.Fear.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Warlock.Spells.Fear.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Warlock.Spells.Fear.CustomChannel.Channel)
					end
					if RSA.db.profile.Warlock.Spells.Fear.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Warlock.Spells.Fear.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.Fear.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Warlock.Spells.Fear.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.Fear.Party == true then
						if RSA.db.profile.Warlock.Spells.Fear.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Warlock.Spells.Fear.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.Fear.Raid == true then
						if RSA.db.profile.Warlock.Spells.Fear.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Warlock.Spells.Fear.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- FEAR
			if spellID == 6789 then -- DEATH COIL
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Warlock.Spells.DeathCoil.Messages.Start ~= "" then
					if RSA.db.profile.Warlock.Spells.DeathCoil.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Warlock.Spells.DeathCoil.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.DeathCoil.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Warlock.Spells.DeathCoil.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Warlock.Spells.DeathCoil.CustomChannel.Channel)
					end
					if RSA.db.profile.Warlock.Spells.DeathCoil.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Warlock.Spells.DeathCoil.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.DeathCoil.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Warlock.Spells.DeathCoil.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.DeathCoil.Party == true then
						if RSA.db.profile.Warlock.Spells.DeathCoil.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Warlock.Spells.DeathCoil.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.DeathCoil.Raid == true then
						if RSA.db.profile.Warlock.Spells.DeathCoil.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Warlock.Spells.DeathCoil.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- DEATH COIL
			if spellID == 30283 then -- SHADOWFURY
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Warlock.Spells.Shadowfury.Messages.Start ~= "" then
					if RSA.db.profile.Warlock.Spells.Shadowfury.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Warlock.Spells.Shadowfury.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.Shadowfury.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Warlock.Spells.Shadowfury.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Warlock.Spells.Shadowfury.CustomChannel.Channel)
					end
					if RSA.db.profile.Warlock.Spells.Shadowfury.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Warlock.Spells.Shadowfury.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.Shadowfury.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Warlock.Spells.Shadowfury.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.Shadowfury.Party == true then
						if RSA.db.profile.Warlock.Spells.Shadowfury.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Warlock.Spells.Shadowfury.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.Shadowfury.Raid == true then
						if RSA.db.profile.Warlock.Spells.Shadowfury.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Warlock.Spells.Shadowfury.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- SHADOWFURY
			if spellID == 6358 then -- SEDUCE
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Warlock.Spells.Seduce.Messages.Start ~= "" then
					if RSA.db.profile.Warlock.Spells.Seduce.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Warlock.Spells.Seduce.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.Seduce.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Warlock.Spells.Seduce.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Warlock.Spells.Seduce.CustomChannel.Channel)
					end
					if RSA.db.profile.Warlock.Spells.Seduce.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Warlock.Spells.Seduce.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.Seduce.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Warlock.Spells.Seduce.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.Seduce.Party == true then
						if RSA.db.profile.Warlock.Spells.Seduce.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Warlock.Spells.Seduce.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.Seduce.Raid == true then
						if RSA.db.profile.Warlock.Spells.Seduce.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Warlock.Spells.Seduce.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- SEDUCE
			--[[if spellID == 20707 then -- SOULSTONE
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Warlock.Spells.Soulstone.Messages.Start ~= "" then
					if RSA.db.profile.Warlock.Spells.Soulstone.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Warlock.Spells.Soulstone.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.Soulstone.Whisper == true and dest ~= pName and RSA_Whisperable(destGUID) then
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
						RSA_Print_Whisper(string.gsub(RSA.db.profile.Warlock.Spells.Soulstone.Messages.Start, ".%a+.", RSA_String_Replace), dest)
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					end
					if RSA.db.profile.Warlock.Spells.Soulstone.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Warlock.Spells.Soulstone.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Warlock.Spells.Soulstone.CustomChannel.Channel)
					end
					if RSA.db.profile.Warlock.Spells.Soulstone.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Warlock.Spells.Soulstone.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.Soulstone.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Warlock.Spells.Soulstone.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.Soulstone.Party == true then
						if RSA.db.profile.Warlock.Spells.Soulstone.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Warlock.Spells.Soulstone.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.Soulstone.Raid == true then
						if RSA.db.profile.Warlock.Spells.Soulstone.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Warlock.Spells.Soulstone.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- SOULSTONE]]--
			if spellID == 85767 then -- DARK INTENT
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Warlock.Spells.DarkIntent.Messages.Start ~= "" then
					if RSA.db.profile.Warlock.Spells.DarkIntent.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Warlock.Spells.DarkIntent.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.DarkIntent.Whisper == true and dest ~= pName and RSA_Whisperable(destGUID) then
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
						RSA_Print_Whisper(string.gsub(RSA.db.profile.Warlock.Spells.DarkIntent.Messages.Start, ".%a+.", RSA_String_Replace), dest)
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					end
					if RSA.db.profile.Warlock.Spells.DarkIntent.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Warlock.Spells.DarkIntent.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Warlock.Spells.DarkIntent.CustomChannel.Channel)
					end
					if RSA.db.profile.Warlock.Spells.DarkIntent.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Warlock.Spells.DarkIntent.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.DarkIntent.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Warlock.Spells.DarkIntent.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.DarkIntent.Party == true then
						if RSA.db.profile.Warlock.Spells.DarkIntent.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Warlock.Spells.DarkIntent.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.DarkIntent.Raid == true then
						if RSA.db.profile.Warlock.Spells.DarkIntent.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Warlock.Spells.DarkIntent.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- DARK INTENT
		end -- IF EVENT IS SPELL_AURA_APPLIED
		if event == "SPELL_CAST_SUCCESS" then
			if spellID == 29893 then -- SOUL WELL
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Warlock.Spells.SoulWell.Messages.Start ~= "" then
					if RSA.db.profile.Warlock.Spells.SoulWell.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Warlock.Spells.SoulWell.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.SoulWell.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Warlock.Spells.SoulWell.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Warlock.Spells.SoulWell.CustomChannel.Channel)
					end
					if RSA.db.profile.Warlock.Spells.SoulWell.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Warlock.Spells.SoulWell.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.SoulWell.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Warlock.Spells.SoulWell.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.SoulWell.Party == true then
						if RSA.db.profile.Warlock.Spells.SoulWell.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Warlock.Spells.SoulWell.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.SoulWell.Raid == true then
						if RSA.db.profile.Warlock.Spells.SoulWell.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Warlock.Spells.SoulWell.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- SOUL WELL
			if spellID == 698 then -- SUMMONING STONE
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Warlock.Spells.SummonStone.Messages.Start ~= "" then
					if RSA.db.profile.Warlock.Spells.SummonStone.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Warlock.Spells.SummonStone.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.SummonStone.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Warlock.Spells.SummonStone.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Warlock.Spells.SummonStone.CustomChannel.Channel)
					end
					if RSA.db.profile.Warlock.Spells.SummonStone.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Warlock.Spells.SummonStone.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.SummonStone.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Warlock.Spells.SummonStone.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.SummonStone.Party == true then
						if RSA.db.profile.Warlock.Spells.SummonStone.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Warlock.Spells.SummonStone.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.SummonStone.Raid == true then
						if RSA.db.profile.Warlock.Spells.SummonStone.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Warlock.Spells.SummonStone.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- SUMMONING STONE
			if spellID == 29858 then -- SOULSHATTER
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Warlock.Spells.Soulshatter.Messages.Start ~= "" then
					if RSA.db.profile.Warlock.Spells.Soulshatter.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Warlock.Spells.Soulshatter.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.Soulshatter.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Warlock.Spells.Soulshatter.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Warlock.Spells.Soulshatter.CustomChannel.Channel)
					end
					if RSA.db.profile.Warlock.Spells.Soulshatter.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Warlock.Spells.Soulshatter.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.Soulshatter.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Warlock.Spells.Soulshatter.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.Soulshatter.Party == true then
						if RSA.db.profile.Warlock.Spells.Soulshatter.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Warlock.Spells.Soulshatter.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.Soulshatter.Raid == true then
						if RSA.db.profile.Warlock.Spells.Soulshatter.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Warlock.Spells.Soulshatter.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- SOULSHATTER
			if spellID == 5484 then -- HOWL OF TERROR
				RSA_HowlOfTerror = false
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Warlock.Spells.HowlOfTerror.Messages.Start ~= "" then
					if RSA.db.profile.Warlock.Spells.HowlOfTerror.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Warlock.Spells.HowlOfTerror.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.HowlOfTerror.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Warlock.Spells.HowlOfTerror.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Warlock.Spells.HowlOfTerror.CustomChannel.Channel)
					end
					if RSA.db.profile.Warlock.Spells.HowlOfTerror.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Warlock.Spells.HowlOfTerror.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.HowlOfTerror.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Warlock.Spells.HowlOfTerror.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.HowlOfTerror.Party == true then
						if RSA.db.profile.Warlock.Spells.HowlOfTerror.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Warlock.Spells.HowlOfTerror.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.HowlOfTerror.Raid == true then
						if RSA.db.profile.Warlock.Spells.HowlOfTerror.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Warlock.Spells.HowlOfTerror.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- HOWL OF TERROR
		end -- IF EVENT IS SPELL_CAST_SUCCESS
		if event == "SPELL_INTERRUPT" then
			if spellID == 19647 then -- SPELL LOCK
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				extraspellinfo = GetSpellInfo(missType)
				extraspellinfolink = GetSpellLink(missType)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[TARSPELL]"] = extraspellinfo, ["[TARLINK]"] = extraspellinfolink,}
				if RSA.db.profile.Warlock.Spells.SpellLock.Messages.Start ~= "" then
					if RSA.db.profile.Warlock.Spells.SpellLock.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Warlock.Spells.SpellLock.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.SpellLock.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Warlock.Spells.SpellLock.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Warlock.Spells.SpellLock.CustomChannel.Channel)
					end
					if RSA.db.profile.Warlock.Spells.SpellLock.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Warlock.Spells.SpellLock.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.SpellLock.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Warlock.Spells.SpellLock.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.SpellLock.Party == true then
						if RSA.db.profile.Warlock.Spells.SpellLock.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Warlock.Spells.SpellLock.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.SpellLock.Raid == true then
						if RSA.db.profile.Warlock.Spells.SpellLock.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Warlock.Spells.SpellLock.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- SPELL LOCK
		end -- IF EVENT IS SPELL_INTERRUPT
		if event == "SPELL_AURA_REMOVED" then
			if spellID == 710 then -- BANISH
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Warlock.Spells.Banish.Messages.End ~= "" then
					if RSA.db.profile.Warlock.Spells.Banish.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Warlock.Spells.Banish.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.Banish.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Warlock.Spells.Banish.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Warlock.Spells.Banish.CustomChannel.Channel)
					end
					if RSA.db.profile.Warlock.Spells.Banish.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Warlock.Spells.Banish.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.Banish.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Warlock.Spells.Banish.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.Banish.Party == true then
						if RSA.db.profile.Warlock.Spells.Banish.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Warlock.Spells.Banish.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.Banish.Raid == true then
						if RSA.db.profile.Warlock.Spells.Banish.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Warlock.Spells.Banish.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- BANISH
			if spellID == 5782 then -- FEAR
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Warlock.Spells.Fear.Messages.End ~= "" then
					if RSA.db.profile.Warlock.Spells.Fear.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Warlock.Spells.Fear.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.Fear.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Warlock.Spells.Fear.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Warlock.Spells.Fear.CustomChannel.Channel)
					end
					if RSA.db.profile.Warlock.Spells.Fear.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Warlock.Spells.Fear.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.Fear.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Warlock.Spells.Fear.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.Fear.Party == true then
						if RSA.db.profile.Warlock.Spells.Fear.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Warlock.Spells.Fear.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.Fear.Raid == true then
						if RSA.db.profile.Warlock.Spells.Fear.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Warlock.Spells.Fear.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- FEAR
			if spellID == 6358 then -- SEDUCE
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Warlock.Spells.Seduce.Messages.End ~= "" then
					if RSA.db.profile.Warlock.Spells.Seduce.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Warlock.Spells.Seduce.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.Seduce.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Warlock.Spells.Seduce.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Warlock.Spells.Seduce.CustomChannel.Channel)
					end
					if RSA.db.profile.Warlock.Spells.Seduce.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Warlock.Spells.Seduce.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.Seduce.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Warlock.Spells.Seduce.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.Seduce.Party == true then
						if RSA.db.profile.Warlock.Spells.Seduce.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Warlock.Spells.Seduce.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.Seduce.Raid == true then
						if RSA.db.profile.Warlock.Spells.Seduce.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Warlock.Spells.Seduce.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- SEDUCE
			if spellID == 85767 then -- DARK INTENT
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Warlock.Spells.DarkIntent.Messages.End ~= "" then
					if RSA.db.profile.Warlock.Spells.DarkIntent.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Warlock.Spells.DarkIntent.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.DarkIntent.Whisper == true and dest ~= pName and RSA_Whisperable(destGUID) then
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
						RSA_Print_Whisper(string.gsub(RSA.db.profile.Warlock.Spells.DarkIntent.Messages.End, ".%a+.", RSA_String_Replace), dest)
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					end
					if RSA.db.profile.Warlock.Spells.DarkIntent.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Warlock.Spells.DarkIntent.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Warlock.Spells.DarkIntent.CustomChannel.Channel)
					end
					if RSA.db.profile.Warlock.Spells.DarkIntent.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Warlock.Spells.DarkIntent.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.DarkIntent.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Warlock.Spells.DarkIntent.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.DarkIntent.Party == true then
						if RSA.db.profile.Warlock.Spells.DarkIntent.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Warlock.Spells.DarkIntent.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.DarkIntent.Raid == true then
						if RSA.db.profile.Warlock.Spells.DarkIntent.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Warlock.Spells.DarkIntent.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- DARK INTENT
			if spellID == 5484 and RSA_HowlOfTerror == false then -- HOWL OF TERROR
				RSA_HowlOfTerror = true
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Warlock.Spells.HowlOfTerror.Messages.End ~= "" then
					if RSA.db.profile.Warlock.Spells.HowlOfTerror.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Warlock.Spells.HowlOfTerror.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.HowlOfTerror.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Warlock.Spells.HowlOfTerror.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Warlock.Spells.HowlOfTerror.CustomChannel.Channel)
					end
					if RSA.db.profile.Warlock.Spells.HowlOfTerror.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Warlock.Spells.HowlOfTerror.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.HowlOfTerror.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Warlock.Spells.HowlOfTerror.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.HowlOfTerror.Party == true then
						if RSA.db.profile.Warlock.Spells.HowlOfTerror.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Warlock.Spells.HowlOfTerror.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.HowlOfTerror.Raid == true then
						if RSA.db.profile.Warlock.Spells.HowlOfTerror.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Warlock.Spells.HowlOfTerror.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- HOWL OF TERROR
		end -- IF EVENT IS SPELL_AURA_REMOVED
		if event == "SPELL_DISPEL" then
			if spellID == 89808 then -- SINGE MAGIC
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				extraspellinfo = GetSpellInfo(missType)
				extraspellinfolink = GetSpellLink(missType)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[AURA]"] = extraspellinfo, ["[AURALINK]"] = extraspellinfolink,}
				if RSA.db.profile.Warlock.Spells.SingeMagic.Messages.Start ~= "" then
					if RSA.db.profile.Warlock.Spells.SingeMagic.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Warlock.Spells.SingeMagic.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.SingeMagic.Whisper == true and dest ~= pName and RSA_Whisperable(destGUID) then
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"], ["[AURA]"] = extraspellinfo, ["[AURALINK]"] = extraspellinfolink,}
						RSA_Print_Whisper(string.gsub(RSA.db.profile.Warlock.Spells.SingeMagic.Messages.Start, ".%a+.", RSA_String_Replace), dest)
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[AURA]"] = extraspellinfo, ["[AURALINK]"] = extraspellinfolink,}
					end
					if RSA.db.profile.Warlock.Spells.SingeMagic.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Warlock.Spells.SingeMagic.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Warlock.Spells.SingeMagic.CustomChannel.Channel)
					end
					if RSA.db.profile.Warlock.Spells.SingeMagic.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Warlock.Spells.SingeMagic.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.SingeMagic.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Warlock.Spells.SingeMagic.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.SingeMagic.Party == true then
						if RSA.db.profile.Warlock.Spells.SingeMagic.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Warlock.Spells.SingeMagic.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.SingeMagic.Raid == true then
						if RSA.db.profile.Warlock.Spells.SingeMagic.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Warlock.Spells.SingeMagic.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- SINGE MAGIC
			if spellID == 19505 then -- DEVOUR MAGIC
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				extraspellinfo = GetSpellInfo(missType) extraspellinfolink = GetSpellLink(missType)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[AURA]"] = extraspellinfo, ["[AURALINK]"] = extraspellinfolink,}
				if RSA.db.profile.Warlock.Spells.Devour.Messages.Start ~= "" then
					if RSA.db.profile.Warlock.Spells.Devour.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Warlock.Spells.Devour.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.Devour.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Warlock.Spells.Devour.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Warlock.Spells.Devour.CustomChannel.Channel)
					end
					if RSA.db.profile.Warlock.Spells.Devour.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Warlock.Spells.Devour.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.Devour.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Warlock.Spells.Devour.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.Devour.Party == true then
						if RSA.db.profile.Warlock.Spells.Devour.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Warlock.Spells.Devour.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.Devour.Raid == true then
						if RSA.db.profile.Warlock.Spells.Devour.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Warlock.Spells.Devour.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- DEVOUR MAGIC
		end -- IF EVENT IS SPELL_DISPEL
		if event == "SPELL_DISPEL_FAILED" then
			if spellID == 19505 then -- DEVOUR MAGIC
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				extraspellinfo = GetSpellInfo(missType)
				extraspellinfolink = GetSpellLink(missType)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[AURA]"] = extraspellinfo, ["[AURALINK]"] = extraspellinfolink,}
				if RSA.db.profile.Warlock.Spells.Devour.Messages.End ~= "" then
					if RSA.db.profile.Warlock.Spells.Devour.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Warlock.Spells.Devour.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.Devour.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Warlock.Spells.Devour.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Warlock.Spells.Devour.CustomChannel.Channel)
					end
					if RSA.db.profile.Warlock.Spells.Devour.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Warlock.Spells.Devour.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.Devour.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Warlock.Spells.Devour.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.Devour.Party == true then
						if RSA.db.profile.Warlock.Spells.Devour.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Warlock.Spells.Devour.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.Devour.Raid == true then
						if RSA.db.profile.Warlock.Spells.Devour.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Warlock.Spells.Devour.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- DEVOUR MAGIC
		end -- IF EVENT IS SPELL_DISPEL_FAILED
		if event == "SPELL_MISSED" and missType ~= "IMMUNE" then
			if spellID == 19647 then -- SPELL LOCK
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				if missType == "MISS" then
					missinfo = L["missed"]
				elseif missType ~= "MISS" then
					missinfo = L["was resisted by"]
				end
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = missinfo,}
				if RSA.db.profile.Warlock.Spells.SpellLock.Messages.End ~= "" then
					if RSA.db.profile.Warlock.Spells.SpellLock.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Warlock.Spells.SpellLock.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.SpellLock.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Warlock.Spells.SpellLock.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Warlock.Spells.SpellLock.CustomChannel.Channel)
					end
					if RSA.db.profile.Warlock.Spells.SpellLock.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Warlock.Spells.SpellLock.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.SpellLock.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Warlock.Spells.SpellLock.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.SpellLock.Party == true then
						if RSA.db.profile.Warlock.Spells.SpellLock.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Warlock.Spells.SpellLock.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.SpellLock.Raid == true then
						if RSA.db.profile.Warlock.Spells.SpellLock.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Warlock.Spells.SpellLock.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- SPELL LOCK
			if spellID == 17735 then -- SUFFERING
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				if missType == "MISS" then
					missinfo = L["missed"]
				elseif missType ~= "MISS" then
					missinfo = L["was resisted by"]
				end
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = missinfo,}
				if RSA.db.profile.Warlock.Spells.Suffering.Messages.End ~= "" then
					if RSA.db.profile.Warlock.Spells.Suffering.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Warlock.Spells.Suffering.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.Suffering.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Warlock.Spells.Suffering.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Warlock.Spells.Suffering.CustomChannel.Channel)
					end
					if RSA.db.profile.Warlock.Spells.Suffering.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Warlock.Spells.Suffering.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.Suffering.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Warlock.Spells.Suffering.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.Suffering.Party == true then
						if RSA.db.profile.Warlock.Spells.Suffering.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Warlock.Spells.Suffering.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.Suffering.Raid == true then
						if RSA.db.profile.Warlock.Spells.Suffering.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Warlock.Spells.Suffering.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- SUFFERING
		end -- IF EVENT IS SPELL_MISSED AND NOT IMMUNE
		if event == "SPELL_MISSED" and missType == "IMMUNE" then
			if spellID == 19647 then -- SPELL LOCK
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = L["Immune"],}
				if RSA.db.profile.Warlock.Spells.SpellLock.Messages.Immune ~= "" then
					if RSA.db.profile.Warlock.Spells.SpellLock.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Warlock.Spells.SpellLock.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.SpellLock.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Warlock.Spells.SpellLock.Messages.Immune, ".%a+.", RSA_String_Replace), RSA.db.profile.Warlock.Spells.SpellLock.CustomChannel.Channel)
					end
					if RSA.db.profile.Warlock.Spells.SpellLock.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Warlock.Spells.SpellLock.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.SpellLock.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Warlock.Spells.SpellLock.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.SpellLock.Party == true then
						if RSA.db.profile.Warlock.Spells.SpellLock.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Warlock.Spells.SpellLock.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.SpellLock.Raid == true then
						if RSA.db.profile.Warlock.Spells.SpellLock.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Warlock.Spells.SpellLock.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
				end
			end -- SPELL LOCK
			if spellID == 17735 then -- SUFFERING
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = L["Immune"],}
				if RSA.db.profile.Warlock.Spells.Suffering.Messages.Immune ~= "" then
					if RSA.db.profile.Warlock.Spells.Suffering.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Warlock.Spells.Suffering.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.Suffering.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Warlock.Spells.Suffering.Messages.Immune, ".%a+.", RSA_String_Replace), RSA.db.profile.Warlock.Spells.Suffering.CustomChannel.Channel)
					end
					if RSA.db.profile.Warlock.Spells.Suffering.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Warlock.Spells.Suffering.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.Suffering.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Warlock.Spells.Suffering.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.Suffering.Party == true then
						if RSA.db.profile.Warlock.Spells.Suffering.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Warlock.Spells.Suffering.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warlock.Spells.Suffering.Raid == true then
						if RSA.db.profile.Warlock.Spells.Suffering.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Warlock.Spells.Suffering.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
				end
			end -- SUFFERING
		end -- IF EVENT IS SPELL_MISSED AND IS IMMUNE
	end -- IF SOURCE IS PLAYER
end -- END ENTIRELY
RSA_CombatLogMonitor:SetScript("OnEvent", Warlock_Spells)
------------------------------
---- Resurrection Monitor ----
------------------------------
local function Warlock_Soulstone(_, event, self, spell, rank, dest, _)
	if spell == GetSpellInfo(20707) and RSA.db.profile.Warlock.Spells.Soulstone.Messages.Start ~= "" then -- REDEMPTION
		if event == "UNIT_SPELLCAST_SENT" and CastingSS ~= true and UnitIsPlayer(dest) then
			CastingSS = true
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
			spellinfo = GetSpellInfo(20707) spelllinkinfo = GetSpellLink(20707)
			RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
			if RSA.db.profile.Warlock.Spells.Soulstone.Messages.Start ~= "" then
				if RSA.db.profile.Warlock.Spells.Soulstone.Local == true then
					RSA_Print_LibSink(string.gsub(RSA.db.profile.Warlock.Spells.Soulstone.Messages.Start, ".%a+.", RSA_String_Replace))
				end
				if RSA.db.profile.Warlock.Spells.Soulstone.Whisper == true and dest ~= pName then
					RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
					RSA_Print_Whisper(string.gsub(RSA.db.profile.Warlock.Spells.Soulstone.Messages.Start, ".%a+.", RSA_String_Replace), dest)
					RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				end
				if RSA.db.profile.Warlock.Spells.Soulstone.CustomChannel.Enabled == true then
					RSA_Print_Channel(string.gsub(RSA.db.profile.Warlock.Spells.Soulstone.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Warlock.Spells.Soulstone.CustomChannel.Channel)
				end
				if RSA.db.profile.Warlock.Spells.Soulstone.Smart.Say == true then
					RSA_Print_Say(string.gsub(RSA.db.profile.Warlock.Spells.Soulstone.Messages.Start, ".%a+.", RSA_String_Replace))
				end
				if RSA.db.profile.Warlock.Spells.Soulstone.Smart.RaidParty == true then
					RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Warlock.Spells.Soulstone.Messages.Start, ".%a+.", RSA_String_Replace))
				end
				if RSA.db.profile.Warlock.Spells.Soulstone.Party == true then
					if RSA.db.profile.Warlock.Spells.Soulstone.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
						RSA_Print_Party(string.gsub(RSA.db.profile.Warlock.Spells.Soulstone.Messages.Start, ".%a+.", RSA_String_Replace))
				end
				if RSA.db.profile.Warlock.Spells.Soulstone.Raid == true then
					if RSA.db.profile.Warlock.Spells.Soulstone.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
					RSA_Print_Raid(string.gsub(RSA.db.profile.Warlock.Spells.Soulstone.Messages.Start, ".%a+.", RSA_String_Replace))
				end
			end
		elseif event == "UNIT_SPELLCAST_INTERRUPTED" then
		CastingSS = false
		elseif event == "UNIT_SPELLCAST_SUCCEEDED" and Ressed ~= true then
			dest = ResTarget
			Ressed = true
			if RSA.db.profile.Warlock.Spells.Soulstone.Messages.End ~= "" then
				if RSA.db.profile.Warlock.Spells.Soulstone.Local == true then
					RSA_Print_LibSink(string.gsub(RSA.db.profile.Warlock.Spells.Soulstone.Messages.End, ".%a+.", RSA_String_Replace))
				end
				if RSA.db.profile.Warlock.Spells.Soulstone.Whisper == true and dest ~= pName then
					RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
					RSA_Print_Whisper(string.gsub(RSA.db.profile.Warlock.Spells.Soulstone.Messages.End, ".%a+.", RSA_String_Replace), dest)
					RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				end
				if RSA.db.profile.Warlock.Spells.Soulstone.CustomChannel.Enabled == true then
					RSA_Print_Channel(string.gsub(RSA.db.profile.Warlock.Spells.Soulstone.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Warlock.Spells.Soulstone.CustomChannel.Channel)
				end
				if RSA.db.profile.Warlock.Spells.Soulstone.Smart.Say == true then
					RSA_Print_Say(string.gsub(RSA.db.profile.Warlock.Spells.Soulstone.Messages.End, ".%a+.", RSA_String_Replace))
				end
				if RSA.db.profile.Warlock.Spells.Soulstone.Smart.RaidParty == true then
					RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Warlock.Spells.Soulstone.Messages.End, ".%a+.", RSA_String_Replace))
				end
				if RSA.db.profile.Warlock.Spells.Soulstone.Party == true then
					if RSA.db.profile.Warlock.Spells.Soulstone.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
						RSA_Print_Party(string.gsub(RSA.db.profile.Warlock.Spells.Soulstone.Messages.End, ".%a+.", RSA_String_Replace))
				end
				if RSA.db.profile.Warlock.Spells.Soulstone.Raid == true then
					if RSA.db.profile.Warlock.Spells.Soulstone.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
					RSA_Print_Raid(string.gsub(RSA.db.profile.Warlock.Spells.Soulstone.Messages.End, ".%a+.", RSA_String_Replace))
				end
			end
		end
	end -- REDEMPTION
end -- END FUNCTION
RSA_ResMon = CreateFrame("Frame", "RSA:RM")
RSA_ResMon:RegisterEvent("UNIT_SPELLCAST_SENT")
RSA_ResMon:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
RSA_ResMon:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED")
RSA_ResMon:SetScript("OnEvent", Warlock_Soulstone)
end -- END ON ENABLED
function RSA_Warlock:OnDisable()
RSA_CombatLogMonitor:SetScript("OnEvent", nil)
RSA_ResMon:SetScript("OnEvent", nil)
end