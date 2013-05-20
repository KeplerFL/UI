------------------------------------------------
---- Raeli's Spell Announcer Warrior Module ----
------------------------------------------------
local RSA = LibStub("AceAddon-3.0"):GetAddon("RSA")
local L = LibStub("AceLocale-3.0"):GetLocale("RSA")
local RSA_Warrior = RSA:NewModule("Warrior")
function RSA_Warrior:OnInitialize()
	if RSA.db.profile.General.Class == "WARRIOR" then
		RSA_Warrior:SetEnabledState(true)
	else
		RSA_Warrior:SetEnabledState(false)
	end
end -- End OnInitialize
function RSA_Warrior:OnEnable()
RSA.db.profile.Modules.Warrior = true -- Set state to loaded, to know if we should announce when a spell is refreshed.
local pName = UnitName("player")
local RSA_RallyingCry = false
local RSA_ChallengingShout = false
local function Warrior_Spells(_, _, _, event, _, _, source, _, _, destGUID, dest, _, _, spellID, spellName, _, missType)
	local petName = UnitName("pet")
	if dest == pName then
		if missType == "REFLECT" then -- SPELL REFLECT
			spellinfo = GetSpellInfo(spellID)
			spelllinkinfo = GetSpellLink(spellID)
			RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = source,}
			if RSA.db.profile.Warrior.Spells.SpellReflect.Messages.Start ~= "" then
				if RSA.db.profile.Warrior.Spells.SpellReflect.Local == true then
					RSA_Print_LibSink(string.gsub(RSA.db.profile.Warrior.Spells.SpellReflect.Messages.Start, ".%a+.", RSA_String_Replace))
				end
				if RSA.db.profile.Warrior.Spells.SpellReflect.CustomChannel.Enabled == true then
					RSA_Print_Channel(string.gsub(RSA.db.profile.Warrior.Spells.SpellReflect.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Warrior.Spells.SpellReflect.CustomChannel.Channel)
				end
				if RSA.db.profile.Warrior.Spells.SpellReflect.Smart.Say == true then
					RSA_Print_Say(string.gsub(RSA.db.profile.Warrior.Spells.SpellReflect.Messages.Start, ".%a+.", RSA_String_Replace))
				end
				if RSA.db.profile.Warrior.Spells.SpellReflect.Smart.RaidParty == true then
					RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Warrior.Spells.SpellReflect.Messages.Start, ".%a+.", RSA_String_Replace))
				end
				if RSA.db.profile.Warrior.Spells.SpellReflect.Party == true then
					if RSA.db.profile.Warrior.Spells.SpellReflect.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
						RSA_Print_Party(string.gsub(RSA.db.profile.Warrior.Spells.SpellReflect.Messages.Start, ".%a+.", RSA_String_Replace))
				end
				if RSA.db.profile.Warrior.Spells.SpellReflect.Raid == true then
					if RSA.db.profile.Warrior.Spells.SpellReflect.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
					RSA_Print_Raid(string.gsub(RSA.db.profile.Warrior.Spells.SpellReflect.Messages.Start, ".%a+.", RSA_String_Replace))
				end
			end
			--SpellReflectSource = source
			--SpellReflectID = spellID
		end -- SPELL REFLECT
	end
	-- Maybe Later for Tracking Spell Reflected Damage.
	--[[if source == SpellReflectSource and dest == SpellReflectSource and spellID == SpellReflectID then
		print(spellName)
		print(missType)
	end]]--
	if source == pName or source == petName then
		if (event == "SPELL_CAST_SUCCESS" and RSA.db.profile.Modules.Reminders_Loaded == true) then -- Reminder Refreshed
			local ReminderSpell = RSA.db.profile.Warrior.Reminders.SpellName
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
			if spellID == 355 then -- TAUNT
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Warrior.Spells.Taunt.Messages.Start ~= "" then
					if RSA.db.profile.Warrior.Spells.Taunt.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Warrior.Spells.Taunt.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.Taunt.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Warrior.Spells.Taunt.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Warrior.Spells.Taunt.CustomChannel.Channel)
					end
					if RSA.db.profile.Warrior.Spells.Taunt.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Warrior.Spells.Taunt.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.Taunt.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Warrior.Spells.Taunt.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.Taunt.Party == true then
						if RSA.db.profile.Warrior.Spells.Taunt.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Warrior.Spells.Taunt.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.Taunt.Raid == true then
						if RSA.db.profile.Warrior.Spells.Taunt.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Warrior.Spells.Taunt.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- TAUNT
			if spellID == 676 then -- DISARM
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Warrior.Spells.Disarm.Messages.Start ~= "" then
					if RSA.db.profile.Warrior.Spells.Disarm.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Warrior.Spells.Disarm.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.Disarm.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Warrior.Spells.Disarm.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Warrior.Spells.Disarm.CustomChannel.Channel)
					end
					if RSA.db.profile.Warrior.Spells.Disarm.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Warrior.Spells.Disarm.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.Disarm.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Warrior.Spells.Disarm.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.Disarm.Party == true then
						if RSA.db.profile.Warrior.Spells.Disarm.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Warrior.Spells.Disarm.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.Disarm.Raid == true then
						if RSA.db.profile.Warrior.Spells.Disarm.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Warrior.Spells.Disarm.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- DISARM
			if spellID == 64382 then -- SHATTERING THROW
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Warrior.Spells.ShatteringThrow.Messages.Start ~= "" then
					if RSA.db.profile.Warrior.Spells.ShatteringThrow.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Warrior.Spells.ShatteringThrow.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.ShatteringThrow.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Warrior.Spells.ShatteringThrow.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Warrior.Spells.ShatteringThrow.CustomChannel.Channel)
					end
					if RSA.db.profile.Warrior.Spells.ShatteringThrow.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Warrior.Spells.ShatteringThrow.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.ShatteringThrow.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Warrior.Spells.ShatteringThrow.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.ShatteringThrow.Party == true then
						if RSA.db.profile.Warrior.Spells.ShatteringThrow.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Warrior.Spells.ShatteringThrow.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.ShatteringThrow.Raid == true then
						if RSA.db.profile.Warrior.Spells.ShatteringThrow.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Warrior.Spells.ShatteringThrow.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- SHATTERING THROW
			if spellID == 85388 then -- THROWDOWN
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Warrior.Spells.Throwdown.Messages.Start ~= "" then
					if RSA.db.profile.Warrior.Spells.Throwdown.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Warrior.Spells.Throwdown.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.Throwdown.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Warrior.Spells.Throwdown.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Warrior.Spells.Throwdown.CustomChannel.Channel)
					end
					if RSA.db.profile.Warrior.Spells.Throwdown.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Warrior.Spells.Throwdown.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.Throwdown.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Warrior.Spells.Throwdown.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.Throwdown.Party == true then
						if RSA.db.profile.Warrior.Spells.Throwdown.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Warrior.Spells.Throwdown.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.Throwdown.Raid == true then
						if RSA.db.profile.Warrior.Spells.Throwdown.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Warrior.Spells.Throwdown.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- THROWDOWN
			if spellID == 1719 then -- RECKLESSNESS
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Warrior.Spells.Recklessness.Messages.Start ~= "" then
					if RSA.db.profile.Warrior.Spells.Recklessness.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Warrior.Spells.Recklessness.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.Recklessness.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Warrior.Spells.Recklessness.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Warrior.Spells.Recklessness.CustomChannel.Channel)
					end
					if RSA.db.profile.Warrior.Spells.Recklessness.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Warrior.Spells.Recklessness.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.Recklessness.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Warrior.Spells.Recklessness.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.Recklessness.Party == true then
						if RSA.db.profile.Warrior.Spells.Recklessness.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Warrior.Spells.Recklessness.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.Recklessness.Raid == true then
						if RSA.db.profile.Warrior.Spells.Recklessness.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Warrior.Spells.Recklessness.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- RECKLESSNESS
			if spellID == 12809 then -- CONCUSSION BLOW
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Warrior.Spells.ConcussionBlow.Messages.Start ~= "" then
					if RSA.db.profile.Warrior.Spells.ConcussionBlow.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Warrior.Spells.ConcussionBlow.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.ConcussionBlow.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Warrior.Spells.ConcussionBlow.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Warrior.Spells.ConcussionBlow.CustomChannel.Channel)
					end
					if RSA.db.profile.Warrior.Spells.ConcussionBlow.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Warrior.Spells.ConcussionBlow.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.ConcussionBlow.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Warrior.Spells.ConcussionBlow.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.ConcussionBlow.Party == true then
						if RSA.db.profile.Warrior.Spells.ConcussionBlow.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Warrior.Spells.ConcussionBlow.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.ConcussionBlow.Raid == true then
						if RSA.db.profile.Warrior.Spells.ConcussionBlow.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Warrior.Spells.ConcussionBlow.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- CONCUSSION BLOW
			if spellID == 50720 then -- VIGILANCE
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Warrior.Spells.Vigilance.Messages.Start ~= "" then
					if RSA.db.profile.Warrior.Spells.Vigilance.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Warrior.Spells.Vigilance.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.Vigilance.Whisper == true and dest ~= pName and RSA_Whisperable(destGUID) then
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
						RSA_Print_Whisper(string.gsub(RSA.db.profile.Warrior.Spells.Vigilance.Messages.Start, ".%a+.", RSA_String_Replace), dest)
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					end
					if RSA.db.profile.Warrior.Spells.Vigilance.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Warrior.Spells.Vigilance.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Warrior.Spells.Vigilance.CustomChannel.Channel)
					end
					if RSA.db.profile.Warrior.Spells.Vigilance.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Warrior.Spells.Vigilance.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.Vigilance.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Warrior.Spells.Vigilance.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.Vigilance.Party == true then
						if RSA.db.profile.Warrior.Spells.Vigilance.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Warrior.Spells.Vigilance.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.Vigilance.Raid == true then
						if RSA.db.profile.Warrior.Spells.Vigilance.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Warrior.Spells.Vigilance.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- VIGILANCE
			if spellID == 18498 then -- PUMMEL (GAG ORDER)
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				extraspellinfo = GetSpellInfo(missType)
				extraspellinfolink = GetSpellLink(missType)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[TARSPELL]"] = extraspellinfo, ["[TARLINK]"] = extraspellinfolink,}
				if RSA.db.profile.Warrior.Spells.Pummel.Messages.Gag ~= "" then
					if RSA.db.profile.Warrior.Spells.Pummel.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Warrior.Spells.Pummel.Messages.Gag, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.Pummel.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Warrior.Spells.Pummel.Messages.Gag, ".%a+.", RSA_String_Replace), RSA.db.profile.Warrior.Spells.Pummel.CustomChannel.Channel)
					end
					if RSA.db.profile.Warrior.Spells.Pummel.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Warrior.Spells.Pummel.Messages.Gag, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.Pummel.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Warrior.Spells.Pummel.Messages.Gag, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.Pummel.Party == true then
						if RSA.db.profile.Warrior.Spells.Pummel.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Warrior.Spells.Pummel.Messages.Gag, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.Pummel.Raid == true then
						if RSA.db.profile.Warrior.Spells.Pummel.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Warrior.Spells.Pummel.Messages.Gag, ".%a+.", RSA_String_Replace))
					end
				end
			end -- PUMMEL (GAG ORDER)
		end -- IF EVENT IS SPELL_AURA_APPLIED
		if event == "SPELL_CAST_SUCCESS" then
			if spellID == 871 then -- SHIELD WALL
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Warrior.Spells.ShieldWall.Messages.Start ~= "" then
					if RSA.db.profile.Warrior.Spells.ShieldWall.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Warrior.Spells.ShieldWall.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.ShieldWall.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Warrior.Spells.ShieldWall.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Warrior.Spells.ShieldWall.CustomChannel.Channel)
					end
					if RSA.db.profile.Warrior.Spells.ShieldWall.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Warrior.Spells.ShieldWall.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.ShieldWall.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Warrior.Spells.ShieldWall.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.ShieldWall.Party == true then
						if RSA.db.profile.Warrior.Spells.ShieldWall.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Warrior.Spells.ShieldWall.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.ShieldWall.Raid == true then
						if RSA.db.profile.Warrior.Spells.ShieldWall.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Warrior.Spells.ShieldWall.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- SHIELD WALL
			if spellID == 2565 then -- SHIELD BLOCK
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Warrior.Spells.ShieldBlock.Messages.Start ~= "" then
					if RSA.db.profile.Warrior.Spells.ShieldBlock.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Warrior.Spells.ShieldBlock.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.ShieldBlock.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Warrior.Spells.ShieldBlock.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Warrior.Spells.ShieldBlock.CustomChannel.Channel)
					end
					if RSA.db.profile.Warrior.Spells.ShieldBlock.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Warrior.Spells.ShieldBlock.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.ShieldBlock.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Warrior.Spells.ShieldBlock.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.ShieldBlock.Party == true then
						if RSA.db.profile.Warrior.Spells.ShieldBlock.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Warrior.Spells.ShieldBlock.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.ShieldBlock.Raid == true then
						if RSA.db.profile.Warrior.Spells.ShieldBlock.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Warrior.Spells.ShieldBlock.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- SHIELD BLOCK
			if spellID == 12975 then -- LAST STAND
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Warrior.Spells.LastStand.Messages.Start ~= "" then
					if RSA.db.profile.Warrior.Spells.LastStand.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Warrior.Spells.LastStand.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.LastStand.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Warrior.Spells.LastStand.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Warrior.Spells.LastStand.CustomChannel.Channel)
					end
					if RSA.db.profile.Warrior.Spells.LastStand.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Warrior.Spells.LastStand.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.LastStand.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Warrior.Spells.LastStand.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.LastStand.Party == true then
						if RSA.db.profile.Warrior.Spells.LastStand.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Warrior.Spells.LastStand.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.LastStand.Raid == true then
						if RSA.db.profile.Warrior.Spells.LastStand.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Warrior.Spells.LastStand.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- LAST STAND
			if spellID == 1161 then -- CHALLENGING SHOUT
				RSA_ChallengingShout = false
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Warrior.Spells.ChallengingShout.Messages.Start ~= "" then
					if RSA.db.profile.Warrior.Spells.ChallengingShout.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Warrior.Spells.ChallengingShout.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.ChallengingShout.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Warrior.Spells.ChallengingShout.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Warrior.Spells.ChallengingShout.CustomChannel.Channel)
					end
					if RSA.db.profile.Warrior.Spells.ChallengingShout.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Warrior.Spells.ChallengingShout.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.ChallengingShout.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Warrior.Spells.ChallengingShout.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.ChallengingShout.Party == true then
						if RSA.db.profile.Warrior.Spells.ChallengingShout.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Warrior.Spells.ChallengingShout.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.ChallengingShout.Raid == true then
						if RSA.db.profile.Warrior.Spells.ChallengingShout.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Warrior.Spells.ChallengingShout.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- CHALLENGING SHOUT
			if spellID == 55694 then -- ENRAGED REGENERATION
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Warrior.Spells.EnragedRegeneration.Messages.Start ~= "" then
					if RSA.db.profile.Warrior.Spells.EnragedRegeneration.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Warrior.Spells.EnragedRegeneration.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.EnragedRegeneration.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Warrior.Spells.EnragedRegeneration.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Warrior.Spells.EnragedRegeneration.CustomChannel.Channel)
					end
					if RSA.db.profile.Warrior.Spells.EnragedRegeneration.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Warrior.Spells.EnragedRegeneration.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.EnragedRegeneration.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Warrior.Spells.EnragedRegeneration.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.EnragedRegeneration.Party == true then
						if RSA.db.profile.Warrior.Spells.EnragedRegeneration.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Warrior.Spells.EnragedRegeneration.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.EnragedRegeneration.Raid == true then
						if RSA.db.profile.Warrior.Spells.EnragedRegeneration.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Warrior.Spells.EnragedRegeneration.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- ENRAGED REGENERATION
			if spellID == 97462 then -- RALLYING CRY
				RSA_RallyingCry = false
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Warrior.Spells.RallyingCry.Messages.Start ~= "" then
					if RSA.db.profile.Warrior.Spells.RallyingCry.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Warrior.Spells.RallyingCry.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.RallyingCry.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Warrior.Spells.RallyingCry.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Warrior.Spells.RallyingCry.CustomChannel.Channel)
					end
					if RSA.db.profile.Warrior.Spells.RallyingCry.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Warrior.Spells.RallyingCry.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.RallyingCry.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Warrior.Spells.RallyingCry.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.RallyingCry.Party == true then
						if RSA.db.profile.Warrior.Spells.RallyingCry.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Warrior.Spells.RallyingCry.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.RallyingCry.Raid == true then
						if RSA.db.profile.Warrior.Spells.RallyingCry.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Warrior.Spells.RallyingCry.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- RALLYING CRY
			if spellID == 3411 then -- INTERVENE
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Warrior.Spells.Intervene.Messages.Start ~= "" then
					if RSA.db.profile.Warrior.Spells.Intervene.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Warrior.Spells.Intervene.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.Intervene.Whisper == true and dest ~= pName and RSA_Whisperable(destGUID) then
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
						RSA_Print_Whisper(string.gsub(RSA.db.profile.Warrior.Spells.Intervene.Messages.Start, ".%a+.", RSA_String_Replace), dest)
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					end
					if RSA.db.profile.Warrior.Spells.Intervene.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Warrior.Spells.Intervene.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Warrior.Spells.Intervene.CustomChannel.Channel)
					end
					if RSA.db.profile.Warrior.Spells.Intervene.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Warrior.Spells.Intervene.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.Intervene.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Warrior.Spells.Intervene.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.Intervene.Party == true then
						if RSA.db.profile.Warrior.Spells.Intervene.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Warrior.Spells.Intervene.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.Intervene.Raid == true then
						if RSA.db.profile.Warrior.Spells.Intervene.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Warrior.Spells.Intervene.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- INTERVENE
			if spellID == 20230 then -- RETALIATION
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Warrior.Spells.Retaliation.Messages.Start ~= "" then
					if RSA.db.profile.Warrior.Spells.Retaliation.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Warrior.Spells.Retaliation.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.Retaliation.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Warrior.Spells.Retaliation.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Warrior.Spells.Retaliation.CustomChannel.Channel)
					end
					if RSA.db.profile.Warrior.Spells.Retaliation.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Warrior.Spells.Retaliation.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.Retaliation.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Warrior.Spells.Retaliation.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.Retaliation.Party == true then
						if RSA.db.profile.Warrior.Spells.Retaliation.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Warrior.Spells.Retaliation.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.Retaliation.Raid == true then
						if RSA.db.profile.Warrior.Spells.Retaliation.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Warrior.Spells.Retaliation.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- RETALIATION
		end -- IF EVENT IS SPELL_CAST_SUCCESS
		if event == "SPELL_INTERRUPT" then
			if spellID == 6552 then -- PUMMEL
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				extraspellinfo = GetSpellInfo(missType)
				extraspellinfolink = GetSpellLink(missType)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[TARSPELL]"] = extraspellinfo, ["[TARLINK]"] = extraspellinfolink,}
				if RSA.db.profile.Warrior.Spells.Pummel.Messages.Start ~= "" then
					if RSA.db.profile.Warrior.Spells.Pummel.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Warrior.Spells.Pummel.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.Pummel.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Warrior.Spells.Pummel.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Warrior.Spells.Pummel.CustomChannel.Channel)
					end
					if RSA.db.profile.Warrior.Spells.Pummel.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Warrior.Spells.Pummel.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.Pummel.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Warrior.Spells.Pummel.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.Pummel.Party == true then
						if RSA.db.profile.Warrior.Spells.Pummel.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Warrior.Spells.Pummel.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.Pummel.Raid == true then
						if RSA.db.profile.Warrior.Spells.Pummel.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Warrior.Spells.Pummel.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- PUMMEL
		end -- IF EVENT IS SPELL_INTERRUPT
		if event == "SPELL_AURA_REMOVED" then
			if spellID == 64382 then -- SHATTERING THROW
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Warrior.Spells.ShatteringThrow.Messages.End ~= "" then
					if RSA.db.profile.Warrior.Spells.ShatteringThrow.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Warrior.Spells.ShatteringThrow.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.ShatteringThrow.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Warrior.Spells.ShatteringThrow.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Warrior.Spells.ShatteringThrow.CustomChannel.Channel)
					end
					if RSA.db.profile.Warrior.Spells.ShatteringThrow.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Warrior.Spells.ShatteringThrow.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.ShatteringThrow.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Warrior.Spells.ShatteringThrow.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.ShatteringThrow.Party == true then
						if RSA.db.profile.Warrior.Spells.ShatteringThrow.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Warrior.Spells.ShatteringThrow.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.ShatteringThrow.Raid == true then
						if RSA.db.profile.Warrior.Spells.ShatteringThrow.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Warrior.Spells.ShatteringThrow.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- SHATTERING THROW
			if spellID == 50720 then -- VIGILANCE
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Warrior.Spells.Vigilance.Messages.End ~= "" then
					if RSA.db.profile.Warrior.Spells.Vigilance.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Warrior.Spells.Vigilance.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.Vigilance.Whisper == true and dest ~= pName and RSA_Whisperable(destGUID) then
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
						RSA_Print_Whisper(string.gsub(RSA.db.profile.Warrior.Spells.Vigilance.Messages.End, ".%a+.", RSA_String_Replace), dest)
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					end
					if RSA.db.profile.Warrior.Spells.Vigilance.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Warrior.Spells.Vigilance.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Warrior.Spells.Vigilance.CustomChannel.Channel)
					end
					if RSA.db.profile.Warrior.Spells.Vigilance.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Warrior.Spells.Vigilance.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.Vigilance.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Warrior.Spells.Vigilance.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.Vigilance.Party == true then
						if RSA.db.profile.Warrior.Spells.Vigilance.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Warrior.Spells.Vigilance.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.Vigilance.Raid == true then
						if RSA.db.profile.Warrior.Spells.Vigilance.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Warrior.Spells.Vigilance.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- VIGILANCE
			if spellID == 871 then -- SHIELD WALL
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Warrior.Spells.ShieldWall.Messages.End ~= "" then
					if RSA.db.profile.Warrior.Spells.ShieldWall.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Warrior.Spells.ShieldWall.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.ShieldWall.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Warrior.Spells.ShieldWall.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Warrior.Spells.ShieldWall.CustomChannel.Channel)
					end
					if RSA.db.profile.Warrior.Spells.ShieldWall.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Warrior.Spells.ShieldWall.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.ShieldWall.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Warrior.Spells.ShieldWall.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.ShieldWall.Party == true then
						if RSA.db.profile.Warrior.Spells.ShieldWall.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Warrior.Spells.ShieldWall.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.ShieldWall.Raid == true then
						if RSA.db.profile.Warrior.Spells.ShieldWall.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Warrior.Spells.ShieldWall.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- SHIELD WALL
			if spellID == 12976 then -- LAST STAND
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Warrior.Spells.LastStand.Messages.End ~= "" then
					if RSA.db.profile.Warrior.Spells.LastStand.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Warrior.Spells.LastStand.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.LastStand.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Warrior.Spells.LastStand.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Warrior.Spells.LastStand.CustomChannel.Channel)
					end
					if RSA.db.profile.Warrior.Spells.LastStand.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Warrior.Spells.LastStand.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.LastStand.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Warrior.Spells.LastStand.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.LastStand.Party == true then
						if RSA.db.profile.Warrior.Spells.LastStand.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Warrior.Spells.LastStand.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.LastStand.Raid == true then
						if RSA.db.profile.Warrior.Spells.LastStand.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Warrior.Spells.LastStand.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- LAST STAND
			if spellID == 676 then -- DISARM
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Warrior.Spells.Disarm.Messages.End ~= "" then
					if RSA.db.profile.Warrior.Spells.Disarm.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Warrior.Spells.Disarm.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.Disarm.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Warrior.Spells.Disarm.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Warrior.Spells.Disarm.CustomChannel.Channel)
					end
					if RSA.db.profile.Warrior.Spells.Disarm.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Warrior.Spells.Disarm.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.Disarm.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Warrior.Spells.Disarm.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.Disarm.Party == true then
						if RSA.db.profile.Warrior.Spells.Disarm.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Warrior.Spells.Disarm.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.Disarm.Raid == true then
						if RSA.db.profile.Warrior.Spells.Disarm.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Warrior.Spells.Disarm.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- DISARM
			if spellID == 55694 then -- ENRAGED REGENERATION
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Warrior.Spells.EnragedRegeneration.Messages.End ~= "" then
					if RSA.db.profile.Warrior.Spells.EnragedRegeneration.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Warrior.Spells.EnragedRegeneration.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.EnragedRegeneration.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Warrior.Spells.EnragedRegeneration.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Warrior.Spells.EnragedRegeneration.CustomChannel.Channel)
					end
					if RSA.db.profile.Warrior.Spells.EnragedRegeneration.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Warrior.Spells.EnragedRegeneration.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.EnragedRegeneration.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Warrior.Spells.EnragedRegeneration.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.EnragedRegeneration.Party == true then
						if RSA.db.profile.Warrior.Spells.EnragedRegeneration.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Warrior.Spells.EnragedRegeneration.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.EnragedRegeneration.Raid == true then
						if RSA.db.profile.Warrior.Spells.EnragedRegeneration.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Warrior.Spells.EnragedRegeneration.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- ENRAGED REGENERATION
			if spellID == 2565 then -- SHIELD BLOCK
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Warrior.Spells.ShieldBlock.Messages.End ~= "" then
					if RSA.db.profile.Warrior.Spells.ShieldBlock.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Warrior.Spells.ShieldBlock.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.ShieldBlock.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Warrior.Spells.ShieldBlock.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Warrior.Spells.ShieldBlock.CustomChannel.Channel)
					end
					if RSA.db.profile.Warrior.Spells.ShieldBlock.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Warrior.Spells.ShieldBlock.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.ShieldBlock.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Warrior.Spells.ShieldBlock.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.ShieldBlock.Party == true then
						if RSA.db.profile.Warrior.Spells.ShieldBlock.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Warrior.Spells.ShieldBlock.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.ShieldBlock.Raid == true then
						if RSA.db.profile.Warrior.Spells.ShieldBlock.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Warrior.Spells.ShieldBlock.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- SHIELD BLOCK
			if spellID == 85388 then -- THROWDOWN
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Warrior.Spells.Throwdown.Messages.End ~= "" then
					if RSA.db.profile.Warrior.Spells.Throwdown.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Warrior.Spells.Throwdown.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.Throwdown.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Warrior.Spells.Throwdown.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Warrior.Spells.Throwdown.CustomChannel.Channel)
					end
					if RSA.db.profile.Warrior.Spells.Throwdown.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Warrior.Spells.Throwdown.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.Throwdown.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Warrior.Spells.Throwdown.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.Throwdown.Party == true then
						if RSA.db.profile.Warrior.Spells.Throwdown.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Warrior.Spells.Throwdown.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.Throwdown.Raid == true then
						if RSA.db.profile.Warrior.Spells.Throwdown.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Warrior.Spells.Throwdown.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- THROWDOWN
			if spellID == 1719 then -- RECKLESSNESS
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Warrior.Spells.Recklessness.Messages.End ~= "" then
					if RSA.db.profile.Warrior.Spells.Recklessness.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Warrior.Spells.Recklessness.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.Recklessness.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Warrior.Spells.Recklessness.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Warrior.Spells.Recklessness.CustomChannel.Channel)
					end
					if RSA.db.profile.Warrior.Spells.Recklessness.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Warrior.Spells.Recklessness.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.Recklessness.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Warrior.Spells.Recklessness.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.Recklessness.Party == true then
						if RSA.db.profile.Warrior.Spells.Recklessness.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Warrior.Spells.Recklessness.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.Recklessness.Raid == true then
						if RSA.db.profile.Warrior.Spells.Recklessness.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Warrior.Spells.Recklessness.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- RECKLESSNESS
			if spellID == 12809 then -- CONCUSSION BLOW
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Warrior.Spells.ConcussionBlow.Messages.End ~= "" then
					if RSA.db.profile.Warrior.Spells.ConcussionBlow.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Warrior.Spells.ConcussionBlow.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.ConcussionBlow.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Warrior.Spells.ConcussionBlow.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Warrior.Spells.ConcussionBlow.CustomChannel.Channel)
					end
					if RSA.db.profile.Warrior.Spells.ConcussionBlow.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Warrior.Spells.ConcussionBlow.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.ConcussionBlow.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Warrior.Spells.ConcussionBlow.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.ConcussionBlow.Party == true then
						if RSA.db.profile.Warrior.Spells.ConcussionBlow.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Warrior.Spells.ConcussionBlow.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.ConcussionBlow.Raid == true then
						if RSA.db.profile.Warrior.Spells.ConcussionBlow.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Warrior.Spells.ConcussionBlow.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- CONCUSSION BLOW
			if spellID == 97463 and RSA_RallyingCry == false then -- RALLYING CRY
				RSA_RallyingCry = true
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Warrior.Spells.RallyingCry.Messages.End ~= "" then
					if RSA.db.profile.Warrior.Spells.RallyingCry.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Warrior.Spells.RallyingCry.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.RallyingCry.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Warrior.Spells.RallyingCry.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Warrior.Spells.RallyingCry.CustomChannel.Channel)
					end
					if RSA.db.profile.Warrior.Spells.RallyingCry.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Warrior.Spells.RallyingCry.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.RallyingCry.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Warrior.Spells.RallyingCry.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.RallyingCry.Party == true then
						if RSA.db.profile.Warrior.Spells.RallyingCry.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Warrior.Spells.RallyingCry.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.RallyingCry.Raid == true then
						if RSA.db.profile.Warrior.Spells.RallyingCry.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Warrior.Spells.RallyingCry.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- RALLYING CRY
			if spellID == 1161 and RSA_ChallengingShout == false then -- CHALLENGING SHOUT
				RSA_ChallengingShout = true
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Warrior.Spells.ChallengingShout.Messages.End ~= "" then
					if RSA.db.profile.Warrior.Spells.ChallengingShout.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Warrior.Spells.ChallengingShout.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.ChallengingShout.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Warrior.Spells.ChallengingShout.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Warrior.Spells.ChallengingShout.CustomChannel.Channel)
					end
					if RSA.db.profile.Warrior.Spells.ChallengingShout.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Warrior.Spells.ChallengingShout.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.ChallengingShout.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Warrior.Spells.ChallengingShout.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.ChallengingShout.Party == true then
						if RSA.db.profile.Warrior.Spells.ChallengingShout.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Warrior.Spells.ChallengingShout.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.ChallengingShout.Raid == true then
						if RSA.db.profile.Warrior.Spells.ChallengingShout.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Warrior.Spells.ChallengingShout.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- CHALLENGING SHOUT
			if spellID == 20230 then -- RETALIATION
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Warrior.Spells.Retaliation.Messages.End ~= "" then
					if RSA.db.profile.Warrior.Spells.Retaliation.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Warrior.Spells.Retaliation.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.Retaliation.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Warrior.Spells.Retaliation.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Warrior.Spells.Retaliation.CustomChannel.Channel)
					end
					if RSA.db.profile.Warrior.Spells.Retaliation.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Warrior.Spells.Retaliation.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.Retaliation.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Warrior.Spells.Retaliation.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.Retaliation.Party == true then
						if RSA.db.profile.Warrior.Spells.Retaliation.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Warrior.Spells.Retaliation.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.Retaliation.Raid == true then
						if RSA.db.profile.Warrior.Spells.Retaliation.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Warrior.Spells.Retaliation.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- RETALIATION
		end -- IF EVENT IS SPELL_AURA_REMOVED
		if event == "SPELL_DISPEL" then
			if spellID == 23922 then -- SHIELD SLAM DISPEL
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				extraspellinfo = GetSpellInfo(missType)
				extraspellinfolink = GetSpellLink(missType)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[AURA]"] = extraspellinfo, ["[AURALINK]"] = extraspellinfolink,}
				if RSA.db.profile.Warrior.Spells.ShieldSlamDispel.Messages.Start ~= "" then
					if RSA.db.profile.Warrior.Spells.ShieldSlamDispel.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Warrior.Spells.ShieldSlamDispel.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.ShieldSlamDispel.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Warrior.Spells.ShieldSlamDispel.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Warrior.Spells.ShieldSlamDispel.CustomChannel.Channel)
					end
					if RSA.db.profile.Warrior.Spells.ShieldSlamDispel.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Warrior.Spells.ShieldSlamDispel.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.ShieldSlamDispel.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Warrior.Spells.ShieldSlamDispel.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.ShieldSlamDispel.Party == true then
						if RSA.db.profile.Warrior.Spells.ShieldSlamDispel.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Warrior.Spells.ShieldSlamDispel.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.ShieldSlamDispel.Raid == true then
						if RSA.db.profile.Warrior.Spells.ShieldSlamDispel.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Warrior.Spells.ShieldSlamDispel.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- SHIELD SLAM DISPEL
		end -- IF EVENT IS SPELL_DISPEL
		if event == "SPELL_DISPEL_FAILED" then
			if spellID == 23922 then -- SHIELD SLAM DISPEL
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				extraspellinfo = GetSpellInfo(missType)
				extraspellinfolink = GetSpellLink(missType)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[AURA]"] = extraspellinfo, ["[AURALINK]"] = extraspellinfolink,}
				if RSA.db.profile.Warrior.Spells.ShieldSlamDispel.Messages.End ~= "" then
					if RSA.db.profile.Warrior.Spells.ShieldSlamDispel.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Warrior.Spells.ShieldSlamDispel.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.ShieldSlamDispel.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Warrior.Spells.ShieldSlamDispel.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Warrior.Spells.ShieldSlamDispel.CustomChannel.Channel)
					end
					if RSA.db.profile.Warrior.Spells.ShieldSlamDispel.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Warrior.Spells.ShieldSlamDispel.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.ShieldSlamDispel.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Warrior.Spells.ShieldSlamDispel.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.ShieldSlamDispel.Party == true then
						if RSA.db.profile.Warrior.Spells.ShieldSlamDispel.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Warrior.Spells.ShieldSlamDispel.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.ShieldSlamDispel.Raid == true then
						if RSA.db.profile.Warrior.Spells.ShieldSlamDispel.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Warrior.Spells.ShieldSlamDispel.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- SHIELD SLAM DISPEL
		end -- IF EVENT IS SPELL_DISPEL_FAILED
		if event == "SPELL_MISSED" and missType ~= "IMMUNE" then
			if spellID == 355 then -- TAUNT
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				if missType == "MISS" then
					missinfo = L["missed"]
				elseif missType ~= "MISS" then
					missinfo = L["was resisted by"]
				end
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = missinfo,}
				if RSA.db.profile.Warrior.Spells.Taunt.Messages.End ~= "" then
					if RSA.db.profile.Warrior.Spells.Taunt.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Warrior.Spells.Taunt.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.Taunt.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Warrior.Spells.Taunt.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Warrior.Spells.Taunt.CustomChannel.Channel)
					end
					if RSA.db.profile.Warrior.Spells.Taunt.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Warrior.Spells.Taunt.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.Taunt.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Warrior.Spells.Taunt.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.Taunt.Party == true then
						if RSA.db.profile.Warrior.Spells.Taunt.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Warrior.Spells.Taunt.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.Taunt.Raid == true then
						if RSA.db.profile.Warrior.Spells.Taunt.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Warrior.Spells.Taunt.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- TAUNT
			if spellID == 6552 then -- PUMMEL
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				if missType == "MISS" then
					missinfo = L["missed"]
				elseif missType ~= "MISS" then
					missinfo = L["was resisted by"]
				end
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = missinfo,}
				if RSA.db.profile.Warrior.Spells.Pummel.Messages.End ~= "" then
					if RSA.db.profile.Warrior.Spells.Pummel.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Warrior.Spells.Pummel.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.Pummel.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Warrior.Spells.Pummel.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Warrior.Spells.Pummel.CustomChannel.Channel)
					end
					if RSA.db.profile.Warrior.Spells.Pummel.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Warrior.Spells.Pummel.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.Pummel.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Warrior.Spells.Pummel.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.Pummel.Party == true then
						if RSA.db.profile.Warrior.Spells.Pummel.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Warrior.Spells.Pummel.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.Pummel.Raid == true then
						if RSA.db.profile.Warrior.Spells.Pummel.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Warrior.Spells.Pummel.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- PUMMEL
		end -- IF EVENT IS SPELL_MISSED AND NOT IMMUNE
		if event == "SPELL_MISSED" and missType == "IMMUNE" then
			if spellID == 355 then -- TAUNT
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = L["Immune"],}
				if RSA.db.profile.Warrior.Spells.Taunt.Messages.Immune ~= "" then
					if RSA.db.profile.Warrior.Spells.Taunt.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Warrior.Spells.Taunt.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.Taunt.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Warrior.Spells.Taunt.Messages.Immune, ".%a+.", RSA_String_Replace), RSA.db.profile.Warrior.Spells.Taunt.CustomChannel.Channel)
					end
					if RSA.db.profile.Warrior.Spells.Taunt.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Warrior.Spells.Taunt.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.Taunt.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Warrior.Spells.Taunt.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.Taunt.Party == true then
						if RSA.db.profile.Warrior.Spells.Taunt.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Warrior.Spells.Taunt.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.Taunt.Raid == true then
						if RSA.db.profile.Warrior.Spells.Taunt.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Warrior.Spells.Taunt.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
				end
			end -- TAUNT
			if spellID == 6552 then -- PUMMEL
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = L["Immune"],}
				if RSA.db.profile.Warrior.Spells.Pummel.Messages.Immune ~= "" then
					if RSA.db.profile.Warrior.Spells.Pummel.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Warrior.Spells.Pummel.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.Pummel.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Warrior.Spells.Pummel.Messages.Immune, ".%a+.", RSA_String_Replace), RSA.db.profile.Warrior.Spells.Pummel.CustomChannel.Channel)
					end
					if RSA.db.profile.Warrior.Spells.Pummel.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Warrior.Spells.Pummel.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.Pummel.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Warrior.Spells.Pummel.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.Pummel.Party == true then
						if RSA.db.profile.Warrior.Spells.Pummel.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Warrior.Spells.Pummel.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.Pummel.Raid == true then
						if RSA.db.profile.Warrior.Spells.Pummel.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Warrior.Spells.Pummel.Messages.Immune, ".%a+.", RSA_String_Replace))
					end
				end
			end -- PUMMEL
		end -- IF EVENT IS SPELL_MISSED AND IS IMMUNE
	end -- IF SOURCE IS PLAYER
end -- END ENTIRELY
RSA_CombatLogMonitor:SetScript("OnEvent", Warrior_Spells)
end -- END ON ENABLED
function RSA_Warrior:OnDisable()
RSA_CombatLogMonitor:SetScript("OnEvent", nil)
end