----------------------------------------------
---- Raeli's Spell Announcer Druid Module ----
----------------------------------------------
local RSA = LibStub("AceAddon-3.0"):GetAddon("RSA")
local L = LibStub("AceLocale-3.0"):GetLocale("RSA")
local RSA_Druid = RSA:NewModule("Druid")
function RSA_Druid:OnInitialize()
	if RSA.db.profile.General.Class == "DRUID" then
		RSA_Druid:SetEnabledState(true)
	else
		RSA_Druid:SetEnabledState(false)
	end
end -- End OnInitialize
function RSA_Druid:OnEnable()
local spellinfo
local spelllinkinfo
local extraspellinfo
local extraspellinfolink
RSA.db.profile.Modules.Druid = true -- Set state to loaded, to know if we should announce when a spell is refreshed.
local pName = UnitName("player")
local ResTarget = L["Unknown"]
local Ressed
local RSA_Timer = CreateFrame("Frame", "RSA:Timer") -- REMOVE. USE RALLYING CRY IMPLEMENTATION.
local function Druid_Spells(_, _, _, event, _, _, source, _, _, destGUID, dest, _, _, spellID, spellName, _, missType)
	local petName = UnitName("pet")
	if source == pName or source == petName then
		if (event == "SPELL_CAST_SUCCESS" and RSA.db.profile.Modules.Reminders_Loaded == true) then -- Reminder Refreshed
			local ReminderSpell = RSA.db.profile.Druid.Reminders.SpellName
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
			if spellID == 29166 then -- INNERVATE
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Druid.Spells.Innervate.Messages.Start ~= "" then
					if RSA.db.profile.Druid.Spells.Innervate.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Druid.Spells.Innervate.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Innervate.Whisper == true and dest ~= pName and RSA_Whisperable(destGUID) then
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
						RSA_Print_Whisper(string.gsub(RSA.db.profile.Druid.Spells.Innervate.Messages.Start, ".%a+.", RSA_String_Replace), dest)
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					end
					if RSA.db.profile.Druid.Spells.Innervate.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Druid.Spells.Innervate.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Druid.Spells.Innervate.CustomChannel.Channel)
					end
					if RSA.db.profile.Druid.Spells.Innervate.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Druid.Spells.Innervate.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Innervate.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Druid.Spells.Innervate.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Innervate.Party == true then
						if RSA.db.profile.Druid.Spells.Innervate.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Druid.Spells.Innervate.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Innervate.Raid == true then
						if RSA.db.profile.Druid.Spells.Innervate.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Druid.Spells.Innervate.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- INNERVATE
			if spellID == 6795 then -- GROWL
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Druid.Spells.Growl.Messages.Start ~= "" then
					if RSA.db.profile.Druid.Spells.Growl.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Druid.Spells.Growl.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Growl.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Druid.Spells.Growl.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Druid.Spells.Growl.CustomChannel.Channel)
					end
					if RSA.db.profile.Druid.Spells.Growl.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Druid.Spells.Growl.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Growl.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Druid.Spells.Growl.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Growl.Party == true then
						if RSA.db.profile.Druid.Spells.Growl.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Druid.Spells.Growl.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Growl.Raid == true then
						if RSA.db.profile.Druid.Spells.Growl.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Druid.Spells.Growl.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- GROWL
			if spellID == 2637 then -- HIBERNATE
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Druid.Spells.Hibernate.Messages.Start ~= "" then
					if RSA.db.profile.Druid.Spells.Hibernate.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Druid.Spells.Hibernate.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Hibernate.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Druid.Spells.Hibernate.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Druid.Spells.Hibernate.CustomChannel.Channel)
					end
					if RSA.db.profile.Druid.Spells.Hibernate.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Druid.Spells.Hibernate.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Hibernate.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Druid.Spells.Hibernate.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Hibernate.Party == true then
						if RSA.db.profile.Druid.Spells.Hibernate.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Druid.Spells.Hibernate.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Hibernate.Raid == true then
						if RSA.db.profile.Druid.Spells.Hibernate.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Druid.Spells.Hibernate.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- HIBERNATE
			if spellID == 33786 then -- CYCLONE
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Druid.Spells.Cyclone.Messages.Start ~= "" then
					if RSA.db.profile.Druid.Spells.Cyclone.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Druid.Spells.Cyclone.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Cyclone.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Druid.Spells.Cyclone.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Druid.Spells.Cyclone.CustomChannel.Channel)
					end
					if RSA.db.profile.Druid.Spells.Cyclone.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Druid.Spells.Cyclone.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Cyclone.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Druid.Spells.Cyclone.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Cyclone.Party == true then
						if RSA.db.profile.Druid.Spells.Cyclone.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Druid.Spells.Cyclone.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Cyclone.Raid == true then
						if RSA.db.profile.Druid.Spells.Cyclone.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Druid.Spells.Cyclone.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- CYCLONE
			if spellID == 339 then -- ENTANGLING ROOTS
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Druid.Spells.Roots.Messages.Start ~= "" then
					if RSA.db.profile.Druid.Spells.Roots.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Druid.Spells.Roots.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Roots.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Druid.Spells.Roots.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Druid.Spells.Roots.CustomChannel.Channel)
					end
					if RSA.db.profile.Druid.Spells.Roots.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Druid.Spells.Roots.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Roots.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Druid.Spells.Roots.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Roots.Party == true then
						if RSA.db.profile.Druid.Spells.Roots.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Druid.Spells.Roots.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Roots.Raid == true then
						if RSA.db.profile.Druid.Spells.Roots.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Druid.Spells.Roots.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- ENTANGLING ROOTS
			if spellID == 33891 or spellID == 65139 then -- TREE OF LIFE
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Druid.Spells.TreeOfLife.Messages.Start ~= "" then
					if RSA.db.profile.Druid.Spells.TreeOfLife.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Druid.Spells.TreeOfLife.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.TreeOfLife.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Druid.Spells.TreeOfLife.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Druid.Spells.TreeOfLife.CustomChannel.Channel)
					end
					if RSA.db.profile.Druid.Spells.TreeOfLife.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Druid.Spells.TreeOfLife.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.TreeOfLife.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Druid.Spells.TreeOfLife.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.TreeOfLife.Party == true then
						if RSA.db.profile.Druid.Spells.TreeOfLife.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Druid.Spells.TreeOfLife.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.TreeOfLife.Raid == true then
						if RSA.db.profile.Druid.Spells.TreeOfLife.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Druid.Spells.TreeOfLife.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- TREE OF LIFE
			if spellID == 22812 then -- BARKSKIN
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Druid.Spells.Barkskin.Messages.Start ~= "" then
					if RSA.db.profile.Druid.Spells.Barkskin.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Druid.Spells.Barkskin.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Barkskin.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Druid.Spells.Barkskin.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Druid.Spells.Barkskin.CustomChannel.Channel)
					end
					if RSA.db.profile.Druid.Spells.Barkskin.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Druid.Spells.Barkskin.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Barkskin.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Druid.Spells.Barkskin.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Barkskin.Party == true then
						if RSA.db.profile.Druid.Spells.Barkskin.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Druid.Spells.Barkskin.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Barkskin.Raid == true then
						if RSA.db.profile.Druid.Spells.Barkskin.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Druid.Spells.Barkskin.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- BARKSKIN
			if spellID == 467 then -- THORNS
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Druid.Spells.Thorns.Messages.Start ~= "" then
					if RSA.db.profile.Druid.Spells.Thorns.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Druid.Spells.Thorns.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Thorns.Whisper == true and dest ~= pName and RSA_Whisperable(destGUID) then
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
						RSA_Print_Whisper(string.gsub(RSA.db.profile.Druid.Spells.Thorns.Messages.Start, ".%a+.", RSA_String_Replace), dest)
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					end
					if RSA.db.profile.Druid.Spells.Thorns.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Druid.Spells.Thorns.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Druid.Spells.Thorns.CustomChannel.Channel)
					end
					if RSA.db.profile.Druid.Spells.Thorns.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Druid.Spells.Thorns.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Thorns.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Druid.Spells.Thorns.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Thorns.Party == true then
						if RSA.db.profile.Druid.Spells.Thorns.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Druid.Spells.Thorns.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Thorns.Raid == true then
						if RSA.db.profile.Druid.Spells.Thorns.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Druid.Spells.Thorns.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- THORNS
		end -- IF EVENT IS SPELL_AURA_APPLIED
		if event == "SPELL_CAST_SUCCESS" then
			if spellID == 22842 then -- FRENZIED REGENERATION
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Druid.Spells.FrenziedRegeneration.Messages.Start ~= "" then
					if RSA.db.profile.Druid.Spells.FrenziedRegeneration.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Druid.Spells.FrenziedRegeneration.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.FrenziedRegeneration.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Druid.Spells.FrenziedRegeneration.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Druid.Spells.FrenziedRegeneration.CustomChannel.Channel)
					end
					if RSA.db.profile.Druid.Spells.FrenziedRegeneration.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Druid.Spells.FrenziedRegeneration.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.FrenziedRegeneration.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Druid.Spells.FrenziedRegeneration.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.FrenziedRegeneration.Party == true then
						if RSA.db.profile.Druid.Spells.FrenziedRegeneration.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Druid.Spells.FrenziedRegeneration.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.FrenziedRegeneration.Raid == true then
						if RSA.db.profile.Druid.Spells.FrenziedRegeneration.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Druid.Spells.FrenziedRegeneration.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- FRENZIED REGENERATION
			if spellID == 61336 then -- SURVIVAL INSTINCTS
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Druid.Spells.SurvivalInstincts.Messages.Start ~= "" then
					if RSA.db.profile.Druid.Spells.SurvivalInstincts.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Druid.Spells.SurvivalInstincts.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.SurvivalInstincts.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Druid.Spells.SurvivalInstincts.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Druid.Spells.SurvivalInstincts.CustomChannel.Channel)
					end
					if RSA.db.profile.Druid.Spells.SurvivalInstincts.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Druid.Spells.SurvivalInstincts.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.SurvivalInstincts.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Druid.Spells.SurvivalInstincts.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.SurvivalInstincts.Party == true then
						if RSA.db.profile.Druid.Spells.SurvivalInstincts.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Druid.Spells.SurvivalInstincts.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.SurvivalInstincts.Raid == true then
						if RSA.db.profile.Druid.Spells.SurvivalInstincts.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Druid.Spells.SurvivalInstincts.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- SURVIVAL INSTINCTS
			if spellID == 740 then -- TRANQUILITY
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Druid.Spells.Tranquility.Messages.Start ~= "" then
					if RSA.db.profile.Druid.Spells.Tranquility.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Druid.Spells.Tranquility.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Tranquility.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Druid.Spells.Tranquility.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Druid.Spells.Tranquility.CustomChannel.Channel)
					end
					if RSA.db.profile.Druid.Spells.Tranquility.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Druid.Spells.Tranquility.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Tranquility.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Druid.Spells.Tranquility.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Tranquility.Party == true then
						if RSA.db.profile.Druid.Spells.Tranquility.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Druid.Spells.Tranquility.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Tranquility.Raid == true then
						if RSA.db.profile.Druid.Spells.Tranquility.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Druid.Spells.Tranquility.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- TRANQUILITY
			if spellID == 5209 then -- CHALLENGING ROAR WITH TIMER FOR ENDING
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Druid.Spells.ChallengingRoar.Messages.Start ~= "" then
					if RSA.db.profile.Druid.Spells.ChallengingRoar.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Druid.Spells.ChallengingRoar.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.ChallengingRoar.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Druid.Spells.ChallengingRoar.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Druid.Spells.ChallengingRoar.CustomChannel.Channel)
					end
					if RSA.db.profile.Druid.Spells.ChallengingRoar.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Druid.Spells.ChallengingRoar.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.ChallengingRoar.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Druid.Spells.ChallengingRoar.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.ChallengingRoar.Party == true then
						if RSA.db.profile.Druid.Spells.ChallengingRoar.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Druid.Spells.ChallengingRoar.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.ChallengingRoar.Raid == true then
						if RSA.db.profile.Druid.Spells.ChallengingRoar.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Druid.Spells.ChallengingRoar.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
				local ReminderTimeElapsed = 0.0 -- Start Challenging Roar Timer for end announcement.
				local function CRTimer(self, elapsed)
					ReminderTimeElapsed = ReminderTimeElapsed + elapsed
					if ReminderTimeElapsed < 6 then return end
					ReminderTimeElapsed = ReminderTimeElapsed - floor(ReminderTimeElapsed)
					if RSA.db.profile.Druid.Spells.ChallengingRoar.Messages.End ~= "" then
						if RSA.db.profile.Druid.Spells.ChallengingRoar.Local == true then
							RSA_Print_LibSink(string.gsub(RSA.db.profile.Druid.Spells.ChallengingRoar.Messages.End, ".%a+.", RSA_String_Replace))
						end
						if RSA.db.profile.Druid.Spells.ChallengingRoar.CustomChannel.Enabled == true then
							RSA_Print_Channel(string.gsub(RSA.db.profile.Druid.Spells.ChallengingRoar.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Druid.Spells.ChallengingRoar.CustomChannel.Channel)
						end
						if RSA.db.profile.Druid.Spells.ChallengingRoar.Smart.Say == true then
							RSA_Print_Say(string.gsub(RSA.db.profile.Druid.Spells.ChallengingRoar.Messages.End, ".%a+.", RSA_String_Replace))
						end
						if RSA.db.profile.Druid.Spells.ChallengingRoar.Smart.RaidParty == true then
							RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Druid.Spells.ChallengingRoar.Messages.End, ".%a+.", RSA_String_Replace))
						end
						if RSA.db.profile.Druid.Spells.ChallengingRoar.Party == true then
							if RSA.db.profile.Druid.Spells.ChallengingRoar.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
								RSA_Print_Party(string.gsub(RSA.db.profile.Druid.Spells.ChallengingRoar.Messages.End, ".%a+.", RSA_String_Replace))
						end
						if RSA.db.profile.Druid.Spells.ChallengingRoar.Raid == true then
							if RSA.db.profile.Druid.Spells.ChallengingRoar.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
							RSA_Print_Raid(string.gsub(RSA.db.profile.Druid.Spells.ChallengingRoar.Messages.End, ".%a+.", RSA_String_Replace))
						end
					end
					RSA_Timer:SetScript("OnUpdate", nil)
				end
				RSA_Timer:SetScript("OnUpdate", CRTimer)
			end -- CHALLENGING ROAR WITH TIMER FOR ENDING
			if spellID == 50334 then -- BERSERK
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Druid.Spells.Berserk.Messages.Start ~= "" then
					if RSA.db.profile.Druid.Spells.Berserk.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Druid.Spells.Berserk.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Berserk.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Druid.Spells.Berserk.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Druid.Spells.Berserk.CustomChannel.Channel)
					end
					if RSA.db.profile.Druid.Spells.Berserk.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Druid.Spells.Berserk.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Berserk.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Druid.Spells.Berserk.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Berserk.Party == true then
						if RSA.db.profile.Druid.Spells.Berserk.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Druid.Spells.Berserk.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Berserk.Raid == true then
						if RSA.db.profile.Druid.Spells.Berserk.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Druid.Spells.Berserk.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- BERSERK
			if spellID == 77761 or spellID == 77764 then -- STAMPEDING ROAR
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Druid.Spells.StampedingRoar.Messages.Start ~= "" then
					if RSA.db.profile.Druid.Spells.StampedingRoar.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Druid.Spells.StampedingRoar.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.StampedingRoar.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Druid.Spells.StampedingRoar.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Druid.Spells.StampedingRoar.CustomChannel.Channel)
					end
					if RSA.db.profile.Druid.Spells.StampedingRoar.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Druid.Spells.StampedingRoar.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.StampedingRoar.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Druid.Spells.StampedingRoar.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.StampedingRoar.Party == true then
						if RSA.db.profile.Druid.Spells.StampedingRoar.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Druid.Spells.StampedingRoar.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.StampedingRoar.Raid == true then
						if RSA.db.profile.Druid.Spells.StampedingRoar.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Druid.Spells.StampedingRoar.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- STAMPEDING ROAR
		end -- IF EVENT IS SPELL_CAST_SUCCESS
		if event == "SPELL_INTERRUPT" then
			if spellID == 80965 or spellID == 80964 or spellID == 93985 then -- SKULL BASH
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				extraspellinfo = GetSpellInfo(missType)
				extraspellinfolink = GetSpellLink(missType)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[TARSPELL]"] = extraspellinfo, ["[TARLINK]"] = extraspellinfolink,}
				if RSA.db.profile.Druid.Spells.SkullBash.Messages.Start ~= "" then
					if RSA.db.profile.Druid.Spells.SkullBash.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Druid.Spells.SkullBash.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.SkullBash.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Druid.Spells.SkullBash.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Druid.Spells.SkullBash.CustomChannel.Channel)
					end
					if RSA.db.profile.Druid.Spells.SkullBash.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Druid.Spells.SkullBash.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.SkullBash.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Druid.Spells.SkullBash.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.SkullBash.Party == true then
						if RSA.db.profile.Druid.Spells.SkullBash.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Druid.Spells.SkullBash.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.SkullBash.Raid == true then
						if RSA.db.profile.Druid.Spells.SkullBash.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Druid.Spells.SkullBash.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- SKULL BASH
			if spellID == 97547 then -- SOLAR BEAM
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				extraspellinfo = GetSpellInfo(missType)
				extraspellinfolink = GetSpellLink(missType)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[TARSPELL]"] = extraspellinfo, ["[TARLINK]"] = extraspellinfolink,}
				if RSA.db.profile.Druid.Spells.SolarBeam.Messages.Start ~= "" then
					if RSA.db.profile.Druid.Spells.SolarBeam.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Druid.Spells.SolarBeam.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.SolarBeam.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Druid.Spells.SolarBeam.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Druid.Spells.SolarBeam.CustomChannel.Channel)
					end
					if RSA.db.profile.Druid.Spells.SolarBeam.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Druid.Spells.SolarBeam.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.SolarBeam.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Druid.Spells.SolarBeam.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.SolarBeam.Party == true then
						if RSA.db.profile.Druid.Spells.SolarBeam.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Druid.Spells.SolarBeam.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.SolarBeam.Raid == true then
						if RSA.db.profile.Druid.Spells.SolarBeam.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Druid.Spells.SolarBeam.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- SOLAR BEAM
		end -- IF EVENT IS SPELL_INTERRUPT
		if event == "SPELL_DISPEL" then
			if spellID == 2782 then -- REMOVE CORRUPTION
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				extraspellinfo = GetSpellInfo(missType)
				extraspellinfolink = GetSpellLink(missType)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[AURA]"] = extraspellinfo, ["[AURALINK]"] = extraspellinfolink,}
				if RSA.db.profile.Druid.Spells.RemoveCorruption.Messages.Start ~= "" then
					if RSA.db.profile.Druid.Spells.RemoveCorruption.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Druid.Spells.RemoveCorruption.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.RemoveCorruption.Whisper == true and dest ~= pName and RSA_Whisperable(destGUID) then
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
						RSA_Print_Whisper(string.gsub(RSA.db.profile.Druid.Spells.RemoveCorruption.Messages.End, ".%a+.", RSA_String_Replace), dest)
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					end
					if RSA.db.profile.Druid.Spells.RemoveCorruption.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Druid.Spells.RemoveCorruption.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Druid.Spells.RemoveCorruption.CustomChannel.Channel)
					end
					if RSA.db.profile.Druid.Spells.RemoveCorruption.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Druid.Spells.RemoveCorruption.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.RemoveCorruption.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Druid.Spells.RemoveCorruption.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.RemoveCorruption.Party == true then
						if RSA.db.profile.Druid.Spells.RemoveCorruption.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Druid.Spells.RemoveCorruption.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.RemoveCorruption.Raid == true then
						if RSA.db.profile.Druid.Spells.RemoveCorruption.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Druid.Spells.RemoveCorruption.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- REMOVE CORRUPTION
			if spellID == 2908 then -- SOOTHE
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				extraspellinfo = GetSpellInfo(missType)
				extraspellinfolink = GetSpellLink(missType)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[AURA]"] = extraspellinfo, ["[AURALINK]"] = extraspellinfolink,}
				if RSA.db.profile.Druid.Spells.Soothe.Messages.Start ~= "" then
					if RSA.db.profile.Druid.Spells.Soothe.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Druid.Spells.Soothe.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Soothe.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Druid.Spells.Soothe.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Druid.Spells.Soothe.CustomChannel.Channel)
					end
					if RSA.db.profile.Druid.Spells.Soothe.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Druid.Spells.Soothe.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Soothe.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Druid.Spells.Soothe.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Soothe.Party == true then
						if RSA.db.profile.Druid.Spells.Soothe.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Druid.Spells.Soothe.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Soothe.Raid == true then
						if RSA.db.profile.Druid.Spells.Soothe.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Druid.Spells.Soothe.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- SOOTHE
		end
		if event == "SPELL_DISPEL_FAILED" then
			if spellID == 2908 then -- SOOTHE
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				extraspellinfo = GetSpellInfo(missType)
				extraspellinfolink = GetSpellLink(missType)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[AURA]"] = extraspellinfo, ["[AURALINK]"] = extraspellinfolink,}
				if RSA.db.profile.Druid.Spells.Soothe.Messages.End ~= "" then
					if RSA.db.profile.Druid.Spells.Soothe.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Druid.Spells.Soothe.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Soothe.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Druid.Spells.Soothe.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Druid.Spells.Soothe.CustomChannel.Channel)
					end
					if RSA.db.profile.Druid.Spells.Soothe.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Druid.Spells.Soothe.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Soothe.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Druid.Spells.Soothe.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Soothe.Party == true then
						if RSA.db.profile.Druid.Spells.Soothe.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Druid.Spells.Soothe.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Soothe.Raid == true then
						if RSA.db.profile.Druid.Spells.Soothe.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Druid.Spells.Soothe.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- SOOTHE
		end -- IF EVENT IS SPELL_DISPEL_FAILED
		if event == "SPELL_AURA_REMOVED" then
			if spellID == 29166 then -- INNERVATE
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Druid.Spells.Innervate.Messages.End ~= "" then
					if RSA.db.profile.Druid.Spells.Innervate.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Druid.Spells.Innervate.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Innervate.Whisper == true and dest ~= pName and RSA_Whisperable(destGUID) then
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
						RSA_Print_Whisper(string.gsub(RSA.db.profile.Druid.Spells.Innervate.Messages.End, ".%a+.", RSA_String_Replace), dest)
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					end
					if RSA.db.profile.Druid.Spells.Innervate.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Druid.Spells.Innervate.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Druid.Spells.Innervate.CustomChannel.Channel)
					end
					if RSA.db.profile.Druid.Spells.Innervate.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Druid.Spells.Innervate.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Innervate.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Druid.Spells.Innervate.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Innervate.Party == true then
						if RSA.db.profile.Druid.Spells.Innervate.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Druid.Spells.Innervate.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Innervate.Raid == true then
						if RSA.db.profile.Druid.Spells.Innervate.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Druid.Spells.Innervate.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- INNERVATE
			if spellID == 2637 then -- HIBERNATE
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Druid.Spells.Hibernate.Messages.End ~= "" then
					if RSA.db.profile.Druid.Spells.Hibernate.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Druid.Spells.Hibernate.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Hibernate.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Druid.Spells.Hibernate.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Druid.Spells.Hibernate.CustomChannel.Channel)
					end
					if RSA.db.profile.Druid.Spells.Hibernate.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Druid.Spells.Hibernate.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Hibernate.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Druid.Spells.Hibernate.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Hibernate.Party == true then
						if RSA.db.profile.Druid.Spells.Hibernate.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Druid.Spells.Hibernate.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Hibernate.Raid == true then
						if RSA.db.profile.Druid.Spells.Hibernate.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Druid.Spells.Hibernate.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- HIBERNATE
			if spellID == 33786 then -- CYCLONE
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Druid.Spells.Cyclone.Messages.End ~= "" then
					if RSA.db.profile.Druid.Spells.Cyclone.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Druid.Spells.Cyclone.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Cyclone.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Druid.Spells.Cyclone.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Druid.Spells.Cyclone.CustomChannel.Channel)
					end
					if RSA.db.profile.Druid.Spells.Cyclone.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Druid.Spells.Cyclone.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Cyclone.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Druid.Spells.Cyclone.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Cyclone.Party == true then
						if RSA.db.profile.Druid.Spells.Cyclone.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Druid.Spells.Cyclone.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Cyclone.Raid == true then
						if RSA.db.profile.Druid.Spells.Cyclone.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Druid.Spells.Cyclone.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- CYCLONE
			if spellID == 22842 then -- FRENZIED REGENERATION
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Druid.Spells.FrenziedRegeneration.Messages.End ~= "" then
					if RSA.db.profile.Druid.Spells.FrenziedRegeneration.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Druid.Spells.FrenziedRegeneration.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.FrenziedRegeneration.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Druid.Spells.FrenziedRegeneration.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Druid.Spells.FrenziedRegeneration.CustomChannel.Channel)
					end
					if RSA.db.profile.Druid.Spells.FrenziedRegeneration.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Druid.Spells.FrenziedRegeneration.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.FrenziedRegeneration.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Druid.Spells.FrenziedRegeneration.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.FrenziedRegeneration.Party == true then
						if RSA.db.profile.Druid.Spells.FrenziedRegeneration.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Druid.Spells.FrenziedRegeneration.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.FrenziedRegeneration.Raid == true then
						if RSA.db.profile.Druid.Spells.FrenziedRegeneration.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Druid.Spells.FrenziedRegeneration.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- FRENZIED REGENERATION
			if spellID == 61336 then -- SURVIVAL INSTINCTS
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Druid.Spells.SurvivalInstincts.Messages.End ~= "" then
					if RSA.db.profile.Druid.Spells.SurvivalInstincts.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Druid.Spells.SurvivalInstincts.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.SurvivalInstincts.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Druid.Spells.SurvivalInstincts.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Druid.Spells.SurvivalInstincts.CustomChannel.Channel)
					end
					if RSA.db.profile.Druid.Spells.SurvivalInstincts.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Druid.Spells.SurvivalInstincts.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.SurvivalInstincts.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Druid.Spells.SurvivalInstincts.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.SurvivalInstincts.Party == true then
						if RSA.db.profile.Druid.Spells.SurvivalInstincts.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Druid.Spells.SurvivalInstincts.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.SurvivalInstincts.Raid == true then
						if RSA.db.profile.Druid.Spells.SurvivalInstincts.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Druid.Spells.SurvivalInstincts.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- SURVIVAL INSTINCTS
			if spellID == 33891 or spellID == 65139 then -- TREE OF LIFE
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Druid.Spells.TreeOfLife.Messages.End ~= "" then
					if RSA.db.profile.Druid.Spells.TreeOfLife.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Druid.Spells.TreeOfLife.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.TreeOfLife.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Druid.Spells.TreeOfLife.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Druid.Spells.TreeOfLife.CustomChannel.Channel)
					end
					if RSA.db.profile.Druid.Spells.TreeOfLife.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Druid.Spells.TreeOfLife.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.TreeOfLife.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Druid.Spells.TreeOfLife.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.TreeOfLife.Party == true then
						if RSA.db.profile.Druid.Spells.TreeOfLife.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Druid.Spells.TreeOfLife.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.TreeOfLife.Raid == true then
						if RSA.db.profile.Druid.Spells.TreeOfLife.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Druid.Spells.TreeOfLife.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- TREE OF LIFE
			if spellID == 22812 then -- BARKSKIN
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Druid.Spells.Barkskin.Messages.End ~= "" then
					if RSA.db.profile.Druid.Spells.Barkskin.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Druid.Spells.Barkskin.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Barkskin.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Druid.Spells.Barkskin.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Druid.Spells.Barkskin.CustomChannel.Channel)
					end
					if RSA.db.profile.Druid.Spells.Barkskin.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Druid.Spells.Barkskin.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Barkskin.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Druid.Spells.Barkskin.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Barkskin.Party == true then
						if RSA.db.profile.Druid.Spells.Barkskin.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Druid.Spells.Barkskin.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Barkskin.Raid == true then
						if RSA.db.profile.Druid.Spells.Barkskin.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Druid.Spells.Barkskin.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- BARKSKIN
			if spellID == 467 then -- THORNS
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Druid.Spells.Thorns.Messages.End ~= "" then
					if RSA.db.profile.Druid.Spells.Thorns.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Druid.Spells.Thorns.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Thorns.Whisper == true and dest ~= pName and RSA_Whisperable(destGUID) then
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
						RSA_Print_Whisper(string.gsub(RSA.db.profile.Druid.Spells.Thorns.Messages.End, ".%a+.", RSA_String_Replace), dest)
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					end
					if RSA.db.profile.Druid.Spells.Thorns.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Druid.Spells.Thorns.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Druid.Spells.Thorns.CustomChannel.Channel)
					end
					if RSA.db.profile.Druid.Spells.Thorns.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Druid.Spells.Thorns.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Thorns.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Druid.Spells.Thorns.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Thorns.Party == true then
						if RSA.db.profile.Druid.Spells.Thorns.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Druid.Spells.Thorns.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Thorns.Raid == true then
						if RSA.db.profile.Druid.Spells.Thorns.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Druid.Spells.Thorns.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- THORNS
			if spellID == 740 then -- TRANQUILITY
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Druid.Spells.Tranquility.Messages.End ~= "" then
					if RSA.db.profile.Druid.Spells.Tranquility.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Druid.Spells.Tranquility.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Tranquility.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Druid.Spells.Tranquility.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Druid.Spells.Tranquility.CustomChannel.Channel)
					end
					if RSA.db.profile.Druid.Spells.Tranquility.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Druid.Spells.Tranquility.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Tranquility.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Druid.Spells.Tranquility.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Tranquility.Party == true then
						if RSA.db.profile.Druid.Spells.Tranquility.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Druid.Spells.Tranquility.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Tranquility.Raid == true then
						if RSA.db.profile.Druid.Spells.Tranquility.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Druid.Spells.Tranquility.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- TRANQUILITY
			if spellID == 50334 then -- BERSERK
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Druid.Spells.Berserk.Messages.End ~= "" then
					if RSA.db.profile.Druid.Spells.Berserk.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Druid.Spells.Berserk.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Berserk.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Druid.Spells.Berserk.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Druid.Spells.Berserk.CustomChannel.Channel)
					end
					if RSA.db.profile.Druid.Spells.Berserk.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Druid.Spells.Berserk.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Berserk.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Druid.Spells.Berserk.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Berserk.Party == true then
						if RSA.db.profile.Druid.Spells.Berserk.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Druid.Spells.Berserk.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Berserk.Raid == true then
						if RSA.db.profile.Druid.Spells.Berserk.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Druid.Spells.Berserk.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- BERSERK
			if spellID == 339 then -- ENTANGLING ROOTS
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Druid.Spells.Roots.Messages.End ~= "" then
					if RSA.db.profile.Druid.Spells.Roots.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Druid.Spells.Roots.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Roots.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Druid.Spells.Roots.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Druid.Spells.Roots.CustomChannel.Channel)
					end
					if RSA.db.profile.Druid.Spells.Roots.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Druid.Spells.Roots.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Roots.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Druid.Spells.Roots.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Roots.Party == true then
						if RSA.db.profile.Druid.Spells.Roots.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Druid.Spells.Roots.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Roots.Raid == true then
						if RSA.db.profile.Druid.Spells.Roots.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Druid.Spells.Roots.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- ENTANGLING ROOTS
			if (spellID == 77761 or spellID == 77764) and dest == pName then -- STAMPEDING ROAR
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Druid.Spells.StampedingRoar.Messages.End ~= "" then
					if RSA.db.profile.Druid.Spells.StampedingRoar.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Druid.Spells.StampedingRoar.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.StampedingRoar.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Druid.Spells.StampedingRoar.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Druid.Spells.StampedingRoar.CustomChannel.Channel)
					end
					if RSA.db.profile.Druid.Spells.StampedingRoar.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Druid.Spells.StampedingRoar.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.StampedingRoar.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Druid.Spells.StampedingRoar.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.StampedingRoar.Party == true then
						if RSA.db.profile.Druid.Spells.StampedingRoar.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Druid.Spells.StampedingRoar.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.StampedingRoar.Raid == true then
						if RSA.db.profile.Druid.Spells.StampedingRoar.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Druid.Spells.StampedingRoar.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- STAMPEDING ROAR
		end -- IF EVENT IS SPELL_AURA_REMOVED
		if event == "SPELL_MISSED" and missType ~= "IMMUNE" then
			if spellID == 6795 then -- GROWL
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				if missType == "MISS" then
					missinfo = L["missed"]
				elseif missType ~= "MISS" then
					missinfo = L["was resisted by"]
				end
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = missinfo,}
				if RSA.db.profile.Druid.Spells.Growl.Messages.End ~= "" then
					if RSA.db.profile.Druid.Spells.Growl.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Druid.Spells.Growl.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Growl.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Druid.Spells.Growl.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Druid.Spells.Growl.CustomChannel.Channel)
					end
					if RSA.db.profile.Druid.Spells.Growl.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Druid.Spells.Growl.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Growl.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Druid.Spells.Growl.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Growl.Party == true then
						if RSA.db.profile.Druid.Spells.Growl.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Druid.Spells.Growl.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Growl.Raid == true then
						if RSA.db.profile.Druid.Spells.Growl.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Druid.Spells.Growl.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- GROWL
			if spellID == 80965 or spellID == 80964 or spellID == 93985 then -- SKULL BASH
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				if missType == "MISS" then
					missinfo = L["missed"]
				elseif missType ~= "MISS" then
					missinfo = L["was resisted by"]
				end
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = missinfo,}
				if RSA.db.profile.Druid.Spells.SkullBash.Messages.End ~= "" then
					if RSA.db.profile.Druid.Spells.SkullBash.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Druid.Spells.SkullBash.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.SkullBash.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Druid.Spells.SkullBash.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Druid.Spells.SkullBash.CustomChannel.Channel)
					end
					if RSA.db.profile.Druid.Spells.SkullBash.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Druid.Spells.SkullBash.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.SkullBash.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Druid.Spells.SkullBash.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.SkullBash.Party == true then
						if RSA.db.profile.Druid.Spells.SkullBash.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Druid.Spells.SkullBash.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.SkullBash.Raid == true then
						if RSA.db.profile.Druid.Spells.SkullBash.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Druid.Spells.SkullBash.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- SKULL BASH
		end -- IF EVENT IS SPELL_MISSED AND NOT IMMUNE
		if event == "SPELL_MISSED" and missType == "IMMUNE" then
			if spellID == 6795 then -- GROWL
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = L["Immune"],}
				if RSA.db.profile.Druid.Spells.Growl.Messages.Immune ~= "" then
					if RSA.db.profile.Druid.Spells.Growl.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Druid.Spells.Growl.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Growl.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Druid.Spells.Growl.Messages.Immune, ".%a+.", RSA_String_Replace), RSA.db.profile.Druid.Spells.Growl.CustomChannel.Channel)
					end
					if RSA.db.profile.Druid.Spells.Growl.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Druid.Spells.Growl.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Growl.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Druid.Spells.Growl.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Growl.Party == true then
						if RSA.db.profile.Druid.Spells.Growl.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Druid.Spells.Growl.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Growl.Raid == true then
						if RSA.db.profile.Druid.Spells.Growl.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Druid.Spells.Growl.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
				end
			end -- GROWL
			if spellID == 80965 or spellID == 80964 or spellID == 93985 then -- SKULL BASH
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = L["Immune"],}
				if RSA.db.profile.Druid.Spells.SkullBash.Messages.Immune ~= "" then
					if RSA.db.profile.Druid.Spells.SkullBash.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Druid.Spells.SkullBash.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.SkullBash.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Druid.Spells.SkullBash.Messages.Immune, ".%a+.", RSA_String_Replace), RSA.db.profile.Druid.Spells.SkullBash.CustomChannel.Channel)
					end
					if RSA.db.profile.Druid.Spells.SkullBash.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Druid.Spells.SkullBash.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.SkullBash.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Druid.Spells.SkullBash.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.SkullBash.Party == true then
						if RSA.db.profile.Druid.Spells.SkullBash.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Druid.Spells.SkullBash.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.SkullBash.Raid == true then
						if RSA.db.profile.Druid.Spells.SkullBash.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Druid.Spells.SkullBash.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
				end
			end -- SKULL BASH
		end -- IF EVENT IS SPELL_MISSED AND IS IMMUNE
	end -- IF SOURCE IS PLAYER
end -- END ENTIRELY
RSA_CombatLogMonitor:SetScript("OnEvent", Druid_Spells)
------------------------------
---- Resurrection Monitor ----
------------------------------
local function Druid_Resurrections(_, event, source, spell, rank, dest, _)
	if UnitName(source) == pName then
		if spell == GetSpellInfo(50769) and RSA.db.profile.Druid.Spells.Revive.Messages.Start ~= "" then -- REVIVE
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
				if RSA.db.profile.Druid.Spells.Revive.Messages.Start ~= "" then
					if RSA.db.profile.Druid.Spells.Revive.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Druid.Spells.Revive.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Revive.Whisper == true and dest ~= pName then
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
						RSA_Print_Whisper(string.gsub(RSA.db.profile.Druid.Spells.Revive.Messages.Start, ".%a+.", RSA_String_Replace), dest)
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					end
					if RSA.db.profile.Druid.Spells.Revive.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Druid.Spells.Revive.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Druid.Spells.Revive.CustomChannel.Channel)
					end
					if RSA.db.profile.Druid.Spells.Revive.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Druid.Spells.Revive.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Revive.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Druid.Spells.Revive.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Revive.Party == true then
						if RSA.db.profile.Druid.Spells.Revive.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Druid.Spells.Revive.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Revive.Raid == true then
						if RSA.db.profile.Druid.Spells.Revive.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Druid.Spells.Revive.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			elseif event == "UNIT_SPELLCAST_SUCCEEDED" and Ressed ~= true then
				dest = ResTarget
				Ressed = true
				if RSA.db.profile.Druid.Spells.Revive.Messages.End ~= "" then
					if RSA.db.profile.Druid.Spells.Revive.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Druid.Spells.Revive.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Revive.Whisper == true and dest ~= pName then
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
						RSA_Print_Whisper(string.gsub(RSA.db.profile.Druid.Spells.Revive.Messages.End, ".%a+.", RSA_String_Replace), dest)
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					end
					if RSA.db.profile.Druid.Spells.Revive.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Druid.Spells.Revive.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Druid.Spells.Revive.CustomChannel.Channel)
					end
					if RSA.db.profile.Druid.Spells.Revive.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Druid.Spells.Revive.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Revive.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Druid.Spells.Revive.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Revive.Party == true then
						if RSA.db.profile.Druid.Spells.Revive.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Druid.Spells.Revive.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Revive.Raid == true then
						if RSA.db.profile.Druid.Spells.Revive.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Druid.Spells.Revive.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end
		end -- REVIVE
		if spell == GetSpellInfo(20484) and RSA.db.profile.Druid.Spells.Rebirth.Messages.Start ~= "" then -- REBIRTH
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
				if RSA.db.profile.Druid.Spells.Rebirth.Messages.Start ~= "" then
					if RSA.db.profile.Druid.Spells.Rebirth.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Druid.Spells.Rebirth.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Rebirth.Whisper == true and dest ~= pName then
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
						RSA_Print_Whisper(string.gsub(RSA.db.profile.Druid.Spells.Rebirth.Messages.Start, ".%a+.", RSA_String_Replace), dest)
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					end
					if RSA.db.profile.Druid.Spells.Rebirth.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Druid.Spells.Rebirth.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Druid.Spells.Rebirth.CustomChannel.Channel)
					end
					if RSA.db.profile.Druid.Spells.Rebirth.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Druid.Spells.Rebirth.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Rebirth.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Druid.Spells.Rebirth.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Rebirth.Party == true then
						if RSA.db.profile.Druid.Spells.Rebirth.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Druid.Spells.Rebirth.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Rebirth.Raid == true then
						if RSA.db.profile.Druid.Spells.Rebirth.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Druid.Spells.Rebirth.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			elseif event == "UNIT_SPELLCAST_SUCCEEDED" and Ressed ~= true then
				dest = ResTarget
				Ressed = true
				if RSA.db.profile.Druid.Spells.Rebirth.Messages.End ~= "" then
					if RSA.db.profile.Druid.Spells.Rebirth.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Druid.Spells.Rebirth.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Rebirth.Whisper == true and dest ~= pName then
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
						RSA_Print_Whisper(string.gsub(RSA.db.profile.Druid.Spells.Rebirth.Messages.End, ".%a+.", RSA_String_Replace), dest)
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					end
					if RSA.db.profile.Druid.Spells.Rebirth.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Druid.Spells.Rebirth.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Druid.Spells.Rebirth.CustomChannel.Channel)
					end
					if RSA.db.profile.Druid.Spells.Rebirth.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Druid.Spells.Rebirth.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Rebirth.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Druid.Spells.Rebirth.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Rebirth.Party == true then
						if RSA.db.profile.Druid.Spells.Rebirth.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Druid.Spells.Rebirth.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Druid.Spells.Rebirth.Raid == true then
						if RSA.db.profile.Druid.Spells.Rebirth.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Druid.Spells.Rebirth.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end
		end -- REBIRTH
	end
end -- END FUNCTION
RSA_ResMon = CreateFrame("Frame", "RSA:RM")
RSA_ResMon:RegisterEvent("UNIT_SPELLCAST_SENT")
RSA_ResMon:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
RSA_ResMon:SetScript("OnEvent", Druid_Resurrections)
end -- END ON ENABLED
function RSA_Druid:OnDisable()
RSA_CombatLogMonitor:SetScript("OnEvent", nil)
RSA_ResMon:SetScript("OnEvent", nil)
end