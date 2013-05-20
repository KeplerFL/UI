---------------------------------------------
---- Raeli's Spell Announcer Mage Module ----
---------------------------------------------
local RSA = LibStub("AceAddon-3.0"):GetAddon("RSA")
local L = LibStub("AceLocale-3.0"):GetLocale("RSA")
local RSA_Mage = RSA:NewModule("Mage")
function RSA_Mage:OnInitialize()
	if RSA.db.profile.General.Class == "MAGE" then
		RSA_Mage:SetEnabledState(true)
	else
		RSA_Mage:SetEnabledState(false)
	end
end -- End OnInitialize
function RSA_Mage:OnEnable()
RSA.db.profile.Modules.Mage = true -- Set state to loaded, to know if we should announce when a spell is refreshed.
local pName = UnitName("player")
local function Mage_Spells(_, _, _, event, _, _, source, _, _, destGUID, dest, _, _, spellID, spellName, _, missType)
	local petName = UnitName("pet")
	if source == pName or source == petName then
		if (event == "SPELL_CAST_SUCCESS" and RSA.db.profile.Modules.Reminders_Loaded == true) then -- Reminder Refreshed
			local ReminderSpell = RSA.db.profile.Mage.Reminders.SpellName
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
			if spellID == 118 or spellID == 61305 or spellID == 28272 or spellID == 61721 or spellID == 61780 or spellID == 28271 then -- POLYMORPH
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Mage.Spells.Polymorph.Messages.Start ~= "" then
					if RSA.db.profile.Mage.Spells.Polymorph.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Mage.Spells.Polymorph.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.Polymorph.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Mage.Spells.Polymorph.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Mage.Spells.Polymorph.CustomChannel.Channel)
					end
					if RSA.db.profile.Mage.Spells.Polymorph.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Mage.Spells.Polymorph.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.Polymorph.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Mage.Spells.Polymorph.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.Polymorph.Party == true then
						if RSA.db.profile.Mage.Spells.Polymorph.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Mage.Spells.Polymorph.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.Polymorph.Raid == true then
						if RSA.db.profile.Mage.Spells.Polymorph.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Mage.Spells.Polymorph.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- POLYMORPH
			if spellID == 80353 and dest == pName then -- TIME WARP
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Mage.Spells.TimeWarp.Messages.Start ~= "" then
					if RSA.db.profile.Mage.Spells.TimeWarp.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Mage.Spells.TimeWarp.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.TimeWarp.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Mage.Spells.TimeWarp.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Mage.Spells.TimeWarp.CustomChannel.Channel)
					end
					if RSA.db.profile.Mage.Spells.TimeWarp.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Mage.Spells.TimeWarp.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.TimeWarp.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Mage.Spells.TimeWarp.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.TimeWarp.Party == true then
						if RSA.db.profile.Mage.Spells.TimeWarp.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Mage.Spells.TimeWarp.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.TimeWarp.Raid == true then
						if RSA.db.profile.Mage.Spells.TimeWarp.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Mage.Spells.TimeWarp.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- TIME WARP
			if spellID == 54646 then -- FOCUS MAGIC
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Mage.Spells.FocusMagic.Messages.Start ~= "" then
					if RSA.db.profile.Mage.Spells.FocusMagic.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Mage.Spells.FocusMagic.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.FocusMagic.Whisper == true and dest ~= pName and RSA_Whisperable(destGUID) then
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
						RSA_Print_Whisper(string.gsub(RSA.db.profile.Mage.Spells.FocusMagic.Messages.Start, ".%a+.", RSA_String_Replace), dest)
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					end
					if RSA.db.profile.Mage.Spells.FocusMagic.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Mage.Spells.FocusMagic.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Mage.Spells.FocusMagic.CustomChannel.Channel)
					end
					if RSA.db.profile.Mage.Spells.FocusMagic.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Mage.Spells.FocusMagic.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.FocusMagic.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Mage.Spells.FocusMagic.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.FocusMagic.Party == true then
						if RSA.db.profile.Mage.Spells.FocusMagic.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Mage.Spells.FocusMagic.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.FocusMagic.Raid == true then
						if RSA.db.profile.Mage.Spells.FocusMagic.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Mage.Spells.FocusMagic.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- FOCUS MAGIC
			if spellID == 130 then -- SLOW FALL
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Mage.Spells.SlowFall.Messages.Start ~= "" then
					if RSA.db.profile.Mage.Spells.SlowFall.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Mage.Spells.SlowFall.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.SlowFall.Whisper == true and dest ~= pName and RSA_Whisperable(destGUID) then
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
						RSA_Print_Whisper(string.gsub(RSA.db.profile.Mage.Spells.SlowFall.Messages.Start, ".%a+.", RSA_String_Replace), dest)
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					end
					if RSA.db.profile.Mage.Spells.SlowFall.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Mage.Spells.SlowFall.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Mage.Spells.SlowFall.CustomChannel.Channel)
					end
					if RSA.db.profile.Mage.Spells.SlowFall.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Mage.Spells.SlowFall.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.SlowFall.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Mage.Spells.SlowFall.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.SlowFall.Party == true then
						if RSA.db.profile.Mage.Spells.SlowFall.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Mage.Spells.SlowFall.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.SlowFall.Raid == true then
						if RSA.db.profile.Mage.Spells.SlowFall.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Mage.Spells.SlowFall.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- SLOW FALL
		end -- IF EVENT IS SPELL_AURA_APPLIED
		if event == "SPELL_CAST_START" then
			if spellID == 53142 or spellID == 11419 or spellID == 32266 or spellID == 11416 or spellID == 11417 -- PORTALS
			or spellID == 35717 or spellID == 33691 or spellID == 32267 or spellID == 49361 or spellID == 10059
			or spellID == 49360 or spellID == 11420 or spellID == 11418 or spellID == 88345 or spellID == 88346 then
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Mage.Spells.Portals.Messages.Start ~= "" then
					if RSA.db.profile.Mage.Spells.Portals.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Mage.Spells.Portals.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.Portals.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Mage.Spells.Portals.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Mage.Spells.Portals.CustomChannel.Channel)
					end
					if RSA.db.profile.Mage.Spells.Portals.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Mage.Spells.Portals.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.Portals.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Mage.Spells.Portals.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.Portals.Party == true then
						if RSA.db.profile.Mage.Spells.Portals.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Mage.Spells.Portals.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.Portals.Raid == true then
						if RSA.db.profile.Mage.Spells.Portals.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Mage.Spells.Portals.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- PORTALS
			if spellID == 53140 or spellID == 3562 or spellID == 32271 or spellID == 3562 or spellID == 3567 -- TELEPORTS
			or spellID == 33690 or spellID == 35715 or spellID == 32272 or spellID == 49358 or spellID == 3561
			or spellID == 49359 or spellID == 3566 or spellID == 3563 or spellID == 88342 or spellID == 88344 then
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Mage.Spells.Teleport.Messages.Start ~= "" then
					if RSA.db.profile.Mage.Spells.Teleport.Local == true and (GetNumPartyMembers() > 0 or GetNumRaidMembers() > 0) then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Mage.Spells.Teleport.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- TELEPORT
		end -- IF EVENT IS SPELL_CAST_START
		if event == "SPELL_CAST_SUCCESS" then
			if spellID == 45438 then -- ICE BLOCK
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Mage.Spells.IceBlock.Messages.Start ~= "" then
					if RSA.db.profile.Mage.Spells.IceBlock.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Mage.Spells.IceBlock.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.IceBlock.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Mage.Spells.IceBlock.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Mage.Spells.IceBlock.CustomChannel.Channel)
					end
					if RSA.db.profile.Mage.Spells.IceBlock.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Mage.Spells.IceBlock.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.IceBlock.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Mage.Spells.IceBlock.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.IceBlock.Party == true then
						if RSA.db.profile.Mage.Spells.IceBlock.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Mage.Spells.IceBlock.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.IceBlock.Raid == true then
						if RSA.db.profile.Mage.Spells.IceBlock.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Mage.Spells.IceBlock.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- ICE BLOCK
			if spellID == 43987 then -- REFRESHMENT TABLE
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Mage.Spells.RefreshmentTable.Messages.Start ~= "" then
					if RSA.db.profile.Mage.Spells.RefreshmentTable.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Mage.Spells.RefreshmentTable.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.RefreshmentTable.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Mage.Spells.RefreshmentTable.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Mage.Spells.RefreshmentTable.CustomChannel.Channel)
					end
					if RSA.db.profile.Mage.Spells.RefreshmentTable.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Mage.Spells.RefreshmentTable.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.RefreshmentTable.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Mage.Spells.RefreshmentTable.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.RefreshmentTable.Party == true then
						if RSA.db.profile.Mage.Spells.RefreshmentTable.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Mage.Spells.RefreshmentTable.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.RefreshmentTable.Raid == true then
						if RSA.db.profile.Mage.Spells.RefreshmentTable.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Mage.Spells.RefreshmentTable.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- REFRESHMENT TABLE
		end -- IF EVENT IS SPELL_CAST_SUCCESS
		if event == "SPELL_HEAL" then
			if spellID == 87023 then -- CAUTERIZE
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Mage.Spells.Cauterize.Messages.Start ~= "" then
					if RSA.db.profile.Mage.Spells.Cauterize.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Mage.Spells.Cauterize.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.Cauterize.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Mage.Spells.Cauterize.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Mage.Spells.Cauterize.CustomChannel.Channel)
					end
					if RSA.db.profile.Mage.Spells.Cauterize.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Mage.Spells.Cauterize.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.Cauterize.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Mage.Spells.Cauterize.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.Cauterize.Party == true then
						if RSA.db.profile.Mage.Spells.Cauterize.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Mage.Spells.Cauterize.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.Cauterize.Raid == true then
						if RSA.db.profile.Mage.Spells.Cauterize.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Mage.Spells.Cauterize.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- CAUTERIZE
		end -- IF EVENT IS SPELL_HEAL
		if event == "SPELL_INTERRUPT" then
			if spellID == 2139 then -- COUNTERSPELL
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				extraspellinfo = GetSpellInfo(missType)
				extraspellinfolink = GetSpellLink(missType)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[TARSPELL]"] = extraspellinfo, ["[TARLINK]"] = extraspellinfolink,}
				if RSA.db.profile.Mage.Spells.Counterspell.Messages.Start ~= "" then
					if RSA.db.profile.Mage.Spells.Counterspell.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Mage.Spells.Counterspell.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.Counterspell.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Mage.Spells.Counterspell.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Mage.Spells.Counterspell.CustomChannel.Channel)
					end
					if RSA.db.profile.Mage.Spells.Counterspell.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Mage.Spells.Counterspell.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.Counterspell.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Mage.Spells.Counterspell.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.Counterspell.Party == true then
						if RSA.db.profile.Mage.Spells.Counterspell.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Mage.Spells.Counterspell.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.Counterspell.Raid == true then
						if RSA.db.profile.Mage.Spells.Counterspell.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Mage.Spells.Counterspell.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- COUNTERSPELL
		end -- IF EVENT IS SPELL_INTERRUPT
		if event == "SPELL_AURA_REMOVED" then
			if spellID == 118 or spellID == 61305 or spellID == 28272 or spellID == 61721 or spellID == 61780 or spellID == 28271 then -- POLYMORPH
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Mage.Spells.Polymorph.Messages.End ~= "" then
					if RSA.db.profile.Mage.Spells.Polymorph.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Mage.Spells.Polymorph.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.Polymorph.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Mage.Spells.Polymorph.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Mage.Spells.Polymorph.CustomChannel.Channel)
					end
					if RSA.db.profile.Mage.Spells.Polymorph.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Mage.Spells.Polymorph.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.Polymorph.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Mage.Spells.Polymorph.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.Polymorph.Party == true then
						if RSA.db.profile.Mage.Spells.Polymorph.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Mage.Spells.Polymorph.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.Polymorph.Raid == true then
						if RSA.db.profile.Mage.Spells.Polymorph.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Mage.Spells.Polymorph.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- POLYMORPH
			if spellID == 87023 then -- CAUTERIZE
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Mage.Spells.Cauterize.Messages.End ~= "" then
					if RSA.db.profile.Mage.Spells.Cauterize.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Mage.Spells.Cauterize.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.Cauterize.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Mage.Spells.Cauterize.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Mage.Spells.Cauterize.CustomChannel.Channel)
					end
					if RSA.db.profile.Mage.Spells.Cauterize.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Mage.Spells.Cauterize.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.Cauterize.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Mage.Spells.Cauterize.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.Cauterize.Party == true then
						if RSA.db.profile.Mage.Spells.Cauterize.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Mage.Spells.Cauterize.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.Cauterize.Raid == true then
						if RSA.db.profile.Mage.Spells.Cauterize.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Mage.Spells.Cauterize.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- CAUTERIZE
			if spellID == 45438 then -- ICE BLOCK
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Mage.Spells.IceBlock.Messages.End ~= "" then
					if RSA.db.profile.Mage.Spells.IceBlock.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Mage.Spells.IceBlock.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.IceBlock.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Mage.Spells.IceBlock.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Mage.Spells.IceBlock.CustomChannel.Channel)
					end
					if RSA.db.profile.Mage.Spells.IceBlock.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Mage.Spells.IceBlock.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.IceBlock.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Mage.Spells.IceBlock.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.IceBlock.Party == true then
						if RSA.db.profile.Mage.Spells.IceBlock.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Mage.Spells.IceBlock.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.IceBlock.Raid == true then
						if RSA.db.profile.Mage.Spells.IceBlock.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Mage.Spells.IceBlock.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- ICE BLOCK
			if spellID == 80353 and dest == pName then -- TIME WARP
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Mage.Spells.TimeWarp.Messages.End ~= "" then
					if RSA.db.profile.Mage.Spells.TimeWarp.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Mage.Spells.TimeWarp.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.TimeWarp.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Mage.Spells.TimeWarp.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Mage.Spells.TimeWarp.CustomChannel.Channel)
					end
					if RSA.db.profile.Mage.Spells.TimeWarp.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Mage.Spells.TimeWarp.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.TimeWarp.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Mage.Spells.TimeWarp.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.TimeWarp.Party == true then
						if RSA.db.profile.Mage.Spells.TimeWarp.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Mage.Spells.TimeWarp.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.TimeWarp.Raid == true then
						if RSA.db.profile.Mage.Spells.TimeWarp.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Mage.Spells.TimeWarp.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- TIME WARP
			if spellID == 54646 then -- FOCUS MAGIC
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Mage.Spells.FocusMagic.Messages.End ~= "" then
					if RSA.db.profile.Mage.Spells.FocusMagic.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Mage.Spells.FocusMagic.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.FocusMagic.Whisper == true and dest ~= pName and RSA_Whisperable(destGUID) then
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
						RSA_Print_Whisper(string.gsub(RSA.db.profile.Mage.Spells.FocusMagic.Messages.End, ".%a+.", RSA_String_Replace), dest)
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					end
					if RSA.db.profile.Mage.Spells.FocusMagic.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Mage.Spells.FocusMagic.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Mage.Spells.FocusMagic.CustomChannel.Channel)
					end
					if RSA.db.profile.Mage.Spells.FocusMagic.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Mage.Spells.FocusMagic.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.FocusMagic.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Mage.Spells.FocusMagic.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.FocusMagic.Party == true then
						if RSA.db.profile.Mage.Spells.FocusMagic.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Mage.Spells.FocusMagic.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.FocusMagic.Raid == true then
						if RSA.db.profile.Mage.Spells.FocusMagic.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Mage.Spells.FocusMagic.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- FOCUS MAGIC
			if spellID == 130 then -- SLOW FALL
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Mage.Spells.SlowFall.Messages.End ~= "" then
					if RSA.db.profile.Mage.Spells.SlowFall.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Mage.Spells.SlowFall.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.SlowFall.Whisper == true and dest ~= pName and RSA_Whisperable(destGUID) then
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
						RSA_Print_Whisper(string.gsub(RSA.db.profile.Mage.Spells.SlowFall.Messages.End, ".%a+.", RSA_String_Replace), dest)
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					end
					if RSA.db.profile.Mage.Spells.SlowFall.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Mage.Spells.SlowFall.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Mage.Spells.SlowFall.CustomChannel.Channel)
					end
					if RSA.db.profile.Mage.Spells.SlowFall.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Mage.Spells.SlowFall.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.SlowFall.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Mage.Spells.SlowFall.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.SlowFall.Party == true then
						if RSA.db.profile.Mage.Spells.SlowFall.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Mage.Spells.SlowFall.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.SlowFall.Raid == true then
						if RSA.db.profile.Mage.Spells.SlowFall.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Mage.Spells.SlowFall.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- SLOW FALL
		end -- IF EVENT IS SPELL_AURA_REMOVED
		if event == "SPELL_STOLEN" then
			if spellID == 30449 then -- SPELLSTEAL
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				extraspellinfo = GetSpellInfo(missType)
				extraspellinfolink = GetSpellLink(missType)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[AURA]"] = extraspellinfo, ["[AURALINK]"] = extraspellinfolink,}
				if RSA.db.profile.Mage.Spells.Spellsteal.Messages.Start ~= "" then
					if RSA.db.profile.Mage.Spells.Spellsteal.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Mage.Spells.Spellsteal.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.Spellsteal.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Mage.Spells.Spellsteal.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Mage.Spells.Spellsteal.CustomChannel.Channel)
					end
					if RSA.db.profile.Mage.Spells.Spellsteal.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Mage.Spells.Spellsteal.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.Spellsteal.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Mage.Spells.Spellsteal.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.Spellsteal.Party == true then
						if RSA.db.profile.Mage.Spells.Spellsteal.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Mage.Spells.Spellsteal.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.Spellsteal.Raid == true then
						if RSA.db.profile.Mage.Spells.Spellsteal.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Mage.Spells.Spellsteal.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- SPELLSTEAL
		end -- IF EVENT IS SPELL_STOLEN
		if event == "SPELL_SUMMON" then
			if spellID == 82676 then -- RING OF FROST
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Mage.Spells.RingOfFrost.Messages.Start ~= "" then
					if RSA.db.profile.Mage.Spells.RingOfFrost.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Mage.Spells.RingOfFrost.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.RingOfFrost.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Mage.Spells.RingOfFrost.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Mage.Spells.RingOfFrost.CustomChannel.Channel)
					end
					if RSA.db.profile.Mage.Spells.RingOfFrost.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Mage.Spells.RingOfFrost.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.RingOfFrost.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Mage.Spells.RingOfFrost.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.RingOfFrost.Party == true then
						if RSA.db.profile.Mage.Spells.RingOfFrost.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Mage.Spells.RingOfFrost.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.RingOfFrost.Raid == true then
						if RSA.db.profile.Mage.Spells.RingOfFrost.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Mage.Spells.RingOfFrost.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- RING OF FROST
		end -- IF EVENT IS SPELL_SUMMON
		if event == "SPELL_MISSED" and missType ~= "IMMUNE" then
			if spellID == 2139 then -- COUNTERSPELL
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				if missType == "MISS" then
					missinfo = L["missed"]
				elseif missType ~= "MISS" then
					missinfo = L["was resisted by"]
				end
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = missinfo,}
				if RSA.db.profile.Mage.Spells.Counterspell.Messages.End ~= "" then
					if RSA.db.profile.Mage.Spells.Counterspell.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Mage.Spells.Counterspell.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.Counterspell.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Mage.Spells.Counterspell.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Mage.Spells.Counterspell.CustomChannel.Channel)
					end
					if RSA.db.profile.Mage.Spells.Counterspell.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Mage.Spells.Counterspell.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.Counterspell.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Mage.Spells.Counterspell.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.Counterspell.Party == true then
						if RSA.db.profile.Mage.Spells.Counterspell.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Mage.Spells.Counterspell.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.Counterspell.Raid == true then
						if RSA.db.profile.Mage.Spells.Counterspell.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Mage.Spells.Counterspell.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- COUNTERSPELL
			if spellID == 30449 then -- SPELLSTEAL
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				if missType == "MISS" then
					missinfo = L["missed"]
				elseif missType ~= "MISS" then
					missinfo = L["was resisted by"]
				end
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = missinfo,}
				if RSA.db.profile.Mage.Spells.Spellsteal.Messages.End ~= "" then
					if RSA.db.profile.Mage.Spells.Spellsteal.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Mage.Spells.Spellsteal.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.Spellsteal.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Mage.Spells.Spellsteal.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Mage.Spells.Spellsteal.CustomChannel.Channel)
					end
					if RSA.db.profile.Mage.Spells.Spellsteal.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Mage.Spells.Spellsteal.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.Spellsteal.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Mage.Spells.Spellsteal.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.Spellsteal.Party == true then
						if RSA.db.profile.Mage.Spells.Spellsteal.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Mage.Spells.Spellsteal.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.Spellsteal.Raid == true then
						if RSA.db.profile.Mage.Spells.Spellsteal.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Mage.Spells.Spellsteal.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- SPELLSTEAL
		end -- IF EVENT IS SPELL_MISSED AND NOT IMMUNE
		if event == "SPELL_MISSED" and missType == "IMMUNE" then
			if spellID == 2139 then -- COUNTERSPELL
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = L[L["Immune"]],}
				if RSA.db.profile.Mage.Spells.Counterspell.Messages.Immune ~= "" then
					if RSA.db.profile.Mage.Spells.Counterspell.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Mage.Spells.Counterspell.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.Counterspell.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Mage.Spells.Counterspell.Messages.Immune, ".%a+.", RSA_String_Replace), RSA.db.profile.Mage.Spells.Counterspell.CustomChannel.Channel)
					end
					if RSA.db.profile.Mage.Spells.Counterspell.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Mage.Spells.Counterspell.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.Counterspell.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Mage.Spells.Counterspell.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.Counterspell.Party == true then
						if RSA.db.profile.Mage.Spells.Counterspell.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Mage.Spells.Counterspell.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Mage.Spells.Counterspell.Raid == true then
						if RSA.db.profile.Mage.Spells.Counterspell.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Mage.Spells.Counterspell.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
				end
			end -- COUNTERSPELL
		end -- IF EVENT IS SPELL_MISSED AND IS IMMUNE
	end -- IF SOURCE IS PLAYER
end -- END ENTIRELY
RSA_CombatLogMonitor:SetScript("OnEvent", Mage_Spells)
end -- END ON ENABLED
function RSA_Mage:OnDisable()
RSA_CombatLogMonitor:SetScript("OnEvent", nil)
end