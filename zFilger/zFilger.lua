
local configmode = false

local spells = {
	["DRUID"] = {
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Interval = 4,
			Opacity = 1,
			Mode = "ICON",

			-- Lifebloom/Bluhendes Leben
			{ spellID = 33763, size = 24, unitId = "player", caster = "player", filter = "BUFF" },
			-- Rejuvenation/Verjungung
			{ spellID = 774, size = 24, unitId = "player", caster = "player", filter = "BUFF" },
			-- Regrowth/Nachwachsen
			{ spellID = 8936, size = 24, unitId = "player", caster = "player", filter = "BUFF" },
			-- Wild Growth/Wildwuchs
			{ spellID = 48438, size = 24, unitId = "player", caster = "player", filter = "BUFF" },
			-- Berserk
			{ spellID = 50334, size = 42, unitId = "player", caster = "all", filter = "BUFF" },
			-- TF
			{ spellID = 5217, size = 42, unitId = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "T_BUFF_ICON",
			Direction = "RIGHT",
			Interval = 4,
			Opacity = 1,
			Mode = "ICON",

			-- Lifebloom/Bluhendes Leben
			{ spellID = 33763, size = 24, unitId = "target", caster = "player", filter = "BUFF" },
			-- Rejuvenation/Verjungung
			{ spellID = 774, size = 24, unitId = "target", caster = "player", filter = "BUFF" },
			-- Regrowth/Nachwachsen
			{ spellID = 8936, size = 24, unitId = "target", caster = "player", filter = "BUFF" },
			-- Wild Growth/Wildwuchs
			{ spellID = 48438, size = 24, unitId = "target", caster = "player", filter = "BUFF" },
		},
		{
			Name = "P_PROC_ICON",
			Direction = "LEFT",
			Interval = 4,
			Mode = "ICON",

			-- Eclipse (Lunar)/Mondfinsternis
			{ spellID = 48518, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Eclipse (Solar)/Sonnenfinsternis
			{ spellID = 48517, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Shooting Stars/Sternschnuppen
			{ spellID = 93400, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Savage Roar/Wildes Brullen
			{ spellID = 52610, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Survival Instincts/Uberlebensinstinkte
			{ spellID = 61336, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Tree of Life/Baum des Lebens
			{ spellID = 33891, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Clearcasting/Freizaubern
			{ spellID = 16870, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Innervate/Anregen
			{ spellID = 29166, size = 30, unitId = "player", caster = "all", filter = "BUFF" },
			-- Barkskin/Baumrinde
			{ spellID = 22812, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Interval = 4,
			Mode = "ICON",

			-- Hibernate/Winterschlaf
			{ spellID = 2637, size = 30, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Entangling Roots/Wucherwurzeln
			{ spellID = 339, size = 30, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Cyclone/Wirbelsturm
			{ spellID = 33786, size = 30, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Moonfire/Mondfeuer
			{ spellID = 8921, size = 30, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Sunfire/Sonnenfeuer
			{ spellID = 93402, size = 30, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Insect Swarm/Insektenschwarm
			{ spellID = 5570, size = 30, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Rake/Krallenhieb
			{ spellID = 1822, size = 30, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Rip/Zerfetzen
			{ spellID = 1079, size = 30, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Lacerate/Aufschlitzen
			{ spellID = 33745, size = 30, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Pounce Bleed/Anspringblutung
			{ spellID = 9007, size = 30, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Mangle/Zerfleischen
			{ spellID = 33876, size = 30, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Earth and Moon/Erde und Mond
			{ spellID = 48506, size = 30, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Faerie Fire/Feenfeuer
			{ spellID = 770, size = 30, unitId = "target", caster = "all", filter = "DEBUFF" },
		},
		{
			Name = "F/DEBUFF_BAR",
			Direction = "UP",
			IconSide = "LEFT",
			Interval = 4,
			Mode = "BAR",

			-- Hibernate/Winterschlaf
			{ spellID = 2637, size = 24, barWidth = 200, unitId = "focus", caster = "all", filter = "DEBUFF" },
			-- Entangling Roots/Wucherwurzeln
			{ spellID = 339, size = 24, barWidth = 200, unitId = "focus", caster = "all", filter = "DEBUFF" },
			-- Cyclone/Wirbelsturm
			{ spellID = 33786, size = 24, barWidth = 200, unitId = "focus", caster = "all", filter = "DEBUFF" },
		},

		{
			Name = "CD/HEAL",
			Direction = "UP",
			IconSide = "RIGHT",
			Interval = 4,
			Mode = "BAR",

			-- Swiftmend/Rasche Heilung
			{ spellID = 18562, size = 24, barWidth = 200, filter = "CD" },
			-- Wild Growth/Wildwuchs
			{ spellID = 48438, size = 24, barWidth = 200, filter = "CD" },
		},
	},
	["HUNTER"] = {
		{
			Name = "P_PROC_ICON",
			Direction = "LEFT",
			Interval = 4,
			Mode = "ICON",

			-- Lock and Load
			{ spellID = 56342, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Fury of the Five Flights
			{ spellID = 60314, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Master Tactician
			{ spellID = 34837, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Improved Steady Shot/Verbesserter zuverlassiger Schuss
			{ spellID = 53224, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Ready, Set, Aim...
			{ spellID = 82925, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Fire!
			{ spellID = 82926, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Expose Weakness
			--{ spellID = 34503, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Rapid Fire
			{ spellID = 3045, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Call of the Wild
			{ spellID = 53434, size = 30, unitId = "player", caster = "pet", filter = "BUFF" },
			-- Mend Pet/Tier heilen
			{ spellID = 136, size = 30, unitId = "pet", caster = "player", filter = "BUFF" },
			-- Feed Pet/Tier futtern
			{ spellID = 6991, size = 30, unitId = "pet", caster = "player", filter = "BUFF" },
			
			{ spellID = 99623, size = 30, unitId = "player", caster = "all", filter = "BUFF" },
			-- Essence of the Cyclone 372
			{ spellID = 92351, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- 4t12
			{ spellID = 99060, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Interval = 4,
			Mode = "ICON",

			-- Wyvern Sting
			{ spellID = 19386, size = 30, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Silencing Shot
			{ spellID = 34490, size = 30, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Serpent Sting
			{ spellID = 1978, size = 30, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Piercing Shots
			{ spellID = 53238, size = 30, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Scorpid Sting
			--{ spellID = 3043, size = 30, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Black Arrow
			{ spellID = 3674, size = 30, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Explosive Shot
			{ spellID = 53301, size = 30, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Hunter's Mark
			{ spellID = 1130, size = 30, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Hunter's Mark
			{ spellID = 88691, size = 30, unitId = "target", caster = "all", filter = "DEBUFF" },

		},
		{
			Name = "F/DEBUFF_BAR",
			Direction = "UP",
			IconSide = "LEFT",
			Interval = 4,
			Mode = "BAR",

			-- Wyvern Sting
			{ spellID = 19386, size = 24, barWidth = 200, unitId = "focus", caster = "all", filter = "DEBUFF" },
			-- Silencing Shot
			{ spellID = 34490, size = 24, barWidth = 200, unitId = "focus", caster = "all", filter = "DEBUFF" },
		},
               
{
			Name = "CD/HEAL",
			Direction = "UP",
			IconSide = "RIGHT",
			Interval = 4,
			Mode = "BAR",

			-- Swiftmend/Rasche Heilung
			{ spellID = 18562, size = 24, barWidth = 200, filter = "CD" },
			-- Wild Growth/Wildwuchs
			{ spellID = 48438, size = 24, barWidth = 200, filter = "CD" },
		},
	},
	["MAGE"] = {
		{
			Name = "P_PROC_ICON",
			Direction = "LEFT",
			Interval = 4,
			Mode = "ICON",

			-- Frostbite
			--{ spellID = 11071, size = 30, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Winter's Chill
			{ spellID = 28593, size = 30, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Fingers of Frost
			{ spellID = 44544, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Fireball!
			{ spellID = 57761, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Hot Streak
			{ spellID = 44445, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Missile Barrage
			{ spellID = 54486, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Clearcasting
			{ spellID = 12536, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Impact
			{ spellID = 12358, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Interval = 4,
			Mode = "ICON",

			-- Polymorph
			{ spellID = 118, size = 30, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Arcane Blast
			{ spellID = 36032, size = 30, unitId = "player", caster = "player", filter = "DEBUFF" },
			-- Improved Scorch
			{ spellID = 11367, size = 30, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Scorch
			{ spellID = 2948, size = 30, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Slow
			{ spellID = 31589, size = 30, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Ignite
			{ spellID = 11119, size = 30, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Living Bomb
			{ spellID = 44457, size = 30, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Pyroblast!
			{ spellID = 92315, size = 30, unitId = "player", caster = "player", filter = "DEBUFF" },
		},
		{
			Name = "F/DEBUFF_BAR",
			Direction = "UP",
			IconSide = "LEFT",
			Interval = 4,
			Mode = "BAR",

			-- Polymorph
			{ spellID = 118, size = 24, barWidth = 191, unitId = "focus", caster = "all", filter = "DEBUFF" },
		},
	},
	["WARRIOR"] = {
		{
			Name = "P_PROC_ICON",
			Direction = "LEFT",
			Interval = 4,
			Mode = "ICON",

			-- Sudden Death / Plotzlicher Tod
			{ spellID = 52437, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Bloodsurge / Schaumendes Blut
			{ spellID = 46916, size = 30, unitId = "player", caster = "all", filter = "BUFF" },
			-- Sword and Board / Schwert und Schild
			{ spellID = 50227, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Blood Reserve / Blutreserve
			{ spellID = 64568, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Spell Reflection / Zauberreflexion
			{ spellID = 23920, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Victory Rush / Siegesrausch
			{ spellID = 34428, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Shield Block / Schildblock
			{ spellID = 2565, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Last Stand / Letztes Gefecht
			{ spellID = 12975, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Shield Wall / Schildwall
			{ spellID = 871, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Interval = 4,
			Mode = "ICON",

			-- Charge Stun / Sturmangriffsbetaubung
			{ spellID = 7922, size = 30, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Shockwave / Schockwelle
			{ spellID = 46968, size = 30, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Hamstring / Kniesehne
			{ spellID = 1715, size = 30, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Rend / Verwunden
			{ spellID = 94009, size = 30, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Sunder Armor /Rustung zerrei?e
			{ spellID = 7386, size = 30, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Thunder Clap / Donnerknall
			{ spellID = 6343, size = 30, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Demoralizing Shout / Demoralisierender Ruf
			{ spellID = 1160, size = 30, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Expose Armor / Rustung schwachen (Rogue)
			{ spellID = 8647, size = 30, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Infected Wounds / Infizierte Wunden (Druid)
			{ spellID = 48484, size = 30, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Frost Fever / Frostfieber (Death Knight)
			{ spellID = 55095, size = 30, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Demoralizing Roar / Demoralisierendes Gebrull (Druid)
			{ spellID = 99, size = 30, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Curse of Weakness / Fluch der Schwache (Warlock)
			{ spellID = 702, size = 30, unitId = "target", caster = "all", filter = "DEBUFF" },
			
		},
	},
	["SHAMAN"] = {
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Interval = 4,
			Mode = "ICON",

			-- Earth Shield/Erdschild
			{ spellID = 974, size = 24, unitId = "player", caster = "player", filter = "BUFF" },
			-- Riptide/Springflut
			{ spellID = 61295, size = 24, unitId = "player", caster = "player", filter = "BUFF" },
			-- Water Shield/Wasserschild
			{ spellID = 52127, size = 24, unitId = "player", caster = "player", filter = "BUFF" },
			-- Elemental Devastation
			{ spellID = 29180, size = 24, unitId = "player", caster = "player", filter = "BUFF" },
			-- Flurry
			{ spellID = 12966, size = 24, unitId = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "T_BUFF_ICON",
			Direction = "RIGHT",
			Interval = 4,
			Mode = "ICON",

			-- Earth Shield/Erdschild
			{ spellID = 974, size = 24, unitId = "target", caster = "player", filter = "BUFF" },
			-- Riptide/Springflut
			{ spellID = 61295, size = 24, unitId = "target", caster = "player", filter = "BUFF" },
		},
		{
			Name = "P_PROC_ICON",
			Direction = "LEFT",
			Interval = 4,
			Mode = "ICON",

			-- Maelstorm Weapon
			{ spellID = 53817, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Shamanistic Rage
			{ spellID = 30823, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Clearcasting
			{ spellID = 16246, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Tidal Waves
			{ spellID = 51562, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Ancestral Fortitude
			{ spellID = 16236, size = 30, barWidth = 187, unitId = "target", caster = "player", filter = "BUFF" },
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Interval = 4,
			Mode = "ICON",

			-- Hex
			{ spellID = 51514, size = 30, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Storm Strike
			{ spellID = 17364, size = 30, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Earth Shock
			{ spellID = 8042, size = 30, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Frost Shock
			{ spellID = 8056, size = 30, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Flame Shock
			{ spellID = 8050, size = 30, unitId = "target", caster = "player", filter = "DEBUFF" },
		},
		{
			Name = "F/DEBUFF_BAR",
			Direction = "UP",
			IconSide = "LEFT",
			Interval = 4,
			Mode = "BAR",

			-- Hex
			{ spellID = 51514, size = 24, barWidth = 200, unitId = "focus", caster = "all", filter = "DEBUFF" },
		},
	},
	["PALADIN"] = {
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Interval = 4,
			Opacity = 1,
			Mode = "ICON",

			-- Beacon of Light/Flamme des Glaubens
			{ spellID = 53563, size = 24, unitId = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "T_BUFF_ICON",
			Direction = "RIGHT",
			Interval = 4,
			Opacity = 1,
			Mode = "ICON",

			-- Beacon of Light/Flamme des Glaubens
			{ spellID = 53563, size = 24, unitId = "target", caster = "player", filter = "BUFF" },
		},
		{
			Name = "P_PROC_ICON",
			Direction = "LEFT",
			Interval = 4,
			Mode = "ICON",

			-- Judgements of the Pure / Richturteile des Reinen
			{ spellID = 53671, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Judgements of the Just / Richturteil des Gerechten
			{ spellID = 68055, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Holy Shield / Heiliger Schild
			{ spellID = 20925, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Infusion of Light / Lichtenergie
			{ spellID = 53672, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Divine Plea / Gottliche Bitte
			{ spellID = 54428, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Essence of Life / Essenz des Lebens
			{ spellID = 60062, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Divine Illumination / Gottliche Gunst
			{ spellID = 31842, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Interval = 4,
			Mode = "ICON",

			-- Hammer of Justice/Hammer der Gerechtigkeit
			{ spellID = 853, size = 30, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Judgement of Light
			{ spellID = 20271, size = 30, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Judgement of Justice
			--{ spellID = 53407, size = 30, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Judgement of Wisdom
			--{ spellID = 20186, size = 30, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Heart of the Crusader
			--{ spellID = 54499, size = 30, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Blood Corruption
			--{ spellID = 53742, size = 30, unitId = "target", caster = "player", filter = "DEBUFF" },
		},
		{
			Name = "F/DEBUFF_BAR",
			Direction = "UP",
			IconSide = "LEFT",
			Interval = 4,
			Mode = "BAR",

			-- Hammer of Justice/Hammer der Gerechtigkeit
			{ spellID = 853, size = 24, barWidth = 200, unitId = "focus", caster = "all", filter = "DEBUFF" },
		},
	},
	["PRIEST"] = {
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Interval = 4,
			Mode = "ICON",

			-- Prayer of Mending/Gebet der Besserung
			{ spellID = 41637, size = 24, unitId = "player", caster = "player", filter = "BUFF" },
			-- Guardian Spirit/Schutzgeist
			{ spellID = 47788, size = 24, unitId = "player", caster = "player", filter = "BUFF" },
			-- Pain Suppression/Schmerzunterdruckung
			{ spellID = 33206, size = 24, unitId = "player", caster = "player", filter = "BUFF" },
			-- Power Word: Shield/Machtwort: Schild
			{ spellID = 17, size = 24, unitId = "player", caster = "player", filter = "BUFF" },
			-- Renew/Erneuerung
			{ spellID = 139, size = 24, unitId = "player", caster = "player", filter = "BUFF" },
			-- Fade/Verblassen
			{ spellID = 586, size = 24, unitId = "player", caster = "player", filter = "BUFF" },
			-- Fear Ward/Furchtzauberschutz
			{ spellID = 6346, size = 24, unitId = "player", caster = "player", filter = "BUFF" },
			-- Dark Archangel
			{ spellID = 87153, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Dark Evangelism
			{ spellID = 87117, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Shadow Orb Power
			{ spellID = 95799, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "T_BUFF_ICON",
			Direction = "RIGHT",
			Interval = 4,
			Mode = "ICON",

			-- Prayer of Mending/Gebet der Besserung
			{ spellID = 41637, size = 24, unitId = "target", caster = "player", filter = "BUFF" },
			-- Guardian Spirit/Schutzgeist
			{ spellID = 47788, size = 24, unitId = "target", caster = "player", filter = "BUFF" },
			-- Pain Suppression/Schmerzunterdruckung
			{ spellID = 33206, size = 24, unitId = "target", caster = "player", filter = "BUFF" },
			-- Power Word: Shield/Machtwort: Schild
			{ spellID = 17, size = 24, unitId = "target", caster = "player", filter = "BUFF" },
			-- Renew/Erneuerung
			{ spellID = 139, size = 24, unitId = "target", caster = "player", filter = "BUFF" },
			-- Fear Ward/Furchtzauberschutz
			{ spellID = 6346, size = 24, unitId = "target", caster = "player", filter = "BUFF" },
		},
		{
			Name = "P_PROC_ICON",
			Direction = "LEFT",
			Interval = 4,
			Mode = "ICON",

			-- Surge of Light
			{ spellID = 88688, size = 30, unitId = "player", caster = "all", filter = "BUFF" },
			-- Serendipity
			{ spellID = 63730, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Shadow Weaving
			--{ spellID = 15258, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Improved Spirit Tap
			-- { spellID = 59000, size = 37, unitId = "player", caster = "all", filter = "BUFF" },
			-- Shadow Orb
			{ spellID = 77487, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Archangel
			{ spellID = 81700, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Evangelism
			{ spellID = 81661, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Dispersion
			{ spellID = 47585, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Interval = 4,
			Mode = "ICON",

			-- Shackle undead
			{ spellID = 9484, size = 30, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Psychic Scream
			{ spellID = 8122, size = 30, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Shadow Word: Pain
			{ spellID = 589, size = 30, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Devouring Plague
			{ spellID = 2944, size = 30, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Vampiric Touch
			{ spellID = 34914, size = 30, unitId = "target", caster = "player", filter = "DEBUFF" },
		},
		{
			Name = "F/DEBUFF_BAR",
			Direction = "UP",
			IconSide = "LEFT",
			Interval = 4,
			Mode = "BAR",

			-- Shackle undead
			{ spellID = 9484, size = 24, barWidth = 200, unitId = "focus", caster = "all", filter = "DEBUFF" },
			-- Psychic Scream
			{ spellID = 8122, size = 24, barWidth = 200, unitId = "focus", caster = "all", filter = "DEBUFF" },
		},
	},
	["WARLOCK"] = {
		{
			Name = "P_PROC_ICON",
			Direction = "LEFT",
			Interval = 4,
			Mode = "ICON",

			--Devious Minds/Teuflische Absichten
			{ spellID = 70840, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Molten Core
			{ spellID = 47383, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Decimation
			{ spellID = 63158, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Backdraft
			{ spellID = 54277, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Backlash
			{ spellID = 34939, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Nether Protection
			{ spellID = 30301, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Nightfall
			{ spellID = 18095, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Burning Soul
			{ spellID = 74434, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Improved Soul Fire
			{ spellID = 18120, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Fel Spark
			{ spellID = 89937, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Empowered Imp
			{ spellID = 47220, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Replenishment
			{ spellID = 57669, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Nether Ward
			{ spellID = 91713, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Interval = 4,
			Mode = "ICON",

			-- Fear
			{ spellID = 5782, size = 30, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Banish
			{ spellID = 710, size = 30, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Curse of the Elements
			{ spellID = 1490, size = 30, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Curse of Tongues
			{ spellID = 1714, size = 30, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Curse of Exhaustion
			{ spellID = 18223, size = 30, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Curse of Weakness
			{ spellID = 702, size = 30, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Shadow Embrace
			{ spellID = 32385, size = 30, unitId = "target", caster = "player", filter = "BUFF" },
			-- Corruption
			{ spellID = 172, size = 30, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Immolate
			{ spellID = 348, size = 30, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Curse of Agony
			{ spellID = 980, size = 30, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Bane of Doom
			{ spellID = 603, size = 30, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Unstable Affliction
			{ spellID = 30108, size = 30, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Haunt
			{ spellID = 48181, size = 30, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Seed of Corruption
			{ spellID = 27243, size = 30, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Howl of Terror
			{ spellID = 5484, size = 30, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Death Coil
			{ spellID = 6789, size = 30, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Enslave Demon
			{ spellID = 1098, size = 30, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Demon Charge
			{ spellID = 54785, size = 30, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Bane of Havoc
			{ spellID = 80240, size = 30, unitId = "target", caster = "player", filter = "DEBUFF" },
		},
		{
			Name = "F/DEBUFF_BAR",
			Direction = "UP",
			IconSide = "RIGHT",
			Interval = 4,
			Mode = "BAR",

			-- Fear
			{ spellID = 5782, size = 24, barWidth = 200, unitId = "focus", caster = "all", filter = "DEBUFF" },
			-- Banish
			{ spellID = 710, size = 24, barWidth = 200, unitId = "focus", caster = "all", filter = "DEBUFF" },
		},
	},
	["ROGUE"] = {
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Interval = 4,
			Mode = "ICON",

			-- Sprint
			{ spellID = 2983, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Cloak of Shadows
			{ spellID = 31224, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Adrenaline Rush
			{ spellID = 13750, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Evasion
			{ spellID = 5277, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Envenom
			{ spellID = 32645, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Overkill
			{ spellID = 58426, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Slice and Dice
			{ spellID = 5171, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
				{ spellID = 84745, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
					{ spellID = 84746, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
						{ spellID = 84747, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
						
			-- Tricks of the Trade
			{ spellID = 57934, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Turn the Tables
			{ spellID = 51627, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Interval = 4,
			Mode = "ICON",

			-- Cheap shot
			{ spellID = 1833, size = 30, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Kidney shot
			{ spellID = 408, size = 30, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Blind
			{ spellID = 2094, size = 30, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Sap
			{ spellID = 6770, size = 30, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Rupture
			{ spellID = 1943, size = 30, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Garrote
			{ spellID = 703, size = 30, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Gouge
			{ spellID = 1776, size = 30, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Expose Armor
			{ spellID = 8647, size = 30, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Dismantle
			{ spellID = 51722, size = 30, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Deadly Poison
			{ spellID = 2818, size = 30, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Mind-numbing Poison
			{ spellID = 5760, size = 30, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Crippling Poison
			{ spellID = 3409, size = 30, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Wound Poison
			{ spellID = 13218, size = 30, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Revealing Strike  
			{ spellID = 84617, size = 30, unitId = "target", caster = "player", filter = "DEBUFF" },
		},
		{
			Name = "F/DEBUFF_BAR",
			Direction = "UP",
			IconSide = "LEFT",
			Interval = 4,
			Mode = "BAR",

			-- Blind
			{ spellID = 2094, size = 24, barWidth = 200, unitId = "focus", caster = "all", filter = "DEBUFF" },
			-- Sap
			{ spellID = 6770, size = 24, barWidth = 200, unitId = "focus", caster = "all", filter = "DEBUFF" },
		},
	},
	["DEATHKNIGHT"] = {
		{
			Name = "P_PROC_ICON",
			Direction = "LEFT",
			Interval = 4,
			Mode = "ICON",

			-- Blood Shield/Blutschild
			{ spellID = 77513, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Unholy Force/Unheilige Kraft
			{ spellID = 67383, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Unholy Strength/Unheilige Starke
			{ spellID = 53365, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Unholy Might/Unheilige Macht
			{ spellID = 67117, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Dancing Rune Weapon/Tanzende Runenwaffe
			{ spellID = 49028, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Icebound Fortitude/Eisige Gegenwehr
			{ spellID = 48792, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Anti-Magic Shell/Antimagische Hulle
			{ spellID = 48707, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Killing machine
			{ spellID = 51124, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Freezing fog
			{ spellID = 59052, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Bone Shield/Knochenschild
			{ spellID = 49222, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Interval = 4,
			Mode = "ICON",

			-- Strangulate/Strangulieren
			{ spellID = 47476, size = 30, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Blood Plague/Blutseuche
			{ spellID = 59879, size = 30, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Frost Fever/Frostfieber
			{ spellID = 59921, size = 30, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Unholy Blight/Unheilige Verseuchung
			{ spellID = 49194, size = 30, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Summon Gargoyle/Gargoyle beschworen
			{ spellID = 49206, size = 30, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Death and Decay/Tod und Verfall
			{ spellID = 43265, size = 30, unitId = "target", caster = "player", filter = "DEBUFF" },
		},
	},
	["ALL"] = {
			{
				
			Name = "SPECIAL_P_BUFF_ICON",
			Direction = "LEFT",
			Interval = 4,
			Mode = "ICON",

			-- Geisterstunde/Witching Hour
			{ spellID = 90887, size = 24, unitId = "player", caster = "player", filter = "BUFF" },
			-- Erkenntnis des Herzens/Heart's Revelation
			{ spellID = 91027, size = 24, unitId = "player", caster = "player", filter = "BUFF" },
			-- Richturteil des Herzens/Heart's Judgement
			{ spellID = 91041, size = 24, unitId = "player", caster = "player", filter = "BUFF" },

			-- Hyperspeed Accelerators/Hypergeschwindigkeitsbeschleuniger
			{ spellID = 54758, size = 24, unitId = "player", caster = "player", filter = "BUFF" },
			-- Synapse Springs/Synapsenfedern
			{ spellID = 82175, size = 24, unitId = "player", caster = "player", filter = "BUFF" },

			-- Speed/Geschwindigkeit
			{ spellID = 53908, size = 24, unitId = "player", caster = "player", filter = "BUFF" },
			
			
			-- Wild Magic/Wilde Magie
			{ spellID = 53909, size = 24, unitId = "player", caster = "player", filter = "BUFF" },
			--Tricks of the Trade/Schurkenhandel
			{ spellID = 57934, size = 24, unitId = "player", caster = "all", filter = "BUFF" },
			--Power Infusion/Seele der Macht
			{ spellID = 10060, size = 24, unitId = "player", caster = "all", filter = "BUFF" },
			-- Bloodlust/Kampfrausch
			{ spellID = 2825, size = 24, unitId = "player", caster = "all", filter = "BUFF" },
			-- Heroism/Heldentum
			{ spellID = 32182, size = 24, unitId = "player", caster = "all", filter = "BUFF" },
			-- Time Warp
			{ spellID = 80353, size = 24, unitId = "player", caster = "all", filter = "BUFF" },
			-- Golem's Strength
			{ spellID = 79634, size = 32, unitId = "player", caster = "player", filter = "BUFF" },
			--Potion of the Tol'vir
			{ spellID = 79633, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
			-- Volcanic Power 
			{ spellID = 79476, size = 32, unitId = "player", caster = "player", filter = "BUFF" },
			-- Tier13 (Bonus)
		  -- Warrior 
		-- Shield of Fury (2T13 Protection)
		{ spellID = 105909, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
		-- Shield Wall (4T13 Protection)
		{ spellID = 871, size = 30, unitId = "player", caster = "all", filter = "BUFF" },
		-- Volatile Outrage (2T13 Fury\Arms)	
		{ spellID = 105860, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
		  -- Druid
		-- Natural Harmony (2T13 Heal)
		{ spellID = 105713, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
		-- Frenzied Regeneration (4T13 Bear)
		{ spellID = 22842, size = 30, unitId = "player", caster = "all", filter = "BUFF" },
		  -- Hunter 
		-- Chronohunter (4T13)
		{ spellID = 108687, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
		  -- Mage
		-- Stolen Time (2T13)
		{ spellID = 105785, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
		  -- Paladin
		-- Divine Favor (2T13 Holy)
		{ spellID = 105742, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
		-- Divine Guardian (4T13 Protection)
		{ spellID = 70940, size = 30, unitId = "player", caster = "all", filter = "BUFF" },
		  -- Priest
		-- Temporal Boon (2T13 Healer)
		{ spellID = 105826, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
		  -- Death Knight
		-- Vampiric Blood (4T13 Blood)
		{ spellID = 55233, size = 30, unitId = "player", caster = "all", filter = "BUFF" },
		{ spellID = 58676, size = 30, unitId = "player", caster = "all", filter = "BUFF" },
		  -- Warlock
		-- Temporal Ruin (4T13)
		{ spellID = 105786, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
		  -- Shaman
		-- Fury of the Ancestors (2T13 Elemental)
		{ spellID = 105779, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
		-- Spiritual Stimulus (2T13 Healer)		
		{ spellID = 105763, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
		--
		{ spellID = 105763, size = 30, unitId = "player", caster = "player", filter = "BUFF" },
		  


		
			-- Trinket Procs
		--Dragon Soul
	    -- Preternatural Evasion
	    { spellID = 107968, size = 32, unitId = "player", caster = "player", filter = "BUFF" },
	    -- Seal of the Seven Signs
	    { spellID = 107982, size = 32, unitId = "player", caster = "player", filter = "BUFF" },
	    -- Soulshifter Vortex
	    { spellID = 107986, size = 32, unitId = "player", caster = "player", filter = "BUFF" },
	    -- Creche of the Final Dragon
	    { spellID = 109742, size = 32, unitId = "player", caster = "player", filter = "BUFF" },
	    -- Wrath of Unchaining
	    { spellID = 109717, size = 32, unitId = "player", caster = "player", filter = "BUFF" },
	    -- Will of Unbinding
	    { spellID = 109795, size = 32, unitId = "player", caster = "player", filter = "BUFF" },
	    -- Heart of Unliving
	    { spellID = 107962, size = 32, unitId = "player", caster = "player", filter = "BUFF" },
	    -- Eye of Unmaking
	    { spellID = 109748, size = 32, unitId = "player", caster = "player", filter = "BUFF" },
			-- Other Trinket
	    -- Cleansing Tears / Lauternde Tranen (Tear of Blood)
            { spellID = 91139, size = 32, unitId = "player", caster = "player", filter = "BUFF" },
            -- Fury of the Five Flights / Furor der funf Schwarme
            { spellID = 60314, size = 32, unitId = "player", caster = "player", filter = "BUFF" },
            -- Witching Hour / Geisterstunde
            { spellID = 90887, size = 32, unitId = "player", caster = "player", filter = "BUFF" },
            -- Heart's Revelation / Erkenntnis des Herzens
            { spellID = 91027, size = 32, unitId = "player", caster = "player", filter = "BUFF" },
            -- Heart's Judgement / Richturteil des Herzens
            { spellID = 91041, size = 32, unitId = "player", caster = "player", filter = "BUFF" },
            -- Volcanic Destruction
            { spellID = 89091, size = 32, unitId = "player", caster = "player", filter = "BUFF" },
            -- Soul Fragment / Seelenfragment (Necromatic Focus/Necrotischer Fokus)
            { spellID = 96962, size = 32, unitId = "player", caster = "player", filter = "BUFF" },
            -- Veil of Splashing / Moonwell Phial
            { spellID = 101156, size = 32, unitId = "player", caster = "player", filter = "BUFF" },
            -- Blessing of the Moonwell / Moonwell Chalice
            { spellID = 100403, size = 32, unitId = "player", caster = "player", filter = "BUFF" },
            -- Charged Blows / Ricket's Magnetic Fireball
            { spellID = 101515, size = 32, unitId = "player", caster = "player", filter = "BUFF" },
            -- Matrix Restabilizer Heroic / Matrix Restabilizer Heroic
            { spellID = 97138, size = 32, unitId = "player", caster = "player", filter = "BUFF" },
            -- Matrix Restabilizer  / Matrix Restabilizer
            { spellID = 96976, size = 32, unitId = "player", caster = "player", filter = "BUFF" },
            -- Accelerated Heroic  / Vessel of Acceleration Heroic
            { spellID = 97142, size = 32, unitId = "player", caster = "player", filter = "BUFF" },
            -- Blessing of Khaz'goroth Heroic  / Apparatus of Khaz'goroth Heroic
            { spellID = 97127, size = 32, unitId = "player", caster = "player", filter = "BUFF" },
            -- Victorious Heroic  / Jaws of Defeat Heroic
            { spellID = 97120, size = 32, unitId = "player", caster = "player", filter = "BUFF" },
            -- Soul Fragment Heroic  / Necromantic Focus Heroic
            { spellID = 97131, size = 32, unitId = "player", caster = "player", filter = "BUFF" },
            -- Devour Heroic  / The Hungerer Heroic
            { spellID = 97125, size = 32, unitId = "player", caster = "player", filter = "BUFF" },
            -- Accelerated  / Vessel of Acceleration
            { spellID = 96980, size = 32, unitId = "player", caster = "player", filter = "BUFF" },
            -- Ancient Petrified Seed  / Ancient Petrified Seed
            { spellID = 97009, size = 32, unitId = "player", caster = "player", filter = "BUFF" },
            -- Blessing of Khaz'goroth   / Apparatus of Khaz'goroth
            { spellID = 96934, size = 32, unitId = "player", caster = "player", filter = "BUFF" },
            -- Essence of the Eternal Flame  / Essence of the Eternal Flame
            { spellID = 97010, size = 32, unitId = "player", caster = "player", filter = "BUFF" },
            -- Fiery Quintessence  / Fiery Quintessence
            { spellID = 97008, size = 32, unitId = "player", caster = "player", filter = "BUFF" },
            -- Victorious  / Jaws of Defeat
            { spellID = 96907, size = 32, unitId = "player", caster = "player", filter = "BUFF" },
            -- Mark of the Firelord  / Rune of Zeth
            { spellID = 97007, size = 32, unitId = "player", caster = "player", filter = "BUFF" },
            -- Devour  / The Hungerer
            { spellID = 96911, size = 32, unitId = "player", caster = "player", filter = "BUFF" },
            -- Celerity / Shard of Woe Heroic
            { spellID = 91173, size = 32, unitId = "player", caster = "player", filter = "BUFF" },
			-- Dire Magic { spellID = 92318, size = 32, unitId = "player", caster = "player", filter = "BUFF" }
			-- Power Torrent { spellID = 74241, size = 32, unitId = "player", caster = "player", filter = "BUFF" }
			 { spellID = 96978, size = 32, unitId = "player", caster = "player", filter = "BUFF" },
			 { spellID = 57934, size = 32, unitId = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "PVE/PVP_P_DEBUFF_ICON",
			Direction = "LEFT",
			Interval = 4,
			Mode = "ICON",

			-- Death Knight
			-- Gnaw (Ghoul)
			{ spellID = 47481, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Strangulate
			{ spellID = 47476, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Chains of Ice
			{ spellID = 45524, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Desecration (no duration, lasts as long as you stand in it)
			{ spellID = 55741, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Glyph of Heart Strike
			{ spellID = 58617, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Druid
			-- Cyclone
			{ spellID = 33786, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Hibernate
			{ spellID = 2637, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Bash
			{ spellID = 5211, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Maim
			{ spellID = 22570, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Pounce
			{ spellID = 9005, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Entangling Roots
			{ spellID = 339, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Feral Charge Effect
			{ spellID = 45334, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Infected Wounds
			{ spellID = 58179, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },

			-- Hunter
			-- Freezing Trap Effect
			{ spellID = 3355, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Freezing Arrow Effect
			--{ spellID = 60210, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Scare Beast
			{ spellID = 1513, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Scatter Shot
			{ spellID = 19503, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Chimera Shot - Scorpid
			--{ spellID = 53359, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Snatch (Bird of Prey)
			{ spellID = 50541, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Silencing Shot
			{ spellID = 34490, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Intimidation
			{ spellID = 24394, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Sonic Blast (Bat)
			{ spellID = 50519, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Ravage (Ravager)
			{ spellID = 50518, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Concussive Barrage
			{ spellID = 35101, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Concussive Shot
			{ spellID = 5116, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Frost Trap Aura
			{ spellID = 13810, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Glyph of Freezing Trap
			{ spellID = 61394, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Wing Clip
			{ spellID = 2974, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Counterattack
			{ spellID = 19306, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Entrapment
			{ spellID = 19185, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Pin (Crab)
			{ spellID = 50245, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Venom Web Spray (Silithid)
			{ spellID = 54706, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Web (Spider)
			{ spellID = 4167, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },

			-- Mage
			-- Dragon's Breath
			{ spellID = 31661, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Polymorph
			{ spellID = 118, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Silenced - Improved Counterspell
			{ spellID = 18469, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Deep Freeze
			{ spellID = 44572, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Freeze (Water Elemental)
			{ spellID = 33395, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Frost Nova
			{ spellID = 122, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Shattered Barrier
			{ spellID = 55080, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Chilled
			{ spellID = 6136, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Cone of Cold
			{ spellID = 120, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Slow
			{ spellID = 31589, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },

			-- Paladin
			-- Repentance
			{ spellID = 20066, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Turn Evil
			{ spellID = 10326, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Shield of the Templar
			{ spellID = 63529, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Hammer of Justice
			{ spellID = 853, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Holy Wrath
			{ spellID = 2812, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Stun (Seal of Justice proc)
			{ spellID = 20170, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Avenger's Shield
			{ spellID = 31935, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },

			-- Priest
			-- Psychic Horror
			{ spellID = 64058, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Mind Control
			{ spellID = 605, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Psychic Horror
			{ spellID = 64044, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Psychic Scream
			{ spellID = 8122, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Silence
			{ spellID = 15487, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Mind Flay
			{ spellID = 15407, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },

			-- Rogue
			-- Dismantle
			{ spellID = 51722, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Blind
			{ spellID = 2094, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Gouge
			{ spellID = 1776, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Sap
			{ spellID = 6770, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Garrote - Silence
			{ spellID = 1330, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Silenced - Improved Kick
			{ spellID = 18425, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Cheap Shot
			{ spellID = 1833, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Kidney Shot
			{ spellID = 408, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Blade Twisting
			{ spellID = 31125, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Crippling Poison
			{ spellID = 3409, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Deadly Throw
			{ spellID = 26679, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },

			-- Shaman
			-- Hex
			{ spellID = 51514, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Earthgrab
			{ spellID = 64695, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Freeze
			{ spellID = 63685, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Stoneclaw Stun
			{ spellID = 39796, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Earthbind
			{ spellID = 3600, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Frost Shock
			{ spellID = 8056, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },

			-- Warlock
			-- Banish
			{ spellID = 710, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Death Coil
			{ spellID = 6789, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Fear
			{ spellID = 5782, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Howl of Terror
			{ spellID = 5484, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Seduction (Succubus)
			{ spellID = 6358, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Spell Lock (Felhunter)
			{ spellID = 24259, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Shadowfury
			{ spellID = 30283, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Intercept (Felguard)
			{ spellID = 30153, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Aftermath
			{ spellID = 18118, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Curse of Exhaustion
			{ spellID = 18223, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },

			-- Warrior
			-- Intimidating Shout
			{ spellID = 20511, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Disarm
			{ spellID = 676, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Silenced (Gag Order)
			{ spellID = 18498, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Charge Stun
			{ spellID = 7922, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Concussion Blow
			{ spellID = 12809, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Intercept
			{ spellID = 20253, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Revenge Stun
			--{ spellID = 12798, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Shockwave
			{ spellID = 46968, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Glyph of Hamstring
			{ spellID = 58373, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Improved Hamstring
			{ spellID = 23694, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Hamstring
			{ spellID = 1715, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Piercing Howl
			{ spellID = 12323, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },

			-- Racials
			-- War Stomp
			{ spellID = 20549, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },

			-- Baradin Hold(PvP)
			-- Meteor Slash/Meteorschlag (Argaloth)
			{ spellID = 88942, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },

			-- Bastion of Twilight
			-- Blackout/Blackout (Valiona & Theralion)
			{ spellID = 92879, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Engulfing Magic/Einhullende Magie (Valiona & Theralion)
			{ spellID = 86631, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Waterlogged/Wasserdurchtrankt (Twilight Ascendant Council)
			{ spellID = 82762, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Burning Blood/Brennendes Blut (Twilight Ascendant Council)
			{ spellID = 82662, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Heart of Ice/Herz aus Eis (Twilight Ascendant Council)
			{ spellID = 82667, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Frozen/Gefroren (Twilight Ascendant Council)
			{ spellID = 92503, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Swirling Winds/Wirbelnde Winde (Twilight Ascendant Council)
			{ spellID = 83500, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Magnetic Pull/Magnetische Anziehung (Twilight Ascendant Council)
			{ spellID = 83587, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Corruption: Accelerated/Verderbnis: Beschleunigung (Cho'gall)
			{ spellID = 81836, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Corruption: Malformation/Verderbnis: Missbildung (Cho'gall)
			{ spellID = 82125, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Corruption: Absolute/Verderbnis: Vollendet (Cho'gall)
			{ spellID = 82170, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Corruption: Sickness/Verderbnis: Krankheit (Cho'gall)
			{ spellID = 93200, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },

			-- Blackwing Descent
			-- Constricting Chains/Fesselnde Ketten (Magmaw)
			{ spellID = 91911, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Parasitic Infection/Parasitare Infektion (Magmaw)
			{ spellID = 94679, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Infectious Vomit/Infektioses Erbrochenes (Magmaw)
			{ spellID = 91923, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Lightning Conductor (Omnitron Defense System)
			{ spellID = 91433, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Flash Freeze/Blitzeis (Maloriak)
			{ spellID = 77699, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Consuming Flames/Verzehrende Flammen (Maloriak)
			{ spellID = 77786, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Finkle's Mixture/Finkels Mixtur (Chimaeron)
			{ spellID = 82705, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Shadow Conductor/Schattenleiter (Nefarian)
			{ spellID = 92053, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			--(Nefarian)
			{ spellID = 79339, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			
			
			-- Throne of Four Winds
			-- Wind Chill/Windkuhle (Conclave of Wind)
			{ spellID = 93123, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Slicing Gale/Schneidender Orkan (Conclave of Wind)
			{ spellID = 93058, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Static Shock/Statischer Schock (Al'Akir)
			{ spellID = 87873, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Acid Rain/Saureregen (Al'Akir)
			{ spellID = 93279, size = 64, unitId = "player", caster = "all", filter = "DEBUFF" },
			
			
			-- Firelands
		-- Magma Rupture (Shannox)
		{ spellID = 99840, size = 52, unitId = "player", caster = "all", filter = "DEBUFF" },
		-- Crystal Prison Trap (Shannox)
		{ spellID = 99837, size = 52, unitId = "player", caster = "all", filter = "DEBUFF" },
		-- Jagged Tear (Shannox)
		{ spellID = 99936, size = 52, unitId = "player", caster = "all", filter = "DEBUFF" },
		-- Eruption (Lord Rhyolith)
		{ spellID = 98492, size = 52, unitId = "player", caster = "all", filter = "DEBUFF" },
		-- Molten Feather (Alysrazor)
		{ spellID = 97128, size = 52, unitId = "player", caster = "all", filter = "BUFF" },
		-- Wings of Flame (Alysrazor)
		{ spellID = 98619, size = 52, unitId = "player", caster = "all", filter = "BUFF" },
		-- Blazing Power (Alysrazor)
		{ spellID = 99461, size = 52, unitId = "player", caster = "all", filter = "DEBUFF" },
		-- Alysra's Razor (Alysrazor)
		{ spellID = 100029, size = 52, unitId = "player", caster = "all", filter = "DEBUFF" },
		-- The Widow's Kiss (Beth'tilac)
		{ spellID = 99506, size = 52, unitId = "player", caster = "all", filter = "DEBUFF" },
		-- Torment (Baleroc)
		{ spellID = 99256, size = 52, unitId = "player", caster = "all", filter = "DEBUFF" },
		-- Tormented (Baleroc)
		{ spellID = 99257, size = 52, unitId = "player", caster = "all", filter = "DEBUFF" },
		-- Blaze of Glory (Baleroc)
		{ spellID = 99252, size = 52, unitId = "player", caster = "all", filter = "DEBUFF" },
		-- Vital Flame (Baleroc)
		{ spellID = 99262, size = 52, unitId = "player", caster = "all", filter = "BUFF" },
		-- Vital Spark (Baleroc)
		{ spellID = 99263, size = 52, unitId = "player", caster = "all", filter = "BUFF" },
		-- Searing Seeds (Majordomo Staghelm)
		{ spellID = 98450, size = 52, unitId = "player", caster = "all", filter = "DEBUFF" },
		-- Burning Orbs (Majordomo Staghelm)
		{ spellID = 98451, size = 52, unitId = "player", caster = "all", filter = "DEBUFF" },
		-- Blazing Heat (Ragnaros)
		{ spellID = 100460, size = 52, unitId = "player", caster = "all", filter = "DEBUFF" },
		-- Burning Wound (Ragnaros)
		{ spellID = 101239, size = 52, unitId = "player", caster = "all", filter = "DEBUFF" },
		
			-- Dragon Soul
		-- Crush Armor (Morchok)
		{ spellID = 103687, size = 52, unitId = "player", caster = "all", filter = "DEBUFF" },
		-- Black Blood of the Earth (Morchok)
		{ spellID = 103785, size = 52, unitId = "player", caster = "all", filter = "DEBUFF" },
		-- Resonating Crystal (Morchok)
		{ spellID = 103534, size = 52, unitId = "player", caster = "all", filter = "DEBUFF" },
		{ spellID = 103536, size = 52, unitId = "player", caster = "all", filter = "DEBUFF" },
		{ spellID = 103541, size = 52, unitId = "player", caster = "all", filter = "DEBUFF" },
		-- Disrupting Shadows (Warlord Zon'ozz)
		{ spellID = 103434, size = 52, unitId = "player", caster = "all", filter = "DEBUFF" },
		-- Void Bolt (Yor'sahj the Unsleeping)
		{ spellID = 108383, size = 52, unitId = "player", caster = "all", filter = "DEBUFF" },
		-- Deep Corruption (Yor'sahj the Unsleeping)
		{ spellID = 103628, size = 52, unitId = "player", caster = "all", filter = "DEBUFF" },
		-- Ice Tomb (Hagara the Stormbinder)
		{ spellID = 104448, size = 52, unitId = "player", caster = "all", filter = "DEBUFF" },
		-- Fading Light (Ultraxion)
		{ spellID = 110073, size = 52, unitId = "player", caster = "all", filter = "DEBUFF" },
		-- Devastate (Warmaster Blackhorn)
		{ spellID = 108043, size = 52, unitId = "player", caster = "all", filter = "DEBUFF" },
		-- Disrupting Roar (Warmaster Blackhorn)
		{ spellID = 109228, size = 52, unitId = "player", caster = "all", filter = "DEBUFF" },
		-- Shockwave (Warmaster Blackhorn)
		{ spellID = 108046, size = 52, unitId = "player", caster = "all", filter = "DEBUFF" },
		-- Searing Plasma (Burning Tendons)
		{ spellID = 105479, size = 52, unitId = "player", caster = "all", filter = "DEBUFF" },
		-- Elementium Blast (Deathwing)
		{ spellID = 105723, size = 52, unitId = "player", caster = "all", filter = "DEBUFF" },
		-- Blistering Heat (Deathwing)
		{ spellID = 105444, size = 52, unitId = "player", caster = "all", filter = "DEBUFF" },
		-- Degenerative Bite (Deathwing)
		{ spellID = 105841, size = 52, unitId = "player", caster = "all", filter = "DEBUFF" },
		-- Tetanus (Deathwing)
		{ spellID = 106730, size = 52, unitId = "player", caster = "all", filter = "DEBUFF" },	
		},
		{
			Name = "PVP_T_BUFF_ICON",
			Direction = "RIGHT",
			Interval = 4,
			Mode = "ICON",

			-- Aspect of the Pack
			{ spellID = 13159, size = 64, unitId = "player", caster = "player", filter = "BUFF" },
			-- Innervate
			{ spellID = 29166, size = 64, unitId = "target", caster = "all", filter = "BUFF"},
			-- Spell Reflection
			{ spellID = 23920, size = 64, unitId = "target", caster = "all", filter = "BUFF" },
			-- Aura Mastery
			{ spellID = 31821, size = 64, unitId = "target", caster = "all", filter = "BUFF" },
			-- Ice Block
			{ spellID = 45438, size = 64, unitId = "target", caster = "all", filter = "BUFF" },
			-- Cloak of Shadows
			{ spellID = 31224, size = 64, unitId = "target", caster = "all", filter = "BUFF" },
			-- Divine Shield
			{ spellID = 642, size = 64, unitId = "target", caster = "all", filter = "BUFF" },
			-- Deterrence
			{ spellID = 19263, size = 64, unitId = "target", caster = "all", filter = "BUFF" },
			-- Anti-Magic Shell
			{ spellID = 48707, size = 64, unitId = "target", caster = "all", filter = "BUFF" },
			-- Lichborne
			{ spellID = 49039, size = 64, unitId = "target", caster = "all", filter = "BUFF" },
			-- Hand of Freedom
			{ spellID = 1044, size = 64, unitId = "target", caster = "all", filter = "BUFF" },
			-- Hand of Sacrifice
			{ spellID = 6940, size = 64, unitId = "target", caster = "all", filter = "BUFF" },
			-- Grounding Totem Effect
			{ spellID = 8178, size = 64, unitId = "target", caster = "all", filter = "BUFF" },
		},
	},
}

local class = select(2, UnitClass("player")) 
local classcolor = RAID_CLASS_COLORS[class] 
local active, bars = {}, {};
local MyUnits = {
  player = true,
  vehicle = true,
  pet = true,
}

local time, Update 
local function OnUpdate(self, elapsed)
	time = self.filter == "CD" and self.expirationTime+self.duration-GetTime() or self.expirationTime-GetTime() 
	if ( self:GetParent().Mode == "BAR" ) then
		self.statusbar:SetValue(time) 
		self.time:SetFormattedText(SecondsToTimeAbbrev(time)) 
	end
	if ( time < 0 and self.filter == "CD" ) then
		local id = self:GetParent().Id 
		for index, value in ipairs(active[id]) do
			if ( self.spellName == value.data.spellName ) then
				tremove(active[id], index) 
				break 
			end
		end
		self:SetScript("OnUpdate", nil) 
		Update(self:GetParent()) 
	end
end

function Update(self)
	local id = self.Id 
	if ( not bars[id] ) then
		bars[id] = {} 
	end
	for index, value in ipairs(bars[id]) do
		value:Hide() 
	end
	local bar 
	for index, value in ipairs(active[id]) do
		bar = bars[id][index] 
		if ( not bar ) then
			bar = CreateFrame("Frame", "FilgerAnchor"..id.."Frame"..index, self) 
			bar:SetWidth(value.data.size) 
			bar:SetHeight(value.data.size) 
			bar:SetScale(1) 

			if ( index == 1 ) then
				if ( configmode ) then
				
				elseif ( self.Direction == "UP" ) then
					bar:SetPoint("BOTTOM", self) 
				elseif ( self.Direction == "RIGHT" ) then
					bar:SetPoint("LEFT", self) 
				elseif ( self.Direction == "LEFT" ) then
					bar:SetPoint("RIGHT", self) 
				else
					bar:SetPoint("TOP", self) 
				end
	else
				if ( self.Direction == "UP" ) then
					bar:SetPoint("BOTTOM", bars[id][index-1], "TOP", 0, self.Spacing) 
				elseif ( self.Direction == "RIGHT" ) then
					bar:SetPoint("LEFT", bars[id][index-1], "RIGHT", self.Mode == "ICON" and self.Spacing or value.data.barWidth+self.Spacing, 0) 
				elseif ( self.Direction == "LEFT" ) then
					bar:SetPoint("RIGHT", bars[id][index-1], "LEFT", self.Mode == "ICON" and -self.Spacing or -(value.data.barWidth+self.Spacing), 0) 
				else
					bar:SetPoint("TOP", bars[id][index-1], "BOTTOM", 0, -self.Spacing) 
				end
			end
                                
if (bar.icon) then
 bar.icon = _G[bar.icon:GetName()]
else
				     bar.icon = bar:CreateTexture(nil,  "ARTWORK")
				     bar.icon:SetPoint("TOPLEFT", 2, -2)
				     bar.icon:SetPoint("BOTTOMRIGHT", -2, 2)
				     bar.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
end

			if ( self.Mode == "ICON" ) then
								
				bar.cooldown = CreateFrame("Cooldown", nil, bar, "CooldownFrameTemplate") 
				bar.cooldown:SetAllPoints(bar.icon) 
				bar.cooldown:SetReverse() 

 if (bar.count) then
   bar.count = _G[bar.count:GetName()]
else
				--[[bar.icon = bar:CreateTexture(nil, "ARTWORK") 
				bar.icon:SetAllPoints() 
				bar.icon:SetTexCoord(0.07, 0.93, 0.07, 0.93) ]]--
				
				bar.count = bar:CreateFontString("$parentFontString", "OVERLAY") 
                                bar.count:SetFont("Interface\\AddOns\\zFilger\\media\\pxFont.ttf", 14, "OUTLINE")
				bar.count:SetPoint("BOTTOMRIGHT") 
				bar.count:SetJustifyH("RIGHT")
end
                   else
							 
if (bar.statusbar) then
bar.statusbar = _G[bar.statusbar:GetName()] 
else
                                bar.statusbar = CreateFrame("StatusBar", nil, bar)
				bar.statusbar:SetWidth(value.data.barWidth - 2) 
				bar.statusbar:SetHeight(value.data.size - 10) 
				bar.statusbar:SetStatusBarTexture("Interface\\AddOns\\zFilger\\media\\flat") 
				bar.statusbar:SetStatusBarColor(0.25, 0.25, 0.25, 1)  
if ( self.IconSide == "LEFT" ) then
						bar.statusbar:SetPoint("BOTTOMLEFT", bar, "BOTTOMRIGHT", 6, 2)
					elseif ( self.IconSide == "RIGHT" ) then
						bar.statusbar:SetPoint("BOTTOMRIGHT", bar, "BOTTOMLEFT", -6, 2)
					end
end 
				bar.statusbar:SetMinMaxValues(0, 1) 
				bar.statusbar:SetValue(0) 

if (bar.background) then
  bar.background = _G[bar.background:GetName()]
else
				bar.background = bar.statusbar:CreateTexture(nil, "BACKGROUND") 
				bar.background:SetAllPoints() 
				bar.background:SetTexture("Interface\\AddOns\\zFilger\\media\\flat") 
				bar.background:SetVertexColor(0, 0, 0, 1) 	
end

if (bar.time) then
 bar.time = _G[bar.time:GetName()]
else			
				bar.time = bar.statusbar:CreateFontString("$parentFontString","OVERLAY") 
                                bar.time:SetFont("Interface\\AddOns\\zFilger\\media\\pxFont.ttf", 14, "OUTLINE")
				bar.time:SetPoint("RIGHT", bar.statusbar, -2, 0) 
end

if (bar.count) then
 bar.count = _G[bar.count:GetName()]
 else
					bar.count = bar:CreateFontString("$parentFontString","OVERLAY")
                                        bar.count:SetFont("Interface\\AddOns\\zFilger\\media\\pxFont.ttf", 14, "OUTLINE")
					bar.count:SetPoint("BOTTOMRIGHT", 1, 1)
					bar.count:SetJustifyH("CENTER")
				end

if (bar.spellname) then
bar.spellname = _G[bar.spellname:GetName()]
else				
				bar.spellname = bar.statusbar:CreateFontString("$parentFontString", "OVERLAY") 
                                bar.spellname:SetFont("Interface\\AddOns\\zFilger\\media\\pxFont.ttf", 14, "OUTLINE")
				bar.spellname:SetPoint("LEFT", bar.statusbar, 2, 0) 
				bar.spellname:SetPoint("RIGHT", bar.time, "LEFT") 
				bar.spellname:SetJustifyH("LEFT") 
end
		end	
			tinsert(bars[id], bar) 
		end
		
		bar.spellName = value.data.spellName 
		
		bar.icon:SetTexture(value.icon) 
		bar.count:SetText(value.count > 1 and value.count or "") 
		if ( self.Mode == "BAR" ) then
			bar.spellname:SetText(value.data.spellName) 
		end
		if ( value.duration > 0 ) then
			if ( self.Mode == "ICON" ) then
				CooldownFrame_SetTimer(bar.cooldown, value.data.filter == "CD" and value.expirationTime or value.expirationTime-value.duration, value.duration, 1) 
				if ( value.data.filter == "CD" ) then
					bar.expirationTime = value.expirationTime 
					bar.duration = value.duration 
					bar.filter = value.data.filter 
					bar:SetScript("OnUpdate", OnUpdate) 
				end
			else
				bar.statusbar:SetMinMaxValues(0, value.duration) 
				bar.expirationTime = value.expirationTime 
				bar.duration = value.duration 
				bar.filter = value.data.filter 
				bar:SetScript("OnUpdate", OnUpdate) 
			end
		else
			if ( self.Mode == "ICON" ) then
				bar.cooldown:Hide() 
			else
				bar.statusbar:SetMinMaxValues(0, 1) 
				bar.statusbar:SetValue(1) 
				bar.time:SetText("") 
				bar:SetScript("OnUpdate", nil) 
			end
		end		
		bar:Show() 
	end
end

local function OnEvent(self, event, ...)
	local unit = ... 
	if ( ( unit == "target" or unit == "player" or unit == "pet" or unit == "focus" ) or event == "PLAYER_TARGET_CHANGED" or event == "PLAYER_ENTERING_WORLD" or event == "SPELL_UPDATE_COOLDOWN" ) then
 		local id = self.Id 
		for i=1, #spells[class][id], 1 do
                        local data, name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable, start, enabled, slotLink
			data = spells[class][id][i] 
			if ( data.filter == "BUFF" ) then
                                spn = GetSpellInfo(data.spellID)
				name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitBuff(data.unitId, spn) 
			elseif ( data.filter == "DEBUFF" ) then
                                spn = GetSpellInfo(data.spellID)
				name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff(data.unitId, spn) 
			else
				if (data.spellID) then
					spn = GetSpellInfo(data.spellID)
					start, duration, enabled = GetSpellCooldown(spn)
					_, _, icon = GetSpellInfo(data.spellID)
				else
					slotLink = GetInventoryItemLink("player", data.slotID) 
					if ( slotLink ) then
						name, _, _, _, _, _, _, _, _, icon = GetItemInfo(slotLink) 						
							data.spellName = name 	
						start, duration, enabled = GetInventoryItemCooldown("player", data.slotID) 
					end
				end
				count = 0 
				caster = "all" 
			end
                        if (not data.spellName) then
				data.spellName = spn
			end
			if ( not active[id] ) then
				active[id] = {} 
			end
			for index, value in ipairs(active[id]) do
				if ( data.spellName == value.data.spellName ) then
					tremove(active[id], index) 
					break 
				end
			end
			if ((name and (data.caster ~= 1 and (caster == data.caster or data.caster == "all") or MyUnits[caster])) or ((enabled or 0) > 0 and (duration or 0) > 1.5)) then
				table.insert(active[id], { data = data, icon = icon, count = count, duration = duration, expirationTime = expirationTime or start }) 
			end
		end
		Update(self) 
	end
end

if (spells and spells["ALL"]) then
	if (not spells[class]) then
		spells[class] = {}
	end

	for i = 1, #spells["ALL"], 1 do
		table.insert(spells[class], spells["ALL"][i])
	end
end

if ( spells and spells[class] ) then
	for index in pairs(spells) do
		if ( index ~= class ) then
			spells[index] = nil 
		end
	end

	local data, frame 
	for i=1, #spells[class], 1 do
		data = spells[class][i] 
		
		frame = CreateFrame("Frame", "sFilgerAnchor"..i, UIParent) 
		frame.Id = i 
                frame.Name = data.Name
		frame.Direction = data.Direction or "DOWN" 
                frame.IconSide = data.IconSide or "LEFT"
		frame.Spacing = data.Spacing or 3 
		frame.Mode = data.Mode or "ICON" 
		frame:SetWidth(spells[class][i][1] and spells[class][i][1].size or 100) 
		frame:SetHeight(spells[class][i][1] and spells[class][i][1].size or 20) 
		frame:SetPoint("CENTER") 
		frame:SetMovable(1) 
		
		if ( configmode ) then
			frame:SetFrameStrata("DIALOG") 
			frame:SetBackdrop({ bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", edgeFile = "", insets = { left = 0, right = 0, top = 0, bottom = 0 }}) 
			frame:EnableMouse(1) 
			frame:RegisterForDrag("LeftButton") 
			frame:SetScript("OnDragStart", function(self)
				if ( IsShiftKeyDown() and IsAltKeyDown() ) then
					self:StartMoving() 
				end
			end) 
			frame:SetScript("OnDragStop", function(self)
				self:StopMovingOrSizing() 
			end) 
			
			frame.text = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightCenter") 
			frame.text:SetPoint("CENTER") 
			frame.text:SetText(data.Name and data.Name or "sFilgerAnchor"..i) 
			
			for j=1, #spells[class][i], 1 do
				data = spells[class][i][j] 
				if ( not active[i] ) then
					active[i] = {} 
				end
				table.insert(active[i], { data = data, icon = "Interface\\Icons\\temp", count = 9, duration = 0, expirationTime = 0 }) 
			end
			Update(frame) 
		else
			for j=1, #spells[class][i], 1 do
				data = spells[class][i][j] 
				if ( data.filter == "CD" ) then
					frame:RegisterEvent("SPELL_UPDATE_COOLDOWN") 
					break 
				end
			end
			frame:RegisterEvent("UNIT_AURA") 
			frame:RegisterEvent("PLAYER_TARGET_CHANGED") 
			frame:RegisterEvent("PLAYER_ENTERING_WORLD") 
			frame:SetScript("OnEvent", OnEvent) 
		end
	end
end
