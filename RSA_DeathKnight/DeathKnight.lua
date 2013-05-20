-----------------------------------------------------
---- Raeli's Spell Announcer Death Knight Module ----
-----------------------------------------------------
local RSA = LibStub("AceAddon-3.0"):GetAddon("RSA")
local L = LibStub("AceLocale-3.0"):GetLocale("RSA")
local RSA_DeathKnight = RSA:NewModule("DeathKnight")
function RSA_DeathKnight:OnInitialize()
	if RSA.db.profile.General.Class == "DEATHKNIGHT" then
		RSA_DeathKnight:SetEnabledState(true)
	else
		RSA_DeathKnight:SetEnabledState(false)
	end
end -- End OnInitialize
function RSA_DeathKnight:OnEnable()
RSA.db.profile.Modules.DeathKnight = true -- Set state to loaded, to know if we should announce when a spell is refreshed.
local pName = UnitName("player")
local function DeathKnight_Spells(_, _, _, event, _, _, source, _, _, destGUID, dest, _, _, spellID, spellName, _, missType)
	local petName = UnitName("pet")
	if source == pName or source == petName then
		if (event == "SPELL_CAST_SUCCESS" and RSA.db.profile.Modules.Reminders_Loaded == true) then -- Reminder Refreshed
			local ReminderSpell = RSA.db.profile.DeathKnight.Reminders.SpellName
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
			if spellID == 56222 then -- DARK COMMAND
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.DeathKnight.Spells.DarkCommand.Messages.Start ~= "" then
					if RSA.db.profile.DeathKnight.Spells.DarkCommand.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.DeathKnight.Spells.DarkCommand.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.DarkCommand.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.DeathKnight.Spells.DarkCommand.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.DeathKnight.Spells.DarkCommand.CustomChannel.Channel)
					end
					if RSA.db.profile.DeathKnight.Spells.DarkCommand.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.DeathKnight.Spells.DarkCommand.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.DarkCommand.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.DeathKnight.Spells.DarkCommand.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.DarkCommand.Party == true then
						if RSA.db.profile.DeathKnight.Spells.DarkCommand.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.DeathKnight.Spells.DarkCommand.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.DarkCommand.Raid == true then
						if RSA.db.profile.DeathKnight.Spells.DarkCommand.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.DeathKnight.Spells.DarkCommand.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- DARK COMMAND
			if spellID == 49560 then -- DEATH GRIP
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.DeathKnight.Spells.DeathGrip.Messages.Start ~= "" then
					if RSA.db.profile.DeathKnight.Spells.DeathGrip.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.DeathKnight.Spells.DeathGrip.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.DeathGrip.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.DeathKnight.Spells.DeathGrip.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.DeathKnight.Spells.DeathGrip.CustomChannel.Channel)
					end
					if RSA.db.profile.DeathKnight.Spells.DeathGrip.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.DeathKnight.Spells.DeathGrip.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.DeathGrip.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.DeathKnight.Spells.DeathGrip.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.DeathGrip.Party == true then
						if RSA.db.profile.DeathKnight.Spells.DeathGrip.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.DeathKnight.Spells.DeathGrip.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.DeathGrip.Raid == true then
						if RSA.db.profile.DeathKnight.Spells.DeathGrip.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.DeathKnight.Spells.DeathGrip.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- DEATH GRIP
			if spellID == 81162 then -- WILL OF THE NECROPOLIS
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.DeathKnight.Spells.WotN.Messages.Start ~= "" then
					if RSA.db.profile.DeathKnight.Spells.WotN.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.DeathKnight.Spells.WotN.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.WotN.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.DeathKnight.Spells.WotN.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.DeathKnight.Spells.WotN.CustomChannel.Channel)
					end
					if RSA.db.profile.DeathKnight.Spells.WotN.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.DeathKnight.Spells.WotN.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.WotN.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.DeathKnight.Spells.WotN.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.WotN.Party == true then
						if RSA.db.profile.DeathKnight.Spells.WotN.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.DeathKnight.Spells.WotN.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.WotN.Raid == true then
						if RSA.db.profile.DeathKnight.Spells.WotN.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.DeathKnight.Spells.WotN.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- WILL OF THE NECROPOLIS
		end -- IF EVENT IS SPELL_AURA_APPLIED
		if event == "SPELL_CAST_SUCCESS" then
			if spellID == 48792 then -- ICEBOUND FORTITUDE
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.DeathKnight.Spells.IceboundFortitude.Messages.Start ~= "" then
					if RSA.db.profile.DeathKnight.Spells.IceboundFortitude.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.DeathKnight.Spells.IceboundFortitude.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.IceboundFortitude.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.DeathKnight.Spells.IceboundFortitude.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.DeathKnight.Spells.IceboundFortitude.CustomChannel.Channel)
					end
					if RSA.db.profile.DeathKnight.Spells.IceboundFortitude.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.DeathKnight.Spells.IceboundFortitude.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.IceboundFortitude.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.DeathKnight.Spells.IceboundFortitude.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.IceboundFortitude.Party == true then
						if RSA.db.profile.DeathKnight.Spells.IceboundFortitude.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.DeathKnight.Spells.IceboundFortitude.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.IceboundFortitude.Raid == true then
						if RSA.db.profile.DeathKnight.Spells.IceboundFortitude.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.DeathKnight.Spells.IceboundFortitude.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- ICEBOUND FORTITUDE
			if spellID == 55233 then -- VAMPIRIC BLOOD
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.DeathKnight.Spells.VampiricBlood.Messages.Start ~= "" then
					if RSA.db.profile.DeathKnight.Spells.VampiricBlood.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.DeathKnight.Spells.VampiricBlood.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.VampiricBlood.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.DeathKnight.Spells.VampiricBlood.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.DeathKnight.Spells.VampiricBlood.CustomChannel.Channel)
					end
					if RSA.db.profile.DeathKnight.Spells.VampiricBlood.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.DeathKnight.Spells.VampiricBlood.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.VampiricBlood.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.DeathKnight.Spells.VampiricBlood.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.VampiricBlood.Party == true then
						if RSA.db.profile.DeathKnight.Spells.VampiricBlood.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.DeathKnight.Spells.VampiricBlood.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.VampiricBlood.Raid == true then
						if RSA.db.profile.DeathKnight.Spells.VampiricBlood.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.DeathKnight.Spells.VampiricBlood.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- VAMPIRIC BLOOD
			if spellID == 49222 then -- BONE SHIELD
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.DeathKnight.Spells.BoneShield.Messages.Start ~= "" then
					if RSA.db.profile.DeathKnight.Spells.BoneShield.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.DeathKnight.Spells.BoneShield.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.BoneShield.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.DeathKnight.Spells.BoneShield.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.DeathKnight.Spells.BoneShield.CustomChannel.Channel)
					end
					if RSA.db.profile.DeathKnight.Spells.BoneShield.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.DeathKnight.Spells.BoneShield.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.BoneShield.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.DeathKnight.Spells.BoneShield.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.BoneShield.Party == true then
						if RSA.db.profile.DeathKnight.Spells.BoneShield.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.DeathKnight.Spells.BoneShield.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.BoneShield.Raid == true then
						if RSA.db.profile.DeathKnight.Spells.BoneShield.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.DeathKnight.Spells.BoneShield.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- BONE SHIELD
			if spellID == 48707 then -- ANTI MAGIC SHELL
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.DeathKnight.Spells.AMS.Messages.Start ~= "" then
					if RSA.db.profile.DeathKnight.Spells.AMS.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.DeathKnight.Spells.AMS.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.AMS.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.DeathKnight.Spells.AMS.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.DeathKnight.Spells.AMS.CustomChannel.Channel)
					end
					if RSA.db.profile.DeathKnight.Spells.AMS.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.DeathKnight.Spells.AMS.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.AMS.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.DeathKnight.Spells.AMS.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.AMS.Party == true then
						if RSA.db.profile.DeathKnight.Spells.AMS.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.DeathKnight.Spells.AMS.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.AMS.Raid == true then
						if RSA.db.profile.DeathKnight.Spells.AMS.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.DeathKnight.Spells.AMS.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- ANTI MAGIC SHELL
			if spellID == 42650 then -- ARMY OF THE DEAD
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.DeathKnight.Spells.Army.Messages.Start ~= "" then
					if RSA.db.profile.DeathKnight.Spells.Army.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.DeathKnight.Spells.Army.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.Army.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.DeathKnight.Spells.Army.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.DeathKnight.Spells.Army.CustomChannel.Channel)
					end
					if RSA.db.profile.DeathKnight.Spells.Army.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.DeathKnight.Spells.Army.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.Army.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.DeathKnight.Spells.Army.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.Army.Party == true then
						if RSA.db.profile.DeathKnight.Spells.Army.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.DeathKnight.Spells.Army.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.Army.Raid == true then
						if RSA.db.profile.DeathKnight.Spells.Army.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.DeathKnight.Spells.Army.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- ARMY OF THE DEAD
			if spellID == 49016 then -- UNHOLY FRENZY
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.DeathKnight.Spells.UnholyFrenzy.Messages.Start ~= "" then
					if RSA.db.profile.DeathKnight.Spells.UnholyFrenzy.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.DeathKnight.Spells.UnholyFrenzy.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.UnholyFrenzy.Whisper == true and dest ~= pName and RSA_Whisperable(destGUID) then
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
						RSA_Print_Whisper(string.gsub(RSA.db.profile.DeathKnight.Spells.UnholyFrenzy.Messages.Start, ".%a+.", RSA_String_Replace), dest)
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					end
					if RSA.db.profile.DeathKnight.Spells.UnholyFrenzy.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.DeathKnight.Spells.UnholyFrenzy.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.DeathKnight.Spells.UnholyFrenzy.CustomChannel.Channel)
					end
					if RSA.db.profile.DeathKnight.Spells.UnholyFrenzy.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.DeathKnight.Spells.UnholyFrenzy.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.UnholyFrenzy.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.DeathKnight.Spells.UnholyFrenzy.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.UnholyFrenzy.Party == true then
						if RSA.db.profile.DeathKnight.Spells.UnholyFrenzy.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.DeathKnight.Spells.UnholyFrenzy.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.UnholyFrenzy.Raid == true then
						if RSA.db.profile.DeathKnight.Spells.UnholyFrenzy.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.DeathKnight.Spells.UnholyFrenzy.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- UNHOLY FRENZY
			if spellID == 61999 then -- RAISE ALLY
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.DeathKnight.Spells.RaiseAlly.Messages.Start ~= "" then
					if RSA.db.profile.DeathKnight.Spells.RaiseAlly.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.DeathKnight.Spells.RaiseAlly.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.RaiseAlly.Whisper == true and dest ~= pName and RSA_Whisperable(destGUID) then
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
						RSA_Print_Whisper(string.gsub(RSA.db.profile.DeathKnight.Spells.RaiseAlly.Messages.Start, ".%a+.", RSA_String_Replace), dest)
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					end
					if RSA.db.profile.DeathKnight.Spells.RaiseAlly.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.DeathKnight.Spells.RaiseAlly.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.DeathKnight.Spells.RaiseAlly.CustomChannel.Channel)
					end
					if RSA.db.profile.DeathKnight.Spells.RaiseAlly.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.DeathKnight.Spells.RaiseAlly.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.RaiseAlly.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.DeathKnight.Spells.RaiseAlly.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.RaiseAlly.Party == true then
						if RSA.db.profile.DeathKnight.Spells.RaiseAlly.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.DeathKnight.Spells.RaiseAlly.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.RaiseAlly.Raid == true then
						if RSA.db.profile.DeathKnight.Spells.RaiseAlly.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.DeathKnight.Spells.RaiseAlly.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- RAISE ALLY
			if spellID == 49028 then -- DANCING RUNE WEAPON
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.DeathKnight.Spells.DancingRuneWeapon.Messages.Start ~= "" then
					if RSA.db.profile.DeathKnight.Spells.DancingRuneWeapon.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.DeathKnight.Spells.DancingRuneWeapon.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.DancingRuneWeapon.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.DeathKnight.Spells.DancingRuneWeapon.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.DeathKnight.Spells.DancingRuneWeapon.CustomChannel.Channel)
					end
					if RSA.db.profile.DeathKnight.Spells.DancingRuneWeapon.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.DeathKnight.Spells.DancingRuneWeapon.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.DancingRuneWeapon.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.DeathKnight.Spells.DancingRuneWeapon.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.DancingRuneWeapon.Party == true then
						if RSA.db.profile.DeathKnight.Spells.DancingRuneWeapon.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.DeathKnight.Spells.DancingRuneWeapon.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.DancingRuneWeapon.Raid == true then
						if RSA.db.profile.DeathKnight.Spells.DancingRuneWeapon.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.DeathKnight.Spells.DancingRuneWeapon.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- DANCING RUNE WEAPON
			if spellID == 49039 then -- LICHBORNE
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.DeathKnight.Spells.Lichborne.Messages.Start ~= "" then
					if RSA.db.profile.DeathKnight.Spells.Lichborne.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.DeathKnight.Spells.Lichborne.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.Lichborne.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.DeathKnight.Spells.Lichborne.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.DeathKnight.Spells.Lichborne.CustomChannel.Channel)
					end
					if RSA.db.profile.DeathKnight.Spells.Lichborne.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.DeathKnight.Spells.Lichborne.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.Lichborne.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.DeathKnight.Spells.Lichborne.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.Lichborne.Party == true then
						if RSA.db.profile.DeathKnight.Spells.Lichborne.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.DeathKnight.Spells.Lichborne.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.Lichborne.Raid == true then
						if RSA.db.profile.DeathKnight.Spells.Lichborne.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.DeathKnight.Spells.Lichborne.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- LICHBORNE
			if spellID == 51271 then -- PILLAR OF FROST
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.DeathKnight.Spells.PillarOfFrost.Messages.Start ~= "" then
					if RSA.db.profile.DeathKnight.Spells.PillarOfFrost.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.DeathKnight.Spells.PillarOfFrost.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.PillarOfFrost.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.DeathKnight.Spells.PillarOfFrost.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.DeathKnight.Spells.PillarOfFrost.CustomChannel.Channel)
					end
					if RSA.db.profile.DeathKnight.Spells.PillarOfFrost.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.DeathKnight.Spells.PillarOfFrost.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.PillarOfFrost.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.DeathKnight.Spells.PillarOfFrost.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.PillarOfFrost.Party == true then
						if RSA.db.profile.DeathKnight.Spells.PillarOfFrost.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.DeathKnight.Spells.PillarOfFrost.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.PillarOfFrost.Raid == true then
						if RSA.db.profile.DeathKnight.Spells.PillarOfFrost.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.DeathKnight.Spells.PillarOfFrost.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- PILLAR OF FROST
		end -- IF EVENT IS SPELL_CAST_SUCCESS
		if event == "SPELL_INTERRUPT" then
			if spellID == 32747 then -- STRANGULATE
				spellinfo = GetSpellInfo(47476)
				spelllinkinfo = GetSpellLink(47476)
				extraspellinfo = GetSpellInfo(missType)
				extraspellinfolink = GetSpellLink(missType)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[TARSPELL]"] = extraspellinfo, ["[TARLINK]"] = extraspellinfolink,}
				if RSA.db.profile.DeathKnight.Spells.Strangulate.Messages.Start ~= "" then
					if RSA.db.profile.DeathKnight.Spells.Strangulate.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.DeathKnight.Spells.Strangulate.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.Strangulate.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.DeathKnight.Spells.Strangulate.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.DeathKnight.Spells.Strangulate.CustomChannel.Channel)
					end
					if RSA.db.profile.DeathKnight.Spells.Strangulate.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.DeathKnight.Spells.Strangulate.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.Strangulate.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.DeathKnight.Spells.Strangulate.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.Strangulate.Party == true then
						if RSA.db.profile.DeathKnight.Spells.Strangulate.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.DeathKnight.Spells.Strangulate.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.Strangulate.Raid == true then
						if RSA.db.profile.DeathKnight.Spells.Strangulate.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.DeathKnight.Spells.Strangulate.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- STRANGULATE
			if spellID == 47528 then -- MIND FREEZE
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				extraspellinfo = GetSpellInfo(missType)
				extraspellinfolink = GetSpellLink(missType)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[TARSPELL]"] = extraspellinfo, ["[TARLINK]"] = extraspellinfolink,}
				if RSA.db.profile.DeathKnight.Spells.MindFreeze.Messages.Start ~= "" then
					if RSA.db.profile.DeathKnight.Spells.MindFreeze.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.DeathKnight.Spells.MindFreeze.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.MindFreeze.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.DeathKnight.Spells.MindFreeze.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.DeathKnight.Spells.MindFreeze.CustomChannel.Channel)
					end
					if RSA.db.profile.DeathKnight.Spells.MindFreeze.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.DeathKnight.Spells.MindFreeze.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.MindFreeze.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.DeathKnight.Spells.MindFreeze.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.MindFreeze.Party == true then
						if RSA.db.profile.DeathKnight.Spells.MindFreeze.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.DeathKnight.Spells.MindFreeze.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.MindFreeze.Raid == true then
						if RSA.db.profile.DeathKnight.Spells.MindFreeze.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.DeathKnight.Spells.MindFreeze.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- MIND FREEZE
		end -- IF EVENT IS SPELL_INTERRUPT
		if event == "SPELL_AURA_REMOVED" then
			if spellID == 48792 then -- ICEBOUND FORTITUDE
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.DeathKnight.Spells.IceboundFortitude.Messages.End ~= "" then
					if RSA.db.profile.DeathKnight.Spells.IceboundFortitude.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.DeathKnight.Spells.IceboundFortitude.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.IceboundFortitude.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.DeathKnight.Spells.IceboundFortitude.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.DeathKnight.Spells.IceboundFortitude.CustomChannel.Channel)
					end
					if RSA.db.profile.DeathKnight.Spells.IceboundFortitude.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.DeathKnight.Spells.IceboundFortitude.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.IceboundFortitude.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.DeathKnight.Spells.IceboundFortitude.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.IceboundFortitude.Party == true then
						if RSA.db.profile.DeathKnight.Spells.IceboundFortitude.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.DeathKnight.Spells.IceboundFortitude.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.IceboundFortitude.Raid == true then
						if RSA.db.profile.DeathKnight.Spells.IceboundFortitude.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.DeathKnight.Spells.IceboundFortitude.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- ICEBOUND FORTITUDE
			if spellID == 55233 then -- VAMPIRIC BLOOD
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.DeathKnight.Spells.VampiricBlood.Messages.End ~= "" then
					if RSA.db.profile.DeathKnight.Spells.VampiricBlood.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.DeathKnight.Spells.VampiricBlood.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.VampiricBlood.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.DeathKnight.Spells.VampiricBlood.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.DeathKnight.Spells.VampiricBlood.CustomChannel.Channel)
					end
					if RSA.db.profile.DeathKnight.Spells.VampiricBlood.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.DeathKnight.Spells.VampiricBlood.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.VampiricBlood.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.DeathKnight.Spells.VampiricBlood.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.VampiricBlood.Party == true then
						if RSA.db.profile.DeathKnight.Spells.VampiricBlood.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.DeathKnight.Spells.VampiricBlood.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.VampiricBlood.Raid == true then
						if RSA.db.profile.DeathKnight.Spells.VampiricBlood.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.DeathKnight.Spells.VampiricBlood.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- VAMPIRIC BLOOD
			if spellID == 49222 then -- BONE SHIELD
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.DeathKnight.Spells.BoneShield.Messages.End ~= "" then
					if RSA.db.profile.DeathKnight.Spells.BoneShield.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.DeathKnight.Spells.BoneShield.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.BoneShield.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.DeathKnight.Spells.BoneShield.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.DeathKnight.Spells.BoneShield.CustomChannel.Channel)
					end
					if RSA.db.profile.DeathKnight.Spells.BoneShield.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.DeathKnight.Spells.BoneShield.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.BoneShield.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.DeathKnight.Spells.BoneShield.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.BoneShield.Party == true then
						if RSA.db.profile.DeathKnight.Spells.BoneShield.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.DeathKnight.Spells.BoneShield.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.BoneShield.Raid == true then
						if RSA.db.profile.DeathKnight.Spells.BoneShield.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.DeathKnight.Spells.BoneShield.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- BONE SHIELD
			if spellID == 48707 then -- ANTI MAGIC SHELL
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.DeathKnight.Spells.AMS.Messages.End ~= "" then
					if RSA.db.profile.DeathKnight.Spells.AMS.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.DeathKnight.Spells.AMS.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.AMS.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.DeathKnight.Spells.AMS.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.DeathKnight.Spells.AMS.CustomChannel.Channel)
					end
					if RSA.db.profile.DeathKnight.Spells.AMS.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.DeathKnight.Spells.AMS.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.AMS.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.DeathKnight.Spells.AMS.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.AMS.Party == true then
						if RSA.db.profile.DeathKnight.Spells.AMS.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.DeathKnight.Spells.AMS.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.AMS.Raid == true then
						if RSA.db.profile.DeathKnight.Spells.AMS.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.DeathKnight.Spells.AMS.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- ANTI MAGIC SHELL
			if spellID == 49016 then -- UNHOLY FRENZY
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.DeathKnight.Spells.UnholyFrenzy.Messages.End ~= "" then
					if RSA.db.profile.DeathKnight.Spells.UnholyFrenzy.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.DeathKnight.Spells.UnholyFrenzy.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.UnholyFrenzy.Whisper == true and dest ~= pName and RSA_Whisperable(destGUID) then
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
						RSA_Print_Whisper(string.gsub(RSA.db.profile.DeathKnight.Spells.UnholyFrenzy.Messages.End, ".%a+.", RSA_String_Replace), dest)
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					end
					if RSA.db.profile.DeathKnight.Spells.UnholyFrenzy.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.DeathKnight.Spells.UnholyFrenzy.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.DeathKnight.Spells.UnholyFrenzy.CustomChannel.Channel)
					end
					if RSA.db.profile.DeathKnight.Spells.UnholyFrenzy.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.DeathKnight.Spells.UnholyFrenzy.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.UnholyFrenzy.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.DeathKnight.Spells.UnholyFrenzy.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.UnholyFrenzy.Party == true then
						if RSA.db.profile.DeathKnight.Spells.UnholyFrenzy.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.DeathKnight.Spells.UnholyFrenzy.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.UnholyFrenzy.Raid == true then
						if RSA.db.profile.DeathKnight.Spells.UnholyFrenzy.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.DeathKnight.Spells.UnholyFrenzy.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- UNHOLY FRENZY
			if spellID == 81256 then -- DANCING RUNE WEAPON -- The buff is 81256, the spell cast is 49028.
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.DeathKnight.Spells.DancingRuneWeapon.Messages.End ~= "" then
					if RSA.db.profile.DeathKnight.Spells.DancingRuneWeapon.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.DeathKnight.Spells.DancingRuneWeapon.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.DancingRuneWeapon.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.DeathKnight.Spells.DancingRuneWeapon.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.DeathKnight.Spells.DancingRuneWeapon.CustomChannel.Channel)
					end
					if RSA.db.profile.DeathKnight.Spells.DancingRuneWeapon.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.DeathKnight.Spells.DancingRuneWeapon.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.DancingRuneWeapon.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.DeathKnight.Spells.DancingRuneWeapon.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.DancingRuneWeapon.Party == true then
						if RSA.db.profile.DeathKnight.Spells.DancingRuneWeapon.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.DeathKnight.Spells.DancingRuneWeapon.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.DancingRuneWeapon.Raid == true then
						if RSA.db.profile.DeathKnight.Spells.DancingRuneWeapon.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.DeathKnight.Spells.DancingRuneWeapon.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- DANCING RUNE WEAPON
			if spellID == 81162 then -- WILL OF THE NECROPOLIS
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.DeathKnight.Spells.WotN.Messages.End ~= "" then
					if RSA.db.profile.DeathKnight.Spells.WotN.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.DeathKnight.Spells.WotN.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.WotN.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.DeathKnight.Spells.WotN.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.DeathKnight.Spells.WotN.CustomChannel.Channel)
					end
					if RSA.db.profile.DeathKnight.Spells.WotN.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.DeathKnight.Spells.WotN.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.WotN.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.DeathKnight.Spells.WotN.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.WotN.Party == true then
						if RSA.db.profile.DeathKnight.Spells.WotN.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.DeathKnight.Spells.WotN.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.WotN.Raid == true then
						if RSA.db.profile.DeathKnight.Spells.WotN.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.DeathKnight.Spells.WotN.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- WILL OF THE NECROPOLIS
			if spellID == 49039 then -- LICHBORNE
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.DeathKnight.Spells.Lichborne.Messages.End ~= "" then
					if RSA.db.profile.DeathKnight.Spells.Lichborne.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.DeathKnight.Spells.Lichborne.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.Lichborne.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.DeathKnight.Spells.Lichborne.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.DeathKnight.Spells.Lichborne.CustomChannel.Channel)
					end
					if RSA.db.profile.DeathKnight.Spells.Lichborne.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.DeathKnight.Spells.Lichborne.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.Lichborne.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.DeathKnight.Spells.Lichborne.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.Lichborne.Party == true then
						if RSA.db.profile.DeathKnight.Spells.Lichborne.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.DeathKnight.Spells.Lichborne.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.Lichborne.Raid == true then
						if RSA.db.profile.DeathKnight.Spells.Lichborne.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.DeathKnight.Spells.Lichborne.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- LICHBORNE
			if spellID == 51271 then -- PILLAR OF FROST
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.DeathKnight.Spells.PillarOfFrost.Messages.End ~= "" then
					if RSA.db.profile.DeathKnight.Spells.PillarOfFrost.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.DeathKnight.Spells.PillarOfFrost.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.PillarOfFrost.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.DeathKnight.Spells.PillarOfFrost.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.DeathKnight.Spells.PillarOfFrost.CustomChannel.Channel)
					end
					if RSA.db.profile.DeathKnight.Spells.PillarOfFrost.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.DeathKnight.Spells.PillarOfFrost.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.PillarOfFrost.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.DeathKnight.Spells.PillarOfFrost.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.PillarOfFrost.Party == true then
						if RSA.db.profile.DeathKnight.Spells.PillarOfFrost.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.DeathKnight.Spells.PillarOfFrost.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.PillarOfFrost.Raid == true then
						if RSA.db.profile.DeathKnight.Spells.PillarOfFrost.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.DeathKnight.Spells.PillarOfFrost.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- PILLAR OF FROST
		end -- IF EVENT IS SPELL_AURA_REMOVED
		if event == "SPELL_MISSED" and missType ~= "IMMUNE" then
			if spellID == 56222 then -- DARK COMMAND
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				if missType == "MISS" then
					missinfo = L["missed"]
				elseif missType ~= "MISS" then
					missinfo = L["was resisted by"]
				end
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = missinfo,}
				if RSA.db.profile.DeathKnight.Spells.DarkCommand.Messages.End ~= "" then
					if RSA.db.profile.DeathKnight.Spells.DarkCommand.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.DeathKnight.Spells.DarkCommand.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.DarkCommand.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.DeathKnight.Spells.DarkCommand.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.DeathKnight.Spells.DarkCommand.CustomChannel.Channel)
					end
					if RSA.db.profile.DeathKnight.Spells.DarkCommand.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.DeathKnight.Spells.DarkCommand.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.DarkCommand.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.DeathKnight.Spells.DarkCommand.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.DarkCommand.Party == true then
						if RSA.db.profile.DeathKnight.Spells.DarkCommand.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.DeathKnight.Spells.DarkCommand.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.DarkCommand.Raid == true then
						if RSA.db.profile.DeathKnight.Spells.DarkCommand.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.DeathKnight.Spells.DarkCommand.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- DARK COMMAND
			if spellID == 49560 or spellID == 49576 then -- DEATH GRIP
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				if missType == "MISS" then
					missinfo = L["missed"]
				elseif missType ~= "MISS" then
					missinfo = L["was resisted by"]
				end
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = missinfo,}
				if RSA.db.profile.DeathKnight.Spells.DeathGrip.Messages.End ~= "" then
					if RSA.db.profile.DeathKnight.Spells.DeathGrip.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.DeathKnight.Spells.DeathGrip.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.DeathGrip.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.DeathKnight.Spells.DeathGrip.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.DeathKnight.Spells.DeathGrip.CustomChannel.Channel)
					end
					if RSA.db.profile.DeathKnight.Spells.DeathGrip.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.DeathKnight.Spells.DeathGrip.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.DeathGrip.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.DeathKnight.Spells.DeathGrip.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.DeathGrip.Party == true then
						if RSA.db.profile.DeathKnight.Spells.DeathGrip.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.DeathKnight.Spells.DeathGrip.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.DeathGrip.Raid == true then
						if RSA.db.profile.DeathKnight.Spells.DeathGrip.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.DeathKnight.Spells.DeathGrip.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- DEATH GRIP
			if spellID == 47476 then -- STRANGULATE
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				if missType == "MISS" then
					missinfo = L["missed"]
				elseif missType ~= "MISS" then
					missinfo = L["was resisted by"]
				end
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = missinfo,}
				if RSA.db.profile.DeathKnight.Spells.Strangulate.Messages.End ~= "" then
					if RSA.db.profile.DeathKnight.Spells.Strangulate.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.DeathKnight.Spells.Strangulate.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.Strangulate.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.DeathKnight.Spells.Strangulate.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.DeathKnight.Spells.Strangulate.CustomChannel.Channel)
					end
					if RSA.db.profile.DeathKnight.Spells.Strangulate.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.DeathKnight.Spells.Strangulate.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.Strangulate.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.DeathKnight.Spells.Strangulate.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.Strangulate.Party == true then
						if RSA.db.profile.DeathKnight.Spells.Strangulate.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.DeathKnight.Spells.Strangulate.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.Strangulate.Raid == true then
						if RSA.db.profile.DeathKnight.Spells.Strangulate.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.DeathKnight.Spells.Strangulate.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- STRANGULATE
			if spellID == 47528 then -- MIND FREEZE
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				if missType == "MISS" then
					missinfo = L["missed"]
				elseif missType ~= "MISS" then
					missinfo = L["was resisted by"]
				end
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = missinfo,}
				if RSA.db.profile.DeathKnight.Spells.MindFreeze.Messages.End ~= "" then
					if RSA.db.profile.DeathKnight.Spells.MindFreeze.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.DeathKnight.Spells.MindFreeze.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.MindFreeze.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.DeathKnight.Spells.MindFreeze.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.DeathKnight.Spells.MindFreeze.CustomChannel.Channel)
					end
					if RSA.db.profile.DeathKnight.Spells.MindFreeze.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.DeathKnight.Spells.MindFreeze.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.MindFreeze.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.DeathKnight.Spells.MindFreeze.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.MindFreeze.Party == true then
						if RSA.db.profile.DeathKnight.Spells.MindFreeze.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.DeathKnight.Spells.MindFreeze.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.MindFreeze.Raid == true then
						if RSA.db.profile.DeathKnight.Spells.MindFreeze.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.DeathKnight.Spells.MindFreeze.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- MIND FREEZE
		end -- IF EVENT IS SPELL_MISSED AND NOT IMMUNE
		if event == "SPELL_MISSED" and missType == "IMMUNE" then
			if spellID == 56222 then -- DARK COMMAND
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = L["Immune"],}
				if RSA.db.profile.DeathKnight.Spells.DarkCommand.Messages.Immune ~= "" then
					if RSA.db.profile.DeathKnight.Spells.DarkCommand.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.DeathKnight.Spells.DarkCommand.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.DarkCommand.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.DeathKnight.Spells.DarkCommand.Messages.Immune, ".%a+.", RSA_String_Replace), RSA.db.profile.DeathKnight.Spells.DarkCommand.CustomChannel.Channel)
					end
					if RSA.db.profile.DeathKnight.Spells.DarkCommand.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.DeathKnight.Spells.DarkCommand.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.DarkCommand.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.DeathKnight.Spells.DarkCommand.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.DarkCommand.Party == true then
						if RSA.db.profile.DeathKnight.Spells.DarkCommand.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.DeathKnight.Spells.DarkCommand.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.DarkCommand.Raid == true then
						if RSA.db.profile.DeathKnight.Spells.DarkCommand.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.DeathKnight.Spells.DarkCommand.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
				end
			end -- DARK COMMAND
			if spellID == 49560 or spellID == 49576 then -- DEATH GRIP
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = L["Immune"],}
				if RSA.db.profile.DeathKnight.Spells.DeathGrip.Messages.Immune ~= "" then
					if RSA.db.profile.DeathKnight.Spells.DeathGrip.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.DeathKnight.Spells.DeathGrip.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.DeathGrip.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.DeathKnight.Spells.DeathGrip.Messages.Immune, ".%a+.", RSA_String_Replace), RSA.db.profile.DeathKnight.Spells.DeathGrip.CustomChannel.Channel)
					end
					if RSA.db.profile.DeathKnight.Spells.DeathGrip.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.DeathKnight.Spells.DeathGrip.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.DeathGrip.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.DeathKnight.Spells.DeathGrip.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.DeathGrip.Party == true then
						if RSA.db.profile.DeathKnight.Spells.DeathGrip.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.DeathKnight.Spells.DeathGrip.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.DeathGrip.Raid == true then
						if RSA.db.profile.DeathKnight.Spells.DeathGrip.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.DeathKnight.Spells.DeathGrip.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
				end
			end -- DEATH GRIP
			if spellID == 47476 then -- STRANGULATE
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = L["Immune"],}
				if RSA.db.profile.DeathKnight.Spells.Strangulate.Messages.Immune ~= "" then
					if RSA.db.profile.DeathKnight.Spells.Strangulate.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.DeathKnight.Spells.Strangulate.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.Strangulate.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.DeathKnight.Spells.Strangulate.Messages.Immune, ".%a+.", RSA_String_Replace), RSA.db.profile.DeathKnight.Spells.Strangulate.CustomChannel.Channel)
					end
					if RSA.db.profile.DeathKnight.Spells.Strangulate.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.DeathKnight.Spells.Strangulate.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.Strangulate.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.DeathKnight.Spells.Strangulate.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.Strangulate.Party == true then
						if RSA.db.profile.DeathKnight.Spells.Strangulate.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.DeathKnight.Spells.Strangulate.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.Strangulate.Raid == true then
						if RSA.db.profile.DeathKnight.Spells.Strangulate.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.DeathKnight.Spells.Strangulate.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
				end
			end -- STRANGULATE
			if spellID == 47528 then -- MIND FREEZE
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = L["Immune"],}
				if RSA.db.profile.DeathKnight.Spells.MindFreeze.Messages.Immune ~= "" then
					if RSA.db.profile.DeathKnight.Spells.MindFreeze.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.DeathKnight.Spells.MindFreeze.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.MindFreeze.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.DeathKnight.Spells.MindFreeze.Messages.Immune, ".%a+.", RSA_String_Replace), RSA.db.profile.DeathKnight.Spells.MindFreeze.CustomChannel.Channel)
					end
					if RSA.db.profile.DeathKnight.Spells.MindFreeze.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.DeathKnight.Spells.MindFreeze.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.MindFreeze.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.DeathKnight.Spells.MindFreeze.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.MindFreeze.Party == true then
						if RSA.db.profile.DeathKnight.Spells.MindFreeze.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.DeathKnight.Spells.MindFreeze.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.MindFreeze.Raid == true then
						if RSA.db.profile.DeathKnight.Spells.MindFreeze.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.DeathKnight.Spells.MindFreeze.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
				end
			end -- MIND FREEZE
		end -- IF EVENT IS SPELL_MISSED AND IS IMMUNE
		if event == "SPELL_HEAL" then
			if spellID == 48982 then -- RUNE TAP
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[AMOUNT]"] = missType,}
				if RSA.db.profile.DeathKnight.Spells.RuneTap.Messages.Start ~= "" then
					if RSA.db.profile.DeathKnight.Spells.RuneTap.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.DeathKnight.Spells.RuneTap.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.RuneTap.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.DeathKnight.Spells.RuneTap.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.DeathKnight.Spells.RuneTap.CustomChannel.Channel)
					end
					if RSA.db.profile.DeathKnight.Spells.RuneTap.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.DeathKnight.Spells.RuneTap.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.RuneTap.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.DeathKnight.Spells.RuneTap.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.RuneTap.Party == true then
						if RSA.db.profile.DeathKnight.Spells.RuneTap.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.DeathKnight.Spells.RuneTap.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.RuneTap.Raid == true then
						if RSA.db.profile.DeathKnight.Spells.RuneTap.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.DeathKnight.Spells.RuneTap.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- RUNE TAP
			if spellID == 48743 then -- DEATH PACT
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[AMOUNT]"] = missType,}
				if RSA.db.profile.DeathKnight.Spells.DeathPact.Messages.Start ~= "" then
					if RSA.db.profile.DeathKnight.Spells.DeathPact.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.DeathKnight.Spells.DeathPact.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.DeathPact.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.DeathKnight.Spells.DeathPact.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.DeathKnight.Spells.DeathPact.CustomChannel.Channel)
					end
					if RSA.db.profile.DeathKnight.Spells.DeathPact.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.DeathKnight.Spells.DeathPact.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.DeathPact.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.DeathKnight.Spells.DeathPact.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.DeathPact.Party == true then
						if RSA.db.profile.DeathKnight.Spells.DeathPact.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.DeathKnight.Spells.DeathPact.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.DeathKnight.Spells.DeathPact.Raid == true then
						if RSA.db.profile.DeathKnight.Spells.DeathPact.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.DeathKnight.Spells.DeathPact.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- DEATH PACT
		end -- IF EVENT IS SPELL_HEAL
	end -- IF SOURCE IS PLAYER
end -- END ENTIRELY
RSA_CombatLogMonitor:SetScript("OnEvent", DeathKnight_Spells)
end -- END ON ENABLED
function RSA_DeathKnight:OnDisable()
RSA_CombatLogMonitor:SetScript("OnEvent", nil)
end