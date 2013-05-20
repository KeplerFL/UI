-----------------------------------------------
---- Raeli's Spell Announcer Shaman Module ----
-----------------------------------------------
local RSA = LibStub("AceAddon-3.0"):GetAddon("RSA")
local L = LibStub("AceLocale-3.0"):GetLocale("RSA")
local RSA_Shaman = RSA:NewModule("Shaman")
function RSA_Shaman:OnInitialize()
	if RSA.db.profile.General.Class == "SHAMAN" then
		RSA_Shaman:SetEnabledState(true)
	else
		RSA_Shaman:SetEnabledState(false)
	end
end -- End OnInitialize
function RSA_Shaman:OnEnable()
local spellinfo
local spelllinkinfo
local extraspellinfo
local extraspellinfolink
RSA.db.profile.Modules.Shaman = true -- Set state to loaded, to know if we should announce when a spell is refreshed.
local pName = UnitName("player")
local ResTarget = L["Unknown"]
local Ressed
local function Shaman_Spells(_, _, _, event, _, _, source, _, _, destGUID, dest, _, _, spellID, spellName, _, missType)
	local petName = UnitName("pet")
	if source == pName or source == petName then
		if (event == "SPELL_CAST_SUCCESS" and RSA.db.profile.Modules.Reminders_Loaded == true) then -- Reminder Refreshed
			local ReminderSpell = RSA.db.profile.Shaman.Reminders.SpellName
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
			if spellID == 51514 then -- HEX
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Shaman.Spells.Hex.Messages.Start ~= "" then
					if RSA.db.profile.Shaman.Spells.Hex.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Shaman.Spells.Hex.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.Hex.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Shaman.Spells.Hex.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Shaman.Spells.Hex.CustomChannel.Channel)
					end
					if RSA.db.profile.Shaman.Spells.Hex.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Shaman.Spells.Hex.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.Hex.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Shaman.Spells.Hex.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.Hex.Party == true then
						if RSA.db.profile.Shaman.Spells.Hex.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Shaman.Spells.Hex.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.Hex.Raid == true then
						if RSA.db.profile.Shaman.Spells.Hex.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Shaman.Spells.Hex.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- HEX
			if spellID == 76780 then -- BIND ELEMENTAL
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Shaman.Spells.BindElemental.Messages.Start ~= "" then
					if RSA.db.profile.Shaman.Spells.BindElemental.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Shaman.Spells.BindElemental.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.BindElemental.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Shaman.Spells.BindElemental.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Shaman.Spells.BindElemental.CustomChannel.Channel)
					end
					if RSA.db.profile.Shaman.Spells.BindElemental.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Shaman.Spells.BindElemental.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.BindElemental.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Shaman.Spells.BindElemental.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.BindElemental.Party == true then
						if RSA.db.profile.Shaman.Spells.BindElemental.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Shaman.Spells.BindElemental.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.BindElemental.Raid == true then
						if RSA.db.profile.Shaman.Spells.BindElemental.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Shaman.Spells.BindElemental.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- BIND ELEMENTAL
		end -- IF EVENT IS SPELL_AURA_APPLIED
		if event == "SPELL_CAST_SUCCESS" then
			if spellID == 32182 or spellID == 2825 then -- BLOODLUST / HEROISM
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Shaman.Spells.Heroism.Messages.Start ~= "" then
					if RSA.db.profile.Shaman.Spells.Heroism.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Shaman.Spells.Heroism.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.Heroism.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Shaman.Spells.Heroism.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Shaman.Spells.Heroism.CustomChannel.Channel)
					end
					if RSA.db.profile.Shaman.Spells.Heroism.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Shaman.Spells.Heroism.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.Heroism.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Shaman.Spells.Heroism.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.Heroism.Party == true then
						if RSA.db.profile.Shaman.Spells.Heroism.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Shaman.Spells.Heroism.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.Heroism.Raid == true then
						if RSA.db.profile.Shaman.Spells.Heroism.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Shaman.Spells.Heroism.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- BLOODLUST / HEROISM
			if spellID == 51490 then -- THUNDERSTORM
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Shaman.Spells.Thunderstorm.Messages.Start ~= "" then
					if RSA.db.profile.Shaman.Spells.Thunderstorm.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Shaman.Spells.Thunderstorm.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.Thunderstorm.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Shaman.Spells.Thunderstorm.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Shaman.Spells.Thunderstorm.CustomChannel.Channel)
					end
					if RSA.db.profile.Shaman.Spells.Thunderstorm.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Shaman.Spells.Thunderstorm.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.Thunderstorm.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Shaman.Spells.Thunderstorm.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.Thunderstorm.Party == true then
						if RSA.db.profile.Shaman.Spells.Thunderstorm.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Shaman.Spells.Thunderstorm.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.Thunderstorm.Raid == true then
						if RSA.db.profile.Shaman.Spells.Thunderstorm.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Shaman.Spells.Thunderstorm.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- THUNDERSTORM
		end -- IF EVENT IS SPELL_CAST_SUCCESS
		if event == "SPELL_INTERRUPT" then
			if spellID == 57994 then -- WIND SHEAR
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				extraspellinfo = GetSpellInfo(missType)
				extraspellinfolink = GetSpellLink(missType)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[TARSPELL]"] = extraspellinfo, ["[TARLINK]"] = extraspellinfolink,}
				if RSA.db.profile.Shaman.Spells.WindShear.Messages.Start ~= "" then
					if RSA.db.profile.Shaman.Spells.WindShear.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Shaman.Spells.WindShear.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.WindShear.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Shaman.Spells.WindShear.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Shaman.Spells.WindShear.CustomChannel.Channel)
					end
					if RSA.db.profile.Shaman.Spells.WindShear.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Shaman.Spells.WindShear.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.WindShear.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Shaman.Spells.WindShear.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.WindShear.Party == true then
						if RSA.db.profile.Shaman.Spells.WindShear.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Shaman.Spells.WindShear.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.WindShear.Raid == true then
						if RSA.db.profile.Shaman.Spells.WindShear.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Shaman.Spells.WindShear.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- WIND SHEAR
		end -- IF EVENT IS SPELL_INTERRUPT
		if event == "SPELL_AURA_REMOVED" then
			if spellID == 76780 then -- BIND ELEMENTAL
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Shaman.Spells.BindElemental.Messages.End ~= "" then
					if RSA.db.profile.Shaman.Spells.BindElemental.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Shaman.Spells.BindElemental.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.BindElemental.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Shaman.Spells.BindElemental.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Shaman.Spells.BindElemental.CustomChannel.Channel)
					end
					if RSA.db.profile.Shaman.Spells.BindElemental.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Shaman.Spells.BindElemental.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.BindElemental.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Shaman.Spells.BindElemental.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.BindElemental.Party == true then
						if RSA.db.profile.Shaman.Spells.BindElemental.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Shaman.Spells.BindElemental.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.BindElemental.Raid == true then
						if RSA.db.profile.Shaman.Spells.BindElemental.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Shaman.Spells.BindElemental.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- BIND ELEMENTAL
			if spellID == 51514 then -- HEX
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Shaman.Spells.Hex.Messages.End ~= "" then
					if RSA.db.profile.Shaman.Spells.Hex.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Shaman.Spells.Hex.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.Hex.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Shaman.Spells.Hex.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Shaman.Spells.Hex.CustomChannel.Channel)
					end
					if RSA.db.profile.Shaman.Spells.Hex.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Shaman.Spells.Hex.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.Hex.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Shaman.Spells.Hex.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.Hex.Party == true then
						if RSA.db.profile.Shaman.Spells.Hex.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Shaman.Spells.Hex.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.Hex.Raid == true then
						if RSA.db.profile.Shaman.Spells.Hex.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Shaman.Spells.Hex.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- HEX
			if (spellID == 32182 or spellID == 2825) and dest == pName then -- BLOODLUST / HEROISM
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Shaman.Spells.Heroism.Messages.End ~= "" then
					if RSA.db.profile.Shaman.Spells.Heroism.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Shaman.Spells.Heroism.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.Heroism.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Shaman.Spells.Heroism.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Shaman.Spells.Heroism.CustomChannel.Channel)
					end
					if RSA.db.profile.Shaman.Spells.Heroism.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Shaman.Spells.Heroism.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.Heroism.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Shaman.Spells.Heroism.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.Heroism.Party == true then
						if RSA.db.profile.Shaman.Spells.Heroism.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Shaman.Spells.Heroism.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.Heroism.Raid == true then
						if RSA.db.profile.Shaman.Spells.Heroism.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Shaman.Spells.Heroism.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- BLOODLUST / HEROISM
		end -- IF EVENT IS SPELL_AURA_REMOVED
		if event == "SPELL_DISPEL" then
			if spellID == 370 then -- PURGE
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				extraspellinfo = GetSpellInfo(missType)
				extraspellinfolink = GetSpellLink(missType)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[AURA]"] = extraspellinfo, ["[AURALINK]"] = extraspellinfolink,}
				if RSA.db.profile.Shaman.Spells.Purge.Messages.Start ~= "" then
					if RSA.db.profile.Shaman.Spells.Purge.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Shaman.Spells.Purge.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.Purge.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Shaman.Spells.Purge.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Shaman.Spells.Purge.CustomChannel.Channel)
					end
					if RSA.db.profile.Shaman.Spells.Purge.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Shaman.Spells.Purge.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.Purge.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Shaman.Spells.Purge.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.Purge.Party == true then
						if RSA.db.profile.Shaman.Spells.Purge.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Shaman.Spells.Purge.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.Purge.Raid == true then
						if RSA.db.profile.Shaman.Spells.Purge.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Shaman.Spells.Purge.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- PURGE
			if spellID == 51886 or spellID == 77130 then -- CLEANSE SPIRIT
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				extraspellinfo = GetSpellInfo(missType)
				extraspellinfolink = GetSpellLink(missType)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[AURA]"] = extraspellinfo, ["[AURALINK]"] = extraspellinfolink,}
				if RSA.db.profile.Shaman.Spells.CleanseSpirit.Messages.Start ~= "" then
					if RSA.db.profile.Shaman.Spells.CleanseSpirit.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Shaman.Spells.CleanseSpirit.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.CleanseSpirit.Whisper == true and dest ~= pName and RSA_Whisperable(destGUID) then
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
						RSA_Print_Whisper(string.gsub(RSA.db.profile.Shaman.Spells.CleanseSpirit.Messages.End, ".%a+.", RSA_String_Replace), dest)
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					end
					if RSA.db.profile.Shaman.Spells.CleanseSpirit.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Shaman.Spells.CleanseSpirit.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Shaman.Spells.CleanseSpirit.CustomChannel.Channel)
					end
					if RSA.db.profile.Shaman.Spells.CleanseSpirit.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Shaman.Spells.CleanseSpirit.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.CleanseSpirit.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Shaman.Spells.CleanseSpirit.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.CleanseSpirit.Party == true then
						if RSA.db.profile.Shaman.Spells.CleanseSpirit.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Shaman.Spells.CleanseSpirit.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.CleanseSpirit.Raid == true then
						if RSA.db.profile.Shaman.Spells.CleanseSpirit.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Shaman.Spells.CleanseSpirit.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- CLEANSE SPIRIT
		end -- IF EVENT IS SPELL_DISPEL
		if event == "SPELL_DISPEL_FAILED" then
			if spellID == 370 then -- PURGE
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				extraspellinfo = GetSpellInfo(missType)
				extraspellinfolink = GetSpellLink(missType)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[AURA]"] = extraspellinfo, ["[AURALINK]"] = extraspellinfolink,}
				if RSA.db.profile.Shaman.Spells.Purge.Messages.End ~= "" then
					if RSA.db.profile.Shaman.Spells.Purge.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Shaman.Spells.Purge.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.Purge.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Shaman.Spells.Purge.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Shaman.Spells.Purge.CustomChannel.Channel)
					end
					if RSA.db.profile.Shaman.Spells.Purge.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Shaman.Spells.Purge.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.Purge.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Shaman.Spells.Purge.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.Purge.Party == true then
						if RSA.db.profile.Shaman.Spells.Purge.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Shaman.Spells.Purge.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.Purge.Raid == true then
						if RSA.db.profile.Shaman.Spells.Purge.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Shaman.Spells.Purge.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- PURGE
		end -- IF EVENT IS SPELL_DISPEL_FAILED
		if event == "SPELL_MISSED" and missType ~= "IMMUNE" then
			if spellID == 57994 then -- WIND SHEAR
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				if missType == "MISS" then
					missinfo = L["missed"]
				elseif missType ~= "MISS" then
					missinfo = L["was resisted by"]
				end
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = missinfo,}
				if RSA.db.profile.Shaman.Spells.WindShear.Messages.End ~= "" then
					if RSA.db.profile.Shaman.Spells.WindShear.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Shaman.Spells.WindShear.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.WindShear.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Shaman.Spells.WindShear.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Shaman.Spells.WindShear.CustomChannel.Channel)
					end
					if RSA.db.profile.Shaman.Spells.WindShear.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Shaman.Spells.WindShear.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.WindShear.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Shaman.Spells.WindShear.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.WindShear.Party == true then
						if RSA.db.profile.Shaman.Spells.WindShear.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Shaman.Spells.WindShear.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.WindShear.Raid == true then
						if RSA.db.profile.Shaman.Spells.WindShear.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Shaman.Spells.WindShear.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- WIND SHEAR
		end -- IF EVENT IS SPELL_MISSED AND NOT IMMUNE
		if event == "SPELL_MISSED" and missType == "IMMUNE" then
			if spellID == 57994 then -- WIND SHEAR
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = L["Immune"],}
				if RSA.db.profile.Shaman.Spells.WindShear.Messages.Immune ~= "" then
					if RSA.db.profile.Shaman.Spells.WindShear.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Shaman.Spells.WindShear.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.WindShear.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Shaman.Spells.WindShear.Messages.Immune, ".%a+.", RSA_String_Replace), RSA.db.profile.Shaman.Spells.WindShear.CustomChannel.Channel)
					end
					if RSA.db.profile.Shaman.Spells.WindShear.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Shaman.Spells.WindShear.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.WindShear.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Shaman.Spells.WindShear.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.WindShear.Party == true then
						if RSA.db.profile.Shaman.Spells.WindShear.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Shaman.Spells.WindShear.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.WindShear.Raid == true then
						if RSA.db.profile.Shaman.Spells.WindShear.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Shaman.Spells.WindShear.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
				end
			end -- WIND SHEAR
		end -- IF EVENT IS SPELL_MISSED AND IS IMMUNE
		if event == "SPELL_SUMMON" then
			if spellID == 16190 then -- MANA TIDE TOTEM
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_MT_GUID = destGUID
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Shaman.Spells.ManaTide.Messages.Start ~= "" then
					if RSA.db.profile.Shaman.Spells.ManaTide.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Shaman.Spells.ManaTide.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.ManaTide.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Shaman.Spells.ManaTide.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Shaman.Spells.ManaTide.CustomChannel.Channel)
					end
					if RSA.db.profile.Shaman.Spells.ManaTide.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Shaman.Spells.ManaTide.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.ManaTide.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Shaman.Spells.ManaTide.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.ManaTide.Party == true then
						if RSA.db.profile.Shaman.Spells.ManaTide.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Shaman.Spells.ManaTide.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.ManaTide.Raid == true then
						if RSA.db.profile.Shaman.Spells.ManaTide.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Shaman.Spells.ManaTide.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- MANA TIDE TOTEM
			if spellID == 98008 then -- SPIRIT LINK TOTEM
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_SL_GUID = destGUID
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Shaman.Spells.SpiritLink.Messages.Start ~= "" then
					if RSA.db.profile.Shaman.Spells.SpiritLink.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Shaman.Spells.SpiritLink.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.SpiritLink.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Shaman.Spells.SpiritLink.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Shaman.Spells.SpiritLink.CustomChannel.Channel)
					end
					if RSA.db.profile.Shaman.Spells.SpiritLink.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Shaman.Spells.SpiritLink.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.SpiritLink.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Shaman.Spells.SpiritLink.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.SpiritLink.Party == true then
						if RSA.db.profile.Shaman.Spells.SpiritLink.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Shaman.Spells.SpiritLink.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.SpiritLink.Raid == true then
						if RSA.db.profile.Shaman.Spells.SpiritLink.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Shaman.Spells.SpiritLink.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- SPIRIT LINK TOTEM
			if spellID == 8143 then -- TREMOR TOTEM
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_TREMOR_GUID = destGUID
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Shaman.Spells.TremorTotem.Messages.Start ~= "" then
					if RSA.db.profile.Shaman.Spells.TremorTotem.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Shaman.Spells.TremorTotem.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.TremorTotem.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Shaman.Spells.TremorTotem.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Shaman.Spells.TremorTotem.CustomChannel.Channel)
					end
					if RSA.db.profile.Shaman.Spells.TremorTotem.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Shaman.Spells.TremorTotem.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.TremorTotem.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Shaman.Spells.TremorTotem.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.TremorTotem.Party == true then
						if RSA.db.profile.Shaman.Spells.TremorTotem.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Shaman.Spells.TremorTotem.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.TremorTotem.Raid == true then
						if RSA.db.profile.Shaman.Spells.TremorTotem.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Shaman.Spells.TremorTotem.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- TREMOR TOTEM
			if spellID == 8177 then -- GROUNDING TOTEM
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_GROUNDING_GUID = destGUID
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Shaman.Spells.GroundingTotem.Messages.Start ~= "" then
					if RSA.db.profile.Shaman.Spells.GroundingTotem.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Shaman.Spells.GroundingTotem.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.GroundingTotem.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Shaman.Spells.GroundingTotem.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Shaman.Spells.GroundingTotem.CustomChannel.Channel)
					end
					if RSA.db.profile.Shaman.Spells.GroundingTotem.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Shaman.Spells.GroundingTotem.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.GroundingTotem.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Shaman.Spells.GroundingTotem.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.GroundingTotem.Party == true then
						if RSA.db.profile.Shaman.Spells.GroundingTotem.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Shaman.Spells.GroundingTotem.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.GroundingTotem.Raid == true then
						if RSA.db.profile.Shaman.Spells.GroundingTotem.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Shaman.Spells.GroundingTotem.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- GROUNDING TOTEM
		end -- IF EVENT IS SPELL_SUMMON
		if event == "UNIT_DESTROYED" then
			if destGUID == RSA_MT_GUID then -- MANA TIDE TOTEM
				spellinfo = GetSpellInfo(16190) spelllinkinfo = GetSpellLink(16190)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Shaman.Spells.ManaTide.Messages.End ~= "" then
					if RSA.db.profile.Shaman.Spells.ManaTide.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Shaman.Spells.ManaTide.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.ManaTide.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Shaman.Spells.ManaTide.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Shaman.Spells.ManaTide.CustomChannel.Channel)
					end
					if RSA.db.profile.Shaman.Spells.ManaTide.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Shaman.Spells.ManaTide.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.ManaTide.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Shaman.Spells.ManaTide.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.ManaTide.Party == true then
						if RSA.db.profile.Shaman.Spells.ManaTide.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Shaman.Spells.ManaTide.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.ManaTide.Raid == true then
						if RSA.db.profile.Shaman.Spells.ManaTide.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Shaman.Spells.ManaTide.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- MANA TIDE TOTEM
			if destGUID == RSA_SL_GUID then -- SPIRIT LINK TOTEM
				spellinfo = GetSpellInfo(98008) spelllinkinfo = GetSpellLink(98008)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Shaman.Spells.SpiritLink.Messages.End ~= "" then
					if RSA.db.profile.Shaman.Spells.SpiritLink.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Shaman.Spells.SpiritLink.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.SpiritLink.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Shaman.Spells.SpiritLink.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Shaman.Spells.SpiritLink.CustomChannel.Channel)
					end
					if RSA.db.profile.Shaman.Spells.SpiritLink.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Shaman.Spells.SpiritLink.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.SpiritLink.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Shaman.Spells.SpiritLink.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.SpiritLink.Party == true then
						if RSA.db.profile.Shaman.Spells.SpiritLink.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Shaman.Spells.SpiritLink.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.SpiritLink.Raid == true then
						if RSA.db.profile.Shaman.Spells.SpiritLink.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Shaman.Spells.SpiritLink.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- SPIRIT LINK TOTEM
			if destGUID == RSA_TREMOR_GUID then -- TREMOR TOTEM
				spellinfo = GetSpellInfo(8143) spelllinkinfo = GetSpellLink(8143)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Shaman.Spells.TremorTotem.Messages.End ~= "" then
					if RSA.db.profile.Shaman.Spells.TremorTotem.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Shaman.Spells.TremorTotem.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.TremorTotem.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Shaman.Spells.TremorTotem.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Shaman.Spells.TremorTotem.CustomChannel.Channel)
					end
					if RSA.db.profile.Shaman.Spells.TremorTotem.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Shaman.Spells.TremorTotem.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.TremorTotem.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Shaman.Spells.TremorTotem.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.TremorTotem.Party == true then
						if RSA.db.profile.Shaman.Spells.TremorTotem.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Shaman.Spells.TremorTotem.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.TremorTotem.Raid == true then
						if RSA.db.profile.Shaman.Spells.TremorTotem.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Shaman.Spells.TremorTotem.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- TREMOR TOTEM
		end -- IF EVENT IS UNIT_DESTROYED
	end -- IF SOURCE IS PLAYER
	if destGUID == RSA_GROUNDING_GUID and event ~= "SPELL_SUMMON" and event ~= "UNIT_DESTROYED" and event ~= "SPELL_MISSED" and event ~= "PARTY_KILL" and event ~= "UNIT_DIED" then -- GROUNDING TOTEM
		spellinfo = GetSpellInfo(8177)
		spelllinkinfo = GetSpellLink(8177)
		extraspellinfo = GetSpellInfo(spellID)
		extraspellinfolink = GetSpellLink(spellID)
		RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = source, ["[AMOUNT]"] = missType, ["[TARLINK]"] = extraspellinfolink, ["[TARSPELL]"] = extraspellinfo,}
		if RSA.db.profile.Shaman.Spells.GroundingTotem.Messages.End ~= "" then
			if RSA.db.profile.Shaman.Spells.GroundingTotem.Local == true then
				RSA_Print_LibSink(string.gsub(RSA.db.profile.Shaman.Spells.GroundingTotem.Messages.End, ".%a+.", RSA_String_Replace))
			end
			if RSA.db.profile.Shaman.Spells.GroundingTotem.CustomChannel.Enabled == true then
				RSA_Print_Channel(string.gsub(RSA.db.profile.Shaman.Spells.GroundingTotem.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Shaman.Spells.GroundingTotem.CustomChannel.Channel)
			end
			if RSA.db.profile.Shaman.Spells.GroundingTotem.Smart.Say == true then
				RSA_Print_Say(string.gsub(RSA.db.profile.Shaman.Spells.GroundingTotem.Messages.End, ".%a+.", RSA_String_Replace))
			end
			if RSA.db.profile.Shaman.Spells.GroundingTotem.Smart.RaidParty == true then
				RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Shaman.Spells.GroundingTotem.Messages.End, ".%a+.", RSA_String_Replace))
			end
			if RSA.db.profile.Shaman.Spells.GroundingTotem.Party == true then
				if RSA.db.profile.Shaman.Spells.GroundingTotem.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
					RSA_Print_Party(string.gsub(RSA.db.profile.Shaman.Spells.GroundingTotem.Messages.End, ".%a+.", RSA_String_Replace))
			end
			if RSA.db.profile.Shaman.Spells.GroundingTotem.Raid == true then
				if RSA.db.profile.Shaman.Spells.GroundingTotem.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
				RSA_Print_Raid(string.gsub(RSA.db.profile.Shaman.Spells.GroundingTotem.Messages.End, ".%a+.", RSA_String_Replace))
			end
		end
	end -- GROUNDING TOTEM
	if destGUID == RSA_GROUNDING_GUID and event == "SPELL_MISSED" and missType == "IMMUNE" then -- GROUNDING TOTEM
		spellinfo = GetSpellInfo(8177)
		spelllinkinfo = GetSpellLink(8177)
		extraspellinfo = GetSpellInfo(spellID)
		extraspellinfolink = GetSpellLink(spellID)
		RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = source, ["[TARLINK]"] = extraspellinfolink, ["[TARSPELL]"] = extraspellinfo,}
		if RSA.db.profile.Shaman.Spells.GroundingTotem.Messages.Immune ~= "" then
			if RSA.db.profile.Shaman.Spells.GroundingTotem.Local == true then
				RSA_Print_LibSink(string.gsub(RSA.db.profile.Shaman.Spells.GroundingTotem.Messages.Immune, ".%a+.", RSA_String_Replace))
			end
			if RSA.db.profile.Shaman.Spells.GroundingTotem.CustomChannel.Enabled == true then
				RSA_Print_Channel(string.gsub(RSA.db.profile.Shaman.Spells.GroundingTotem.Messages.Immune, ".%a+.", RSA_String_Replace), RSA.db.profile.Shaman.Spells.GroundingTotem.CustomChannel.Channel)
			end
			if RSA.db.profile.Shaman.Spells.GroundingTotem.Smart.Say == true then
				RSA_Print_Say(string.gsub(RSA.db.profile.Shaman.Spells.GroundingTotem.Messages.Immune, ".%a+.", RSA_String_Replace))
			end
			if RSA.db.profile.Shaman.Spells.GroundingTotem.Smart.RaidParty == true then
				RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Shaman.Spells.GroundingTotem.Messages.Immune, ".%a+.", RSA_String_Replace))
			end
			if RSA.db.profile.Shaman.Spells.GroundingTotem.Party == true then
				if RSA.db.profile.Shaman.Spells.GroundingTotem.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
					RSA_Print_Party(string.gsub(RSA.db.profile.Shaman.Spells.GroundingTotem.Messages.Immune, ".%a+.", RSA_String_Replace))
			end
			if RSA.db.profile.Shaman.Spells.GroundingTotem.Raid == true then
				if RSA.db.profile.Shaman.Spells.GroundingTotem.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
				RSA_Print_Raid(string.gsub(RSA.db.profile.Shaman.Spells.GroundingTotem.Messages.Immune, ".%a+.", RSA_String_Replace))
			end
		end
	end -- GROUNDING TOTEM
end -- END ENTIRELY
RSA_CombatLogMonitor:SetScript("OnEvent", Shaman_Spells)
------------------------------
---- Resurrection Monitor ----
------------------------------
local function Shaman_AncestralSpirit(_, event, source, spell, rank, dest, _)
	if UnitName(source) == pName then
		if spell == GetSpellInfo(2008) and RSA.db.profile.Shaman.Spells.AncestralSpirit.Messages.Start ~= "" then -- ANCESTRAL SPIRIT
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
				if RSA.db.profile.Shaman.Spells.AncestralSpirit.Messages.Start ~= "" then
					if RSA.db.profile.Shaman.Spells.AncestralSpirit.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Shaman.Spells.AncestralSpirit.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.AncestralSpirit.Whisper == true and dest ~= pName then
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
						RSA_Print_Whisper(string.gsub(RSA.db.profile.Shaman.Spells.AncestralSpirit.Messages.Start, ".%a+.", RSA_String_Replace), dest)
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					end
					if RSA.db.profile.Shaman.Spells.AncestralSpirit.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Shaman.Spells.AncestralSpirit.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Shaman.Spells.AncestralSpirit.CustomChannel.Channel)
					end
					if RSA.db.profile.Shaman.Spells.AncestralSpirit.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Shaman.Spells.AncestralSpirit.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.AncestralSpirit.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Shaman.Spells.AncestralSpirit.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.AncestralSpirit.Party == true then
						if RSA.db.profile.Shaman.Spells.AncestralSpirit.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Shaman.Spells.AncestralSpirit.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.AncestralSpirit.Raid == true then
						if RSA.db.profile.Shaman.Spells.AncestralSpirit.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Shaman.Spells.AncestralSpirit.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			elseif event == "UNIT_SPELLCAST_SUCCEEDED" and Ressed ~= true  then
				dest = ResTarget
				Ressed = true
				if RSA.db.profile.Shaman.Spells.AncestralSpirit.Messages.End ~= "" then
					if RSA.db.profile.Shaman.Spells.AncestralSpirit.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Shaman.Spells.AncestralSpirit.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.AncestralSpirit.Whisper == true and dest ~= pName then
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
						RSA_Print_Whisper(string.gsub(RSA.db.profile.Shaman.Spells.AncestralSpirit.Messages.End, ".%a+.", RSA_String_Replace), dest)
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					end
					if RSA.db.profile.Shaman.Spells.AncestralSpirit.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Shaman.Spells.AncestralSpirit.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Shaman.Spells.AncestralSpirit.CustomChannel.Channel)
					end
					if RSA.db.profile.Shaman.Spells.AncestralSpirit.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Shaman.Spells.AncestralSpirit.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.AncestralSpirit.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Shaman.Spells.AncestralSpirit.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.AncestralSpirit.Party == true then
						if RSA.db.profile.Shaman.Spells.AncestralSpirit.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Shaman.Spells.AncestralSpirit.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Shaman.Spells.AncestralSpirit.Raid == true then
						if RSA.db.profile.Shaman.Spells.AncestralSpirit.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Shaman.Spells.AncestralSpirit.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end
		end -- ANCESTRAL SPIRIT
	end
end -- END FUNCTION
RSA_ResMon = CreateFrame("Frame", "RSA:RM")
RSA_ResMon:RegisterEvent("UNIT_SPELLCAST_SENT")
RSA_ResMon:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
RSA_ResMon:SetScript("OnEvent", Shaman_AncestralSpirit)
end -- END ON ENABLED
function RSA_Shaman:OnDisable()
RSA_CombatLogMonitor:SetScript("OnEvent", nil)
RSA_ResMon:SetScript("OnEvent", nil)
end