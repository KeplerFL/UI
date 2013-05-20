-----------------------------------------------
---- Raeli's Spell Announcer Priest Module ----
-----------------------------------------------
local RSA = LibStub("AceAddon-3.0"):GetAddon("RSA")
local L = LibStub("AceLocale-3.0"):GetLocale("RSA")
local RSA_Priest = RSA:NewModule("Priest")
function RSA_Priest:OnInitialize()
	if RSA.db.profile.General.Class == "PRIEST" then
		RSA_Priest:SetEnabledState(true)
	else
		RSA_Priest:SetEnabledState(false)
	end
end -- End OnInitialize
function RSA_Priest:OnEnable()
local spellinfo
local spelllinkinfo
local extraspellinfo
local extraspellinfolink
RSA.db.profile.Modules.Priest = true -- Set state to loaded, to know if we should announce when a spell is refreshed.
local pName = UnitName("player")
local RSA_Silenced = false -- If we Interrupt and Silence our target, it will fire two events, both of which have announcements linked, this variable is to stop that.
local RSA_GSTimer = CreateFrame("Frame", "RSA:GSTimer")
local GSTimeElapsed = 0.0
local RSA_GuardianSpiritProcced = false
local RSA_PsychicScream = false
local RSA_Lightwell = 10
local ResTarget = L["Unknown"]
local Ressed
local function Priest_Spells(_, _, _, event, _, _, source, _, _, destGUID, dest, _, _, spellID, spellName, _, missType)
	local petName = UnitName("pet")
	if source == pName or source == petName then
		if (event == "SPELL_CAST_SUCCESS" and RSA.db.profile.Modules.Reminders_Loaded == true) then -- Reminder Refreshed
			local ReminderSpell = RSA.db.profile.Priest.Reminders.SpellName
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
			if spellID == 9484 then -- SHACKLE UNDEAD
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Priest.Spells.ShackleUndead.Messages.Start ~= "" then
					if RSA.db.profile.Priest.Spells.ShackleUndead.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Priest.Spells.ShackleUndead.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.ShackleUndead.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Priest.Spells.ShackleUndead.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Priest.Spells.ShackleUndead.CustomChannel.Channel)
					end
					if RSA.db.profile.Priest.Spells.ShackleUndead.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Priest.Spells.ShackleUndead.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.ShackleUndead.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Priest.Spells.ShackleUndead.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.ShackleUndead.Party == true then
						if RSA.db.profile.Priest.Spells.ShackleUndead.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Priest.Spells.ShackleUndead.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.ShackleUndead.Raid == true then
						if RSA.db.profile.Priest.Spells.ShackleUndead.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Priest.Spells.ShackleUndead.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- SHACKLE UNDEAD
			if spellID == 453 then -- MIND SOOTHE
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Priest.Spells.MindSoothe.Messages.Start ~= "" then
					if RSA.db.profile.Priest.Spells.MindSoothe.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Priest.Spells.MindSoothe.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.MindSoothe.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Priest.Spells.MindSoothe.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Priest.Spells.MindSoothe.CustomChannel.Channel)
					end
					if RSA.db.profile.Priest.Spells.MindSoothe.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Priest.Spells.MindSoothe.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.MindSoothe.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Priest.Spells.MindSoothe.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.MindSoothe.Party == true then
						if RSA.db.profile.Priest.Spells.MindSoothe.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Priest.Spells.MindSoothe.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.MindSoothe.Raid == true then
						if RSA.db.profile.Priest.Spells.MindSoothe.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Priest.Spells.MindSoothe.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- MIND SOOTHE
			if spellID == 605 and dest ~= pName then -- MIND CONTROL
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Priest.Spells.MindControl.Messages.Start ~= "" then
					if RSA.db.profile.Priest.Spells.MindControl.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Priest.Spells.MindControl.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.MindControl.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Priest.Spells.MindControl.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Priest.Spells.MindControl.CustomChannel.Channel)
					end
					if RSA.db.profile.Priest.Spells.MindControl.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Priest.Spells.MindControl.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.MindControl.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Priest.Spells.MindControl.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.MindControl.Party == true then
						if RSA.db.profile.Priest.Spells.MindControl.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Priest.Spells.MindControl.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.MindControl.Raid == true then
						if RSA.db.profile.Priest.Spells.MindControl.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Priest.Spells.MindControl.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- MIND CONTROL
			if spellID == 7001 then -- LIGHTWELL RENEW
				RSA_Lightwell = RSA_Lightwell - 1
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[AMOUNT]"] = RSA_Lightwell,}
				if RSA.db.profile.Priest.Spells.LightwellRenew.Messages.Start ~= "" then
					if RSA.db.profile.Priest.Spells.LightwellRenew.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Priest.Spells.LightwellRenew.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.LightwellRenew.Whisper == true and dest ~= pName and RSA_Whisperable(destGUID) then
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"], ["[AMOUNT]"] = RSA_Lightwell,}
						RSA_Print_Whisper(string.gsub(RSA.db.profile.Priest.Spells.LightwellRenew.Messages.Start, ".%a+.", RSA_String_Replace), dest)
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[AMOUNT]"] = RSA_Lightwell,}
					end
					if RSA.db.profile.Priest.Spells.LightwellRenew.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Priest.Spells.LightwellRenew.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Priest.Spells.LightwellRenew.CustomChannel.Channel)
					end
					if RSA.db.profile.Priest.Spells.LightwellRenew.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Priest.Spells.LightwellRenew.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.LightwellRenew.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Priest.Spells.LightwellRenew.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.LightwellRenew.Party == true then
						if RSA.db.profile.Priest.Spells.LightwellRenew.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Priest.Spells.LightwellRenew.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.LightwellRenew.Raid == true then
						if RSA.db.profile.Priest.Spells.LightwellRenew.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Priest.Spells.LightwellRenew.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- LIGHTWELL RENEW
			if spellID == 15487 and RSA_Silenced == false then -- SILENCE
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Silenced = true
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Priest.Spells.Silence.Messages.Debuff ~= "" then
					if RSA.db.profile.Priest.Spells.Silence.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Priest.Spells.Silence.Messages.Debuff, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.Silence.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Priest.Spells.Silence.Messages.Debuff, ".%a+.", RSA_String_Replace), RSA.db.profile.Priest.Spells.Silence.CustomChannel.Channel)
					end
					if RSA.db.profile.Priest.Spells.Silence.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Priest.Spells.Silence.Messages.Debuff, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.Silence.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Priest.Spells.Silence.Messages.Debuff, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.Silence.Party == true then
						if RSA.db.profile.Priest.Spells.Silence.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Priest.Spells.Silence.Messages.Debuff, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.Silence.Raid == true then
						if RSA.db.profile.Priest.Spells.Silence.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Priest.Spells.Silence.Messages.Debuff, ".%a+.", RSA_String_Replace))
					end
				end
			end -- SILENCE
			if spellID == 64128 or spellID == 65081 then -- BODY AND SOUL
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Priest.Spells.BodyAndSoul.Messages.Start ~= "" then
					if RSA.db.profile.Priest.Spells.BodyAndSoul.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Priest.Spells.BodyAndSoul.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.BodyAndSoul.Whisper == true and dest ~= pName and RSA_Whisperable(destGUID) then
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
						RSA_Print_Whisper(string.gsub(RSA.db.profile.Priest.Spells.BodyAndSoul.Messages.Start, ".%a+.", RSA_String_Replace), dest)
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					end
					if RSA.db.profile.Priest.Spells.BodyAndSoul.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Priest.Spells.BodyAndSoul.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Priest.Spells.BodyAndSoul.CustomChannel.Channel)
					end
					if RSA.db.profile.Priest.Spells.BodyAndSoul.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Priest.Spells.BodyAndSoul.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.BodyAndSoul.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Priest.Spells.BodyAndSoul.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.BodyAndSoul.Party == true then
						if RSA.db.profile.Priest.Spells.BodyAndSoul.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Priest.Spells.BodyAndSoul.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.BodyAndSoul.Raid == true then
						if RSA.db.profile.Priest.Spells.BodyAndSoul.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Priest.Spells.BodyAndSoul.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- BODY AND SOUL
		end -- IF EVENT IS SPELL_AURA_APPLIED
		if event == "SPELL_AURA_REFRESH" then
			if spellID == 7001 then -- LIGHTWELL RENEW
				RSA_Lightwell = RSA_Lightwell - 1
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[AMOUNT]"] = RSA_Lightwell,}
				if RSA.db.profile.Priest.Spells.LightwellRenew.Messages.End ~= "" then
					if RSA.db.profile.Priest.Spells.LightwellRenew.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Priest.Spells.LightwellRenew.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.LightwellRenew.Whisper == true and dest ~= pName and RSA_Whisperable(destGUID) then
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"], ["[AMOUNT]"] = RSA_Lightwell,}
						RSA_Print_Whisper(string.gsub(RSA.db.profile.Priest.Spells.LightwellRenew.Messages.End, ".%a+.", RSA_String_Replace), dest)
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[AMOUNT]"] = RSA_Lightwell,}
					end
					if RSA.db.profile.Priest.Spells.LightwellRenew.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Priest.Spells.LightwellRenew.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Priest.Spells.LightwellRenew.CustomChannel.Channel)
					end
					if RSA.db.profile.Priest.Spells.LightwellRenew.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Priest.Spells.LightwellRenew.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.LightwellRenew.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Priest.Spells.LightwellRenew.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.LightwellRenew.Party == true then
						if RSA.db.profile.Priest.Spells.LightwellRenew.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Priest.Spells.LightwellRenew.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.LightwellRenew.Raid == true then
						if RSA.db.profile.Priest.Spells.LightwellRenew.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Priest.Spells.LightwellRenew.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- LIGHTWELL RENEW
		end -- IF EVENT IS SPELL_AURA_REFRESH
		--[[if event == "SPELL_CAST_START" then
			if spellID == 605 and dest ~= pName then -- MIND CONTROL
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				if dest == nil or dest == "" then
					if UnitExists("mouseover") then
						dest = UnitName("mouseover")
					elseif UnitExists("target") then
						dest = UnitName("target")
					elseif UnitExists("focus") then
						dest = UnitName("focus")
					else
						dest = UnitName("none")
					end
				end
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Priest.Spells.MindControl.Messages.Casting ~= "" then
					if RSA.db.profile.Priest.Spells.MindControl.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Priest.Spells.MindControl.Messages.Casting, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.MindControl.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Priest.Spells.MindControl.Messages.Casting, ".%a+.", RSA_String_Replace), RSA.db.profile.Priest.Spells.MindControl.CustomChannel.Channel)
					end
					if RSA.db.profile.Priest.Spells.MindControl.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Priest.Spells.MindControl.Messages.Casting, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.MindControl.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Priest.Spells.MindControl.Messages.Casting, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.MindControl.Party == true then
						if RSA.db.profile.Priest.Spells.MindControl.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Priest.Spells.MindControl.Messages.Casting, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.MindControl.Raid == true then
						if RSA.db.profile.Priest.Spells.MindControl.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Priest.Spells.MindControl.Messages.Casting, ".%a+.", RSA_String_Replace))
					end
				end
			end -- MIND CONTROL
		end -- IF EVENT IS SPELL_CAST_START]]--
		if event == "SPELL_CAST_SUCCESS" then
			if spellID == 73325 then -- LEAP OF FAITH
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Priest.Spells.LeapOfFaith.Messages.Start ~= "" then
					if RSA.db.profile.Priest.Spells.LeapOfFaith.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Priest.Spells.LeapOfFaith.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.LeapOfFaith.Whisper == true and dest ~= pName and RSA_Whisperable(destGUID) then
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
						RSA_Print_Whisper(string.gsub(RSA.db.profile.Priest.Spells.LeapOfFaith.Messages.Start, ".%a+.", RSA_String_Replace), dest)
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					end
					if RSA.db.profile.Priest.Spells.LeapOfFaith.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Priest.Spells.LeapOfFaith.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Priest.Spells.LeapOfFaith.CustomChannel.Channel)
					end
					if RSA.db.profile.Priest.Spells.LeapOfFaith.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Priest.Spells.LeapOfFaith.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.LeapOfFaith.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Priest.Spells.LeapOfFaith.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.LeapOfFaith.Party == true then
						if RSA.db.profile.Priest.Spells.LeapOfFaith.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Priest.Spells.LeapOfFaith.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.LeapOfFaith.Raid == true then
						if RSA.db.profile.Priest.Spells.LeapOfFaith.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Priest.Spells.LeapOfFaith.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- LEAP OF FAITH
			if spellID == 64843 then -- DIVINE HYMN
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Priest.Spells.DivineHymn.Messages.Start ~= "" then
					if RSA.db.profile.Priest.Spells.DivineHymn.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Priest.Spells.DivineHymn.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.DivineHymn.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Priest.Spells.DivineHymn.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Priest.Spells.DivineHymn.CustomChannel.Channel)
					end
					if RSA.db.profile.Priest.Spells.DivineHymn.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Priest.Spells.DivineHymn.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.DivineHymn.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Priest.Spells.DivineHymn.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.DivineHymn.Party == true then
						if RSA.db.profile.Priest.Spells.DivineHymn.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Priest.Spells.DivineHymn.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.DivineHymn.Raid == true then
						if RSA.db.profile.Priest.Spells.DivineHymn.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Priest.Spells.DivineHymn.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- DIVINE HYMN
			if spellID == 64901 then -- HYMN OF HOPE
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Priest.Spells.HymnOfHope.Messages.Start ~= "" then
					if RSA.db.profile.Priest.Spells.HymnOfHope.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Priest.Spells.HymnOfHope.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.HymnOfHope.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Priest.Spells.HymnOfHope.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Priest.Spells.HymnOfHope.CustomChannel.Channel)
					end
					if RSA.db.profile.Priest.Spells.HymnOfHope.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Priest.Spells.HymnOfHope.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.HymnOfHope.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Priest.Spells.HymnOfHope.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.HymnOfHope.Party == true then
						if RSA.db.profile.Priest.Spells.HymnOfHope.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Priest.Spells.HymnOfHope.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.HymnOfHope.Raid == true then
						if RSA.db.profile.Priest.Spells.HymnOfHope.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Priest.Spells.HymnOfHope.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- HYMN OF HOPE
			if spellID == 6346 then -- FEAR WARD
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Priest.Spells.FearWard.Messages.Start ~= "" then
					if RSA.db.profile.Priest.Spells.FearWard.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Priest.Spells.FearWard.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.FearWard.Whisper == true and dest ~= pName and RSA_Whisperable(destGUID) then
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
						RSA_Print_Whisper(string.gsub(RSA.db.profile.Priest.Spells.FearWard.Messages.Start, ".%a+.", RSA_String_Replace), dest)
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					end
					if RSA.db.profile.Priest.Spells.FearWard.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Priest.Spells.FearWard.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Priest.Spells.FearWard.CustomChannel.Channel)
					end
					if RSA.db.profile.Priest.Spells.FearWard.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Priest.Spells.FearWard.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.FearWard.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Priest.Spells.FearWard.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.FearWard.Party == true then
						if RSA.db.profile.Priest.Spells.FearWard.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Priest.Spells.FearWard.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.FearWard.Raid == true then
						if RSA.db.profile.Priest.Spells.FearWard.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Priest.Spells.FearWard.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- FEAR WARD
			if spellID == 1706 then -- LEVITATE
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Priest.Spells.Levitate.Messages.Start ~= "" then
					if RSA.db.profile.Priest.Spells.Levitate.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Priest.Spells.Levitate.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.Levitate.Whisper == true and dest ~= pName and RSA_Whisperable(destGUID) then
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
						RSA_Print_Whisper(string.gsub(RSA.db.profile.Priest.Spells.Levitate.Messages.Start, ".%a+.", RSA_String_Replace), dest)
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					end
					if RSA.db.profile.Priest.Spells.Levitate.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Priest.Spells.Levitate.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Priest.Spells.Levitate.CustomChannel.Channel)
					end
					if RSA.db.profile.Priest.Spells.Levitate.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Priest.Spells.Levitate.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.Levitate.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Priest.Spells.Levitate.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.Levitate.Party == true then
						if RSA.db.profile.Priest.Spells.Levitate.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Priest.Spells.Levitate.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.Levitate.Raid == true then
						if RSA.db.profile.Priest.Spells.Levitate.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Priest.Spells.Levitate.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- LEVITATE
			if spellID == 47788 then -- GUARDIAN SPIRIT WITH TIMER
				RSA_GuardianSpiritProcced = false
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Priest.Spells.GuardianSpirit.Messages.Start ~= "" then
					if RSA.db.profile.Priest.Spells.GuardianSpirit.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Priest.Spells.GuardianSpirit.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.GuardianSpirit.Whisper == true and dest ~= pName and RSA_Whisperable(destGUID) then
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
						RSA_Print_Whisper(string.gsub(RSA.db.profile.Priest.Spells.GuardianSpirit.Messages.Start, ".%a+.", RSA_String_Replace), dest)
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					end
					if RSA.db.profile.Priest.Spells.GuardianSpirit.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Priest.Spells.GuardianSpirit.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Priest.Spells.GuardianSpirit.CustomChannel.Channel)
					end
					if RSA.db.profile.Priest.Spells.GuardianSpirit.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Priest.Spells.GuardianSpirit.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.GuardianSpirit.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Priest.Spells.GuardianSpirit.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.GuardianSpirit.Party == true then
						if RSA.db.profile.Priest.Spells.GuardianSpirit.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Priest.Spells.GuardianSpirit.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.GuardianSpirit.Raid == true then
						if RSA.db.profile.Priest.Spells.GuardianSpirit.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Priest.Spells.GuardianSpirit.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
				if RSA.db.profile.Priest.Spells.GuardianSpirit.Messages.End ~= "" then
					GSTimeElapsed = 0.0 -- Start Guardian Spirit Timer for end announcement.
					local function GSTimer(self, elapsed)
						GSTimeElapsed = GSTimeElapsed + elapsed
						if GSTimeElapsed < 10.5 then return end
						if RSA_GuardianSpiritProcced == true then
							RSA_GSTimer:SetScript("OnUpdate", nil)
						return end
						GSTimeElapsed = GSTimeElapsed - floor(GSTimeElapsed)
						spellinfo = GetSpellInfo(spellID)
						spelllinkinfo = GetSpellLink(spellID)
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
						if RSA.db.profile.Priest.Spells.GuardianSpirit.Local == true then
							RSA_Print_LibSink(string.gsub(RSA.db.profile.Priest.Spells.GuardianSpirit.Messages.End, ".%a+.", RSA_String_Replace))
						end
						if RSA.db.profile.Priest.Spells.GuardianSpirit.Whisper == true and dest ~= pName and RSA_Whisperable(destGUID) then
							RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
							RSA_Print_Whisper(string.gsub(RSA.db.profile.Priest.Spells.GuardianSpirit.Messages.End, ".%a+.", RSA_String_Replace), dest)
							RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
						end
						if RSA.db.profile.Priest.Spells.GuardianSpirit.CustomChannel.Enabled == true then
							RSA_Print_Channel(string.gsub(RSA.db.profile.Priest.Spells.GuardianSpirit.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Priest.Spells.GuardianSpirit.CustomChannel.Channel)
						end
						if RSA.db.profile.Priest.Spells.GuardianSpirit.Smart.Say == true then
							RSA_Print_Say(string.gsub(RSA.db.profile.Priest.Spells.GuardianSpirit.Messages.End, ".%a+.", RSA_String_Replace))
						end
						if RSA.db.profile.Priest.Spells.GuardianSpirit.Smart.RaidParty == true then
							RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Priest.Spells.GuardianSpirit.Messages.End, ".%a+.", RSA_String_Replace))
						end
						if RSA.db.profile.Priest.Spells.GuardianSpirit.Party == true then
							if RSA.db.profile.Priest.Spells.GuardianSpirit.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
								RSA_Print_Party(string.gsub(RSA.db.profile.Priest.Spells.GuardianSpirit.Messages.End, ".%a+.", RSA_String_Replace))
						end
						if RSA.db.profile.Priest.Spells.GuardianSpirit.Raid == true then
							if RSA.db.profile.Priest.Spells.GuardianSpirit.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
							RSA_Print_Raid(string.gsub(RSA.db.profile.Priest.Spells.GuardianSpirit.Messages.End, ".%a+.", RSA_String_Replace))
						end
						RSA_GSTimer:SetScript("OnUpdate", nil)
					end
				RSA_GSTimer:SetScript("OnUpdate", GSTimer)
				end
			end -- GUARDIAN SPIRIT
			if spellID == 33206 then -- PAIN SUPPRESSION
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Priest.Spells.PainSuppression.Messages.Start ~= "" then
					if RSA.db.profile.Priest.Spells.PainSuppression.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Priest.Spells.PainSuppression.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.PainSuppression.Whisper == true and dest ~= pName and RSA_Whisperable(destGUID) then
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
						RSA_Print_Whisper(string.gsub(RSA.db.profile.Priest.Spells.PainSuppression.Messages.Start, ".%a+.", RSA_String_Replace), dest)
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					end
					if RSA.db.profile.Priest.Spells.PainSuppression.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Priest.Spells.PainSuppression.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Priest.Spells.PainSuppression.CustomChannel.Channel)
					end
					if RSA.db.profile.Priest.Spells.PainSuppression.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Priest.Spells.PainSuppression.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.PainSuppression.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Priest.Spells.PainSuppression.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.PainSuppression.Party == true then
						if RSA.db.profile.Priest.Spells.PainSuppression.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Priest.Spells.PainSuppression.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.PainSuppression.Raid == true then
						if RSA.db.profile.Priest.Spells.PainSuppression.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Priest.Spells.PainSuppression.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- PAIN SUPPRESSION
			if spellID == 10060 then -- POWER INFUSION
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Priest.Spells.PowerInfusion.Messages.Start ~= "" then
					if RSA.db.profile.Priest.Spells.PowerInfusion.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Priest.Spells.PowerInfusion.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.PowerInfusion.Whisper == true and dest ~= pName and RSA_Whisperable(destGUID) then
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
						RSA_Print_Whisper(string.gsub(RSA.db.profile.Priest.Spells.PowerInfusion.Messages.Start, ".%a+.", RSA_String_Replace), dest)
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					end
					if RSA.db.profile.Priest.Spells.PowerInfusion.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Priest.Spells.PowerInfusion.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Priest.Spells.PowerInfusion.CustomChannel.Channel)
					end
					if RSA.db.profile.Priest.Spells.PowerInfusion.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Priest.Spells.PowerInfusion.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.PowerInfusion.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Priest.Spells.PowerInfusion.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.PowerInfusion.Party == true then
						if RSA.db.profile.Priest.Spells.PowerInfusion.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Priest.Spells.PowerInfusion.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.PowerInfusion.Raid == true then
						if RSA.db.profile.Priest.Spells.PowerInfusion.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Priest.Spells.PowerInfusion.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- POWER INFUSION
			if spellID == 586 then -- FADE
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Priest.Spells.Fade.Messages.Start ~= "" then
					if RSA.db.profile.Priest.Spells.Fade.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Priest.Spells.Fade.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.Fade.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Priest.Spells.Fade.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Priest.Spells.Fade.CustomChannel.Channel)
					end
					if RSA.db.profile.Priest.Spells.Fade.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Priest.Spells.Fade.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.Fade.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Priest.Spells.Fade.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.Fade.Party == true then
						if RSA.db.profile.Priest.Spells.Fade.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Priest.Spells.Fade.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.Fade.Raid == true then
						if RSA.db.profile.Priest.Spells.Fade.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Priest.Spells.Fade.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- FADE
			if spellID == 8122 then -- PSYCHIC SCREAM
				RSA_PsychicScream = false
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Priest.Spells.PsychicScream.Messages.Start ~= "" then
					if RSA.db.profile.Priest.Spells.PsychicScream.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Priest.Spells.PsychicScream.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.PsychicScream.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Priest.Spells.PsychicScream.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Priest.Spells.PsychicScream.CustomChannel.Channel)
					end
					if RSA.db.profile.Priest.Spells.PsychicScream.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Priest.Spells.PsychicScream.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.PsychicScream.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Priest.Spells.PsychicScream.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.PsychicScream.Party == true then
						if RSA.db.profile.Priest.Spells.PsychicScream.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Priest.Spells.PsychicScream.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.PsychicScream.Raid == true then
						if RSA.db.profile.Priest.Spells.PsychicScream.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Priest.Spells.PsychicScream.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- PSYCHIC SCREAM
			if spellID == 64044 then -- PSYCHIC HORROR
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Priest.Spells.PsychicHorror.Messages.Start ~= "" then
					if RSA.db.profile.Priest.Spells.PsychicHorror.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Priest.Spells.PsychicHorror.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.PsychicHorror.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Priest.Spells.PsychicHorror.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Priest.Spells.PsychicHorror.CustomChannel.Channel)
					end
					if RSA.db.profile.Priest.Spells.PsychicHorror.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Priest.Spells.PsychicHorror.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.PsychicHorror.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Priest.Spells.PsychicHorror.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.PsychicHorror.Party == true then
						if RSA.db.profile.Priest.Spells.PsychicHorror.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Priest.Spells.PsychicHorror.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.PsychicHorror.Raid == true then
						if RSA.db.profile.Priest.Spells.PsychicHorror.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Priest.Spells.PsychicHorror.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- PSYCHIC HORROR
			if spellID == 34433 then -- SHADOWFIEND
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Priest.Spells.Shadowfiend.Messages.Start ~= "" then
					if RSA.db.profile.Priest.Spells.Shadowfiend.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Priest.Spells.Shadowfiend.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.Shadowfiend.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Priest.Spells.Shadowfiend.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Priest.Spells.Shadowfiend.CustomChannel.Channel)
					end
					if RSA.db.profile.Priest.Spells.Shadowfiend.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Priest.Spells.Shadowfiend.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.Shadowfiend.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Priest.Spells.Shadowfiend.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.Shadowfiend.Party == true then
						if RSA.db.profile.Priest.Spells.Shadowfiend.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Priest.Spells.Shadowfiend.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.Shadowfiend.Raid == true then
						if RSA.db.profile.Priest.Spells.Shadowfiend.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Priest.Spells.Shadowfiend.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- SHADOWFIEND
			if spellID == 62618 then -- POWER WORD: BARRIER
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_PWB_GUID = destGUID
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Priest.Spells.PowerWordBarrier.Messages.Start ~= "" then
					if RSA.db.profile.Priest.Spells.PowerWordBarrier.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Priest.Spells.PowerWordBarrier.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.PowerWordBarrier.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Priest.Spells.PowerWordBarrier.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Priest.Spells.PowerWordBarrier.CustomChannel.Channel)
					end
					if RSA.db.profile.Priest.Spells.PowerWordBarrier.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Priest.Spells.PowerWordBarrier.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.PowerWordBarrier.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Priest.Spells.PowerWordBarrier.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.PowerWordBarrier.Party == true then
						if RSA.db.profile.Priest.Spells.PowerWordBarrier.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Priest.Spells.PowerWordBarrier.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.PowerWordBarrier.Raid == true then
						if RSA.db.profile.Priest.Spells.PowerWordBarrier.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Priest.Spells.PowerWordBarrier.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- POWER WORD: BARRIER
		end -- IF EVENT IS SPELL_CAST_SUCCESS
		if event == "SPELL_SUMMON" then
			if spellID == 724 then -- LIGHTWELL
				if RSA_Glyphs(55673) == true then
					RSA_Lightwell = 15
				else
					RSA_Lightwell = 10
				end
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[AMOUNT]"] = RSA_Lightwell,}
				if RSA.db.profile.Priest.Spells.Lightwell.Messages.Start ~= "" then
					if RSA.db.profile.Priest.Spells.Lightwell.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Priest.Spells.Lightwell.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.Lightwell.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Priest.Spells.Lightwell.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Priest.Spells.Lightwell.CustomChannel.Channel)
					end
					if RSA.db.profile.Priest.Spells.Lightwell.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Priest.Spells.Lightwell.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.Lightwell.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Priest.Spells.Lightwell.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.Lightwell.Party == true then
						if RSA.db.profile.Priest.Spells.Lightwell.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Priest.Spells.Lightwell.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.Lightwell.Raid == true then
						if RSA.db.profile.Priest.Spells.Lightwell.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Priest.Spells.Lightwell.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- LIGHTWELL
			if spellID == 62618 then -- POWER WORD: BARRIER
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_PWB_GUID = destGUID
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Priest.Spells.PowerWordBarrier.Messages.Start ~= "" then
					if RSA.db.profile.Priest.Spells.PowerWordBarrier.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Priest.Spells.PowerWordBarrier.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.PowerWordBarrier.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Priest.Spells.PowerWordBarrier.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Priest.Spells.PowerWordBarrier.CustomChannel.Channel)
					end
					if RSA.db.profile.Priest.Spells.PowerWordBarrier.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Priest.Spells.PowerWordBarrier.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.PowerWordBarrier.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Priest.Spells.PowerWordBarrier.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.PowerWordBarrier.Party == true then
						if RSA.db.profile.Priest.Spells.PowerWordBarrier.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Priest.Spells.PowerWordBarrier.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.PowerWordBarrier.Raid == true then
						if RSA.db.profile.Priest.Spells.PowerWordBarrier.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Priest.Spells.PowerWordBarrier.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- POWER WORD: BARRIER
		end -- IF EVENT IS SPELL_SUMMON
		if event == "SPELL_HEAL" then
				if spellID == 48153 then -- GUARDIAN SPIRIT
				RSA_GuardianSpiritProcced = true
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[AMOUNT]"] = missType,}
				if RSA.db.profile.Priest.Spells.GuardianSpirit.Messages.Proc ~= "" then
					if RSA.db.profile.Priest.Spells.GuardianSpirit.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Priest.Spells.GuardianSpirit.Messages.Proc, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.GuardianSpirit.Whisper == true and dest ~= pName and RSA_Whisperable(destGUID) then
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"], ["[AMOUNT]"] = missType,}
						RSA_Print_Whisper(string.gsub(RSA.db.profile.Priest.Spells.GuardianSpirit.Messages.Proc, ".%a+.", RSA_String_Replace), dest)
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[AMOUNT]"] = missType,}
					end
					if RSA.db.profile.Priest.Spells.GuardianSpirit.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Priest.Spells.GuardianSpirit.Messages.Proc, ".%a+.", RSA_String_Replace), RSA.db.profile.Priest.Spells.GuardianSpirit.CustomChannel.Channel)
					end
					if RSA.db.profile.Priest.Spells.GuardianSpirit.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Priest.Spells.GuardianSpirit.Messages.Proc, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.GuardianSpirit.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Priest.Spells.GuardianSpirit.Messages.Proc, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.GuardianSpirit.Party == true then
						if RSA.db.profile.Priest.Spells.GuardianSpirit.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Priest.Spells.GuardianSpirit.Messages.Proc, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.GuardianSpirit.Raid == true then
						if RSA.db.profile.Priest.Spells.GuardianSpirit.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Priest.Spells.GuardianSpirit.Messages.Proc, ".%a+.", RSA_String_Replace))
					end
				end
			end -- GUARDIAN SPIRIT
		end -- IF EVENT IS SPELL_SUMMON
		if event == "SPELL_AURA_REMOVED" then
			if spellID == 453 then -- MIND SOOTHE
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Priest.Spells.MindSoothe.Messages.End ~= "" then
					if RSA.db.profile.Priest.Spells.MindSoothe.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Priest.Spells.MindSoothe.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.MindSoothe.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Priest.Spells.MindSoothe.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Priest.Spells.MindSoothe.CustomChannel.Channel)
					end
					if RSA.db.profile.Priest.Spells.MindSoothe.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Priest.Spells.MindSoothe.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.MindSoothe.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Priest.Spells.MindSoothe.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.MindSoothe.Party == true then
						if RSA.db.profile.Priest.Spells.MindSoothe.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Priest.Spells.MindSoothe.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.MindSoothe.Raid == true then
						if RSA.db.profile.Priest.Spells.MindSoothe.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Priest.Spells.MindSoothe.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- MIND SOOTHE
			if spellID == 605 and dest ~= pName then -- MIND CONTROL
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Priest.Spells.MindControl.Messages.End ~= "" then
					if RSA.db.profile.Priest.Spells.MindControl.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Priest.Spells.MindControl.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.MindControl.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Priest.Spells.MindControl.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Priest.Spells.MindControl.CustomChannel.Channel)
					end
					if RSA.db.profile.Priest.Spells.MindControl.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Priest.Spells.MindControl.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.MindControl.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Priest.Spells.MindControl.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.MindControl.Party == true then
						if RSA.db.profile.Priest.Spells.MindControl.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Priest.Spells.MindControl.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.MindControl.Raid == true then
						if RSA.db.profile.Priest.Spells.MindControl.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Priest.Spells.MindControl.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- MIND CONTROL
			if spellID == 64843 then -- DIVINE HYMN
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Priest.Spells.DivineHymn.Messages.End ~= "" then
					if RSA.db.profile.Priest.Spells.DivineHymn.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Priest.Spells.DivineHymn.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.DivineHymn.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Priest.Spells.DivineHymn.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Priest.Spells.DivineHymn.CustomChannel.Channel)
					end
					if RSA.db.profile.Priest.Spells.DivineHymn.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Priest.Spells.DivineHymn.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.DivineHymn.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Priest.Spells.DivineHymn.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.DivineHymn.Party == true then
						if RSA.db.profile.Priest.Spells.DivineHymn.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Priest.Spells.DivineHymn.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.DivineHymn.Raid == true then
						if RSA.db.profile.Priest.Spells.DivineHymn.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Priest.Spells.DivineHymn.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- DIVINE HYMN
			if spellID == 64901 then -- HYMN OF HOPE
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Priest.Spells.HymnOfHope.Messages.End ~= "" then
					if RSA.db.profile.Priest.Spells.HymnOfHope.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Priest.Spells.HymnOfHope.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.HymnOfHope.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Priest.Spells.HymnOfHope.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Priest.Spells.HymnOfHope.CustomChannel.Channel)
					end
					if RSA.db.profile.Priest.Spells.HymnOfHope.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Priest.Spells.HymnOfHope.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.HymnOfHope.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Priest.Spells.HymnOfHope.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.HymnOfHope.Party == true then
						if RSA.db.profile.Priest.Spells.HymnOfHope.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Priest.Spells.HymnOfHope.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.HymnOfHope.Raid == true then
						if RSA.db.profile.Priest.Spells.HymnOfHope.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Priest.Spells.HymnOfHope.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- HYMN OF HOPE
			if spellID == 6346 then -- FEAR WARD
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Priest.Spells.FearWard.Messages.End ~= "" then
					if RSA.db.profile.Priest.Spells.FearWard.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Priest.Spells.FearWard.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.FearWard.Whisper == true and dest ~= pName and RSA_Whisperable(destGUID) then
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
						RSA_Print_Whisper(string.gsub(RSA.db.profile.Priest.Spells.FearWard.Messages.End, ".%a+.", RSA_String_Replace), dest)
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					end
					if RSA.db.profile.Priest.Spells.FearWard.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Priest.Spells.FearWard.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Priest.Spells.FearWard.CustomChannel.Channel)
					end
					if RSA.db.profile.Priest.Spells.FearWard.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Priest.Spells.FearWard.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.FearWard.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Priest.Spells.FearWard.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.FearWard.Party == true then
						if RSA.db.profile.Priest.Spells.FearWard.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Priest.Spells.FearWard.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.FearWard.Raid == true then
						if RSA.db.profile.Priest.Spells.FearWard.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Priest.Spells.FearWard.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- FEAR WARD
			if spellID == 1706 then -- LEVITATE
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Priest.Spells.Levitate.Messages.End ~= "" then
					if RSA.db.profile.Priest.Spells.Levitate.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Priest.Spells.Levitate.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.Levitate.Whisper == true and dest ~= pName and RSA_Whisperable(destGUID) then
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
						RSA_Print_Whisper(string.gsub(RSA.db.profile.Priest.Spells.Levitate.Messages.End, ".%a+.", RSA_String_Replace), dest)
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					end
					if RSA.db.profile.Priest.Spells.Levitate.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Priest.Spells.Levitate.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Priest.Spells.Levitate.CustomChannel.Channel)
					end
					if RSA.db.profile.Priest.Spells.Levitate.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Priest.Spells.Levitate.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.Levitate.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Priest.Spells.Levitate.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.Levitate.Party == true then
						if RSA.db.profile.Priest.Spells.Levitate.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Priest.Spells.Levitate.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.Levitate.Raid == true then
						if RSA.db.profile.Priest.Spells.Levitate.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Priest.Spells.Levitate.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- LEVITATE
			if spellID == 9484 then -- SHACKLE UNDEAD
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Priest.Spells.ShackleUndead.Messages.End ~= "" then
					if RSA.db.profile.Priest.Spells.ShackleUndead.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Priest.Spells.ShackleUndead.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.ShackleUndead.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Priest.Spells.ShackleUndead.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Priest.Spells.ShackleUndead.CustomChannel.Channel)
					end
					if RSA.db.profile.Priest.Spells.ShackleUndead.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Priest.Spells.ShackleUndead.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.ShackleUndead.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Priest.Spells.ShackleUndead.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.ShackleUndead.Party == true then
						if RSA.db.profile.Priest.Spells.ShackleUndead.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Priest.Spells.ShackleUndead.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.ShackleUndead.Raid == true then
						if RSA.db.profile.Priest.Spells.ShackleUndead.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Priest.Spells.ShackleUndead.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- SHACKLE UNDEAD
			if spellID == 33206 then -- PAIN SUPPRESSION
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Priest.Spells.PainSuppression.Messages.End ~= "" then
					if RSA.db.profile.Priest.Spells.PainSuppression.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Priest.Spells.PainSuppression.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.PainSuppression.Whisper == true and dest ~= pName and RSA_Whisperable(destGUID) then
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
						RSA_Print_Whisper(string.gsub(RSA.db.profile.Priest.Spells.PainSuppression.Messages.End, ".%a+.", RSA_String_Replace), dest)
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					end
					if RSA.db.profile.Priest.Spells.PainSuppression.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Priest.Spells.PainSuppression.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Priest.Spells.PainSuppression.CustomChannel.Channel)
					end
					if RSA.db.profile.Priest.Spells.PainSuppression.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Priest.Spells.PainSuppression.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.PainSuppression.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Priest.Spells.PainSuppression.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.PainSuppression.Party == true then
						if RSA.db.profile.Priest.Spells.PainSuppression.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Priest.Spells.PainSuppression.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.PainSuppression.Raid == true then
						if RSA.db.profile.Priest.Spells.PainSuppression.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Priest.Spells.PainSuppression.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- PAIN SUPPRESSION
			if spellID == 10060 then -- POWER INFUSION
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Priest.Spells.PowerInfusion.Messages.End ~= "" then
					if RSA.db.profile.Priest.Spells.PowerInfusion.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Priest.Spells.PowerInfusion.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.PowerInfusion.Whisper == true and dest ~= pName and RSA_Whisperable(destGUID) then
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
						RSA_Print_Whisper(string.gsub(RSA.db.profile.Priest.Spells.PowerInfusion.Messages.End, ".%a+.", RSA_String_Replace), dest)
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					end
					if RSA.db.profile.Priest.Spells.PowerInfusion.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Priest.Spells.PowerInfusion.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Priest.Spells.PowerInfusion.CustomChannel.Channel)
					end
					if RSA.db.profile.Priest.Spells.PowerInfusion.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Priest.Spells.PowerInfusion.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.PowerInfusion.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Priest.Spells.PowerInfusion.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.PowerInfusion.Party == true then
						if RSA.db.profile.Priest.Spells.PowerInfusion.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Priest.Spells.PowerInfusion.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.PowerInfusion.Raid == true then
						if RSA.db.profile.Priest.Spells.PowerInfusion.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Priest.Spells.PowerInfusion.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- POWER INFUSION
			if spellID == 586 then -- FADE
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Priest.Spells.Fade.Messages.End ~= "" then
					if RSA.db.profile.Priest.Spells.Fade.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Priest.Spells.Fade.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.Fade.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Priest.Spells.Fade.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Priest.Spells.Fade.CustomChannel.Channel)
					end
					if RSA.db.profile.Priest.Spells.Fade.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Priest.Spells.Fade.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.Fade.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Priest.Spells.Fade.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.Fade.Party == true then
						if RSA.db.profile.Priest.Spells.Fade.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Priest.Spells.Fade.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.Fade.Raid == true then
						if RSA.db.profile.Priest.Spells.Fade.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Priest.Spells.Fade.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- FADE
			if spellID == 15487 then -- SILENCE
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Silenced = false
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Priest.Spells.Silence.Messages.End ~= "" then
					if RSA.db.profile.Priest.Spells.Silence.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Priest.Spells.Silence.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.Silence.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Priest.Spells.Silence.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Priest.Spells.Silence.CustomChannel.Channel)
					end
					if RSA.db.profile.Priest.Spells.Silence.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Priest.Spells.Silence.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.Silence.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Priest.Spells.Silence.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.Silence.Party == true then
						if RSA.db.profile.Priest.Spells.Silence.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Priest.Spells.Silence.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.Silence.Raid == true then
						if RSA.db.profile.Priest.Spells.Silence.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Priest.Spells.Silence.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- SILENCE
			if spellID == 64044 then -- PSYCHIC HORROR
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.Priest.Spells.PsychicHorror.Messages.End ~= "" then
					if RSA.db.profile.Priest.Spells.PsychicHorror.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Priest.Spells.PsychicHorror.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.PsychicHorror.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Priest.Spells.PsychicHorror.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Priest.Spells.PsychicHorror.CustomChannel.Channel)
					end
					if RSA.db.profile.Priest.Spells.PsychicHorror.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Priest.Spells.PsychicHorror.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.PsychicHorror.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Priest.Spells.PsychicHorror.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.PsychicHorror.Party == true then
						if RSA.db.profile.Priest.Spells.PsychicHorror.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Priest.Spells.PsychicHorror.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.PsychicHorror.Raid == true then
						if RSA.db.profile.Priest.Spells.PsychicHorror.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Priest.Spells.PsychicHorror.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- PSYCHIC HORROR
			if spellID == 8122 and RSA_PsychicScream == false then -- PSYCHIC SCREAM
				RSA_PsychicScream = true
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Priest.Spells.PsychicScream.Messages.End ~= "" then
					if RSA.db.profile.Priest.Spells.PsychicScream.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Priest.Spells.PsychicScream.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.PsychicScream.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Priest.Spells.PsychicScream.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Priest.Spells.PsychicScream.CustomChannel.Channel)
					end
					if RSA.db.profile.Priest.Spells.PsychicScream.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Priest.Spells.PsychicScream.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.PsychicScream.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Priest.Spells.PsychicScream.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.PsychicScream.Party == true then
						if RSA.db.profile.Priest.Spells.PsychicScream.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Priest.Spells.PsychicScream.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.PsychicScream.Raid == true then
						if RSA.db.profile.Priest.Spells.PsychicScream.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Priest.Spells.PsychicScream.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- PSYCHIC SCREAM
		end -- IF EVENT IS SPELL_AURA_REMOVED
		if event == "SPELL_DISPEL" then
			if spellID == 527 or spellID == 97691 or spellID == 97690 then -- DISPEL MAGIC 527 is only for SPELL_CAST_SUCCESS, 97691 is for hostile targets and 97690 is for friendly targets.
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				extraspellinfo = GetSpellInfo(missType)
				extraspellinfolink = GetSpellLink(missType)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[AURA]"] = extraspellinfo, ["[AURALINK]"] = extraspellinfolink,}
				if RSA.db.profile.Priest.Spells.DispelMagic.Messages.Start ~= "" then
					if (RSA.db.profile.Priest.Spells.DispelMagic.HostileOnly == true and spellID == 97691) or RSA.db.profile.Priest.Spells.DispelMagic.HostileOnly == false then
						if RSA.db.profile.Priest.Spells.DispelMagic.Local == true then
							RSA_Print_LibSink(string.gsub(RSA.db.profile.Priest.Spells.DispelMagic.Messages.Start, ".%a+.", RSA_String_Replace))
						end
						if RSA.db.profile.Priest.Spells.DispelMagic.Whisper == true and dest ~= pName and RSA_Whisperable(destGUID) and UnitIsPlayer(dest) and UnitIsFriend(pName, dest) then
							RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"], ["[AURA]"] = extraspellinfo, ["[AURALINK]"] = extraspellinfolink,}
							RSA_Print_Whisper(string.gsub(RSA.db.profile.Priest.Spells.DispelMagic.Messages.Start, ".%a+.", RSA_String_Replace), dest)
							RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[AURA]"] = extraspellinfo, ["[AURALINK]"] = extraspellinfolink,}
						end
						if RSA.db.profile.Priest.Spells.DispelMagic.CustomChannel.Enabled == true then
							RSA_Print_Channel(string.gsub(RSA.db.profile.Priest.Spells.DispelMagic.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Priest.Spells.DispelMagic.CustomChannel.Channel)
						end
						if RSA.db.profile.Priest.Spells.DispelMagic.Smart.Say == true then
							RSA_Print_Say(string.gsub(RSA.db.profile.Priest.Spells.DispelMagic.Messages.Start, ".%a+.", RSA_String_Replace))
						end
						if RSA.db.profile.Priest.Spells.DispelMagic.Smart.RaidParty == true then
							RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Priest.Spells.DispelMagic.Messages.Start, ".%a+.", RSA_String_Replace))
						end
						if RSA.db.profile.Priest.Spells.DispelMagic.Party == true then
							if RSA.db.profile.Priest.Spells.DispelMagic.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
								RSA_Print_Party(string.gsub(RSA.db.profile.Priest.Spells.DispelMagic.Messages.Start, ".%a+.", RSA_String_Replace))
						end
						if RSA.db.profile.Priest.Spells.DispelMagic.Raid == true then
							if RSA.db.profile.Priest.Spells.DispelMagic.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
							RSA_Print_Raid(string.gsub(RSA.db.profile.Priest.Spells.DispelMagic.Messages.Start, ".%a+.", RSA_String_Replace))
						end
					end
				end
			end -- DISPEL MAGIC
			if spellID == 528 then -- CURE DISEASE
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				extraspellinfo = GetSpellInfo(missType)
				extraspellinfolink = GetSpellLink(missType)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[AURA]"] = extraspellinfo, ["[AURALINK]"] = extraspellinfolink,}
				if RSA.db.profile.Priest.Spells.CureDisease.Messages.Start ~= "" then
					if RSA.db.profile.Priest.Spells.CureDisease.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Priest.Spells.CureDisease.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.CureDisease.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Priest.Spells.CureDisease.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Priest.Spells.CureDisease.CustomChannel.Channel)
					end
					if RSA.db.profile.Priest.Spells.CureDisease.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Priest.Spells.CureDisease.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.CureDisease.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Priest.Spells.CureDisease.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.CureDisease.Party == true then
						if RSA.db.profile.Priest.Spells.CureDisease.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Priest.Spells.CureDisease.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.CureDisease.Raid == true then
						if RSA.db.profile.Priest.Spells.CureDisease.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Priest.Spells.CureDisease.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- CURE DISEASE
		end -- IF EVENT IS SPELL_DISPEL
		if event == "SPELL_DISPEL_FAILED" then
			if spellID == 527 or spellID == 97691 or spellID == 97690 then -- DISPEL MAGIC
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				extraspellinfo = GetSpellInfo(missType)
				extraspellinfolink = GetSpellLink(missType)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[AURA]"] = extraspellinfo, ["[AURALINK]"] = extraspellinfolink,}
				if RSA.db.profile.Priest.Spells.DispelMagic.Messages.End ~= "" then
					if RSA.db.profile.Priest.Spells.DispelMagic.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Priest.Spells.DispelMagic.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.DispelMagic.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Priest.Spells.DispelMagic.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Priest.Spells.DispelMagic.CustomChannel.Channel)
					end
					if RSA.db.profile.Priest.Spells.DispelMagic.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Priest.Spells.DispelMagic.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.DispelMagic.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Priest.Spells.DispelMagic.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.DispelMagic.Party == true then
						if RSA.db.profile.Priest.Spells.DispelMagic.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Priest.Spells.DispelMagic.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.DispelMagic.Raid == true then
						if RSA.db.profile.Priest.Spells.DispelMagic.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Priest.Spells.DispelMagic.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- DISPEL MAGIC
		end -- IF EVENT IS SPELL_DISPEL_FAILED
		if event == "SPELL_INTERRUPT" then
			if spellID == 32747 then -- SILENCE
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				extraspellinfo = GetSpellInfo(missType)
				extraspellinfolink = GetSpellLink(missType)
				RSA_Silenced = true
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[TARSPELL]"] = extraspellinfo, ["[TARLINK]"] = extraspellinfolink,}
				if RSA.db.profile.Priest.Spells.Silence.Messages.Start ~= "" then
					if RSA.db.profile.Priest.Spells.Silence.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Priest.Spells.Silence.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.Silence.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Priest.Spells.Silence.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Priest.Spells.Silence.CustomChannel.Channel)
					end
					if RSA.db.profile.Priest.Spells.Silence.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Priest.Spells.Silence.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.Silence.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Priest.Spells.Silence.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.Silence.Party == true then
						if RSA.db.profile.Priest.Spells.Silence.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Priest.Spells.Silence.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.Silence.Raid == true then
						if RSA.db.profile.Priest.Spells.Silence.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Priest.Spells.Silence.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- SILENCE
		end -- IF EVENT IS SPELL_INTERRUPT
	else
		if event == "SPELL_AURA_REMOVED" then
				if spellID == 81781 and destGUID == RSA_PWB_GUID then -- POWER WORD: BARRIER
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.Priest.Spells.PowerWordBarrier.Messages.End ~= "" then
					if RSA.db.profile.Priest.Spells.PowerWordBarrier.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Priest.Spells.PowerWordBarrier.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.PowerWordBarrier.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Priest.Spells.PowerWordBarrier.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Priest.Spells.PowerWordBarrier.CustomChannel.Channel)
					end
					if RSA.db.profile.Priest.Spells.PowerWordBarrier.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Priest.Spells.PowerWordBarrier.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.PowerWordBarrier.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Priest.Spells.PowerWordBarrier.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.PowerWordBarrier.Party == true then
						if RSA.db.profile.Priest.Spells.PowerWordBarrier.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Priest.Spells.PowerWordBarrier.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.PowerWordBarrier.Raid == true then
						if RSA.db.profile.Priest.Spells.PowerWordBarrier.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Priest.Spells.PowerWordBarrier.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- POWER WORD: BARRIER
		end -- END IF SPELL_AURA_REMOVED
	end -- IF SOURCE IS PLAYER
end -- END ENTIRELY
RSA_CombatLogMonitor:SetScript("OnEvent", Priest_Spells)
------------------------------
---- Resurrection Monitor ----
------------------------------
local function Priest_Resurrection(_, event, source, spell, rank, dest, _)
	if UnitName(source) == pName then
		if spell == GetSpellInfo(2006) and RSA.db.profile.Priest.Spells.Resurrection.Messages.Start ~= "" then -- RESURRECTION
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
				if RSA.db.profile.Priest.Spells.Resurrection.Messages.Start ~= "" then
					if RSA.db.profile.Priest.Spells.Resurrection.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Priest.Spells.Resurrection.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.Resurrection.Whisper == true and dest ~= pName then
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
						RSA_Print_Whisper(string.gsub(RSA.db.profile.Priest.Spells.Resurrection.Messages.Start, ".%a+.", RSA_String_Replace), dest)
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					end
					if RSA.db.profile.Priest.Spells.Resurrection.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Priest.Spells.Resurrection.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.Priest.Spells.Resurrection.CustomChannel.Channel)
					end
					if RSA.db.profile.Priest.Spells.Resurrection.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Priest.Spells.Resurrection.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.Resurrection.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Priest.Spells.Resurrection.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.Resurrection.Party == true then
						if RSA.db.profile.Priest.Spells.Resurrection.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Priest.Spells.Resurrection.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.Resurrection.Raid == true then
						if RSA.db.profile.Priest.Spells.Resurrection.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Priest.Spells.Resurrection.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			elseif event == "UNIT_SPELLCAST_SUCCEEDED" and Ressed ~= true then
				dest = ResTarget
				Ressed = true
				if RSA.db.profile.Priest.Spells.Resurrection.Messages.End ~= "" then
					if RSA.db.profile.Priest.Spells.Resurrection.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.Priest.Spells.Resurrection.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.Resurrection.Whisper == true and dest ~= pName then
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
						RSA_Print_Whisper(string.gsub(RSA.db.profile.Priest.Spells.Resurrection.Messages.End, ".%a+.", RSA_String_Replace), dest)
						RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					end
					if RSA.db.profile.Priest.Spells.Resurrection.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.Priest.Spells.Resurrection.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.Priest.Spells.Resurrection.CustomChannel.Channel)
					end
					if RSA.db.profile.Priest.Spells.Resurrection.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.Priest.Spells.Resurrection.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.Resurrection.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.Priest.Spells.Resurrection.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.Resurrection.Party == true then
						if RSA.db.profile.Priest.Spells.Resurrection.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.Priest.Spells.Resurrection.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.Priest.Spells.Resurrection.Raid == true then
						if RSA.db.profile.Priest.Spells.Resurrection.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.Priest.Spells.Resurrection.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end
		end -- RESURRECTION
	end
end -- END FUNCTION
RSA_ResMon = CreateFrame("Frame", "RSA:RM")
RSA_ResMon:RegisterEvent("UNIT_SPELLCAST_SENT")
RSA_ResMon:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
RSA_ResMon:SetScript("OnEvent", Priest_Resurrection)
end -- END ON ENABLED
function RSA_Priest:OnDisable()
RSA_CombatLogMonitor:SetScript("OnEvent", nil)
RSA_ResMon:SetScript("OnEvent", nil)
end