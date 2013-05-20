----------------------------------------------
---- Raeli's Spell Announcer Rogue Module ----
----------------------------------------------
local RSA = LibStub("AceAddon-3.0"):GetAddon("RSA")
local L = LibStub("AceLocale-3.0"):GetLocale("RSA")
local RSA_Rogue = RSA:NewModule("Rogue")
function RSA_Rogue:OnInitialize()
	if RSA.db.profile.General.Class == "ROGUE" then
		RSA_Rogue:SetEnabledState(true)
	else
		RSA_Rogue:SetEnabledState(false)
	end
end -- End OnInitialize
function RSA_Rogue:OnEnable()
RSA_Tricks_Modifier = 1.15
RSA_SBTimer = CreateFrame("Frame", "RSA:SBTimer")
local SBTimeElapsed = 0.0
RSA_TricksTracker = CreateFrame("Frame", "RSA:TT")
RSA.db.profile.Modules.Rogue = true -- Set state to loaded, to know if we should announce when a spell is refreshed.
local pName = UnitName("player")
local function Rogue_Spells(_, _, _, event, _, _, source, _, _, destGUID, dest, _, _, spellID, spellName, _, missType)
	local petName = UnitName("pet")
	if source == pName or source == petName then
		if (event == "SPELL_CAST_SUCCESS" and RSA.db.profile.Modules.Reminders_Loaded == true) then -- Reminder Refreshed
			local ReminderSpell = RSA.db.profile.Rogue.Reminders.SpellName
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
			if spellID == 6770 then -- SAP
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Rogue.Spells.Sap.Messages.Start ~= "" then
					if RSA.db.profile.Rogue.Spells.Sap.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Rogue.Spells.Sap.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Rogue.Spells.Sap.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Rogue.Spells.Sap.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Rogue.Spells.Sap.CustomChannel.Channel)
					end
					if RSA.db.profile.Rogue.Spells.Sap.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Rogue.Spells.Sap.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Rogue.Spells.Sap.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Rogue.Spells.Sap.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Rogue.Spells.Sap.Party == true then
						if RSA.db.profile.Rogue.Spells.Sap.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Rogue.Spells.Sap.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Rogue.Spells.Sap.Raid == true then
						if RSA.db.profile.Rogue.Spells.Sap.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Rogue.Spells.Sap.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- SAP
			if spellID == 51722 then -- DISMANTLE
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Rogue.Spells.Dismantle.Messages.Start ~= "" then
					if RSA.db.profile.Rogue.Spells.Dismantle.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Rogue.Spells.Dismantle.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Rogue.Spells.Dismantle.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Rogue.Spells.Dismantle.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Rogue.Spells.Dismantle.CustomChannel.Channel)
					end
					if RSA.db.profile.Rogue.Spells.Dismantle.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Rogue.Spells.Dismantle.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Rogue.Spells.Dismantle.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Rogue.Spells.Dismantle.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Rogue.Spells.Dismantle.Party == true then
						if RSA.db.profile.Rogue.Spells.Dismantle.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Rogue.Spells.Dismantle.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Rogue.Spells.Dismantle.Raid == true then
						if RSA.db.profile.Rogue.Spells.Dismantle.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Rogue.Spells.Dismantle.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- DISMANTLE
			if spellID == 2094 then -- BLIND
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Rogue.Spells.Blind.Messages.Start ~= "" then
					if RSA.db.profile.Rogue.Spells.Blind.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Rogue.Spells.Blind.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Rogue.Spells.Blind.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Rogue.Spells.Blind.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Rogue.Spells.Blind.CustomChannel.Channel)
					end
					if RSA.db.profile.Rogue.Spells.Blind.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Rogue.Spells.Blind.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Rogue.Spells.Blind.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Rogue.Spells.Blind.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Rogue.Spells.Blind.Party == true then
						if RSA.db.profile.Rogue.Spells.Blind.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Rogue.Spells.Blind.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Rogue.Spells.Blind.Raid == true then
						if RSA.db.profile.Rogue.Spells.Blind.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Rogue.Spells.Blind.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- BLIND
			if spellID == 57933 then -- TRICKS OF THE TRADE DAMAGE BUFF
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Tricks_Damage = 0.0
				RSA_Tricks_Target = dest
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Rogue.Spells.Tricks.Messages.Start ~= "" then
					if RSA.db.profile.Rogue.Spells.Tricks.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Rogue.Spells.Tricks.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Rogue.Spells.Tricks.Whisper == true and dest ~= pName and RSA_Whisperable(destGUID) then
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
						RSA_Print_Whisper(string.gsub(RSA.db.profile.Rogue.Spells.Tricks.Messages.Start, ".%a+.", RSA_String_Replace), dest)
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					end
					if RSA.db.profile.Rogue.Spells.Tricks.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Rogue.Spells.Tricks.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Rogue.Spells.Tricks.CustomChannel.Channel)
					end
					if RSA.db.profile.Rogue.Spells.Tricks.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Rogue.Spells.Tricks.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Rogue.Spells.Tricks.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Rogue.Spells.Tricks.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Rogue.Spells.Tricks.Party == true then
						if RSA.db.profile.Rogue.Spells.Tricks.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Rogue.Spells.Tricks.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Rogue.Spells.Tricks.Raid == true then
						if RSA.db.profile.Rogue.Spells.Tricks.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Rogue.Spells.Tricks.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
				if string.match(RSA.db.profile.Rogue.Spells.Tricks.Messages.End, ".AMOUNT.") == "[AMOUNT]" then
					RSA_TricksTracker:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
						local function TricksTracker(_, _, _, event, _, _, source, _, _, destGUID, dest, _, _, spellID, spellName, _, amount, overkill)
							if source == RSA_Tricks_Target then
								if event == "SPELL_DAMAGE" or event == "SPELL_PERIODIC_DAMAGE" or event == "RANGE_DAMAGE" then
									if overkill ~= -1 then
										overkill = 0
									end
									RSA_Tricks_Damage = RSA_Tricks_Damage + (amount - overkill)
								elseif event == "SWING_DAMAGE" then
									local amount, overkill = spellID, spellName
									if overkill ~= -1 then
										overkill = 0
									end
									RSA_Tricks_Damage = RSA_Tricks_Damage + (spellID - spellName)
								end
							end
						end
					RSA_TricksTracker:SetScript("OnEvent", TricksTracker)
				end
			end -- TRICKS OF THE TRADE DAMAGE BUFF
		end -- IF EVENT IS SPELL_AURA_APPLIED
		if event == "SPELL_CAST_SUCCESS" then
			if spellID == 76577 then -- SMOKE BOMB WITH TIMER FOR ENDING
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Rogue.Spells.SmokeBomb.Messages.Start ~= "" then
					if RSA.db.profile.Rogue.Spells.SmokeBomb.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Rogue.Spells.SmokeBomb.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Rogue.Spells.SmokeBomb.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Rogue.Spells.SmokeBomb.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Rogue.Spells.SmokeBomb.CustomChannel.Channel)
					end
					if RSA.db.profile.Rogue.Spells.SmokeBomb.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Rogue.Spells.SmokeBomb.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Rogue.Spells.SmokeBomb.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Rogue.Spells.SmokeBomb.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Rogue.Spells.SmokeBomb.Party == true then
						if RSA.db.profile.Rogue.Spells.SmokeBomb.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Rogue.Spells.SmokeBomb.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Rogue.Spells.SmokeBomb.Raid == true then
						if RSA.db.profile.Rogue.Spells.SmokeBomb.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Rogue.Spells.SmokeBomb.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
				SBTimeElapsed = 0.0
				local function SBSBTimer(self, elapsed)
					SBTimeElapsed = SBTimeElapsed + elapsed
					if SBTimeElapsed < 5 then return end
					SBTimeElapsed = SBTimeElapsed - floor(SBTimeElapsed)
					spellinfo = GetSpellInfo(76577)
					spelllinkinfo = GetSpellLink(76577)
					RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
					if RSA.db.profile.Rogue.Spells.SmokeBomb.Messages.End ~= "" then
						if RSA.db.profile.Rogue.Spells.SmokeBomb.Local == true then
							RSA_Print_LibSink(string.gsub(RSA.db.profile.Rogue.Spells.SmokeBomb.Messages.End, ".%a+.", RSA_String_Replace))
						end
						if RSA.db.profile.Rogue.Spells.SmokeBomb.CustomChannel.Enabled == true then
							RSA_Print_Channel(string.gsub(RSA.db.profile.Rogue.Spells.SmokeBomb.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Rogue.Spells.SmokeBomb.CustomChannel.Channel)
						end
						if RSA.db.profile.Rogue.Spells.SmokeBomb.Smart.Say == true then
							RSA_Print_Say(string.gsub(RSA.db.profile.Rogue.Spells.SmokeBomb.Messages.End, ".%a+.", RSA_String_Replace))
						end
						if RSA.db.profile.Rogue.Spells.SmokeBomb.Smart.RaidParty == true then
							RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Rogue.Spells.SmokeBomb.Messages.End, ".%a+.", RSA_String_Replace))
						end
						if RSA.db.profile.Rogue.Spells.SmokeBomb.Party == true then
							if RSA.db.profile.Rogue.Spells.SmokeBomb.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
								RSA_Print_Party(string.gsub(RSA.db.profile.Rogue.Spells.SmokeBomb.Messages.End, ".%a+.", RSA_String_Replace))
						end
						if RSA.db.profile.Rogue.Spells.SmokeBomb.Raid == true then
							if RSA.db.profile.Rogue.Spells.SmokeBomb.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
							RSA_Print_Raid(string.gsub(RSA.db.profile.Rogue.Spells.SmokeBomb.Messages.End, ".%a+.", RSA_String_Replace))
						end
					end
					RSA_SBTimer:SetScript("OnUpdate", nil)
				end
				RSA_SBTimer:SetScript("OnUpdate", SBSBTimer)
			end -- SMOKE BOMB WITH TIMER FOR ENDING
		end -- IF EVENT IS SPELL_CAST_SUCCESS
		if event == "SPELL_INTERRUPT" then
			if spellID == 1766 then -- KICK
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				extraspellinfo = GetSpellInfo(missType)
				extraspellinfolink = GetSpellLink(missType)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[TARSPELL]"] = extraspellinfo, ["[TARLINK]"] = extraspellinfolink,}
				if RSA.db.profile.Rogue.Spells.Kick.Messages.Start ~= "" then
					if RSA.db.profile.Rogue.Spells.Kick.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Rogue.Spells.Kick.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Rogue.Spells.Kick.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Rogue.Spells.Kick.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Rogue.Spells.Kick.CustomChannel.Channel)
					end
					if RSA.db.profile.Rogue.Spells.Kick.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Rogue.Spells.Kick.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Rogue.Spells.Kick.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Rogue.Spells.Kick.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Rogue.Spells.Kick.Party == true then
						if RSA.db.profile.Rogue.Spells.Kick.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Rogue.Spells.Kick.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Rogue.Spells.Kick.Raid == true then
						if RSA.db.profile.Rogue.Spells.Kick.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Rogue.Spells.Kick.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- KICK
		end -- IF EVENT IS SPELL_INTERRUPT
		if event == "SPELL_DISPEL" then
			if spellID == 5938 then -- SHIV
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				extraspellinfo = GetSpellInfo(missType)
				extraspellinfolink = GetSpellLink(missType)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[AURA]"] = extraspellinfo, ["[AURALINK]"] = extraspellinfolink,}
				if RSA.db.profile.Rogue.Spells.Shiv.Messages.Start ~= "" then
					if RSA.db.profile.Rogue.Spells.Shiv.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Rogue.Spells.Shiv.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Rogue.Spells.Shiv.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Rogue.Spells.Shiv.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Rogue.Spells.Shiv.CustomChannel.Channel)
					end
					if RSA.db.profile.Rogue.Spells.Shiv.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Rogue.Spells.Shiv.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Rogue.Spells.Shiv.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Rogue.Spells.Shiv.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Rogue.Spells.Shiv.Party == true then
						if RSA.db.profile.Rogue.Spells.Shiv.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Rogue.Spells.Shiv.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Rogue.Spells.Shiv.Raid == true then
						if RSA.db.profile.Rogue.Spells.Shiv.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Rogue.Spells.Shiv.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- SHIV
		end
		if event == "SPELL_DISPEL_FAILED" then
			if spellID == 5938 then -- SHIV
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				extraspellinfo = GetSpellInfo(missType)
				extraspellinfolink = GetSpellLink(missType)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[AURA]"] = extraspellinfo, ["[AURALINK]"] = extraspellinfolink,}
				if RSA.db.profile.Rogue.Spells.Shiv.Messages.End ~= "" then
					if RSA.db.profile.Rogue.Spells.Shiv.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Rogue.Spells.Shiv.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Rogue.Spells.Shiv.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Rogue.Spells.Shiv.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Rogue.Spells.Shiv.CustomChannel.Channel)
					end
					if RSA.db.profile.Rogue.Spells.Shiv.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Rogue.Spells.Shiv.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Rogue.Spells.Shiv.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Rogue.Spells.Shiv.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Rogue.Spells.Shiv.Party == true then
						if RSA.db.profile.Rogue.Spells.Shiv.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Rogue.Spells.Shiv.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Rogue.Spells.Shiv.Raid == true then
						if RSA.db.profile.Rogue.Spells.Shiv.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Rogue.Spells.Shiv.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- SHIV
		end -- IF EVENT IS SPELL_DISPEL_FAILED
		if event == "SPELL_AURA_REMOVED" then
			if spellID == 6770 then -- SAP
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Rogue.Spells.Sap.Messages.End ~= "" then
					if RSA.db.profile.Rogue.Spells.Sap.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Rogue.Spells.Sap.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Rogue.Spells.Sap.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Rogue.Spells.Sap.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Rogue.Spells.Sap.CustomChannel.Channel)
					end
					if RSA.db.profile.Rogue.Spells.Sap.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Rogue.Spells.Sap.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Rogue.Spells.Sap.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Rogue.Spells.Sap.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Rogue.Spells.Sap.Party == true then
						if RSA.db.profile.Rogue.Spells.Sap.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Rogue.Spells.Sap.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Rogue.Spells.Sap.Raid == true then
						if RSA.db.profile.Rogue.Spells.Sap.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Rogue.Spells.Sap.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- SAP
			if spellID == 51722 then -- DISMANTLE
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Rogue.Spells.Dismantle.Messages.End ~= "" then
					if RSA.db.profile.Rogue.Spells.Dismantle.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Rogue.Spells.Dismantle.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Rogue.Spells.Dismantle.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Rogue.Spells.Dismantle.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Rogue.Spells.Dismantle.CustomChannel.Channel)
					end
					if RSA.db.profile.Rogue.Spells.Dismantle.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Rogue.Spells.Dismantle.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Rogue.Spells.Dismantle.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Rogue.Spells.Dismantle.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Rogue.Spells.Dismantle.Party == true then
						if RSA.db.profile.Rogue.Spells.Dismantle.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Rogue.Spells.Dismantle.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Rogue.Spells.Dismantle.Raid == true then
						if RSA.db.profile.Rogue.Spells.Dismantle.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Rogue.Spells.Dismantle.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- DISMANTLE
			if spellID == 2094 then -- BLIND
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Rogue.Spells.Blind.Messages.End ~= "" then
					if RSA.db.profile.Rogue.Spells.Blind.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Rogue.Spells.Blind.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Rogue.Spells.Blind.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Rogue.Spells.Blind.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Rogue.Spells.Blind.CustomChannel.Channel)
					end
					if RSA.db.profile.Rogue.Spells.Blind.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Rogue.Spells.Blind.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Rogue.Spells.Blind.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Rogue.Spells.Blind.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Rogue.Spells.Blind.Party == true then
						if RSA.db.profile.Rogue.Spells.Blind.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Rogue.Spells.Blind.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Rogue.Spells.Blind.Raid == true then
						if RSA.db.profile.Rogue.Spells.Blind.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Rogue.Spells.Blind.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- BLIND
			if spellID == 57933 then -- TRICKS OF THE TRADE DAMAGE BUFF
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				if string.match(RSA.db.profile.Rogue.Spells.Tricks.Messages.End, ".AMOUNT.") == "[AMOUNT]" then
					RSA_TricksTracker:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
					if RSA_Glyphs(63256) == true then
						RSA_Tricks_Modifier = 1.1
					else
						RSA_Tricks_Modifier = 1.15
					end
					RSA_Tricks_Damage = floor(RSA_Tricks_Damage - (RSA_Tricks_Damage/RSA_Tricks_Modifier)) -- Final Tricks Damage gained.
					RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[AMOUNT]"] = RSA_Tricks_Damage,}
				else
					RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				end
				if RSA.db.profile.Rogue.Spells.Tricks.Messages.End ~= "" then
					if RSA.db.profile.Rogue.Spells.Tricks.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Rogue.Spells.Tricks.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Rogue.Spells.Tricks.Whisper == true and dest ~= pName and RSA_Whisperable(destGUID) then
						if string.match(RSA.db.profile.Rogue.Spells.Tricks.Messages.End, ".AMOUNT.") == "[AMOUNT]" then
							RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"], ["[AMOUNT]"] = RSA_Tricks_Damage,}
						else
							RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
						end
						RSA_Print_Whisper(string.gsub(RSA.db.profile.Rogue.Spells.Tricks.Messages.End, ".%a+.", RSA_String_Replace), dest)
						if string.match(RSA.db.profile.Rogue.Spells.Tricks.Messages.End, ".AMOUNT.") == "[AMOUNT]" then
							RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[AMOUNT]"] = RSA_Tricks_Damage,}
						else
							RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
						end
					end
					if RSA.db.profile.Rogue.Spells.Tricks.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Rogue.Spells.Tricks.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Rogue.Spells.Tricks.CustomChannel.Channel)
					end
					if RSA.db.profile.Rogue.Spells.Tricks.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Rogue.Spells.Tricks.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Rogue.Spells.Tricks.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Rogue.Spells.Tricks.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Rogue.Spells.Tricks.Party == true then
						if RSA.db.profile.Rogue.Spells.Tricks.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Rogue.Spells.Tricks.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Rogue.Spells.Tricks.Raid == true then
						if RSA.db.profile.Rogue.Spells.Tricks.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Rogue.Spells.Tricks.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
				if string.match(RSA.db.profile.Rogue.Spells.Tricks.Messages.End, ".AMOUNT.") == "[AMOUNT]" then
					RSA_TricksTracker:SetScript("OnEvent", nil)
					RSA_Tricks_Damage = 0.0
				end
			end -- TRICKS OF THE TRADE DAMAGE BUFF
		end -- IF EVENT IS SPELL_AURA_REMOVED
		if event == "SPELL_MISSED" and missType ~= "IMMUNE" then
			if spellID == 1766 then -- KICK
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				if missType == "MISS" then
					missinfo = L["missed"]
				elseif missType ~= "MISS" then
					missinfo = L["was resisted by"]
				end
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = missinfo,}
				if RSA.db.profile.Rogue.Spells.Kick.Messages.End ~= "" then
					if RSA.db.profile.Rogue.Spells.Kick.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Rogue.Spells.Kick.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Rogue.Spells.Kick.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Rogue.Spells.Kick.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Rogue.Spells.Kick.CustomChannel.Channel)
					end
					if RSA.db.profile.Rogue.Spells.Kick.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Rogue.Spells.Kick.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Rogue.Spells.Kick.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Rogue.Spells.Kick.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Rogue.Spells.Kick.Party == true then
						if RSA.db.profile.Rogue.Spells.Kick.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Rogue.Spells.Kick.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Rogue.Spells.Kick.Raid == true then
						if RSA.db.profile.Rogue.Spells.Kick.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Rogue.Spells.Kick.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- KICK
		end -- IF EVENT IS SPELL_MISSED AND NOT IMMUNE
		if event == "SPELL_MISSED" and missType == "IMMUNE" then
			if spellID == 1766 then -- KICK
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = L["Immune"],}
				if RSA.db.profile.Rogue.Spells.Kick.Messages.Immune ~= "" then
					if RSA.db.profile.Rogue.Spells.Kick.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Rogue.Spells.Kick.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Rogue.Spells.Kick.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Rogue.Spells.Kick.Messages.Immune, ".%a+.", RSA_String_Replace), RSA.db.profile.Rogue.Spells.Kick.CustomChannel.Channel)
					end
					if RSA.db.profile.Rogue.Spells.Kick.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Rogue.Spells.Kick.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Rogue.Spells.Kick.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Rogue.Spells.Kick.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Rogue.Spells.Kick.Party == true then
						if RSA.db.profile.Rogue.Spells.Kick.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Rogue.Spells.Kick.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Rogue.Spells.Kick.Raid == true then
						if RSA.db.profile.Rogue.Spells.Kick.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Rogue.Spells.Kick.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
				end
			end -- KICK
		end -- IF EVENT IS SPELL_MISSED AND IS IMMUNE
	end -- IF SOURCE IS PLAYER
end -- END ENTIRELY
RSA_CombatLogMonitor:SetScript("OnEvent", Rogue_Spells)
end -- END ON ENABLED
function RSA_Rogue:OnDisable()
RSA_CombatLogMonitor:SetScript("OnEvent", nil)
end