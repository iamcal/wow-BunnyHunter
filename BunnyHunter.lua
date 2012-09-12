-- select locale file
local loc = GetLocale();
if (BHLocales[loc]) then
	L = BHLocales["enUS"];
	local k, v;
	for k, v in pairs(L) do
		if (BHLocales[loc][k]) then
			L[k] = BHLocales[loc][k];
		else
			L[k] = "(enUS)"..L[k];
		end
	end
else
	L = BHLocales['enUS'];
end

-- LDB plugin
local ldb = LibStub:GetLibrary("LibDataBroker-1.1")
local ldb_feed = ldb:NewDataObject("BunnyHunter", {type = "data source", text = "...", label = L.NAME});



BH = {}

-- ##################################################################
--
-- START OF THE MOBS
--

--
-- Get list of zone IDs from here: http://www.wowwiki.com/API_SetMapByID
-- Find out current one using: /run print(GetCurrentMapAreaID())
--

BH.dropConfig = {

	{
		name	= L.CATEGORY_PARROTS,
	},

	{
		id	= "8494", -- Hyacinth Macaw
		rate	= 1/10000,
		icon	= [[Interface\Icons\spell_nature_forceofnature]],
		xmobs	= {
			"2545", -- "Pretty Boy" Duncan
			"1561", -- Bloodsail Raider
			"1562", -- Bloodsail Mage
			"4505", -- Bloodsail Deckhand
			"1564", -- Bloodsail Warlock
			"1563", -- Bloodsail Swashbuckler
			"4506", -- Bloodsail Swabby
			"1565", -- Bloodsail Sea Dog
			"1653", -- Bloodsail Elder Magus
		},
		zones	= {
			"37", -- Northern Stranglethorn
			"673", -- Cape of Stranglethorn
			"689", -- Stranglethorn Vale
		},
	},

	{
		id	= "8492", -- Green Wing Macaw
		rate	= 1/1000,
		icon	= [[Interface\Icons\spell_nature_forceofnature]],
		mobs	= {
			"657", -- Defias Pirate
			"48522", -- Defias Pirate
		},
	},


	{
		name	= L.CATEGORY_HATCHLINGS,
	},

	{
		id	= "48114", -- Deviate Hatchling
		rate	= 1/100,
		icon	= [[Interface\Icons\ability_hunter_pet_raptor]],
		mobs	= {
			"3637", -- Deviate Guardian
			"3636", -- Deviate Ravager
		},
	},

	{
		id	= "48116", -- Gundrak Hatchling
		rate	= 1/1000,
		icon	= [[Interface\Icons\ability_mount_raptor]],
		mobs	= {
			"29334", -- Gundrak Raptor
		},
	},

	{
		id	= "48126", -- Razzashi Hatchling
		rate	= 1/1000,
		icon	= [[Interface\Icons\ability_hunter_pet_raptor]],
		xmobs	= {
			"14821", -- Razzashi Raptor
		},
		zones	= {
			"37", -- Northern Stranglethorn
			"673", -- Cape of Stranglethorn
			"689", -- Stranglethorn Vale
		},
	},



	{
		name	= L.CATEGORY_WHELPLINGS,
	},

	{
		id	= "34535", -- Azure Whelpling
		rate	= 1/1000,
		icon	= [[Interface\Icons\inv_misc_head_dragon_blue]],
		xmobs	= {
			"6129", -- Draconic Magelord
			"6131", -- Draconic Mageweaver
			"6130", -- Blue Scalebane
			"193", -- Blue Dragonspawn
		},
		zones	= {
			"281", -- Winterspring
		},
	},

	{
		id	= "8499", -- Tiny Crimson Whelpling
		rate	= 1/1000,
		icon	= [[Interface\Icons\inv_misc_head_dragon_01]],
		xmobs	= {
			"1042", -- Red Whelp
			"1044", -- Flamesnorting Whelp
			"1069", -- Crimson Whelp
		},
		zones	= {
			"40", -- Wetlands
		},
	},

	{
		id	= "10822", -- Dark Whelpling
		rate	= 1/1000,
		icon	= [[Interface\Icons\inv_misc_head_dragon_black]],
		mobs	= {
			"4324",  -- Searing Whelp
			"2725",  -- Scalding Whelp
			"42042", -- Ebon Whelp
			"46916", -- Nyxondra's Broodling
			"7049",  -- Flamescale Broodling
			"4323",  -- Searing Hatchling
			"46914", -- Raging Whelp
		},
	},

	{
		id	= "8498", -- Tiny Emerald Whelpling
		rate	= 1/1000,
		icon	= [[Interface\Icons\inv_misc_head_dragon_green]],
		mobs	= {
			"741", -- Dreaming Whelp
			"740", -- Adolescent Whelp
			"39384", -- Noxious Whelp
		},
	},


	{
		name	= L.CATEGORY_MISC,
	},

	{
		id	= "29960", -- Captured Firefly
		rate	= 1/1000,
		icon	= [[Interface\Icons\inv_box_birdcage_01]],
		mobs	= {
			"20197", -- Bogflare Needler
		},
	},

	{
		id	= "8491", -- Black Tabby Cat
		rate	= 1/1000,
		icon	= [[Interface\Icons\inv_box_petcarrier_01]],
		xmobs	= {
			"2358", -- Dalaran Summoner
			"2272", -- Dalaran Theurgist
			"2271", -- Dalaran Shield Guard
		},
		zones	= {
			"24", -- Hillsbrad Footfills
		},
	},

	{
		id	= "35504", -- Phoenix Hatchling
		icon	= [[Interface\Icons\INV_Misc_PheonixPet_01]],
		rate	= 1/10,
		mobs	= {
			"24664", -- Kael'thas Sunstrider
		},
		notime = 1,
	},

	{
		id	= "11474", -- Sprite Darter Egg
		icon	= [[Interface\Icons\inv_egg_02]],
		rate	= 1/10000,
		xmobs	= {
			"5278", -- Sprite Darter
		},
		zones	= {
			"121", -- Feralas
		},
	},

	{
		id	= "64403", -- Fox Kit
		icon	= [[Interface\Icons\inv_misc_foxkit]],
		rate	= 1/200,
		mobs	= {
			"47676", -- Baradin Fox
		},
	},


	{
		name	= L.CATEGORY_MOUNTS,
	},

	{
		id	= "32458", -- Al'ar
		rate	= 2/100,
		icon	= [[Interface\Icons\inv_misc_summerfest_brazierorange]],
		mobs	= {
			"19622", -- Kael'thas Sunstrider
		},
		notime	= 1,
	},

	{
		id	= "49636", -- Onyxian Drake
		rate	= 2/1000,
		icon	= [[Interface\Icons\achievement_boss_onyxia]],
		mobs	= {
			"10184", -- Onyxia
		},
		mode	= "25N",
		notime	= 1,
	},

	{
		id	= "30480", -- Fiery Warhorse
		rate	= 1/100,
		icon	= [[Interface\Icons\ability_mount_dreadsteed]],
		mobs	= {
			"16152", -- Attumen
		},
		notime	= 1,
	},

	{
		id	= "13335", -- Rivendare's Deathcharger
		rate	= 1/100,
		icon	= [[Interface\Icons\ability_mount_undeadhorse]],
		mobs	= {
			"10440", -- Baron Rivendare
			"45412", -- Lord Aurius Rivendare
		},
		notime	= 1,
	},

	{
		id	= "44151", -- Blue Proto-Drake
		rate	= 13/1000,
		icon	= [[Interface\Icons\ability_mount_drake_proto]],
		mobs	= {
			"26693", -- Skadi the Ruthless
		},
		mode	= "5H",
		notime	= 1,
	},

	{
		id	= "63043", -- Vitreous Stone Drake
		rate	= 9/1000,
		icon	= [[Interface\Icons\inv_misc_stonedragonblue]],
		mobs	= {
			"43214", -- Slabhide
		},
		notime	= 1,
	},

	{
		id = "63040", -- Drake of the North Wind
		rate = 1/100,
		icon = [[Interface\Icons\inv_misc_stormdragonpale]],
		mobs = {
			"43873", -- Altairus
		},
		notime = 1,
	},

	{
		id	= "35513", -- Swift White Hawkstrider
		rate	= 3/100,
		icon	= [[Interface\Icons\ability_mount_cockatricemountelite_white]],
		mobs	= {
			"24664", -- Kael'thas Sunstrider
		},
		mode	= "5H",
		notime	= 1,
	},

	{
		id	= "32768", -- Raven Lord
		rate	= 15/1000,
		icon	= [[Interface\Icons\inv-mount_raven_54]],
		mobs	= {
			"23035", -- Anzu
		},
		mode	= "5H",
		notime	= 1,
	},

	{
		id	= "37012", -- Headless Horseman's Mount
		rate	= 3/1000,
		icon	= [[Interface\Icons\inv_belt_12]],
		mobs	= {
			"23682", -- Headless Horseman
		},
		notime	= 1,
	},

	{
		id	= "21321", -- Red Qiraji Battle Tank
		rate	= 15/1000,
		icon	= [[Interface\Icons\inv_misc_qirajicrystal_02]],
		mobs	= {
			"15250", -- Qiraji Slayer
			"15246", -- Qiraji Mindslayer
			"15249", -- Qiraji Lasher
			"15252", -- Qiraji Champion
			"15247", -- Qiraji Brainwasher
			"15312", -- Obsidian Nullifier
			"15262", -- Obsidian Eradicator
			"15311", -- Anubisath Warder
			"15264", -- Anubisath Sentinel
			"15277", -- Anubisath Defender
 		},
	},

	{
		id	= "33993", -- Mojo
		item2	= "33865", -- Amani Hex Stick
		rate	= 1/2,
		rate2	= 1/50,
		icon	= [[Interface\Icons\spell_shaman_hex]],
		icon2	= [[Interface\Icons\inv_wand_22]],
		mobs	= {
			"23580", -- Amani'shi Warbringer
			"24059", -- Amani'shi Beast Tamer
			"23582", -- Amani'shi Tribesman
			"24374", -- Amani'shi Berserker
			"24065", -- Amani'shi Handler
			"24179", -- Amani'shi Wind Walker
			"23774", -- Amani'shi Trainer
			"23596", -- Amani'shi Flame Caster
			"23597", -- Amani'shi Guardian
			"23542", -- Amani'shi Axe Thrower
			"24180", -- Amani'shi Protector
			"24549", -- Amani'shi Tempest
			"23581", -- Amani'shi Medicine Man
 		},
		hidden	= true,
	},


	-- ###################################################################
	-- START OF TEST ITEMS

	{
		id	= "5465", -- Small Spider Leg
		icon	= [[Interface\Icons\INV_Misc_monsterspidercarapace_01]],
		rate	= 1/10,
		mobs	= {
			"30", -- Forest Spider
			"525", -- Mangy Wolf
		},
		hidden	= true,
	},

	{
		id	= "8952", -- Roasted Quail
		rate	= 1/100,
		icon	= [[Interface\Icons\inv_misc_food_15]],
		mobs	= {
			"17370", -- Laughing Skull Enforcer
		},
		mode	= "5H",
		hidden	= true,
	},

	{
		id	= "62328", -- Shed Fur
		icon	= [[Interface\Icons\INV_Misc_monsterspidercarapace_01]],
		rate	= 1/10,
		zones	= {
			"30", -- Elwynn Forest
		},
		hidden	= true,
	},

	-- END OF TEST ITEMS
	-- ###################################################################

};


-- Disgusting Oozeling (20769) (SPECIAL!)


--
-- END OF THE MOBS
--
-- ##################################################################


function BH.OnLoad()

	--print("BH.OnLoad()");

	BH.lootOpen = false;

	BH.seenGuids = {};	-- a list of GUIDs already looted
	BH.nameList = {};	-- name -> itemId map
	BH.unitIdList = {};	-- unit id -> itemId map
	BH.zoneIdList = {};	-- zone id -> itemId map
	BH.itemData = {};	-- itemId -> dropData map

	BH.inSession = false;
	BH.sessionStarted = 0;
	BH.sessionLast = 0;
	BH.sessionEnds = 0;

	BH.sessionLength = 60 * 5; -- 5m
	--BH.sessionLength = 20;

	local dropData;
	for _, dropData in pairs(BH.dropConfig) do

		if (not dropData.mobs) then dropData.mobs = {}; end
		if (not dropData.zones) then dropData.zones = {}; end

		if (dropData.id and not dropData.hidden) then

			dropData.name = L["ITEM_"..dropData.id];
			if (not dropData.name) then
				dropData.name = "UNKNOWN ITEM "..dropData.id;
			end

			BH.itemData[dropData.id] = dropData;

			local unit_id;
			for _, unit_id in pairs(dropData.mobs) do

				BH.unitIdList[unit_id] = dropData.id;
			end

			local zone_id;
			for _, zone_id in pairs(dropData.zones) do

				BH.zoneIdList[zone_id] = dropData.id;
			end
		end
	end
end

function BH.OnReady()

	--print("NAME: " .. L["NAME"]);
	--print("BH.OnReady()");

	_G.BunnyHunterDB = _G.BunnyHunterDB or {};
	_G.BunnyHunterDB.kills_by_id = _G.BunnyHunterDB.kills_by_id or {};
	_G.BunnyHunterDB.loots = _G.BunnyHunterDB.loots or {};
	_G.BunnyHunterDB.opts = _G.BunnyHunterDB.opts or {};
	_G.BunnyHunterDB.times = _G.BunnyHunterDB.times or {};

	-- if they have an old kills database, convert it
	if (_G.BunnyHunterDB.kills) then
		local name, kills;
		for name, kills in pairs(_G.BunnyHunterDB.kills) do

			local matched_uid = 0;

			-- old migration code
			local unit_id;
			for unit_id, _ in pairs(BH.unitIdList) do
				if (name == BHLocales['enUS']['MOB_'..unit_id]) then
					matched_uid = unit_id;
				end
			end

			if (matched_uid) then
				_G.BunnyHunterDB.kills_by_id[matched_uid] = (_G.BunnyHunterDB.kills_by_id[matched_uid] or 0) + kills;
			end
		end

		_G.BunnyHunterDB.kills = nil;
	end

	BHLocales = nil;

	_G.BunnyHunterDB.opts.curItem = _G.BunnyHunterDB.opts.curItem or "8492";

	-- pick a choice that's enabled pls :)
	if (not BH.itemData[_G.BunnyHunterDB.opts.curItem]) then

		_G.BunnyHunterDB.opts.curItem = "8492";
	end

	-- convert the stored loots data from single numbers to tables
	local itemId, loots;
	for itemId, loots in pairs(_G.BunnyHunterDB.loots) do

		local uid, lootData;
		for uid, lootData in pairs(loots) do

			if (type(lootData) == "table") then

				_G.BunnyHunterDB.loots[itemId][uid].loots = _G.BunnyHunterDB.loots[itemId][uid].loots or 1;
				_G.BunnyHunterDB.loots[itemId][uid].time  = _G.BunnyHunterDB.loots[itemId][uid].time or 0;

			else

				local newLoot = {
					loots = lootData,
					time = 0,
				};

				_G.BunnyHunterDB.loots[itemId][uid] = newLoot;
			end
		end
	end


	BHOptionsFrame.name = 'Bunny Hunter';
	InterfaceOptions_AddCategory(BHOptionsFrame);

	--BH.DumpStatus();

	BH.StartFrame();
end

function BH.ShowOptions()

	InterfaceOptionsFrame_OpenToCategory(BHOptionsFrame.name);
end

function BH.OptionClick(button, name)

	if (name == 'hide') then
		if (_G.BunnyHunterDB.opts.hide) then
			BH.Show();
		else
			BH.Hide();
		end
	end

end


function BH.OnSaving()

	BH.EndSession();

	local point, relativeTo, relativePoint, xOfs, yOfs = BH.UIFrame:GetPoint()
	_G.BunnyHunterDB.opts.frameRef = relativePoint;
	_G.BunnyHunterDB.opts.frameX = xOfs;
	_G.BunnyHunterDB.opts.frameY = yOfs;
	_G.BunnyHunterDB.opts.frameW = BH.UIFrame:GetWidth();
	_G.BunnyHunterDB.opts.frameH = BH.UIFrame:GetHeight();
end

function BH.SeenGuid(guid)

	if (BH.seenGuids[guid]) then
		return true;
	end

	BH.seenGuids[guid] = 1;
end

function BH.DoWeCare(unit_id)

	-- figure out if unit_id is a unit we're watching for *any*
	-- drops. if it is, increment the stored count. we store a count
	-- for the base unit and then for each mode - this allows us to
	-- track both the pheonix hatchling (normal and heroic) and the
	-- hawkstrider (heroic only) that drop from the same mob uid.

	local zone_id = "" .. GetCurrentMapAreaID();

	--print("testing UID "..unit_id);

	if ((not BH.unitIdList[unit_id]) and (not BH.zoneIdList[zone_id])) then

		--print('no list matches');
		return false;
	end

	local curMode = BH.GetMode();
	local matched = false;
	local dropInfo;
	local incKeys = {};

	for _, dropInfo in pairs(BH.dropConfig) do

		local mobId;
		for _, mobId in pairs(dropInfo.mobs) do

			if (mobId == unit_id) then

				if (dropInfo.mode) then
					if (dropInfo.mode == curMode) then
						matched = true;
						incKeys[mobId.."-"..curMode] = 1;
						BH.SwitchToItem(dropInfo.id);
					end
				else
					matched = true;
					incKeys[mobId] = 1;
					BH.SwitchToItem(dropInfo.id);
				end
			end
		end

		local test_zone_id;
		for _, test_zone_id in pairs(dropInfo.zones) do

			if (test_zone_id == zone_id) then

				matched = true;
				incKeys[zone_id.."-ZONE"] = 1;
				BH.SwitchToItem(dropInfo.id);
			end
		end
	end

	local mobId;
	for mobId, _ in pairs(incKeys) do
		BH.IncUnitCount(mobId);
	end

	--print('some matches');
	return matched;
end

function BH.IncUnitCount(unit_id)

	-- can be a simple unit ID ("1234") or include a mode ("1234-5H")

	local old = _G.BunnyHunterDB.kills_by_id[unit_id] or 0;
	_G.BunnyHunterDB.kills_by_id[unit_id] = old + 1;
end

function BH.SwitchToItem(itemId)

	if (_G.BunnyHunterDB.opts.curItem == itemId) then

		--print("Item "..itemId.." is already selected")
		BH.UpdateSession();
	else
		--print("Item "..itemId.." is NOW selected")
		BH.EndSession();
		BH.StartSession();

		_G.BunnyHunterDB.opts.curItem = itemId;
	end
end

function BH.FoundLoot(itemId)

	local itemData = BH.ItemData(itemId);

	print(string.format(L.FOUND, itemData.itemLink));

	if (not _G.BunnyHunterDB.loots[itemId]) then
		_G.BunnyHunterDB.loots[itemId] = {};
	end

	table.insert(_G.BunnyHunterDB.loots[itemId], {
		loots = BH.GetTotalKills(itemId),
		time = _G.BunnyHunterDB.times[itemId] or 0,
	});

	BH.UpdateFrame();
end

function BH.GetTotalKills(itemId)

	if (not BH.itemData[itemId]) then
		return 0;
	end

	local totalKills = 0;

	local unit_id;
	for _, unit_id in pairs(BH.itemData[itemId].mobs) do

		local key = unit_id;
		if (BH.itemData[itemId].mode) then
			key = key .. "-" .. BH.itemData[itemId].mode;
		end

		totalKills = totalKills + (_G.BunnyHunterDB.kills_by_id[key] or 0);
	end

	local zone_id;
	for _, zone_id in pairs(BH.itemData[itemId].zones) do

		local key = zone_id .. "-ZONE";

		totalKills = totalKills + (_G.BunnyHunterDB.kills_by_id[key] or 0);
	end

	return totalKills;
end

function BH.GetTotalKillsSince(itemId)

	local totalKills = BH.GetTotalKills(itemId);
	local latestKill = 0;

	-- find the last time we found the thing we're looking for...
	if (_G.BunnyHunterDB.loots[itemId]) then

		local lootData;
		for _, lootData in pairs(_G.BunnyHunterDB.loots[itemId]) do
			if (lootData.loots) then
				if (lootData.loots > latestKill) then
					latestKill = lootData.loots
				end
			end
		end
	end

	return totalKills - latestKill;
end

function BH.GetTotalTime(itemId)

	local saved = _G.BunnyHunterDB.times[itemId] or 0;
	local fresh = 0;

	if (itemId == _G.BunnyHunterDB.opts.curItem and BH.inSession) then

		fresh = GetTime() - BH.sessionStarted;
	end

	return saved + fresh;
end

function BH.GetTotalTimeSince(itemId)

	local totalTime = BH.GetTotalTime(itemId);
	local latestTime = 0;

	-- find the last time we found the thing we're looking for...
	if (_G.BunnyHunterDB.loots[itemId]) then

		local lootData;
		for _, lootData in pairs(_G.BunnyHunterDB.loots[itemId]) do
			if (lootData.time) then
				if (lootData.time > latestTime) then
					latestTime = lootData.time
				end
			end
		end
	end

	return totalTime - latestTime;
end

function BH.GetKillsLatest(itemId)

	local lootsThis = 0;
	local lastLoot = 0;

	if (_G.BunnyHunterDB.loots[itemId]) then

		local lootData;
		for _, lootData in pairs(_G.BunnyHunterDB.loots[itemId]) do

			lootsThis = lootData.loots - lastLoot;
			lastLoot = lootData.loots;
		end
	end

	return lootsThis;
end

function BH.ItemData(itemId)

	itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice = GetItemInfo(itemId)

	return {
		["itemName"]		= itemName;
		["itemLink"]		= itemLink;
		["itemRarity"]		= itemRarity;
		["itemLevel"]		= itemLevel;
		["itemMinLevel"]	= itemMinLevel;
		["itemType"]		= itemType;
		["itemSubType"]		= itemSubType;
		["itemStackCount"]	= itemStackCount;
		["itemEquipLoc"]	= itemEquipLoc;
		["itemTexture"]		= itemTexture;
		["itemSellPrice"]	= itemSellPrice;
	};
end

function BH.GetItemColor(itemLink)

	if (itemLink) then
		local _, color = strsplit("|", itemLink);
		return color;
	end

	return 'cffffff00';
end

function BH.GetItemColoredName(itemId)

	local itemData = BH.ItemData(itemId);

	if (itemData.itemName) then
		local color = BH.GetItemColor(itemData.itemLink)
		return "|"..color..itemData.itemName
	end

	itemData = BH.itemData[itemId];

	return "|cffffffcc"..itemData.name
end

function BH.DumpStatus()

end

function BH.OnEvent(frame, event, ...)

	if (event == 'ADDON_LOADED') then
		local name = ...;
		if name == 'BunnyHunter' then
			BH.OnReady();
		end
	end

	if (event == 'PLAYER_LOGOUT') then

		BH.OnSaving();
	end

	if (event == 'PLAYER_TARGET_CHANGED') then

	end

	if (event == 'LOOT_OPENED') then

		BH.OnLoot();
		BH.lootOpen = true;
	end

	if (event == 'LOOT_CLOSED') then

		if (not BH.lootOpen) then

			--print "no loot on this target!";
			BH.OnLoot();
		end

		BH.lootOpen = false;
	end
end

function BH.OnLoot()

		local guid = UnitGUID("target");
		local name = UnitName("target");

		--print("target guid: "..guid);

		if (not name or not guid) then
			--print("no target");
			return;
		end

		if (not UnitCanAttack("player", "target")) then
			--print("target not hostile");
			return;
		end

		if (UnitIsPlayer("target")) then
			--print("target is a player");
			return;
		end

		if (not UnitIsDead("target")) then
			--print("Target isn't dead. Uhh...");
			return;
		end

		if (BH.SeenGuid(guid)) then
			--print("We've seen this guid already");
			return;
		end

		if (not BH.DoWeCare(BH.ExtractUnitId(guid))) then
			--print("We don't care about kills of this unit type");
			return;
		end

		--print("ok! process this baby");

		local numItems = GetNumLootItems()

		for slotID = 1, numItems, 1 do

			-- coins have a qty of 0
			local _, _, qty = GetLootSlotInfo(slotID);

			if (qty > 0) then

				local itemLink = GetLootSlotLink(slotID);
				local _, itemId = strsplit(":", itemLink);

				--print("found item id "..itemId);

				if (BH.itemData[itemId]) then

					--print("we care about that!!");
					BH.FoundLoot(itemId);
				end
			end
		end

		BH.UpdateFrame();
end

function BH.ExtractUnitId(guid)

	if (guid) then

		local type = tonumber(guid:sub(5,5), 16) % 8;

		if (type == 3) then
			local uid = "" .. tonumber(guid:sub(7,10), 16);
			local spawn = guid:sub(13,18);

			return uid;
		end
	end

	return 0;
end

function BH.FormatPercent(p)

	if (p == 0) then
		return 0;
	end

	local x = string.format("%.1f", p)

	if (x == "0.0" or x == "99.9") then x = string.format("%.2f", p) end;
	if (x == "0.00" or x == "99.99") then x = string.format("%.3f", p) end;
	if (x == "0.000" or x == "99.999") then x = string.format("%.4f", p) end;

	return x;
end

function BH.FormatTime(t, zero)

	if (t == 0) then
		return zero;
	end

	local h = math.floor(t / (60 * 60));
	t = t - (60 * 60 * h);
	local m = math.floor(t / 60);
	t = t - (60 * m);
	local s = t;

	if (h > 0) then
		return string.format("%d:%02d:%02d", h, m, s);
	end

	if (m > 0) then
		return string.format("%d:%02d", m, s);
	end

	return string.format("%d", s).."s";
end

function BH.OnDragStart(frame)
	BH.UIFrame:StartMoving();
	BH.UIFrame.isMoving = true;
	GameTooltip:Hide()
end

function BH.OnDragStop(frame)
	BH.UIFrame:StopMovingOrSizing();
	BH.UIFrame.isMoving = false;
end

function BH.StartFrame()

	BH.UIFrame = CreateFrame("Frame",nil,UIParent);
	BH.UIFrame:SetFrameStrata("BACKGROUND")
	BH.UIFrame:SetWidth(150)
	BH.UIFrame:SetHeight(32)

	BH.UIFrame.texture = BH.UIFrame:CreateTexture()
	BH.UIFrame.texture:SetAllPoints(BH.UIFrame)
	BH.UIFrame.texture:SetTexture(0, 0, 0)
	

	-- position the parent frame
	local frameRef = "CENTER";
	local frameX = 0;
	local frameY = 0;
	if (_G.BunnyHunterDB.opts.frameRef) then
		frameRef = _G.BunnyHunterDB.opts.frameRef;
		frameX = _G.BunnyHunterDB.opts.frameX;
		frameY = _G.BunnyHunterDB.opts.frameY;

		BH.UIFrame:SetWidth(_G.BunnyHunterDB.opts.frameW);
	end
	BH.UIFrame:SetPoint(frameRef, frameX, frameY);

	-- make it draggable
	BH.UIFrame:SetMovable(true);
	BH.UIFrame:EnableMouse(true);

	-- make it resizable
	BH.UIFrame:SetMaxResize(400, 32)
	BH.UIFrame:SetMinResize(150, 32)
	BH.UIFrame:SetResizable(true)
	makeSizable(BH.UIFrame)

	-- create the button
	local d2 = BH.ItemData(_G.BunnyHunterDB.opts.curItem);
	BH.Button = CreateFrame("Button", nil, BH.UIFrame)
	BH.Button:SetPoint("TOPLEFT", 1, -1)
	BH.Button:SetWidth(30)
	BH.Button:SetHeight(30)
	BH.Button:SetNormalTexture(d2.itemTexture);
	BH.Button:SetScript("OnClick", BH.ShowMenu)

	-- create the progress bar
	BH.ProgressBar = CreateFrame("StatusBar", nil, BH.UIFrame)
	BH.ProgressBar:SetPoint("TOPLEFT", 33, -1)
	BH.ProgressBar:SetPoint("BOTTOMRIGHT", -1, 1)
	BH.ProgressBar:SetMinMaxValues(0, 100)
	BH.ProgressBar:SetValue(100)
	BH.ProgressBar:SetOrientation("HORIZONTAL")
	BH.ProgressBar:SetStatusBarTexture([[Interface\TargetingFrame\UI-StatusBar]], "ARTWORK")
	BH.ProgressBar:SetStatusBarColor(0, 1, 0)

	BH.ProgressBar:EnableMouse(true); 
	BH.ProgressBar:SetHitRectInsets(0, 0, 0, 0)
	BH.ProgressBar:SetScript("OnEnter", BH.ShowTooltip);
	BH.ProgressBar:SetScript("OnLeave", function() GameTooltip:Hide() end);
	BH.ProgressBar:SetScript("OnDragStart", BH.OnDragStart);
	BH.ProgressBar:SetScript("OnDragStop", BH.OnDragStop);
	BH.ProgressBar:RegisterForDrag("LeftButton");


	-- some text to go over it
	BH.Label = BH.ProgressBar:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
	BH.Label:SetPoint("CENTER", BH.ProgressBar, "CENTER", 2, 0)
	BH.Label:SetJustifyH("LEFT")
	BH.Label:SetText("Test Text")
	BH.Label:SetTextColor(1,1,1,1)
	BH.SetFontSize(BH.Label, 10)


	BH.UpdateFrame();

	if (_G.BunnyHunterDB.opts.hide) then
		BH.UIFrame:Hide();
	else
		BH.UIFrame:Show();
	end
end

function BH.Show()
	_G.BunnyHunterDB.opts.hide = false;
	BH.UIFrame:Show();
	BHOptionsFrameCheck1:SetChecked(true);
	--print("Bunny Hunter: Visible");
end

function BH.Hide()
	_G.BunnyHunterDB.opts.hide = true;
	BH.UIFrame:Hide();
	BHOptionsFrameCheck1:SetChecked(false);
	--print("Bunny Hunter: Hidden");
end

function BH.ResetPos()
	BH.Show();
	BH.UIFrame:SetWidth(150);
	BH.UIFrame:ClearAllPoints();
	BH.UIFrame:SetPoint("CENTER", 0, 0);
end

function BH.Toggle()

	if (_G.BunnyHunterDB.opts.hide) then
		BH.Show();
	else
		BH.Hide();
	end
end

function BH.SetFontSize(string, size)

	local Font, Height, Flags = string:GetFont()
	string:SetFont(Font, size, Flags)
end

function makeSizable(frame)

	local grip = CreateFrame("Frame", nil, frame)
	grip:EnableMouse(true)
	local tex = grip:CreateTexture()
	grip.tex = tex
	tex:SetTexture(0.1, 0.1, 0.1)
	tex:ClearAllPoints()
	tex:SetPoint("TOPLEFT")
	tex:SetPoint("BOTTOMRIGHT", grip, "TOPLEFT", 12, -12)
	grip:SetWidth(22)
	grip:SetHeight(21)
	grip:SetScript("OnMouseDown", function(self)
		self:GetParent():StartSizing()
	end)
	grip:SetScript("OnMouseUp", function(self)
		self:GetParent():StopMovingOrSizing()
	end)

	grip:ClearAllPoints()
	grip:SetPoint("BOTTOMRIGHT")
end

function BH.UpdateFrame()

	local itemId = _G.BunnyHunterDB.opts.curItem;
	local itemData = BH.ItemData(itemId);
	local kills = BH.GetTotalKillsSince(itemId);
	local killsTotal = BH.GetTotalKills(itemId);

	if (not BH.itemData[itemId]) then
		BH.itemData[itemId] = {};
	end

	local dropChance = BH.itemData[itemId].rate or 0;
	local totalChance = 100 * (1 - math.pow(1 - dropChance, kills));

	if (kills == 0 and killsTotal > 0) then

		kills = BH.GetKillsLatest(itemId);

		BH.ProgressBar:SetValue(100)
		BH.ProgressBar:SetStatusBarColor(1, 0.4, 0.4)

		local text = string.format(L.FOUND_AFTER, kills);
		BH.Label:SetText(text);
		ldb_feed.text = text;
	else
		BH.ProgressBar:SetValue(totalChance)
		BH.ProgressBar:SetStatusBarColor(0, 1, 0)

		local text = string.format(L.LOOTS, kills, BH.FormatPercent(totalChance));
		BH.Label:SetText(text);
		ldb_feed.text = text;
	end


	-- update icon
	local texture = itemData.itemTexture or BH.itemData[itemId].icon or [[Interface\Icons\INV_Misc_QuestionMark]];
	BH.Button:SetNormalTexture(texture);
	ldb_feed.icon = texture;
end


function BH.ShowMenu()

	local menu_frame = CreateFrame("Frame", "menuFrame", UIParent, "UIDropDownMenuTemplate")

	local menuList = {};
	local first = true;

	local dropData;
	for _, dropData in pairs(BH.dropConfig) do	

		if (dropData.id) then

			if (not dropData.hidden) then

				local icon = "|T"..dropData.icon..":0|t ";

				table.insert(menuList, {
					text = "    "..BH.GetItemColoredName(dropData.id),
					func = function() BH.SetItem(dropData.id) end,
					--fontObject = "GameFontNormalLarge",
					isTitle = false,
					checked = _G.BunnyHunterDB.opts.curItem == dropData.id,
					disabled = false,
				});
			end
		else

			if (not first) then
				table.insert(menuList, {
					text = "",
					disabled = true,
				});

			end

			table.insert(menuList, {
				text = dropData.name,
				isTitle = true,
				--fontObject = "GameFontHighlightLarge",
				disabled = false,
			});

		end

		first = false;
	end

	EasyMenu(menuList, menu_frame, BH.Button, 0 , 0, "MENU")
end

function BH.SetItem(itemId)

	if (not (_G.BunnyHunterDB.opts.curItem == itemId)) then

		BH.EndSession();

		_G.BunnyHunterDB.opts.curItem = itemId;
	end

	BH.UpdateFrame();
end

function BH.ShowTooltip()

	GameTooltip:SetOwner(BH.ProgressBar, "ANCHOR_BOTTOM");

	BH.FillTooltip(GameTooltip);

	GameTooltip:ClearAllPoints()
	GameTooltip:SetPoint("TOPLEFT", BH.ProgressBar, "BOTTOMLEFT"); 

	GameTooltip:Show()
end

function round(num) return math.floor(num+.5) end

function BH.FillTooltip(GameTooltip)

	local itemId = _G.BunnyHunterDB.opts.curItem;
	local itemData = BH.ItemData(itemId);

	local totalKills = BH.GetTotalKills(itemId);
	local totalKillsSince = BH.GetTotalKillsSince(itemId);

	local totalTime = BH.GetTotalTime(itemId);
	local totalTimeSince = BH.GetTotalTimeSince(itemId);

	if (not BH.itemData[itemId]) then
		BH.itemData[itemId] = {};
	end

	local dropChance = BH.itemData[itemId].rate or 0;
	local invChance = 1 / dropChance
	local totalChance = 100 * (1 - math.pow(1 - dropChance, totalKillsSince));

	GameTooltip:SetText(BH.GetItemColoredName(itemId))
	if (not itemData.itemName) then
		GameTooltip:AddLine(L.NEVER_SEEN, 1, 0.4, 0.4)
	end

	GameTooltip:AddLine(" ")
	GameTooltip:AddDoubleLine(L.LOOTS_SINCE, totalKillsSince, 1,1,1,1,1,1)

	if (not BH.itemData[itemId].notime) then

		if (BH.inSession) then
			GameTooltip:AddDoubleLine(L.FARM_TIME, BH.FormatTime(totalTimeSince, "0s"), 1,1,1,1,0.4,0.4)
		else
			GameTooltip:AddDoubleLine(L.FARM_TIME, BH.FormatTime(totalTimeSince, "0s"), 1,1,1,1,1,1)
		end
	end

	GameTooltip:AddDoubleLine(L.DROP_CHANCE, " "..string.format(L.DROP_CHANCE2, round(invChance)), 1,1,1,1,1,1)
	GameTooltip:AddDoubleLine(L.CUMM_CHANCE, BH.FormatPercent(totalChance).."%", 1,1,1,1,1,1)

	local medianLoots = math.log(1 - 0.5) / math.log(1 - dropChance);

	GameTooltip:AddDoubleLine(L.MEDIAN_LOOTS, round(medianLoots), 1,1,1,1,1,1);

	if (not BH.itemData[itemId].notime) then

		if (totalKillsSince > 0 and totalTimeSince > 0) then
			local killsPerSecond = totalKillsSince / totalTimeSince;
			local medianKills = math.ceil(math.log(0.5) / math.log(1 - dropChance));
			local meanTime = invChance / killsPerSecond;
			local medianTime = medianKills / killsPerSecond;

			GameTooltip:AddDoubleLine(L.MEAN_TIME, BH.FormatTime(meanTime, "0s"), 1,1,1,1,1,1)
			GameTooltip:AddDoubleLine(L.MEDIAN_TIME, BH.FormatTime(medianTime, "0s"), 1,1,1,1,1,1)
		end
	end


	GameTooltip:AddLine(" ")
	GameTooltip:AddDoubleLine(L.TOTAL_LOOTS, totalKills, 1,1,1,1,1,1)

	-- show individual mobs
	local unit_id;
	for _, unit_id in pairs(BH.itemData[itemId].mobs) do

		local name = L["MOB_"..unit_id];
		if (not name) then
			name = "UNKNOWN MOB "..unit_id;
		end
		if (BH.itemData[itemId].mode) then
			name = name .. " (" .. L['MODE_'..BH.itemData[itemId].mode] .. ")";
		end

		local key = unit_id;
		if (BH.itemData[itemId].mode) then
			key = key .. "-" .. BH.itemData[itemId].mode;
		end

		GameTooltip:AddDoubleLine(name..":", (_G.BunnyHunterDB.kills_by_id[key] or 0), 1,1,1,1,1,1);
	end

	-- show individual zones
	local zone_id;
	for _, zone_id in pairs(BH.itemData[itemId].zones) do

		local name = L["ZONE_"..zone_id];
		if (not name) then
			name = "UNKNOWN ZONE "..zone_id;
		else
			name = name .. " " .. L["ZONE"];
		end

		local key = zone_id.."-ZONE";

		GameTooltip:AddDoubleLine(name..":", (_G.BunnyHunterDB.kills_by_id[key] or 0), 1,1,1,1,1,1);
	end

	local lastLoot = 0;
	local lastTime = 0;
	local drop = 1;

	if (_G.BunnyHunterDB.loots[itemId]) then

		local lootData;
		for _, lootData in pairs(_G.BunnyHunterDB.loots[itemId]) do

			local timeThis = lootData.time - lastTime;
			lastTime = lootData.time;

			local lootsThis = lootData.loots - lastLoot;
			lastLoot = lootData.loots;

			local thisChance = 100 * (1 - math.pow(1 - dropChance, lootsThis));

			if (drop == 1) then
				GameTooltip:AddLine(" ")
			end

			if (BH.itemData[itemId].notime) then

				GameTooltip:AddDoubleLine(string.format(L.DROP_NUM, drop), string.format(L.LOOT_NUM, lootsThis).." / "..BH.FormatPercent(thisChance).."%", 1,1,1,1,1,1);
			else
				GameTooltip:AddDoubleLine(string.format(L.DROP_NUM, drop), string.format(L.LOOT_NUM, lootsThis).." / "..BH.FormatTime(timeThis, "?").." / "..BH.FormatPercent(thisChance).."%", 1,1,1,1,1,1);
			end

			drop = drop + 1;
		end
	end

	--GameTooltip:AddLine(itemData.itemTexture);

end


function BH.UpdateSession()

	--print(":: Updating session");

	if (BH.inSession) then

		BH.sessionLast = GetTime();
		BH.sessionEnds = BH.sessionLast + BH.sessionLength;
	else
		BH.StartSession();
	end
end

function BH.EndSession()

	if (BH.inSession) then

		local len = BH.sessionLast - BH.sessionStarted;
		local itemId = _G.BunnyHunterDB.opts.curItem;

		--print(":: Ending session ("..len..")");

		_G.BunnyHunterDB.times[itemId] = (_G.BunnyHunterDB.times[itemId] or 0) + len;
	end

	BH.inSession = false;
end

function BH.StartSession()

	--print(":: Starting session");

	BH.inSession = true;
	BH.sessionStarted = GetTime();
	BH.sessionLast = BH.sessionStarted;
	BH.sessionEnds = BH.sessionLast + BH.sessionLength;

	-- assume we started at least 1 second ago.
	-- killing a single mob will add 1 second to the total time.
	BH.sessionStarted = BH.sessionStarted - 1;
end

function BH.OnUpdate()

	if (BH.inSession and GetTime() > BH.sessionEnds) then

		BH.EndSession();
	end
end

function BH.SlashCommand(msg, editbox)
	if (msg == 'show') then
		BH.Show();
	elseif (msg == 'hide') then
		BH.Hide();
	elseif (msg == 'toggle') then
		BH.Toggle();
	elseif (msg == 'reset') then
		BH.ResetPos();
	else
		print(L.CMD_HELP);
		print("   /bh show - "..L.CMD_HELP_SHOW);
		print("   /bh hide - "..L.CMD_HELP_HIDE);
		print("   /bh toggle - "..L.CMD_HELP_TOGGLE);
		print("   /bh reset - "..L.CMD_HELP_RESET);
	end
end

function BH.GetMode()

	local diff = GetInstanceDifficulty();
	local isIn, type = IsInInstance();

	if (not isIn) then
		return "-";
	end

	if (type == 'party' and diff == 1) then return "5N"; end
	if (type == 'party' and diff == 2) then return "5H"; end
	if (type == 'raid' and diff == 1) then return "10N"; end
	if (type == 'raid' and diff == 2) then return "25N"; end
	if (type == 'raid' and diff == 3) then return "10H"; end
	if (type == 'raid' and diff == 4) then return "25H"; end

	return "-";
end


-- ##################################################################

function ldb_feed:OnTooltipShow()
	BH.FillTooltip(self)
	self:AddLine(" ");
	self:AddLine(L.TIP_CLICK)
	self:AddLine(L.TIP_SCLICK)
	self:AddLine(L.TIP_RCLICK)
	self:AddLine();
end

function ldb_feed:OnClick(aButton)
	if (aButton == "LeftButton") then
		if (IsShiftKeyDown()) then
			BH.ShowOptions();
		else
			BH.Toggle();
		end
	else
		BH.ShowMenu();
	end
end

-- ##################################################################


SLASH_BUNNYHUNTER1 = '/bunnyhunter';
SLASH_BUNNYHUNTER2 = '/bunny';
SLASH_BUNNYHUNTER3 = '/bh';

SlashCmdList["BUNNYHUNTER"] = BH.SlashCommand;


BH.Frame = CreateFrame("Frame")
BH.Frame:Show()
BH.Frame:SetScript("OnEvent", BH.OnEvent)
BH.Frame:SetScript("OnUpdate", BH.OnUpdate)
BH.Frame:RegisterEvent("ADDON_LOADED")
BH.Frame:RegisterEvent("PLAYER_TARGET_CHANGED")
BH.Frame:RegisterEvent("LOOT_OPENED")
BH.Frame:RegisterEvent("LOOT_CLOSED")
BH.Frame:RegisterEvent("PLAYER_LOGOUT")

BH.OnLoad()
