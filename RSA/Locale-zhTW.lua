local L = LibStub("AceLocale-3.0"):NewLocale("RSA", "zhTW")
if not L then return end
------------------------------------------------------------------------------
--- IN THE PROCESS OF REDOING THIS TO MAKE IT CLEARER TO READ AND UPDATE. ----
------------------------------------------------------------------------------

-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
-- @@@@@@@@@@ Strings marked with #### should not be translated. They will be edited or deleted soon.
-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

-- PRIMARY LOCALISATIONS
L["Tol Barad"] = "托巴拉德" -- a = select(32,GetMapZones(2)) Will this always return Tol Barad? It seems GetMapZones is alphabetised, maybe not the same order in other localisations?
L["Corpse of "] = "死掉的 " -- Tooltip mouseover of a released corpse.


-- PRIMARY LOCALISATIONS-->>BUFF REMINDER MODULE
L[" is Missing!"] = " 失效！"
L[" Refreshed!"] = " 刷新！"


-- PRIMARY LOCALISATIONS-->>SPELL ANNOUNCEMENTS
L["You"] = "你"
L["missed"] = "未命中"
L["was resisted by"] = "抵抗了"
L["Immune"] = "免疫"
L["Unknown"] = "未知"


-- MAIN OPTIONS PANEL-->>GLOBAL OPTIONS & THEIR DESCRIPTIONS
L["Global Options"] = "全區選項"
L.Global_Options_Desc = "在這裡您可以配置一些常規設置的RSA，這將影響您所有的通告。"

L["About"] = "關於"
L.About_Desc = "歡迎使用RSA！如果你有使用上的問題，請至左側的幫助頁。 If 如果你依然不確定，請給我一個Curse評論於：|cff33ff99http://wow.curse.com/downloads/wow-addons/details/rsa.aspx|r. 如果你發現一個bug，或者有功能上的要求，請在Curse給我一個ticket留言於：|cff33ff99http://wow.curseforge.com/addons/rsa/tickets/|r."

L["Module Settings"] = "模組設置"
L.Module_Settings_Desc = "" -- None for now.

L["Enable Buff Reminder Module"] = "啟用增益提醒模組"
L.Buff_Reminders_Desc = "這個模組允許你來提醒當你有一個 buff失效。"

L["Announcement Options"] = "通報選項"
L.Announcement_Options_Desc = "這些選項影響所有法術，懸停在每個以看到一個它完整作用的描述。"

L["Smart Say"] = "智能說"
L.Smart_Say_Desc = "啟用這只會讓你通報選擇的法術在說 |cffFF0000只有|r 當你在群體中。"

L["Smart Custom Channel"] = "智能自訂頻道"
L.Smart_Custom_Channel_Desc = "啟用這只會讓你通報選擇的法術在自定頻道 |cffFF0000只有|r 當你在群體中。"

L["Enable Only In Combat"] = "只在戰鬥中啟用"
L.Enable_Only_In_Combat_Desc = "啟用此將導致您只在戰鬥中發送通知。"

L["Enable in Arenas"] = "使用在競技場"
L.Enable_In_Arenas_Desc = "啟用此將允許你在競技場時通告。"

L["Enable in Battlegrounds"] = "使用在戰場"
L.Enable_In_Battlegrounds_Desc = "啟用此將允許你在戰場中同時通告。"

L["Enable in Dungeons"] = "使用在地城"
L.Enable_In_Dungeons_Desc = "這將允許您啟用通告，當你在5人地下城或英雄模式。"

L["Enable in Raid Instances"] = "使用在團隊副本"
L.Enable_In_Raid_Instances_Desc = "這將允許您啟用通告，當你在團隊副本。"

L["Enable in Tol Barad"] = "使用在托巴拉德"
L.Enable_In_Tol_Barad_Desc = "這將允許您啟用通告，當你在托巴拉德。"

L["Enable in the World"] = "使用在世界環境"
L.Enable_In_The_World_Desc = "這將允許您啟用通報在正常世界中，換句話說，在任何情況下未列出的所有其他選項。"

L["Enable in PvP"] = "使用在PVP"
L.Enable_In_PvP_Desc = "這將允許您啟用通告當你在PvP狀態，無論身在何處。啟用這將隱藏PVP區域的具體位置選項。"


-- MAIN OPTIONS PANEL-->>LIB SINK OUTPUT
L["Local Message Output Area"] = "本地訊息輸出區域"
L.Local_Message_Output_Area_Desc = "法術設定為\“本地\“在他們的設置將被發送到下列其中一個地方，在這裡你可以選擇。"


-- MAIN OPTIONS PANEL-->>GENERAL ANNOUNCEMENTS
L["General Announcements"] = "一般通報"
L.General_Announcements_Desc = "在這裡您可以配置非職業性的通報。例如種族技能、公會技能有如群體復活，或其他事情，如放置一吉福斯。"

L["Racial: "] = "種族："
L["Leader: "] = "領隊："
L["Personal: "] = "個人："


-- BUFF REMINDERS OPTIONS PANEL-->>GENERAL LOCALISATIONS
L["Reminder Options"] = "提醒選項"
L.Reminder_Options = "提醒您某些增益失效的選項。"
L.Disabled_Reminder_Options = "|cffFF0000此模組已關閉|r，想啟用它請勾選 \"|cff00CCFF啟用增益提醒模組|r\" 在主選項視窗。"
L.Spell_To_Check = "想要檢查的法術名稱："
L.Spell_To_Check_Desc = "輸入希望你被提醒的法術名稱。\n|cffFF0000警告：|r 如果你輸入的法術名稱不準確將無法作用。"
L["Disable in PvP"] = "pvp中禁用" -- To Be Removed and replaced with the earlier "Enable in PvP". I need to rework the Reminders module a little first though. ####
L["Turns off the spell reminders while you have PvP active."] = "當你在PVP狀態時關閉法術提醒" -- Will need to be changed soon also. ####
L.Enable_In_Spec1 = "在主天賦啟用"
L.Enable_In_Spec1_Desc = "在主天賦使用時提醒您失效的增益。"
L.Enable_In_Spec2 = "在副天賦啟用"
L.Enable_In_Spec2_Desc = "在副天賦使用時提醒您失效的增益。"
L["Remind Interval"] = "提醒間隔"
L.Remind_Interval_Desc = "提醒增益失效的頻率"
L["Announce In"] = "通報選項"
L["Chat Window"] = "聊天視窗" -- REMOVE. Buff Reminders will use LibSink soon, this will be redundant. ####
L["Sends reminders to your default chat window."] = "發出提醒到預設聊天視窗" -- This too. ####
L["Raid Warning Frame"] = "團隊警告" -- And this. ####
L["Sends reminders to your Raid Warning frame at the center of the screen."] = "發出提醒到螢幕中央的團隊警告框" -- And also this. ####


-- SPELL OPTIONS PANEL-->>GENERAL LOCALISATIONS
L["Spell Options"] = "法術選項"
L.Spell_Options = "設置個人的法術，選擇要配置的法術從右側的下拉列表。"

L["Hostile Only"] = "僅敵對的"
L.Hostile_Only_Desc = "只有目標是可攻擊的才通報。"


-- SPELL OPTIONS PANEL-->>CHANNEL OPTIONS
L["Local"] = "本地"
L.Local_Desc = "如果勾選，通告在您所選擇的地區，它被設置在主選項面板中的\“本地訊息輸出區域\“一節。\ n此設置並沒有按照全區通告的設置，如果勾選，通告將無論這些設置。"

L["Whisper"] = "悄悄話"
L.Whisper_Desc = "Whispers the target of the spell.\nThis setting also does not follow the global announcement settings, and will, if checked, announce regardless of those settings."

L["Custom Channel"] = "自訂頻道"
L.Custom_Channel_Desc = "This is for player created channels |cffFF0000ONLY|r. e.g \"MyGuildHealerChannel\"\nThere is a setting in the main options that affects if this can announce while you are in a group or not."

L["Channel Name"] = "頻道名稱"
L.Channel_Name_Desc = "Enter the name of the channel you want to announce in. Please |cffFF0000ONLY|r use player created channels. Channels that already exist, such as \"Party\" will |cffFF0000NOT|r work."

L["Raid"] = "團隊"
L.Raid_Desc = "通報在團隊頻道，如果你在團隊中。不發揮任何作用在戰場或競技場。"

L["Party"] = "隊伍"
L.Party_Desc = "通報在隊伍頻道，如果你在任何一種群體中[團隊/隊伍]。不發揮任何作用在戰場。"

L["Smart Group"] = "智能團體"
L.Smart_Group_Desc = "如果你在團隊通報到團隊，或者你在隊伍則通報到隊伍。它也將發送到戰場頻道如果你在戰場或競技場。"

L["Say"] = "說"
L.Say_Desc = "通報在說頻道\n有一個設置在主選項，影響能否通報如果當你在一個群體或沒有。"


-- SPELL OPTIONS PANEL-->>MESSAGE OPTIONS
L["Message Settings"] = "訊息設置"
L.Message_Settings_Desc = "這裡你可以對此法術使用自訂訊息的通報，要禁用某個通報，讓它空白。 You can put any of the following into your messages to make them more dynamic:\n|cFFFF75B3%%|r 一個 % 符號。\n|cFFFF75B3[SPELL]|r 為法術名稱。\n|cFFFF75B3[LINK]|r 為可點擊的法術連結。"
L.MST = "\n|cFFFF75B3[TARGET]|r 為目標名稱"
L.MSA = "\n|cFFFF75B3[AMOUNT]|r 為治療/傷害獲得的數字"
L.MSM = "\n|cFFFF75B3[MISSTYPE]|r 為抵抗類型"
L.MSI = "\n|cFFFF75B3[TARSPELL]|r 為你中斷的法術名稱。\n|cFFFF75B3[TARLINK]|r 為你中斷的法術可點擊的連結。"
L.MSB = "\n|cFFFF75B3[AURA]|r 為可移除的增(減)益名稱。\n|cFFFF75B3[AURALINK]|r 為可移除的增(減)益可點擊的連結。"

-- SPELL OPTIONS PANEL-->>MISCELLANEOUS TRANSLATIONS
L["Dispel"] = true

-- Amount minimums
L["Minimum"] = true
L.MinimumNeeded = "Minimum amount needed to announce."

-- Grounding Totem Descriptions
L["Destroyed by damage"] = true
L.DestroyedByDamage = "The message played when your totem is destroyed by damage."

L["Destroyed by other effects"] = true
L.DestroyedByOther = "The message played when your totem is destroyed by effects which do no damage, such as " .. GetSpellInfo(118) .. "."


-- Load on Demand Descriptions
L.OptionsDisabled = "模組已停用，請啟用它。"
L.OptionsMissing = "模組無法找到, 請刪除RSA資料夾, 下載且重新安裝。"
L.OptionsClass = "假如你想使用此職業的RSA，請啟用此模組。"
-- Option Titles
L["Enabling Options"] = "啟用選項" --  ####
L["End"] = "結束"
L["Help!"] = "幫幫忙！"
L["Reminder Spell"] = "法術提醒"
L["Resisted"] = "抵抗"
L["Start"] = "開始"
L["Successful"] = "成功"
L["Heal"] = "治療"
L["Upon Placement"] = "已經安置"
L["When Tripped"] = "開始置放"
L["Interrupt"] = "中斷"
L["Aura Applied"] = "光環已作用"
L["Stolen Charges"] = true
-- Option Descriptions -- THESE THAT FOLLOW WILL LIKELY BE CHANGED, DO NOT BOTHER TRANSLATING.
L.DescSpellStartSuccess = "法術成功施放時發送此訊息。"
L.DescTrapPlacement = "陷阱開始置放時時發送此訊息。"
L.DescTrapTripped = "陷阱已經安置時發送此訊息。"
L.DescSpellStartCastingMessage = "法術開始施放，或相關的增減益開始作用時發送此訊息。"
L.DescSpellEndCastingMessage = "法術結束施放，或相關的增減益已經移除時發送此訊息。"
L.DescSpellEndResist = "抵抗時發送此訊息。"
L.DescSpellEndImmune = "目標免疫時發送此訊息。"
L.DescSpellProcName = "法術觸發時發送此訊息。"
L.DescLightwellRenewStolen = "The message played when someone clicks the Lightwell too fast and uses up multiple charges."
-- Onload Messages
L.alpha_message = "|cffFF0000警告:|r 你正在使用Alpha版本的RSA。它可能無法實現預期的功能！"
L.updated_message = "|cffFF0000警告:|r RSA內的一些選項已被更改."
