local addon, T = ...;

T.icd_track_equip_changes = true;
T.icd_spells = {
	["PALADIN"] = {
		{
			Name = "ICDs",
			Direction = "RIGHT",
			Mode = "ICON",
			Margin = 4,
			size = 37,
			posx = -209,
			posy = -235,

			{ spellName = "Пелена лжи", item = 72900, icd = 50}, --Пелена лжи
		},
	},
	["WARLOCK"] = {
		{
			Name = "ICDs",
			Direction = "RIGHT",
			Mode = "ICON",
			Margin = 4,
			size = 37,
			posx = -209,
			posy = -235,

			{ spellName = "Страшная магия", item = 65053, icd = 100}, --Колокол яростного резонанса
			{ spellName = "Откровение", item = 65105, icd = 100}, --Зеркало Тералиона
			{ spellName = "Боевая магия", item = 62470, icd = 75}, --Тол барад тринкет
			{ spellName = "Силовой поток", item = 77195, icd = 45}, --Чант на пушку (с валионы)
			{ spellName = "Сердечное правосудие", item = 59514, icd = 120}, --Сердце огниса
			{ spellName = "Вулканическое разрушение", item = 62047, icd = 45}, --Сердце огниса
		},
	},
	["WARRIOR"] = {
		{
			Name = "ICDs",
			Direction = "RIGHT",
			Mode = "ICON",
			Margin = 4,
			size = 37,
			posx = -209,
			posy = -235,

			{ spellName = "Четки Света", item = 72901, icd = 50}, --Четки света
			{ spellName = "Брошь Варо'тена", item = 72899, icd = 50}, --Брошь Варо'тена
			{ spellName = "Поиск слабости", item = 77972, icd = 115}, --Ясли последнего дракона (ЛФР)
		},
	},
}