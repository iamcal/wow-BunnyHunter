BH = {}

-- ##################################################################
--
-- START OF THE MOBS
--


BH.dropConfig = {

	{
		name	= "Parrots",
	},

	{
		id	= "8494",
		name	= "Hyacinth Macaw",
		rate	= 1/10000,
		icon	= [[Interface\Icons\spell_nature_forceofnature]],
		mobs	= {
			'"Pretty Boy" Duncan',
			"Bloodsail Raider",
			"Bloodsail Mage",
			"Bloodsail Deckhand",
			"Bloodsail Warlock",
			"Bloodsail Swashbuckler",
			"Bloodsail Swabby",
			"Bloodsail Sea Dog",
			"Bloodsail Elder Magus",			
		}
	},

	{
		id	= "8492",
		name	= "Green Wing Macaw",
		rate	= 1/1000,
		icon	= [[Interface\Icons\spell_nature_forceofnature]],
		mobs	= {
			"Defias Pirate",
		},
	},


	{
		name	= "Hatchlings",
	},

	{
		id	= "48114",
		name	= "Deviate Hatchling",
		rate	= 1/100,
		icon	= [[Interface\Icons\ability_hunter_pet_raptor]],
		mobs	= {
			"Deviate Guardian",
			"Deviate Ravager",
		},
	},

	{
		id	= "48116",
		name	= "Gundrak Hatchling",
		rate	= 1/1000,
		icon	= [[Interface\Icons\ability_mount_raptor]],
		mobs	= {
			"Gundrak Raptor",
		},
	},

	{
		id	= "48126",
		name	= "Razzashi Hatchling",
		rate	= 1/1000,
		icon	= [[Interface\Icons\ability_hunter_pet_raptor]],
		mobs	= {
			"Razzashi Raptor",
		},
	},



	{
		name	= "Whelplings",
	},

	{
		id	= "34535",
		name	= "Azure Whelpling",
		rate	= 1/1000,
		icon	= [[Interface\Icons\inv_misc_head_dragon_blue]],
		mobs	= {
			"Draconic Magelord",
			"Blue Scalebane",
			"Draconic Mageweaver",
			"Blue Dragonspawn",
		},
	},

	{
		id	= "8499",
		name	= "Tiny Crimson Whelpling",
		rate	= 1/1000,
		icon	= [[Interface\Icons\inv_misc_head_dragon_01]],
		mobs	= {
			"Red Whelp",
			"Flamesnorting Whelp",
			"Crimson Whelp",
		},
	},

	{
		id	= "10822",
		name	= "Dark Whelpling",
		rate	= 1/1000,
		icon	= [[Interface\Icons\inv_misc_head_dragon_black]],
		mobs	= {
			"Searing Whelp",
			"Scalding Whelp",
		},
	},

	{
		id	= "8498",
		name	= "Tiny Emerald Whelpling",
		rate	= 1/1000,
		icon	= [[Interface\Icons\inv_misc_head_dragon_green]],
		mobs	= {
			"Dreaming Whelp",
			"Adolescent Whelp",
		},
	},


	{
		name	= "Misc",
	},

	{
		id	= "29960",
		name	= "Captured Firefly",
		rate	= 1/1000,
		icon	= [[Interface\Icons\inv_box_birdcage_01]],
		mobs	= {
			"Bogflare Needler",
		},
	},

	{
		id	= "8491",
		name	= "Black Tabby Cat",
		rate	= 1/1000,
		icon	= [[Interface\Icons\inv_box_petcarrier_01]],
		mobs	= {
			"Dalaran Summoner",
			"Dalaran Theurgist",
			"Dalaran Shield Guard",
		},
	},

	{
		id	= "35504",
		name	= "Phoenix Hatchling",
		icon	= [[Interface\Icons\INV_Misc_PheonixPet_01]],
		rate	= 1/10,
		mobs	= {
			"Kael'thas Sunstrider",
		},
	},

	{
		id	= "11474",
		name	= "Sprite Darter Egg",
		icon	= [[Interface\Icons\inv_egg_02]],
		rate	= 1/200,
		mobs	= {
			"Sprite Darter",
		},
	},

	{
		id	= "5465",
		name	= "Small Spider Leg",
		icon	= [[Interface\Icons\INV_Misc_monsterspidercarapace_01]],
		rate	= 1/10,
		mobs	= {
			"Forest Spider",
			"Mangy Wolf",
		},
		hidden	= true,
	}

};


-- Disgusting Oozeling (20769) (SPECIAL!)
-- Sprite Darter Hatchling (horde only)

--
-- END OF THE MOBS
--
-- ##################################################################


function BH.OnLoad()

	--print("BH.OnLoad()");

	BH.lootOpen = false;

	BH.seenGuids = {};	-- a list of GUIDs already looted
	BH.nameList = {};	-- name -> itemId map
	BH.itemData = {};	-- itemId -> dropData map

	BH.inSession = false;
	BH.sessionStarted = 0;
	BH.sessionLast = 0;
	BH.sessionEnds = 0;

	BH.sessionLength = 60 * 5; -- 5m
	--BH.sessionLength = 20;

	for _, dropData in pairs(BH.dropConfig) do

		if (dropData.id and not dropData.hidden) then

			BH.itemData[dropData.id] = dropData;

			for _, name in pairs(dropData.mobs) do

				BH.nameList[name] = dropData.id;
			end
		end
	end
end

function BH.OnReady()

	--print("BH.OnReady()");

	_G.BunnyHunterDB = _G.BunnyHunterDB or {};
	_G.BunnyHunterDB.kills = _G.BunnyHunterDB.kills or {};
	_G.BunnyHunterDB.loots = _G.BunnyHunterDB.loots or {};
	_G.BunnyHunterDB.opts = _G.BunnyHunterDB.opts or {};
	_G.BunnyHunterDB.times = _G.BunnyHunterDB.times or {};

	_G.BunnyHunterDB.opts.curItem = _G.BunnyHunterDB.opts.curItem or "8494";

	-- pick a choice that's enabled pls :)
	if (not BH.itemData[_G.BunnyHunterDB.opts.curItem]) then

		_G.BunnyHunterDB.opts.curItem = "8494";
	end

	-- convert the stored loots data from single numbers to tables
	for itemId, loots in pairs(_G.BunnyHunterDB.loots) do
		for uid, lootData in pairs(loots) do

			if (not (type(lootData) == "table")) then

				local newLoot = {
					loots = lootData,
					time = 0,
				};

				_G.BunnyHunterDB.loots[itemId][uid] = newLoot;
			end
		end
	end


	--BH.DumpStatus();

	BH.StartFrame();
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

function BH.DoWeCare(test_name)

	if (BH.nameList[test_name]) then

		_G.BunnyHunterDB.kills[test_name] = (_G.BunnyHunterDB.kills[test_name] or 0) + 1;

		local itemId = BH.nameList[test_name]

		if (_G.BunnyHunterDB.opts.curItem == itemId) then

			--print("Item "..itemId.." is already selected")

			BH.UpdateSession();
		else
			--print("Item "..itemId.." is NOW selected")

			BH.EndSession();
			BH.StartSession();

			_G.BunnyHunterDB.opts.curItem = itemId;
		end

		return true;
	end

	return false;
end

function BH.FoundLoot(itemId)

	local itemData = BH.ItemData(itemId);

	print("Yay! You found a "..itemData.itemLink.."!");

	if (not _G.BunnyHunterDB.loots[itemId]) then
		_G.BunnyHunterDB.loots[itemId] = {};
	end

	table.insert(_G.BunnyHunterDB.loots[itemId], {
		loots = BH.GetTotalKills(itemId),
		time = _G.BunnyHunterDB.times[itemId],
	});

	BH.UpdateFrame();
end

function BH.GetTotalKills(itemId)

	local totalKills = 0;
	if (BH.itemData[itemId].mobs) then
		for _, name in pairs(BH.itemData[itemId].mobs) do

			totalKills = totalKills + (_G.BunnyHunterDB.kills[name] or 0);
		end
	end

	return totalKills;
end

function BH.GetTotalKillsSince(itemId)

	local totalKills = BH.GetTotalKills(itemId);
	local latestKill = 0;

	-- find the last time we found the thing we're looking for...
	if (_G.BunnyHunterDB.loots[itemId]) then
		for _, lootData in pairs(_G.BunnyHunterDB.loots[itemId]) do
			if (lootData.loots > latestKill) then
				latestKill = lootData.loots
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
		for _, lootData in pairs(_G.BunnyHunterDB.loots[itemId]) do
			if (lootData.time > latestTime) then
				latestTime = lootData.time
			end
		end
	end

	return totalTime - latestTime;
end

function BH.GetKillsLatest(itemId)

	local lootsThis = 0;
	local lastLoot = 0;

	if (_G.BunnyHunterDB.loots[itemId]) then
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

		if (not BH.DoWeCare(name)) then
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

function BH.Toggle()

	if (_G.BunnyHunterDB.opts.hide) then

		_G.BunnyHunterDB.opts.hide = false;
		BH.UIFrame:Show();
		print("Bunny Hunter: Visible");
	else
		_G.BunnyHunterDB.opts.hide = true;
		BH.UIFrame:Hide();
		print("Bunny Hunter: Hidden");
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

	local dropChance = BH.itemData[itemId].rate;
	local totalChance = 100 * (1 - math.pow(1 - dropChance, kills));

	if (kills == 0 and killsTotal > 0) then

		kills = BH.GetKillsLatest(itemId);

		BH.ProgressBar:SetValue(100)
		BH.ProgressBar:SetStatusBarColor(1, 0.4, 0.4)
		BH.Label:SetText("Found after "..kills.." loots!");

	else
		BH.ProgressBar:SetValue(totalChance)
		BH.ProgressBar:SetStatusBarColor(0, 1, 0)
		BH.Label:SetText(""..kills.." loots - "..BH.FormatPercent(totalChance).."%");
	end

	BH.Button:SetNormalTexture(itemData.itemTexture or BH.itemData[itemId].icon or [[Interface\Icons\INV_Misc_QuestionMark]]);
end


function BH.ShowMenu()

	local menu_frame = CreateFrame("Frame", "menuFrame", UIParent, "UIDropDownMenuTemplate")

	local menuList = {};
	local first = true;

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


	local itemId = _G.BunnyHunterDB.opts.curItem;
	local itemData = BH.ItemData(itemId);

	local totalKills = BH.GetTotalKills(itemId);
	local totalKillsSince = BH.GetTotalKillsSince(itemId);

	local totalTime = BH.GetTotalTime(itemId);
	local totalTimeSince = BH.GetTotalTimeSince(itemId);

	local dropChance = BH.itemData[itemId].rate;
	local invChance = 1 / dropChance
	local totalChance = 100 * (1 - math.pow(1 - dropChance, totalKillsSince));

	GameTooltip:SetText(BH.GetItemColoredName(itemId))
	if (not itemData.itemName) then
		GameTooltip:AddLine("(Never Seen)", 1, 0.4, 0.4)
	end

	GameTooltip:AddLine(" ")
	GameTooltip:AddDoubleLine("Loots since last drop:", totalKillsSince, 1,1,1,1,1,1)

	if (BH.inSession) then
		GameTooltip:AddDoubleLine("Farm time:", BH.FormatTime(totalTimeSince, "0s"), 1,1,1,1,0.4,0.4)
	else
		GameTooltip:AddDoubleLine("Farm time:", BH.FormatTime(totalTimeSince, "0s"), 1,1,1,1,1,1)
	end

	GameTooltip:AddDoubleLine("Drop chance:", " 1 in "..invChance, 1,1,1,1,1,1)
	GameTooltip:AddDoubleLine("Chance so far:", BH.FormatPercent(totalChance).."%", 1,1,1,1,1,1)

	GameTooltip:AddLine(" ")
	GameTooltip:AddDoubleLine("Total loots:", totalKills, 1,1,1,1,1,1)

	if (BH.itemData[itemId].mobs) then
		for _, name in pairs(BH.itemData[itemId].mobs) do

			GameTooltip:AddDoubleLine(name..":", (_G.BunnyHunterDB.kills[name] or 0), 1,1,1,1,1,1);
		end
	end

	local lastLoot = 0;
	local lastTime = 0;
	local drop = 1;

	if (_G.BunnyHunterDB.loots[itemId]) then
		for _, lootData in pairs(_G.BunnyHunterDB.loots[itemId]) do

			local timeThis = lootData.time - lastTime;
			lastTime = lootData.time;

			local lootsThis = lootData.loots - lastLoot;
			lastLoot = lootData.loots;

			local thisChance = 100 * (1 - math.pow(1 - dropChance, lootsThis));

			if (drop == 1) then
				GameTooltip:AddLine(" ")
			end

			GameTooltip:AddDoubleLine("Drop "..drop, lootsThis.." loots / "..BH.FormatTime(timeThis, "?").." / "..BH.FormatPercent(thisChance).."%", 1,1,1,1,1,1);

			drop = drop + 1;
		end
	end

	--GameTooltip:AddLine(itemData.itemTexture);

	GameTooltip:ClearAllPoints()
	GameTooltip:SetPoint("TOPLEFT", BH.ProgressBar, "BOTTOMLEFT"); 

	GameTooltip:Show()
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


SLASH_BUNNYHUNTER1 = '/bunnyhunter';
SLASH_BUNNYHUNTER2 = '/bunny';
SLASH_BUNNYHUNTER3 = '/bh';

function SlashCmdList.BUNNYHUNTER(msg, editbox)
	BH.Toggle()
end


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
