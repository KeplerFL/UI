--------------------------------------
---- Raeli's Spell Announcer Core ----
--------------------------------------
RSA = LibStub("AceAddon-3.0"):NewAddon("RSA", "AceConsole-3.0", "LibSink-2.0")
local L = LibStub("AceLocale-3.0"):GetLocale("RSA")
local db
local pName = UnitName("player")
local defaults = {
	global = {
		version = 1.0, -- Automatically updates to the .toc version in OnInitialize, allows me to warn users if something big has changed.
		--[===[@alpha@
		DisableAlphaWarning == false,
		--@end-alpha@]===]
	},
	profile = {
		Modules = {
			['*'] = false, -- Defaultly don't load any modules. This will be set and saved once a user has logged in once. Possibly should be under class section, but seems fine here for now.
		},
		General = {
			['*'] = true,
			Class = "",
			GlobalAnnouncements = {
				['*'] = true,
				InPvP = false,
				InWorld = false,
				OnlyInCombat = false,
				Battlegrounds = false,
			},
			Local = {
				['*'] = true,
			},
			GlobalCustomChannel = "MyCustomChannel",
			Spells = {
				-- RACIALS --
				Stoneform = {
					Messages = {
						Start = "[LINK] Activated!",
						End = "[LINK] Ended!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				EMFH = {
					Messages = {
						Start = "[LINK] Activated!",
						End = "",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				GOTN = {
					Messages = {
						Start = "[LINK] on [TARGET]!",
						End = "[LINK] ended on [TARGET]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				WarStomp = {
					Messages = {
						Start = "[LINK] Activated!",
						End = "",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				WOTF = {
					Messages = {
						Start = "[LINK] Activated!",
						End = "[LINK] Ended!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				EscapeArtist = {
					Messages = {
						Start = "[LINK] Activated!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				ArcaneTorrent = {
					Messages = {
						Start = "[LINK] Activated!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				-- LEADER --
				Jeeves = {
					Messages = {
						Start = "[TARGET] has placed a [LINK]!",
						End = "[TARGET]'s [LINK] faded.",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				Cauldron = {
					Messages = {
						Start = "[TARGET] has placed a [LINK]!",
						End = "[TARGET]'s [LINK] faded.",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				Feasts = {
					Messages = {
						Start = "[TARGET] has placed a [LINK]!",
						End = "[TARGET]'s [LINK] faded.",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				MobileBank = {
					Messages = {
						Start = "[TARGET] has placed a [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				-- PERSONAL --
				MassSummon = {
					Messages = {
						Start = "Casting [LINK], summoning you all to me!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				MassRess = {
					Messages = {
						Start = "Casting [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				PotionOfConcentration = {
					Messages = {
						Start = "[LINK] Activated!",
						End = "[LINK] Ended!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
			},
		},
		Reminders = {
			DisableInPvP = true,
			EnableInSpec1 = true,
			EnableInSpec2 = false,
			CheckInterval = 10,
			RemindInterval = 15,
			RemindChannels = {
				['*'] = true,
			},
		},
		sink20OutputSink = "ChatFrame", -- Default for LibSink-2.0
		--sink20ScrollArea = ,
		DeathKnight = {
			Reminders = {
				SpellName = "",
			},
			Spells = {
				Army = {
					Messages = {
						Start = "Casting [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = true,
					},
				}, -- End
				AMS = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				DarkCommand = {
					Messages = {
						Start = "Taunted [TARGET]!",
						End = "My [LINK] [MISSTYPE] [TARGET]!",
						Immune = "[TARGET] is [MISSTYPE] to my [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				IceboundFortitude = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				Strangulate = {
					Messages = {
						Start = "Strangulated [TARGET]'s [TARLINK]!",
						End = "My [LINK] [MISSTYPE] [TARGET]!",
						Immune = "[TARGET] is [MISSTYPE] to my [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				MindFreeze = {
					Messages = {
						Start = "Mind Freezed [TARGET]'s [TARLINK]!",
						End = "My [LINK] [MISSTYPE] [TARGET]!",
						Immune = "[TARGET] is [MISSTYPE] to my [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				DeathGrip = {
					Messages = {
						Start = "Death Gripped [TARGET]!",
						End = "My [LINK] [MISSTYPE] [TARGET]!",
						Immune = "[TARGET] is [MISSTYPE] to my [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				VampiricBlood = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				BoneShield = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				UnholyFrenzy = {
					Messages = {
						Start = "[LINK] cast on [TARGET]!",
						End = "",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = true,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				RuneTap = {
					Messages = {
						Start = "Activated [LINK] for [AMOUNT]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				DancingRuneWeapon = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				WotN = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				DeathPact = {
					Messages = {
						Start = "Activated [LINK] for [AMOUNT]!!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				RaiseAlly = {
					Messages = {
						Start = "[LINK] cast on [TARGET]!",
						End = "",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = true,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				Lichborne = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				PillarOfFrost = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
			},
		},
		Druid = {
			Reminders = {
				SpellName = "",
			},
			Spells = {
				SurvivalInstincts = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				Cyclone = {
					Messages = {
						Start = "[LINK] cast on [TARGET]!",
						End = "[LINK] on [TARGET] ended!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				FrenziedRegeneration = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				Hibernate = {
					Messages = {
						Start = "[LINK] cast on [TARGET]!",
						End = "[LINK] on [TARGET] ended!",
						Immune = "[TARGET] is [MISSTYPE] to my [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				Innervate = {
					Messages = {
						Start = "[LINK] cast on [TARGET]!",
						End = "",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				SkullBash = {
					Messages = {
						Start = "Interrupted [TARGET]'s [TARLINK]!",
						End = "My [LINK] [MISSTYPE] [TARGET]!",
						Immune = "[TARGET] is [MISSTYPE] to my [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				Growl = {
					Messages = {
						Start = "Taunted [TARGET]!",
						End = "My [LINK] [MISSTYPE] [TARGET]!",
						Immune = "[TARGET] is [MISSTYPE] to my [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				Revive = {
					Messages = {
						Start = "Casting [LINK] on [TARGET]!",
						End = "Successfully resurrected [TARGET]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = true,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				Rebirth = {
					Messages = {
						Start = "Casting [LINK] on [TARGET]!",
						End = "Successfully resurrected [TARGET]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = true,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				TreeOfLife = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				Barkskin = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				Thorns = {
					Messages = {
						Start = "[LINK] cast on [TARGET]!",
						End = "",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = true,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				Tranquility = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				ChallengingRoar = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				Berserk = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				RemoveCorruption = {
					Messages = {
						Start = "Removed [TARGET]'s [AURALINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				Roots = {
					Messages = {
						Start = "[LINK] cast on [TARGET]!",
						End = "[LINK] on [TARGET] ended!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				Soothe = {
					Messages = {
						Start = "Purged [TARGET]'s [AURALINK]!",
						End = "[TARGET] resisted [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				StampedingRoar = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = true,
					},
				}, -- End
				SolarBeam = {
					Messages = {
						Start = "Interrupted [TARGET]'s [TARLINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
			},
		},
		Hunter = {
			Reminders = {
				SpellName = "",
			},
			Spells = {
				Misdirection = {
					Messages = {
						Primer = "[LINK] primed on [TARGET]!",
						Start = "[LINK] started on [TARGET]!",
						End = "[LINK] on [TARGET] ended! [AMOUNT] additional threat for 30 seconds.",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = true,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				WidowVenom = {
					Messages = {
						Start = "[LINK] cast on [TARGET]!",
						End = "[LINK] on [TARGET] ended!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				ConcussiveShot = {
					Messages = {
						Start = "[LINK] cast on [TARGET]!",
						End = "[LINK] on [TARGET] ended!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				ScatterShot = {
					Messages = {
						Start = "[LINK] cast on [TARGET]!",
						End = "[LINK] on [TARGET] ended!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				FreezingTrap = {
					Messages = {
						Placement = "[LINK] Placed!",
						Start = "[LINK] hit [TARGET]!",
						End = "[LINK] on [TARGET] ended!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				SilencingShot = {
					Messages = {
						Start = "Interrupted [TARGET]'s [TARLINK]!",
						End = "My [LINK] [MISSTYPE] [TARGET]!",
						Immune = "[TARGET] is [MISSTYPE] to my [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				TranquilizingShot = {
					Messages = {
						Start = "Removed [TARGET]'s [AURALINK]!",
						End = "[TARGET] resisted [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				WyvernSting = {
					Messages = {
						Start = "[LINK] cast on [TARGET]!",
						End = "[LINK] on [TARGET] ended!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				Deterrence = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				Camoflage = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				DistractingShot = {
					Messages = {
						Start = "Taunted [TARGET]!",
						End = "My [LINK] [MISSTYPE] [TARGET]!",
						Immune = "[TARGET] is [MISSTYPE] to my [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = true,
					},
				}, -- End
				MastersCall = {
					Messages = {
						Start = "[LINK] cast on [TARGET]!",
						End = "",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = true,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				RoarOfSacrifice = {
					Messages = {
						Start = "[LINK] cast on [TARGET]!",
						End = "",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = true,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
			},
		},
		Mage = {
			Reminders = {
				SpellName = "",
			},
			Spells = {
				TimeWarp = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				Spellsteal = {
					Messages = {
						Start = "Stole [TARGET]'s [AURALINK]!",
						End = "[TARGET] resisted [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				Polymorph = {
					Messages = {
						Start = "[LINK] cast on [TARGET]!",
						End = "[LINK] on [TARGET] ended!",
						Immune = "[TARGET] is [MISSTYPE] to my [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				Counterspell = {
					Messages = {
						Start = "Counterspelled [TARGET]'s [TARLINK]!",
						End = "My [LINK] [MISSTYPE] [TARGET]!",
						Immune = "[TARGET] is [MISSTYPE] to my [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				Portals = {
					Messages = {
						Start = "Casting [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				Teleport = {
					Messages = {
						Start = "Warning you are Teleporting, and leaving your friends behind!",
					},
					Local = true,
				}, -- End
				RefreshmentTable = {
					Messages = {
						Start = "Casting [LINK], please assist!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				RingOfFrost = {
					Messages = {
						Start = "[LINK] activated!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				Cauterize = {
					Messages = {
						Start = "[LINK] activated, please heal me!",
						End = "[LINK] faded, I'm no longer burning!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				IceBlock = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				FocusMagic = {
					Messages = {
						Start = "[LINK] cast on [TARGET]!",
						End = "[LINK] on [TARGET] ended!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = true,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				SlowFall = {
					Messages = {
						Start = "[LINK] cast on [TARGET]!",
						End = "[LINK] on [TARGET] ended!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = true,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
			},
		},
		Paladin = {
			Reminders = {
				SpellName = "",
			},
			Spells = {
				ArdentDefender = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
						Heal = "[LINK] saved my life and healed me for [AMOUNT] hp!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				AuraMastery = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				DivineProtection = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				Forbearance = {
					Messages = {
						Start = "",
						End = "[LINK] on [TARGET] faded!",
					},
					Local = true,
				}, -- End
				DivineGuardian = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				HandOfFreedom = {
					Messages = {
						Start = "[LINK] cast on [TARGET]!",
						End = "",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = true,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				HandOfProtection = {
					Messages = {
						Start = "[LINK] cast on [TARGET]!",
						End = "",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = true,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				HandOfSacrifice = {
					Messages = {
						Start = "[LINK] cast on [TARGET]!",
						End = "",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = true,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				HandOfSalvation = {
					Messages = {
						Start = "[LINK] cast on [TARGET]!",
						End = "",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = true,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				LayOnHands = {
					Messages = {
						Start = "[LINK] on [TARGET] for [AMOUNT]!",
						End = "",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				GoAK = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				Repentance = {
					Messages = {
						Start = "[LINK] on [TARGET]!",
						End = "[LINK] on [TARGET] has ended!",
						Immune = "[TARGET] is [MISSTYPE] to my [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				Rebuke = {
					Messages = {
						Start = "Interrupted [TARGET]'s [TARLINK]!",
						End = "My [LINK] [MISSTYPE] [TARGET]!",
						Immune = "[TARGET] is [MISSTYPE] to my [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				HandOfReckoning = {
					Messages = {
						Start = "Taunted [TARGET]!",
						End = "My [LINK] [MISSTYPE] [TARGET]!",
						Immune = "[TARGET] is [MISSTYPE] to my [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				RighteousDefense = {
					Messages = {
						Start = "Taunted [TARGET]!",
						End = "My [LINK] [MISSTYPE] [TARGET]!",
						Immune = "[TARGET] is [MISSTYPE] to my [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				Beacon = {
					Messages = {
						Start = "[LINK] cast on [TARGET]!",
						End = "[LINK] on [TARGET] has ended!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = true,
					Whisper = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				Redemption = {
					Messages = {
						Start = "Casting [LINK] on [TARGET]!",
						End = "Successfully resurrected [TARGET]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = true,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				AvengersShield = {
					Messages = {
						Start = "Interrupted [TARGET]'s [TARLINK]!",
						End = "",
						Immune = "",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = true,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				TurnEvil = {
					Messages = {
						Start = "[LINK] [TARGET]!",
						End = "[LINK] on [TARGET] has ended!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				HolyRadiance = {
					Messages = {
						Start = "[LINK] activated, stand close to me if it's safe!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				DivinePlea = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				HammerOfJustice = {
					Messages = {
						Start = "[LINK] on [TARGET]!",
						End = "[LINK] on [TARGET] has ended!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				Cleanse = {
					Messages = {
						Start = "Cleansed [TARGET]'s [AURALINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				HolyShield = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				DivineShield = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				AvengingWrath = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				WordOfGlory = {
					Messages = {
						Start = "[LINK] on [TARGET] for [AMOUNT]!",
						End = "",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
					Minimum = 10000,
				}, -- End
				GbtL = {
					Messages = {
						Start = "I am [LINK] for [AMOUNT]!",
						End = "",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
			},
		},
		Priest = {
			Reminders = {
				SpellName = "",
			},
			Spells = {
				LeapOfFaith = {
					Messages = {
						Start = "Pulling [TARGET] to Me!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = true,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				DivineHymn = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] over!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				HymnOfHope = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] over!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				FearWard = {
					Messages = {
						Start = "[LINK] cast on [TARGET]!",
						End = "[LINK] on [TARGET] ended!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = true,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				Levitate = {
					Messages = {
						Start = "[LINK] cast on [TARGET]!",
						End = "",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				ShackleUndead = {
					Messages = {
						Start = "[LINK] cast on [TARGET]!",
						End = "[LINK] on [TARGET] ended!",
						Immune = "[TARGET] is [MISSTYPE] to my [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				DispelMagic = {
					Messages = {
						Start = "Dispelled [AURALINK] on [TARGET]!",
						End = "[TARGET] resisted [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
					HostileOnly = true,
				}, -- End
				GuardianSpirit = {
					Messages = {
						Start = "[LINK] cast on [TARGET]!",
						End = "[LINK] on [TARGET] ended!",
						Proc = "[LINK] just healed [TARGET] for [AMOUNT]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				PainSuppression = {
					Messages = {
						Start = "[LINK] cast on [TARGET]!",
						End = "[LINK] on [TARGET] ended!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				Lightwell = {
					Messages = {
						Start = "[LINK] activated!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				PowerInfusion = {
					Messages = {
						Start = "[LINK] cast on [TARGET]!",
						End = "",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = true,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				LightwellRenew = {
					Messages = {
						Start = "[TARGET] clicked the Lightwell. [AMOUNT] remain!",
						End = "[TARGET] stole an additional Lightwell charge! [AMOUNT] remain!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = true,
					Whisper = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				PowerWordBarrier = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				CureDisease = {
					Messages = {
						Start = "Cured [TARGET]'s [AURALINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				Resurrection = {
					Messages = {
						Start = "Casting [LINK] on [TARGET]!",
						End = "Successfully resurrected [TARGET]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = true,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				Fade = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				PsychicScream = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				MindSoothe = {
					Messages = {
						Start = "[LINK] cast on [TARGET]!",
						End = "[LINK] on [TARGET] ended!",
						Immune = "[TARGET] is [MISSTYPE] to my [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				MindControl = {
					Messages = {
						Casting = "Casting [LINK] on [TARGET]!",
						Start = "Mindcontrolling [TARGET] Now!",
						End = "[LINK] on [TARGET] ended!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				Silence = {
					Messages = {
						Start = "Interrupted [TARGET]'s [TARLINK]!",
						End = "[LINK] on [TARGET] ended!",
						Debuff = "[LINK] on [TARGET]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				PsychicHorror = {
					Messages = {
						Start = "[LINK] cast on [TARGET]!",
						End = "[LINK] on [TARGET] ended!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				BodyAndSoul = {
					Messages = {
						Start = "[LINK] on [TARGET]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = true,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				Shadowfiend = {
					Messages = {
						Start = "[LINK] activated!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
			},
		},
		Rogue = {
			Reminders = {
				SpellName = "",
			},
			Spells = {
				Sap = {
					Messages = {
						Start = "[LINK] on [TARGET]!",
						End = "[LINK] on [TARGET] has ended!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				Blind = {
					Messages = {
						Start = "[LINK] on [TARGET]!",
						End = "[LINK] on [TARGET] has ended!",
						Resist = "My [LINK] [MISSTYPE] [TARGET]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				Kick = {
					Messages = {
						Start = "Interrupted [TARGET]'s [TARLINK]!",
						End = "My [LINK] [MISSTYPE] [TARGET]!",
						Immune = "[TARGET] is [MISSTYPE] to my [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				Dismantle = {
					Messages = {
						Start = "Dismantled [TARGET]!",
						End = "[LINK] faded from [TARGET]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				Tricks = {
					Messages = {
						Start = "[LINK] cast on [TARGET]!",
						End = "[LINK] gave you an additional [AMOUNT] damage!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = true,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				SmokeBomb = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				Shiv = {
					Messages = {
						Start = "Shived [TARGET]'s [AURALINK]!",
						End = "[TARGET] resisted [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
			},
		},
		Shaman = {
			Reminders = {
				SpellName = "",
			},
			Spells = {
				Hex = {
					Messages = {
						Start = "[LINK] cast on [TARGET]!",
						End = "[LINK] on [TARGET] ended!",
						Immune = "[TARGET] is [MISSTYPE] to my [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				Heroism = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] ended!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				BindElemental = {
					Messages = {
						Start = "[LINK] cast on [TARGET]!",
						End = "[LINK] on [TARGET] ended!",
						Immune = "[TARGET] is [MISSTYPE] to my [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				WindShear = {
					Messages = {
						Start = "Interrupted [TARGET]'s [TARLINK]!",
						End = "My [LINK] [MISSTYPE] [TARGET]!",
						Immune = "[TARGET] is [MISSTYPE] to my [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				Purge = {
					Messages = {
						Start = "Purged [TARGET]'s [AURALINK]!",
						End = "[TARGET] resisted [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				CleanseSpirit = {
					Messages = {
						Start = "Cleansed [TARGET]'s [AURALINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				ManaTide = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				AncestralSpirit = {
					Messages = {
						Start = "Casting [LINK] on [TARGET]!",
						End = "Successfully resurrected [TARGET]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = true,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				SpiritLink = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				TremorTotem = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				Thunderstorm = {
					Messages = {
						Start = "[LINK] activated!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				GroundingTotem = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] absorbed [AMOUNT] from [TARGET]'s [TARLINK]!",
						Immune = "[LINK] absorbed [TARGET]'s [TARLINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
			},
		},
		Warlock = {
			Reminders = {
				SpellName = "",
			},
			Spells = {
				SoulWell = {
					Messages = {
						Start = "Casting [LINK], please assist!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				SummonStone = {
					Messages = {
						Start = "Casting [LINK], please assist!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				Suffering = {
					Messages = {
						Start = "Taunted [TARGET]!",
						End = "My [LINK] [MISSTYPE] [TARGET]!",
						Immune = "[TARGET] is [MISSTYPE] to my [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = true,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				SingeMagic = {
					Messages = {
						Start = "[LINK] on [TARGET] removed [AURALINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = true,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				Banish = {
					Messages = {
						Start = "Banished [TARGET]!",
						End = "[LINK] on [TARGET] has ended!",
						Immune = "[TARGET] is [MISSTYPE] to my [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				Fear = {
					Messages = {
						Start = "Fearing [TARGET]!",
						End = "[LINK] on [TARGET] has ended!",
						Immune = "[TARGET] is [MISSTYPE] to my [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				Seduce = {
					Messages = {
						Start = "Seducing [TARGET]!",
						End = "[LINK] on [TARGET] has ended!",
						Immune = "[TARGET] is [MISSTYPE] to my [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				SpellLock = {
					Messages = {
						Start = "Spell Locked [TARGET]'s [TARLINK]!",
						End = "My [LINK] [MISSTYPE] [TARGET]!",
						Immune = "[TARGET] is [MISSTYPE] to my [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				Devour = {
					Messages = {
						Start = "Devoured [TARGET]'s [AURALINK]!",
						End = "[TARGET] resisted [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = true,
					Whisper = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				Soulstone = {
					Messages = {
						Start = "Casting [LINK] on [TARGET]!",
						End = "Successfully Soulstoned [TARGET]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = true,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				DeathCoil = {
					Messages = {
						Start = "[LINK] on [TARGET]!",
						End = "[LINK] on [TARGET] has ended!",
						Immune = "[TARGET] is [MISSTYPE] to my [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				Shadowfury = {
					Messages = {
						Start = "[LINK] on [TARGET]!",
						End = "[LINK] on [TARGET] has ended!",
						Immune = "[TARGET] is [MISSTYPE] to my [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				HowlOfTerror = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				DarkIntent = {
					Messages = {
						Start = "[LINK] cast on [TARGET]!",
						End = "[LINK] on [TARGET] ended!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = true,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				Soulshatter = {
					Messages = {
						Start = "[LINK] activated!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
			}, -- End Spells
		}, -- End Warlock
		Warrior = {
			Reminders = {
				SpellName = "",
			},
			Spells = {
				ShatteringThrow = {
					Messages = {
						Start = "[LINK] on [TARGET]!",
						End = "[LINK] on [TARGET] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				ShieldWall = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				ChallengingShout = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				Pummel = {
					Messages = {
						Start = "Pummeled [TARGET]'s [TARLINK]!",
						End = "My [LINK] [MISSTYPE] [TARGET]!",
						Immune = "[TARGET] is [MISSTYPE] to my [LINK]!",
						Gag = "[TARGET] is Silenced by my Gag Order!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				Disarm = {
					Messages = {
						Start = "Disarmed [TARGET]!",
						End = "[TARGET] is armed again!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				Taunt = {
					Messages = {
						Start = "Taunted [TARGET]!",
						End = "My [LINK] [MISSTYPE] [TARGET]!",
						Immune = "[TARGET] is [MISSTYPE] to my [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				Vigilance = {
					Messages = {
						Start = "[LINK] cast on [TARGET]!",
						End = "[LINK] on [TARGET] ended!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = true,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				LastStand = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				EnragedRegeneration = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				ShieldBlock = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				SpellReflect = {
					Messages = {
						Start = "Reflected [TARGET]'s [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				Throwdown = {
					Messages = {
						Start = "[LINK] on [TARGET]!",
						End = "[LINK] on [TARGET] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				Recklessness = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				ShieldSlamDispel = {
					Messages = {
						Start = "Dispelled [TARGET]'s [AURALINK]!",
						End = "[TARGET] resisted [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				ConcussionBlow = {
					Messages = {
						Start = "[LINK] on [TARGET]!",
						End = "[LINK] on [TARGET] has ended!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				RallyingCry = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = true,
						Say = false,
					},
				}, -- End
				Intervene = {
					Messages = {
						Start = "[LINK] cast on [TARGET]!",
						End = "",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = true,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
				Retaliation = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Smart = {
						RaidParty = false,
						Say = false,
					},
				}, -- End
			},
		},
	}, -- End Profile
} -- End Defaults
function RSA:OnInitialize() -- Do all this when the addon loads.
	self.db = LibStub("AceDB-3.0"):New("RSADB", defaults) -- Setup Saved Variables
	self:SetSinkStorage(self.db.profile) -- Setup Saved Variables for LibSink
	-- Check what class and race we are and save it. Used to determine what options to show.
	local pRace = select(2, UnitRace("player"))
	self.db.profile.General.Race = pRace
	local pClass = select(2, UnitClass("player"))
	self.db.profile.General.Class = pClass
	db = self.db
	-- Register /RSA command
	self:RegisterChatCommand("RSA", "ChatCommand")
	--@non-alpha@
	if tonumber(GetAddOnMetadata("RSA", "Version")) > tonumber(self.db.global.version) then -- Print when addon is updated.
	print("|cFFFF75B3Raeli's Spell Announcer|r updated to version " .. "|cff00FF00" .. GetAddOnMetadata("RSA", "Version") .. "|r.")
	end
	--@end-non-alpha@
	--[===[@alpha@
	if RSA.db.global.DisableAlphaWarning == false then
		print("|cFFFF75B3Raeli's Spell Announcer|r |cffFF0000alpha|r version " .. "|cff00FF00" .. GetAddOnMetadata("RSA", "Version") .. " r116|r.")
		local RWColor = {r=1, g=1, b=1}
		RaidNotice_AddMessage(RaidWarningFrame, format(L.alpha_message), RWColor)
	end
	--@end-alpha@]===]
	if tonumber(self.db.global.version) < 2.71 then -- Print when addon is updated from an old version.
		print(L.updated_message)
		local RWColor = {r=1, g=1, b=1}
		RaidNotice_AddMessage(RaidWarningFrame, format(L.updated_message), RWColor)
		--message(L.updated_message) -- Creates a Small "Ok" box with the message.
	end
	-- Register current version of RSA
	self.db.global.version = GetAddOnMetadata("RSA", "Version")
	-- Load Reminder Module on startup if it's turned on.
	if RSA.db.profile.Modules.Reminders == true then
		LoadAddOn("RSA_Reminders")
	else
		RSA.db.profile.Modules.Reminders_Loaded = false
	end
	if pClass == "DEATHKNIGHT" then -- Load Class Modules
		local loaded, reason = LoadAddOn("RSA_DeathKnight")
		if not loaded then
			RSA.db.profile.Modules.DeathKnight = false
			if reason == "DISABLED" or reason == "INTERFACE_VERSION" then
				ChatFrame1:AddMessage("|cFFFF75B3RSA:|r Death Knight " .. L.OptionsDisabled .. L.OptionsClass)
			elseif reason == "MISSING" or reason == "CORRUPT" then
				ChatFrame1:AddMessage("|cFFFF75B3RSA:|r Death Knight " .. L.OptionsMissing)
			end
		end
	elseif pClass == "DRUID" then
		local loaded, reason = LoadAddOn("RSA_Druid")
		if not loaded then
			RSA.db.profile.Modules.Druid = false
			if reason == "DISABLED" or reason == "INTERFACE_VERSION" then
				ChatFrame1:AddMessage("|cFFFF75B3RSA:|r Druid " .. L.OptionsDisabled .. L.OptionsClass)
			elseif reason == "MISSING" or reason == "CORRUPT" then
				ChatFrame1:AddMessage("|cFFFF75B3RSA:|r Druid " .. L.OptionsMissing)
			end
		end
	elseif pClass == "HUNTER" then
		local loaded, reason = LoadAddOn("RSA_Hunter")
		if not loaded then
			RSA.db.profile.Modules.Hunter = false
			if reason == "DISABLED" or reason == "INTERFACE_VERSION" then
				ChatFrame1:AddMessage("|cFFFF75B3RSA:|r Hunter " .. L.OptionsDisabled .. L.OptionsClass)
			elseif reason == "MISSING" or reason == "CORRUPT" then
				ChatFrame1:AddMessage("|cFFFF75B3RSA:|r Hunter " .. L.OptionsMissing)
			end
		end
	elseif pClass == "MAGE" then
		local loaded, reason = LoadAddOn("RSA_Mage")
		if not loaded then
			RSA.db.profile.Modules.Mage = false
			if reason == "DISABLED" or reason == "INTERFACE_VERSION" then
				ChatFrame1:AddMessage("|cFFFF75B3RSA:|r Mage " .. L.OptionsDisabled .. L.OptionsClass)
			elseif reason == "MISSING" or reason == "CORRUPT" then
				ChatFrame1:AddMessage("|cFFFF75B3RSA:|r Mage " .. L.OptionsMissing)
			end
		end
	elseif pClass == "PALADIN" then
		local loaded, reason = LoadAddOn("RSA_Paladin")
		if not loaded then
			RSA.db.profile.Modules.Paladin = false
			if reason == "DISABLED" or reason == "INTERFACE_VERSION" then
				ChatFrame1:AddMessage("|cFFFF75B3RSA:|r Paladin " .. L.OptionsDisabled .. L.OptionsClass)
			elseif reason == "MISSING" or reason == "CORRUPT" then
				ChatFrame1:AddMessage("|cFFFF75B3RSA:|r Paladin " .. L.OptionsMissing)
			end
		end
	elseif pClass == "PRIEST" then
		local loaded, reason = LoadAddOn("RSA_Priest")
		if not loaded then
			RSA.db.profile.Modules.Priest = false
			if reason == "DISABLED" or reason == "INTERFACE_VERSION" then
				ChatFrame1:AddMessage("|cFFFF75B3RSA:|r Priest " .. L.OptionsDisabled .. L.OptionsClass)
			elseif reason == "MISSING" or reason == "CORRUPT" then
				ChatFrame1:AddMessage("|cFFFF75B3RSA:|r Priest " .. L.OptionsMissing)
			end
		end
	elseif pClass == "ROGUE" then
		local loaded, reason = LoadAddOn("RSA_Rogue")
		if not loaded then
			RSA.db.profile.Modules.Rogue = false
			if reason == "DISABLED" or reason == "INTERFACE_VERSION" then
				ChatFrame1:AddMessage("|cFFFF75B3RSA:|r Rogue " .. L.OptionsDisabled .. L.OptionsClass)
			elseif reason == "MISSING" or reason == "CORRUPT" then
				ChatFrame1:AddMessage("|cFFFF75B3RSA:|r Rogue " .. L.OptionsMissing)
			end
		end
	elseif pClass == "SHAMAN" then
		local loaded, reason = LoadAddOn("RSA_Shaman")
		if not loaded then
			RSA.db.profile.Modules.Shaman = false
			if reason == "DISABLED" or reason == "INTERFACE_VERSION" then
				ChatFrame1:AddMessage("|cFFFF75B3RSA:|r Shaman " .. L.OptionsDisabled .. L.OptionsClass)
			elseif reason == "MISSING" or reason == "CORRUPT" then
				ChatFrame1:AddMessage("|cFFFF75B3RSA:|r Shaman " .. L.OptionsMissing)
			end
		end
	elseif pClass == "WARLOCK" then
		local loaded, reason = LoadAddOn("RSA_Warlock")
		if not loaded then
			RSA.db.profile.Modules.Warlock = false
			if reason == "DISABLED" or reason == "INTERFACE_VERSION" then
				ChatFrame1:AddMessage("|cFFFF75B3RSA:|r Warlock " .. L.OptionsDisabled .. L.OptionsClass)
			elseif reason == "MISSING" or reason == "CORRUPT" then
				ChatFrame1:AddMessage("|cFFFF75B3RSA:|r Warlock " .. L.OptionsMissing)
			end
		end
	elseif pClass == "WARRIOR" then
		local loaded, reason = LoadAddOn("RSA_Warrior")
		if not loaded then
			RSA.db.profile.Modules.Warrior = false
			if reason == "DISABLED" or reason == "INTERFACE_VERSION" then
				ChatFrame1:AddMessage("|cFFFF75B3RSA:|r Warrior " .. L.OptionsDisabled .. L.OptionsClass)
			elseif reason == "MISSING" or reason == "CORRUPT" then
				ChatFrame1:AddMessage("|cFFFF75B3RSA:|r Warrior " .. L.OptionsMissing)
			end
		end
	end
end -- End OnInitialize
function RSA:OnProfileEnable() -- Need to fill this in better to make changing profiles without reloading possible.
	self.db = self.db.profile
	local pClass = select(2, UnitClass("player"))
		self.db.profile.class = pClass
end
function RSA:ChatCommand(input) -- Handle slash commands. Due to new loading, removed all commands.
	--[===[@alpha@
	if input == "DisableAlphaWarning" then
		RSA.db.global.DisableAlphaWarning = true
		RSA_Print_Self("Will no longer create warnings about alpha version files.")
	elseif input == "EnableAlphaWarning" then
		RSA.db.global.DisableAlphaWarning = false
		RSA_Print_Self("Will create warnings about alpha version files upon login.")
	else
	--@end-alpha@]===]
		InterfaceOptionsFrame_OpenToCategory("Spell Options","RSA")
		InterfaceOptionsFrame_OpenToCategory("RSA","RSA")
	--[===[@alpha@
	end
	--@end-alpha@]===]
end
do -- Adds a blank RSA Panel to the Blizzard Addon Options window, which upon clicked loads RSA Options. No more need to use /rsa.
	local frame = CreateFrame("Frame", nil, UIParent)
	frame.name = "RSA"
	frame:Hide()
	local function removeFrame()
		for k, f in next, INTERFACEOPTIONS_ADDONCATEGORIES do
			if f == frame then
				tremove(INTERFACEOPTIONS_ADDONCATEGORIES, k)
				break
			end
		end
	end
	frame:SetScript("OnShow", function()
		removeFrame()
		local loaded, reason = LoadAddOn("RSA_Options")
		InterfaceOptionsFrame_OpenToCategory("Spell Options","RSA")
		InterfaceOptionsFrame_OpenToCategory("RSA","RSA")
		if not loaded then
			if reason == "DISABLED" or reason == "INTERFACE_VERSION" then
				ChatFrame1:AddMessage("|cFFFF75B3RSA:|r Options " .. L.OptionsDisabled)
			elseif reason == "MISSING" or reason == "CORRUPT" then
				ChatFrame1:AddMessage("|cFFFF75B3RSA:|r Options " .. L.OptionsMissing)
			end
		end
	end)
	InterfaceOptions_AddCategory(frame)
end
--------------------------
---- Global Functions ----
--------------------------
function RSA_AnnouncementCheck() -- Checks against user settings to see if we are allowed to announce.
local InInstance, InstanceType = IsInInstance()
if RSA.db.profile.General.GlobalAnnouncements.OnlyInCombat and not InCombatLockdown() then return false end -- If we're not in combat and only announce in combat, stop right here.
if RSA.db.profile.General.GlobalAnnouncements.InPvP and UnitIsPVP("player") == 1 then return true end
if RSA.db.profile.General.GlobalAnnouncements.Arena and InstanceType == "arena" then return true end
if RSA.db.profile.General.GlobalAnnouncements.Battlegrounds and InstanceType == "pvp" then return true end
if RSA.db.profile.General.GlobalAnnouncements.InDungeon and InstanceType == "party" then return true end
if RSA.db.profile.General.GlobalAnnouncements.InRaid and InstanceType == "raid" then return true end
if RSA.db.profile.General.GlobalAnnouncements.InTolBarad and GetZoneText() == L["Tol Barad"] then return true end
if RSA.db.profile.General.GlobalAnnouncements.InWorld and InstanceType == "none" and GetZoneText() ~= L["Tol Barad"] and UnitIsPVP("player") ~= 1 then return true end
return false
end
function RSA_String_Replace(str) -- Used for custom messages to replace text.
	return RSA_Replacements [str] or str
end
function RSA_CopyText(text) -- Not used at the moment, but perhaps useful in the future.
ChatFrame1EditBox:Show();
ChatFrame1EditBox:SetFocus();
ChatFrame1EditBox:Insert(text);
ChatFrame1EditBox:HighlightText();
end
function RSA_Print_Self(message) -- Send a message to your default chat window.
	ChatFrame1:AddMessage("|cFFFF75B3RSA:|r " .. format(message))
end
function RSA_Print_LibSink(message) -- Sends a message set by LibSink-2.0. Could just use :Pour on the messages themselves, but this is here to save work later if I need to add any additional checks.
	RSA:Pour("|cFFFF75B3RSA:|r " .. message, 1, 1, 1)
end
function RSA_Print_Smart_RaidParty(message) -- Send a message to battleground, raid, party, or nothing, depending on group size or location.
local InInstance, InstanceType = IsInInstance()
local Announced = false
	if RSA_AnnouncementCheck() == true then
		if InstanceType == "pvp" or InstanceType == "arena" then
			SendChatMessage(format(message), "BATTLEGROUND", nil)
			Announced = true
		return end
		if GetNumRaidMembers() > 0 then
			SendChatMessage(format(message), "RAID", nil)
			Announced = true
		elseif GetNumPartyMembers() > 0 then
			SendChatMessage(format(message), "PARTY", nil)
			Announced = true
		return end
		if RSA.db.profile.General.GlobalAnnouncements.SmartSay == true and Announced == false then
			if GetNumRaidMembers() > 0 or GetNumPartyMembers() > 0 then
				SendChatMessage(format(message), "SAY", nil)
			end
		elseif RSA.db.profile.General.GlobalAnnouncements.SmartSay == false then
			SendChatMessage(format(message), "SAY", nil)
		end
	end
end
function RSA_Print_Raid(message) -- Send a message to raid or nothing. Additionally, will not try to send a message if in a Battleground or Arena.
local InInstance, InstanceType = IsInInstance()
	if RSA_AnnouncementCheck() == true then
		if GetNumRaidMembers() > 0 and InstanceType ~= "pvp" and InstanceType ~= "arena" then
			SendChatMessage(format(message), "RAID", nil)
		end
	end
end
function RSA_Print_Party(message) -- Send a message to party or nothing. Additionally, will not try to send a message if in a Battleground.
local InInstance, InstanceType = IsInInstance()
	if RSA_AnnouncementCheck() == true then
		if GetNumPartyMembers() > 0 and InstanceType ~= "pvp" then
			SendChatMessage(format(message), "PARTY", nil)
		end
	end
end
function RSA_Print_Channel(message, channel) -- Send a message to the custom channel that the user defines.
	if RSA_AnnouncementCheck() == true then
		if RSA.db.profile.General.GlobalAnnouncements.SmartCustomChannel == true then
			if GetNumRaidMembers() > 0 or GetNumPartyMembers() > 0 then
			SendChatMessage(format(message), "CHANNEL", nil, GetChannelName(channel))
			end
		elseif RSA.db.profile.General.GlobalAnnouncements.SmartCustomChannel == false then
			SendChatMessage(format(message), "CHANNEL", nil, GetChannelName(channel))
		end
	end
end
function RSA_Print_Self_RW(message) -- Send a message locally to the raid warning frame. Only visible to the user.
	local RWColor = {r=1, g=1, b=1}
	RaidNotice_AddMessage(RaidWarningFrame, "|cFFFF75B3RSA:|r " .. format(message), RWColor)
end
function RSA_Print_RW(message) -- Send a proper message to the raid warning frame.
	if RSA_AnnouncementCheck() == true then
		SendChatMessage(format(message), "RAID_WARNING", nil)
	end
end
function RSA_Print_Whisper(message, target) -- Send a whisper to the target.
	SendChatMessage(format(message), "WHISPER", nil, target)
end
function RSA_Whisperable(destGUID) -- Checks if the unit is a player or not. We can't use Blizzard's API for this since RSA can announce casts for any unit, not just units that fall under UnitID.
-- BUGS TO FIX HERE PROBABLY DISABLED FOR TESTING
return true
--[[
	local first3 = tonumber("0x"..strsub(destGUID, 3,5))
	local unitType = bit.band(first3,0x00f)
	if (unitType == 0x000) then
		--print("Player, ID #", strsub(destGUID,6))
		return true
	elseif (unitType == 0x003) then
		--local creatureID = tonumber("0x"..strsub(destGUID,7,10))
		--local spawnCounter = tonumber("0x"..strsub(destGUID,11))
		--print("NPC, ID #",creatureID,"spawn #",spawnCounter)
		return false
	elseif (unitType == 0x004) then
		--local petID = tonumber("0x"..strsub(destGUID,7,10))
		--local spawnCounter = tonumber("0x"..strsub(destGUID,11))
		--print("Pet, ID #",petID,"spawn #",spawnCounter)
		return false
	elseif (unitType == 0x005) then
		--local creatureID = tonumber("0x"..strsub(destGUID,7,10))
		--local spawnCounter = tonumber("0x"..strsub(destGUID,11))
		--print("Vehicle, ID #",creatureID,"spawn #",spawnCounter)
		return false
	end
	]]--
end
function RSA_Print_Say(message) -- Send a message to Say.
	if RSA_AnnouncementCheck() == true then
		if RSA.db.profile.General.GlobalAnnouncements.SmartSay == true then
			if GetNumRaidMembers() > 0 or GetNumPartyMembers() > 0 then
				SendChatMessage(format(message), "SAY", nil)
			end
		elseif RSA.db.profile.General.GlobalAnnouncements.SmartSay == false then
			SendChatMessage(format(message), "SAY", nil)
		end
	end
end
function RSA_Reload_Link(message1, message2) -- Generates a message with a hyperlink to reload their UI.
ChatFrame1:AddMessage("|cFFFF75B3RSA:|r " .. format(message1) .. "|cffffa0a0|Hrldui:RSA|h[Reload]|h|r" .. format(message2))
end
function RSA_Talents() -- Detects which talent tree a user has primarily.
	if not GetTalentTabInfo( 1 ) then
		return -- Talents aren't loaded yet!
	end
	local specID = GetPrimaryTalentTree()
	if specID then
		return specID
	end
end
function RSA_RaceCheck(Race) -- Detects what race we are. Returns false if it is the same as the arg, true if not.
	if db.profile.General.Race == Race then
		return false
	else
		return true
	end
end
function RSA_CanAnnounce() -- If we are the Raid or Party Leader, or If we have assist in a raid, used for Leader section of General Announcements. TODO: Improve upon this vastly so we can never potentially have multiple raid assistants announcing.
	if IsRaidLeader(pName) then return true end
	if IsPartyLeader(pName) then return true end
	if IsRaidOfficer(pName) then return true end
	return false
end
function RSA_SetBonus(Name) -- Returns the number of items we are wearing of a set passed in the first argument. This would be a table in the class module.
	local Equipped = 0
	local items = RSA_ItemSets[Name]
	if items then
		for i = 1,#items do
			if IsEquippedItem(items[i]) then
				Equipped = Equipped + 1
			end
		end
	end
	return Equipped
end
function RSA_Glyphs(spellID) -- Returns true if the glyph id we pass to it is equipped.
	for i = 1,9 do
		local _, _, _, spell = GetGlyphSocketInfo(i)
		if spell and tonumber(spell) == tonumber(spellID) then
			return true
		end
	end
	return false
end
-------------------------------------------
---- Global Frames and Event Registers ----
-------------------------------------------
RSA_CombatLogMonitor = CreateFrame("Frame", "RSA:CLM")
RSA_CombatLogMonitor:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
RSA_GeneralSpellsMonitor = CreateFrame("Frame", "RSA:GSM")
RSA_GeneralSpellsMonitor:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
---------------------------------------
---- General Announcements Monitor ----
---------------------------------------
local function General_Spells(_, _, _, event, _, _, source, _, _, destGUID, dest, _, _, spellID, spellName, _, missType)
	local petName = UnitName("pet")
	if UnitPlayerOrPetInParty(source) or UnitInRaid(source) or source == pName or source == petName then
		if event == "SPELL_CAST_START" then
			if (spellID == 57426 or spellID == 57426 or spellID == 87643 or spellID == 87915 or spellID == 87644) and RSA_CanAnnounce() then -- FEASTS
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = source,}
				if RSA.db.profile.General.Spells.Feasts.Messages.Start ~= "" then
					if RSA.db.profile.General.Spells.Feasts.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.General.Spells.Feasts.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.General.Spells.Feasts.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.General.Spells.Feasts.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.General.Spells.Feasts.CustomChannel.Channel)
					end
					if RSA.db.profile.General.Spells.Feasts.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.General.Spells.Feasts.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.General.Spells.Feasts.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.General.Spells.Feasts.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.General.Spells.Feasts.Party == true then
						if RSA.db.profile.General.Spells.Feasts.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.General.Spells.Feasts.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.General.Spells.Feasts.Raid == true then
						if RSA.db.profile.General.Spells.Feasts.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.General.Spells.Feasts.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- FEASTS
			if (spellID == 92712 or spellID == 92649) and RSA_CanAnnounce() then -- CAULDRON
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = source,}
				if RSA.db.profile.General.Spells.Cauldron.Messages.Start ~= "" then
					if RSA.db.profile.General.Spells.Cauldron.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.General.Spells.Cauldron.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.General.Spells.Cauldron.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.General.Spells.Cauldron.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.General.Spells.Cauldron.CustomChannel.Channel)
					end
					if RSA.db.profile.General.Spells.Cauldron.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.General.Spells.Cauldron.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.General.Spells.Cauldron.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.General.Spells.Cauldron.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.General.Spells.Cauldron.Party == true then
						if RSA.db.profile.General.Spells.Cauldron.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.General.Spells.Cauldron.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.General.Spells.Cauldron.Raid == true then
						if RSA.db.profile.General.Spells.Cauldron.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.General.Spells.Cauldron.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- CAULDRON
			if spellID == 83967 and source == pName then -- HAVE GROUP, WILL TRAVEL AKA MASS SUMMON
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.General.Spells.MassSummon.Messages.Start ~= "" then
					if RSA.db.profile.General.Spells.MassSummon.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.General.Spells.MassSummon.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.General.Spells.MassSummon.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.General.Spells.MassSummon.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.General.Spells.MassSummon.CustomChannel.Channel)
					end
					if RSA.db.profile.General.Spells.MassSummon.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.General.Spells.MassSummon.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.General.Spells.MassSummon.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.General.Spells.MassSummon.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.General.Spells.MassSummon.Party == true then
						if RSA.db.profile.General.Spells.MassSummon.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.General.Spells.MassSummon.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.General.Spells.MassSummon.Raid == true then
						if RSA.db.profile.General.Spells.MassSummon.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.General.Spells.MassSummon.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- HAVE GROUP, WILL TRAVEL AKA MASS SUMMON
			if spellID == 83968 and source == pName then -- MASS RESURRECTION
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.General.Spells.MassRess.Messages.Start ~= "" then
					if RSA.db.profile.General.Spells.MassRess.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.General.Spells.MassRess.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.General.Spells.MassRess.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.General.Spells.MassRess.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.General.Spells.MassRess.CustomChannel.Channel)
					end
					if RSA.db.profile.General.Spells.MassRess.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.General.Spells.MassRess.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.General.Spells.MassRess.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.General.Spells.MassRess.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.General.Spells.MassRess.Party == true then
						if RSA.db.profile.General.Spells.MassRess.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.General.Spells.MassRess.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.General.Spells.MassRess.Raid == true then
						if RSA.db.profile.General.Spells.MassRess.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.General.Spells.MassRess.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- MASS RESURRECTION
			if spellID == 83958 and RSA_CanAnnounce() then -- MOBILE BANKING
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = source,}
				if RSA.db.profile.General.Spells.MobileBank.Messages.Start ~= "" then
					if RSA.db.profile.General.Spells.MobileBank.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.General.Spells.MobileBank.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.General.Spells.MobileBank.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.General.Spells.MobileBank.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.General.Spells.MobileBank.CustomChannel.Channel)
					end
					if RSA.db.profile.General.Spells.MobileBank.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.General.Spells.MobileBank.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.General.Spells.MobileBank.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.General.Spells.MobileBank.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.General.Spells.MobileBank.Party == true then
						if RSA.db.profile.General.Spells.MobileBank.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.General.Spells.MobileBank.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.General.Spells.MobileBank.Raid == true then
						if RSA.db.profile.General.Spells.MobileBank.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.General.Spells.MobileBank.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- MOBILE BANKING
		end -- IF EVENT IS SPELL_CAST_START
		if event == "SPELL_SUMMON" then
			if spellID == 67826 and RSA_CanAnnounce() then -- JEEVES
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = source,}
				local JeevesGUID = destGUID
				local JeevesSource = source
				if RSA.db.profile.General.Spells.Jeeves.Messages.Start ~= "" then
					if RSA.db.profile.General.Spells.Jeeves.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.General.Spells.Jeeves.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.General.Spells.Jeeves.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.General.Spells.Jeeves.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.General.Spells.Jeeves.CustomChannel.Channel)
					end
					if RSA.db.profile.General.Spells.Jeeves.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.General.Spells.Jeeves.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.General.Spells.Jeeves.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.General.Spells.Jeeves.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.General.Spells.Jeeves.Party == true then
						if RSA.db.profile.General.Spells.Jeeves.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.General.Spells.Jeeves.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.General.Spells.Jeeves.Raid == true then
						if RSA.db.profile.General.Spells.Jeeves.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.General.Spells.Jeeves.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- JEEVES
		end -- IF EVENT IS SPELL_SUMMON
		if event == "SPELL_CAST_SUCCESS" then
			if (spellID == 28880 or spellID == 59547 or spellID == 59544 or spellID == 59542 or spellID == 59548 or spellID == 59543 or spellID == 59545) and source == pName then -- GIFT OF THE NAARU
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.General.Spells.GOTN.Messages.Start ~= "" then
					if RSA.db.profile.General.Spells.GOTN.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.General.Spells.GOTN.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.General.Spells.GOTN.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.General.Spells.GOTN.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.General.Spells.GOTN.CustomChannel.Channel)
					end
					if RSA.db.profile.General.Spells.GOTN.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.General.Spells.GOTN.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.General.Spells.GOTN.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.General.Spells.GOTN.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.General.Spells.GOTN.Party == true then
						if RSA.db.profile.General.Spells.GOTN.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.General.Spells.GOTN.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.General.Spells.GOTN.Raid == true then
						if RSA.db.profile.General.Spells.GOTN.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.General.Spells.GOTN.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- GIFT OF THE NAARU
			if spellID == 59752 and source == pName then -- EVERY MAN FOR HIMSELF
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.General.Spells.EMFH.Messages.Start ~= "" then
					if RSA.db.profile.General.Spells.EMFH.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.General.Spells.EMFH.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.General.Spells.EMFH.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.General.Spells.EMFH.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.General.Spells.EMFH.CustomChannel.Channel)
					end
					if RSA.db.profile.General.Spells.EMFH.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.General.Spells.EMFH.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.General.Spells.EMFH.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.General.Spells.EMFH.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.General.Spells.EMFH.Party == true then
						if RSA.db.profile.General.Spells.EMFH.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.General.Spells.EMFH.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.General.Spells.EMFH.Raid == true then
						if RSA.db.profile.General.Spells.EMFH.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.General.Spells.EMFH.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- EVERY MAN FOR HIMSELF
			if spellID == 20594 and source == pName then -- STONEFORM
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.General.Spells.Stoneform.Messages.Start ~= "" then
					if RSA.db.profile.General.Spells.Stoneform.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.General.Spells.Stoneform.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.General.Spells.Stoneform.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.General.Spells.Stoneform.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.General.Spells.Stoneform.CustomChannel.Channel)
					end
					if RSA.db.profile.General.Spells.Stoneform.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.General.Spells.Stoneform.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.General.Spells.Stoneform.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.General.Spells.Stoneform.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.General.Spells.Stoneform.Party == true then
						if RSA.db.profile.General.Spells.Stoneform.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.General.Spells.Stoneform.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.General.Spells.Stoneform.Raid == true then
						if RSA.db.profile.General.Spells.Stoneform.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.General.Spells.Stoneform.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- STONEFORM
			if spellID == 20549 and source == pName then -- WARSTOMP
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.General.Spells.WarStomp.Messages.Start ~= "" then
					if RSA.db.profile.General.Spells.WarStomp.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.General.Spells.WarStomp.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.General.Spells.WarStomp.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.General.Spells.WarStomp.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.General.Spells.WarStomp.CustomChannel.Channel)
					end
					if RSA.db.profile.General.Spells.WarStomp.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.General.Spells.WarStomp.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.General.Spells.WarStomp.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.General.Spells.WarStomp.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.General.Spells.WarStomp.Party == true then
						if RSA.db.profile.General.Spells.WarStomp.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.General.Spells.WarStomp.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.General.Spells.WarStomp.Raid == true then
						if RSA.db.profile.General.Spells.WarStomp.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.General.Spells.WarStomp.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- WARSTOMP
			if spellID == 7744 and source == pName then -- WILL OF THE FORSAKEN
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = source,}
				if RSA.db.profile.General.Spells.WOTF.Messages.Start ~= "" then
					if RSA.db.profile.General.Spells.WOTF.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.General.Spells.WOTF.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.General.Spells.WOTF.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.General.Spells.WOTF.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.General.Spells.WOTF.CustomChannel.Channel)
					end
					if RSA.db.profile.General.Spells.WOTF.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.General.Spells.WOTF.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.General.Spells.WOTF.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.General.Spells.WOTF.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.General.Spells.WOTF.Party == true then
						if RSA.db.profile.General.Spells.WOTF.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.General.Spells.WOTF.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.General.Spells.WOTF.Raid == true then
						if RSA.db.profile.General.Spells.WOTF.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.General.Spells.WOTF.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- WILL OF THE FORSAKEN
			if spellID == 20589 and source == pName then -- ESCAPE ARTIST
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = source,}
				if RSA.db.profile.General.Spells.EscapeArtist.Messages.Start ~= "" then
					if RSA.db.profile.General.Spells.EscapeArtist.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.General.Spells.EscapeArtist.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.General.Spells.EscapeArtist.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.General.Spells.EscapeArtist.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.General.Spells.EscapeArtist.CustomChannel.Channel)
					end
					if RSA.db.profile.General.Spells.EscapeArtist.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.General.Spells.EscapeArtist.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.General.Spells.EscapeArtist.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.General.Spells.EscapeArtist.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.General.Spells.EscapeArtist.Party == true then
						if RSA.db.profile.General.Spells.EscapeArtist.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.General.Spells.EscapeArtist.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.General.Spells.EscapeArtist.Raid == true then
						if RSA.db.profile.General.Spells.EscapeArtist.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.General.Spells.EscapeArtist.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- ESCAPE ARTIST
			if spellID == 78993 and source == pName then -- POTION OF CONCENTRATION
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = source,}
				if RSA.db.profile.General.Spells.PotionOfConcentration.Messages.Start ~= "" then
					if RSA.db.profile.General.Spells.PotionOfConcentration.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.General.Spells.PotionOfConcentration.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.General.Spells.PotionOfConcentration.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.General.Spells.PotionOfConcentration.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.General.Spells.PotionOfConcentration.CustomChannel.Channel)
					end
					if RSA.db.profile.General.Spells.PotionOfConcentration.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.General.Spells.PotionOfConcentration.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.General.Spells.PotionOfConcentration.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.General.Spells.PotionOfConcentration.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.General.Spells.PotionOfConcentration.Party == true then
						if RSA.db.profile.General.Spells.PotionOfConcentration.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.General.Spells.PotionOfConcentration.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.General.Spells.PotionOfConcentration.Raid == true then
						if RSA.db.profile.General.Spells.PotionOfConcentration.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.General.Spells.PotionOfConcentration.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- POTION OF CONCENTRATION
			if (spellID == 28730 or spellID == 50613 or spellID == 80483 or spellID == 25046 or spellID == 69179) and source == pName then -- ARCANE TORRENT
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = source,}
				if RSA.db.profile.General.Spells.ArcaneTorrent.Messages.Start ~= "" then
					if RSA.db.profile.General.Spells.ArcaneTorrent.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.General.Spells.ArcaneTorrent.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.General.Spells.ArcaneTorrent.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.General.Spells.ArcaneTorrent.Messages.Start, ".%a+.", RSA_String_Replace), RSA.db.profile.General.Spells.ArcaneTorrent.CustomChannel.Channel)
					end
					if RSA.db.profile.General.Spells.ArcaneTorrent.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.General.Spells.ArcaneTorrent.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.General.Spells.ArcaneTorrent.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.General.Spells.ArcaneTorrent.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.General.Spells.ArcaneTorrent.Party == true then
						if RSA.db.profile.General.Spells.ArcaneTorrent.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.General.Spells.ArcaneTorrent.Messages.Start, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.General.Spells.ArcaneTorrent.Raid == true then
						if RSA.db.profile.General.Spells.ArcaneTorrent.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.General.Spells.ArcaneTorrent.Messages.Start, ".%a+.", RSA_String_Replace))
					end
				end
			end -- ARCANE TORRENT
		end -- IF EVENT IS SPELL_CAST_SUCCESS
		if event == "SPELL_AURA_REMOVED" then
			if spellID == 68054 and destGUID == JeevesGUID and RSA_CanAnnounce() then -- JEEVES
				spellinfo = GetSpellInfo(67826)
				spelllinkinfo = GetSpellLink(67826)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = JeevesSource,}
				if RSA.db.profile.General.Spells.Jeeves.Messages.End ~= "" then
					if RSA.db.profile.General.Spells.Jeeves.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.General.Spells.Jeeves.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.General.Spells.Jeeves.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.General.Spells.Jeeves.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.General.Spells.Jeeves.CustomChannel.Channel)
					end
					if RSA.db.profile.General.Spells.Jeeves.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.General.Spells.Jeeves.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.General.Spells.Jeeves.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.General.Spells.Jeeves.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.General.Spells.Jeeves.Party == true then
						if RSA.db.profile.General.Spells.Jeeves.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.General.Spells.Jeeves.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.General.Spells.Jeeves.Raid == true then
						if RSA.db.profile.General.Spells.Jeeves.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.General.Spells.Jeeves.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- JEEVES
			if spellID == 59547 and source == pName then -- GIFT OF THE NAARU
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = source,}
				if RSA.db.profile.General.Spells.GOTN.Messages.End ~= "" then
					if RSA.db.profile.General.Spells.GOTN.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.General.Spells.GOTN.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.General.Spells.GOTN.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.General.Spells.GOTN.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.General.Spells.GOTN.CustomChannel.Channel)
					end
					if RSA.db.profile.General.Spells.GOTN.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.General.Spells.GOTN.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.General.Spells.GOTN.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.General.Spells.GOTN.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.General.Spells.GOTN.Party == true then
						if RSA.db.profile.General.Spells.GOTN.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.General.Spells.GOTN.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.General.Spells.GOTN.Raid == true then
						if RSA.db.profile.General.Spells.GOTN.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.General.Spells.GOTN.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- GIFT OF THE NAARU
			if spellID == 20594 and source == pName then -- STONEFORM
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = source,}
				if RSA.db.profile.General.Spells.Stoneform.Messages.End ~= "" then
					if RSA.db.profile.General.Spells.Stoneform.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.General.Spells.Stoneform.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.General.Spells.Stoneform.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.General.Spells.Stoneform.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.General.Spells.Stoneform.CustomChannel.Channel)
					end
					if RSA.db.profile.General.Spells.Stoneform.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.General.Spells.Stoneform.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.General.Spells.Stoneform.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.General.Spells.Stoneform.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.General.Spells.Stoneform.Party == true then
						if RSA.db.profile.General.Spells.Stoneform.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.General.Spells.Stoneform.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.General.Spells.Stoneform.Raid == true then
						if RSA.db.profile.General.Spells.Stoneform.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.General.Spells.Stoneform.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- STONEFORM
			if spellID == 78993 and source == pName then -- POTION OF CONCENTRATION
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA_Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = source,}
				if RSA.db.profile.General.Spells.PotionOfConcentration.Messages.End ~= "" then
					if RSA.db.profile.General.Spells.PotionOfConcentration.Local == true then
						RSA_Print_LibSink(string.gsub(RSA.db.profile.General.Spells.PotionOfConcentration.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.General.Spells.PotionOfConcentration.CustomChannel.Enabled == true then
						RSA_Print_Channel(string.gsub(RSA.db.profile.General.Spells.PotionOfConcentration.Messages.End, ".%a+.", RSA_String_Replace), RSA.db.profile.General.Spells.PotionOfConcentration.CustomChannel.Channel)
					end
					if RSA.db.profile.General.Spells.PotionOfConcentration.Smart.Say == true then
						RSA_Print_Say(string.gsub(RSA.db.profile.General.Spells.PotionOfConcentration.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.General.Spells.PotionOfConcentration.Smart.RaidParty == true then
						RSA_Print_Smart_RaidParty(string.gsub(RSA.db.profile.General.Spells.PotionOfConcentration.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.General.Spells.PotionOfConcentration.Party == true then
						if RSA.db.profile.General.Spells.PotionOfConcentration.Smart.RaidParty == true and GetNumRaidMembers() == 0 and InstanceType ~= "arena" then return end
							RSA_Print_Party(string.gsub(RSA.db.profile.General.Spells.PotionOfConcentration.Messages.End, ".%a+.", RSA_String_Replace))
					end
					if RSA.db.profile.General.Spells.PotionOfConcentration.Raid == true then
						if RSA.db.profile.General.Spells.PotionOfConcentration.Smart.RaidParty == true and GetNumRaidMembers() > 0 then return end
						RSA_Print_Raid(string.gsub(RSA.db.profile.General.Spells.PotionOfConcentration.Messages.End, ".%a+.", RSA_String_Replace))
					end
				end
			end -- POTION OF CONCENTRATION
		end -- IF EVENT IS SPELL_AURA_REMOVED
	end
end -- END ENTIRELY
RSA_GeneralSpellsMonitor:SetScript("OnEvent", General_Spells)