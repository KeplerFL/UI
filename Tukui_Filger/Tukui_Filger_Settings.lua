local T, C, L = unpack(Tukui)
local _, ns = ...
local cdsize = 30
local allbufficonsize = 40
local debuffsize = 52
local ptsize = 39
local focussize = 31
local anchorplayer = {"TOPRIGHT", TukuiPlayer, "TOPLEFT", -7, 2}
local anchortarget = {"TOPLEFT", TukuiTarget, "TOPRIGHT", 7, 2}
local anchortotbuff = {"BOTTOM", TukuiTargetTarget, "TOP", 0, 95}
local cooldownanchor = {"TOPLEFT", TukuiPlayer, "BOTTOMLEFT", -2, -14}
local allbuffanchor = {"BOTTOMLEFT", TukuiPlayer, "TOPLEFT", -2, 150}

ns.Filger_Settings = {
	configmode = false,
}

--[[ CD-Example
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Interval = 4,
			Mode = "ICON",
			setPoint = { "CENTER", UIParent, "CENTER", 0, -100 },

			-- Wild Growth/Wildwuchs
			{ spellID = 48438, size = 32, filter = "CD" },
		},
]]

ns.Filger_Spells= {
["WARLOCK"] = {
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Interval = 4,
			Opacity = 1,
			Mode = "ICON",
			setPoint = anchorplayer,

			-- Обратный поток
			{ spellID = 54277, size = ptsize, unitId = "player", caster = "player", filter = "BUFF" },	
			-- Колокол яростного резонанса (прок)
			{ spellID = 91007, size = ptsize, unitId = "player", caster = "player", filter = "BUFF" },	
			-- Зеркало Тералиона (прок)
			{ spellID = 91024, size = ptsize, unitId = "player", caster = "player", filter = "BUFF" },	
			-- Инжа
			{ spellID = 82174, size = ptsize, unitId = "player", caster = "player", filter = "BUFF" },	
			-- 500 Int. weapon enchant
			{ spellID = 74241, size = ptsize, unitId = "player", caster = "player", filter = "BUFF" },	
			-- Сердце огниса
			{ spellID = 91027, size = ptsize, unitId = "player", caster = "player", filter = "BUFF" },	
			-- ТБ тринкет
			{ spellID = 91047, size = ptsize, unitId = "player", caster = "player", filter = "BUFF" },
			-- Колода: Вулкан
			{ spellID = 89091, size = ptsize, unitId = "player", caster = "player", filter = "BUFF" },				
		},
		{
			Name = "C_BUFF_ICON",
			Direction = "UP",
			Interval = 4,
			Opacity = 1,
			Mode = "ICON",
			setPoint = anchortotbuff,

			-- Soulfire
			{ spellID = 85383, size = 50, unitId = "player", caster = "player", filter = "BUFF" },	
			-- 4set buff
			{ spellID = 89937, size = 50, unitId = "player", caster = "player", filter = "BUFF" },
			-- Изничтожение
			{ spellID = 64371, size = 50, unitId = "player", caster = "player", filter = "BUFF" },	
			-- Стаки на Нефариане
			{ spellID = 80627, size = 50, unitId = "player", caster = "player", filter = "BUFF" },
			-- Усиление льдом
			{ spellID = 82666, size = 50, unitId = "player", caster = "player", filter = "BUFF" },
			-- Печать огня
			{ spellID = 82663, size = 50, unitId = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Interval = 4,
			Opacity = 1,
			Mode = "ICON",
			setPoint = cooldownanchor,

			-- Soul Shatter
			{ spellID = 29858, size = cdsize, filter = "CD" },
			-- Лик смерти
			{ spellID = 6789, size = cdsize, filter = "CD" },
			-- Демонический круг: телепортация
			{ spellID = 48020, size = cdsize, filter = "CD" },
			-- Горящая душа
			{ spellID = 74434, size = cdsize, filter = "CD" },
			-- Душа демона
			{ spellID = 77801, size = cdsize, filter = "CD" },
			-- Инфернал
			{ spellID = 1122, size = cdsize, filter = "CD" },
			-- Жатва душ
			{ spellID = 79268, size = cdsize, filter = "CD" },
			-- Инжа (перчатки)
			{ slotID = 10, size = cdsize, filter = "CD" },
			-- Инжа (пояс)
			{ slotID = 6, size = cdsize, filter = "CD" },
		},
		{
			Name = "DEBUFF_FOCUS",
			Direction = "RIGHT",
			Interval = 4,
			Opacity = 1,
			Mode = "ICON",
			setPoint = { "TOPLEFT", TukuiFocus, "TOPRIGHT", 6, 2 },

			-- Изгнание
			{ spellID = 710, size = focussize, unitId = "focus", caster = "player", filter = "DEBUFF" },
			-- Страх
			{ spellID = 5782, size = focussize, unitId = "focus", caster = "player", filter = "DEBUFF" },
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Interval = 4,
			Opacity = 1,
			Mode = "ICON",
			setPoint = anchortarget,

			-- Corruption
			{ spellID = 172, size = ptsize, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Immolate
			{ spellID = 348, size = ptsize, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Bane of Agony
			{ spellID = 980, size = ptsize, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Bane of Doom
			{ spellID = 603, size = ptsize, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Unstable Affliction
			{ spellID = 30108, size = ptsize, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Haunt
			{ spellID = 48181, size = ptsize, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Bane of Havoc
			{ spellID = 80240, size = ptsize, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Объятия тьмы
			{ spellID = 32389, size = ptsize, unitId = "target", caster = "player", filter = "DEBUFF" },
		},
	},
	["WARRIOR"] = {
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Interval = 4,
			Opacity = 1,
			Mode = "ICON",
			setPoint = anchorplayer,

			-- Шквал
			{ spellID = 12968, size = ptsize, unitId = "player", caster = "player", filter = "BUFF" },
			-- Кровожадность
			{ spellID = 23885, size = ptsize, unitId = "player", caster = "player", filter = "BUFF" },
			-- Иступление
			{ spellID = 14202, size = ptsize, unitId = "player", caster = "player", filter = "BUFF" },
			-- Ярость берсерка
			{ spellID = 18499, size = ptsize, unitId = "player", caster = "player", filter = "BUFF" },
			-- Четки света
			{ spellID = 102660, size = ptsize, unitId = "player", caster = "player", filter = "BUFF" },
			-- Брошь Варо"тена
			{ spellID = 102664, size = ptsize, unitId = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "C_BUFF_ICON",
			Direction = "UP",
			Interval = 4,
			Opacity = 1,
			Mode = "ICON",
			setPoint = anchortotbuff,

			-- Титаническая сила
			{ spellID = 109748, size = 50, unitId = "player", caster = "player", filter = "BUFF" },
			-- Казнь
			{ spellID = 90806, size = 50, unitId = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Interval = 4,
			Opacity = 1,
			Mode = "ICON",
			setPoint = cooldownanchor,

			--Ярость берсерка
			{ spellID = 18499, size = cdsize, filter = "CD" },
			--Жажда смерти
			{ spellID = 12292, size = cdsize, filter = "CD" },
			--Безрассудство
			{ spellID = 1719, size = cdsize, filter = "CD" },
			-- Инжа (перчатки)
			{ slotID = 10, size = cdsize, filter = "CD" },
			-- Инжа (пояс)
			{ slotID = 6, size = cdsize, filter = "CD" },
		},
		{
			Name = "DEBUFF_FOCUS",
			Direction = "RIGHT",
			Interval = 4,
			Opacity = 1,
			Mode = "ICON",
			setPoint = { "TOPLEFT", TukuiFocus, "TOPRIGHT", 6, 2 },

			-- Изгнание
			{ spellID = 710, size = focussize, unitId = "focus", caster = "player", filter = "DEBUFF" },
			-- Страх
			{ spellID = 5782, size = focussize, unitId = "focus", caster = "player", filter = "DEBUFF" },
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Interval = 4,
			Opacity = 1,
			Mode = "ICON",
			setPoint = anchortarget,

			-- Удар колосса
			{ spellID = 86346, size = ptsize, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Кровопускание
			{ spellID = 94009, size = ptsize, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Кровоточение
			{ spellID = 12721, size = ptsize, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Раскол брони
			{ spellID = 58567, size = ptsize, unitId = "target", caster = "player", filter = "DEBUFF" },
		},
	},
	["PALADIN"] = {
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Interval = 4,
			Opacity = 1,
			Mode = "ICON",
			setPoint = anchorplayer,

			-- Пеленалжи (тринкет)
			{ spellID = 102667, size = ptsize, unitId = "player", caster = "player", filter = "BUFF" },
			-- Щит небес
			{ spellID = 20925, size = ptsize, unitId = "player", caster = "player", filter = "BUFF" },
			-- Божественная защита
			{ spellID = 498, size = ptsize, unitId = "player", caster = "player", filter = "BUFF" },
			-- Гнев карателя
			{ spellID = 31884, size = ptsize, unitId = "player", caster = "player", filter = "BUFF" },
			-- Защитник древних королей
			{ spellID = 86659, size = ptsize, unitId = "player", caster = "player", filter = "BUFF" },
			-- Безупречное правосудие
			{ spellID = 53657, size = ptsize, unitId = "player", caster = "player", filter = "BUFF" },
			-- Фанатизм
			{ spellID = 85696, size = ptsize, unitId = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "C_BUFF_ICON",
			Direction = "UP",
			Interval = 4,
			Opacity = 1,
			Mode = "ICON",
			setPoint = anchortotbuff,

			-- Священный долг
			{ spellID = 85433, size = 50, unitId = "player", caster = "player", filter = "BUFF" },
			-- Ветроступ
			{ spellID = 74243, size = 50, unitId = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Interval = 4,
			Opacity = 1,
			Mode = "ICON",
			setPoint = cooldownanchor,

			--Щит небес
			{ spellID = 20925, size = cdsize, filter = "CD" },
			--Божественная защита
			{ spellID = 498, size = cdsize, filter = "CD" },
			--Божественный защитник
			{ spellID = 70940, size = cdsize, filter = "CD" },
			-- Ревностный защитник
			{ spellID = 31850, size = cdsize, filter = "CD" },
			-- Гнев карателя
			{ spellID = 31884, size = cdsize, filter = "CD" },
			-- Защитник древних королей
			{ spellID = 86150, size = cdsize, filter = "CD" },
			-- Фанатизм
			{ spellID = 85696, size = cdsize, filter = "CD" },
		},
		{
			Name = "DEBUFF_FOCUS",
			Direction = "RIGHT",
			Interval = 4,
			Opacity = 1,
			Mode = "ICON",
			setPoint = { "TOPLEFT", TukuiFocus, "TOPRIGHT", 6, 2 },

			-- Изгнание
			{ spellID = 710, size = focussize, unitId = "focus", caster = "player", filter = "DEBUFF" },
			-- Страх
			{ spellID = 5782, size = focussize, unitId = "focus", caster = "player", filter = "DEBUFF" },
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Interval = 4,
			Opacity = 1,
			Mode = "ICON",
			setPoint = anchortarget,

			-- Порицание
			{ spellID = 31803, size = ptsize, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Оправдание
			{ spellID = 26017, size = ptsize, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Правосудие праведников
			{ spellID = 68055, size = ptsize, unitId = "target", caster = "player", filter = "DEBUFF" },
		},
	},
	["PRIEST"] = {
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Interval = 4,
			Opacity = 1,
			Mode = "ICON",
			setPoint = anchorplayer,

			-- Хаст на Greater Heal
			{ spellID = 63735, size = ptsize, unitId = "player", caster = "player", filter = "BUFF" },
			-- Сферы
			{ spellID = 77487, size = ptsize, unitId = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "SOULFIRE_BUFF_ICON",
			Direction = "UP",
			Interval = 4,
			Opacity = 1,
			Mode = "ICON",
			setPoint = anchortotbuff,

			-- Чакра (директ хил)
			{ spellID = 81208, size = 50, unitId = "player", caster = "player", filter = "BUFF" },
			-- Чакра (АОЕ хил)
			{ spellID = 81206, size = 50, unitId = "player", caster = "player", filter = "BUFF" },	
			-- Стаки архангела (ШП)
			{ spellID = 87117, size = 50, unitId = "player", caster = "player", filter = "BUFF" },			
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Interval = 4,
			Opacity = 1,
			Mode = "ICON",
			setPoint = cooldownanchor,

			-- Чакра
			{ spellID = 14751, size = cdsize, filter = "CD" },
			-- Крылья
			{ spellID = 47788, size = cdsize, filter = "CD" },
			-- ПОМ
			{ spellID = 33076, size = cdsize, filter = "CD" },
			-- Колодец
			{ spellID = 724, size = cdsize, filter = "CD" },
			-- Круг исцеления
			{ spellID = 34861, size = cdsize, filter = "CD" },
			-- Хил Гимн
			{ spellID = 64843, size = cdsize, filter = "CD" },
			-- Мана гимн
			{ spellID = 64901, size = cdsize, filter = "CD" },
			-- Пет
			{ spellID = 34433, size = cdsize, filter = "CD" },
			-- Лужа
			{ spellID = 88685, size = cdsize, filter = "CD" },
		},
		{
			Name = "DEBUFF_FOCUS",
			Direction = "RIGHT",
			Interval = 4,
			Opacity = 1,
			Mode = "ICON",
			setPoint = { "TOPLEFT", TukuiFocus, "TOPRIGHT", 6, 2 },

			-- Оковы
			{ spellID = 9484, size = focussize, unitId = "focus", caster = "player", filter = "DEBUFF" },
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Interval = 4,
			Opacity = 1,
			Mode = "ICON",
			setPoint = anchortarget,

			-- Pain
			{ spellID = 589, size = ptsize, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Взрыв разума, стаки на +крит
			{ spellID = 87178, size = ptsize, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Вампир
			{ spellID = 34914, size = ptsize, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Чума
			{ spellID = 2944, size = ptsize, unitId = "target", caster = "player", filter = "DEBUFF" },
		},
	},
	["ROGUE"] = {
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Interval = 4,
			Opacity = 1,
			Mode = "ICON",
			setPoint = anchorplayer,

			-- Отравление
			{ spellID = 32645, size = ptsize, unitId = "player", caster = "player", filter = "BUFF" },
			-- Узкользание
			{ spellID = 5277, size = ptsize, unitId = "player", caster = "player", filter = "BUFF" },
			-- Спринт
			{ spellID = 2983, size = ptsize, unitId = "player", caster = "player", filter = "BUFF" },
			-- Плащ теней
			{ spellID = 31224, size = ptsize, unitId = "player", caster = "player", filter = "BUFF" },
			-- Заживление ран
			{ spellID = 73651, size = ptsize, unitId = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "C_BUFF_ICON",
			Direction = "UP",
			Interval = 4,
			Opacity = 1,
			Mode = "ICON",
			setPoint = anchortotbuff,

			-- Мясорубка
			{ spellID = 5171, size = 50, unitId = "player", caster = "player", filter = "BUFF" },
			-- Обвал
			{ spellID = 74245, size = 50, unitId = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Interval = 4,
			Opacity = 1,
			Mode = "ICON",
			setPoint = cooldownanchor,

			--Исчезновение
			{ spellID = 1856, size = cdsize, filter = "CD" },
			--Ускользание
			{ spellID = 5277, size = cdsize, filter = "CD" },
			--Спринт
			{ spellID = 2983, size = cdsize, filter = "CD" },
			--Ослепление
			{ spellID = 2094, size = cdsize, filter = "CD" },
			--Хладнокровие
			{ spellID = 14177, size = cdsize, filter = "CD" },
			--Вендетта
			{ spellID = 79140, size = cdsize, filter = "CD" },
			--Долой оружие
			{ spellID = 51722, size = cdsize, filter = "CD" },
			--Плащ теней
			{ spellID = 31224, size = cdsize, filter = "CD" },
			--Маленькие хитрости
			{ spellID = 57934, size = cdsize, filter = "CD" },
		},
		{
			Name = "DEBUFF_FOCUS",
			Direction = "RIGHT",
			Interval = 4,
			Opacity = 1,
			Mode = "ICON",
			setPoint = { "TOPLEFT", TukuiFocus, "TOPRIGHT", 6, 2 },

			-- Изгнание
			{ spellID = 710, size = focussize, unitId = "focus", caster = "player", filter = "DEBUFF" },
			-- Страх
			{ spellID = 5782, size = focussize, unitId = "focus", caster = "player", filter = "DEBUFF" },
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Interval = 4,
			Opacity = 1,
			Mode = "ICON",
			setPoint = anchortarget,

			-- Смертельный яд
			{ spellID = 2818, size = ptsize, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Рваная рана
			{ spellID = 1943, size = ptsize, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Ослабление доспеха
			{ spellID = 8647, size = ptsize, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Удар по почкам
			{ spellID = 408, size = ptsize, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Вендетта
			{ spellID = 79140, size = ptsize, unitId = "target", caster = "player", filter = "DEBUFF" },
		},
	},
	["ALL"] = {
		{
			Name = "P_DEBUFF_ICON",
			Direction = "UP",
			Interval = 4,
			Opacity = 1,
			Mode = "ICON",
			setPoint = { "BOTTOM", UIParent, "CENTER", 0, 0 },

			-- Проводник молний (омнитрон)
			{ spellID = 91431, size = debuffsize, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Статический шок (алакир)
			{ spellID = 87873, size = debuffsize, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Сумеречный метеорит
			{ spellID = 86013, size = debuffsize, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Затмение
			{ spellID = 92878, size = debuffsize, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Громоотвод
			{ spellID = 93295, size = debuffsize, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Промокший насквозь
			{ spellID = 82762, size = debuffsize, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Обморожение сердца
			{ spellID = 82665, size = debuffsize, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Пылающая кровь
			{ spellID = 82660, size = debuffsize, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Пожирающий огонь
			{ spellID = 92973, size = debuffsize, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Слизь -хит
			{ spellID = 88917, size = debuffsize, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Избыточная магия
			{ spellID = 95639, size = debuffsize, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Взрывчатая субстанция
			{ spellID = 79339, size = debuffsize, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Взрывчатая субстанция
			{ spellID = 92956, size = debuffsize, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Гравитационное ядро
			{ spellID = 92075, size = debuffsize, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Статическая перегрузка
			{ spellID = 92067, size = debuffsize, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Ледяная метка
			{ spellID = 92307, size = debuffsize, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Порча: тошнота
			{ spellID = 93200, size = debuffsize, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Searing Seeds (Majordomo Staghelm)
			{ spellID = 98450, size = debuffsize, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Гаснущий свет (Ультраксион)
			{ spellID = 109075, size = debuffsize, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Шрапнель (Безумие смертокрыла)
			{ spellID = 106794, size = debuffsize, unitId = "player", caster = "all", filter = "DEBUFF" },
		},
		{
			Name = "P_BUFF_ICON",
			Direction = "RIGHT",
			Interval = 4,
			Opacity = 1,
			Mode = "ICON",
			setPoint = allbuffanchor,

			-- Potions
			-- Tol'vir Agility
			{ spellID = 79633, size = allbufficonsize, unitId = "player", caster = "player", filter = "BUFF" },
			-- Golem's Strength
			{ spellID = 79634, size = allbufficonsize, unitId = "player", caster = "player", filter = "BUFF" },
			-- Volcanic Power
			{ spellID = 79476, size = allbufficonsize, unitId = "player", caster = "player", filter = "BUFF" },
			-- Bloodlust
			{ spellID = 2825, size = allbufficonsize, unitId = "player", caster = "all", filter = "BUFF" },
			-- Heroism
			{ spellID = 32182, size = allbufficonsize, unitId = "player", caster = "all", filter = "BUFF" },
			-- Time Warp
			{ spellID = 80353, size = allbufficonsize, unitId = "player", caster = "all", filter = "BUFF" },
			-- Ancient Hysteria
			{ spellID = 90355, size = allbufficonsize, unitId = "player", caster = "all", filter = "BUFF" },
		},
	},
}