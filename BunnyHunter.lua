BH = {}
BH.trackDrops = {};
BH.trackKills = {};
BH.dropChances = {};

BH.seenGuids = {};
BH.nameList = {};	-- a list of mob names we care about (for speed!)
BH.lootOpen = false;

-- ##################################################################
--
-- START OF THE MOBS
--

-- Hyacinth Macaw
table.insert(BH.trackDrops, "8494");
BH.dropChances["8494"] = 1/10000;
BH.trackKills["8494"] = {
	'"Pretty Boy" Duncan',
	"Bloodsail Raider",
	"Bloodsail Mage",
	"Bloodsail Deckhand",
	"Bloodsail Warlock",
	"Bloodsail Swashbuckler",
	"Bloodsail Swabby",
	"Bloodsail Sea Dog",
	"Bloodsail Elder Magus",
};

-- Deviate Hatchling
table.insert(BH.trackDrops, "48114");
BH.dropChances["48114"] = 1/100;
BH.trackKills["48114"] = {
	"Deviate Guardian",
	"Deviate Ravager",
};

-- Gundrak Hatchling
table.insert(BH.trackDrops, "48116");
BH.dropChances["48116"] = 1/1000;
BH.trackKills["48116"] = {
	"Gundrak Raptor",
};

-- Razzashi Hatchling
table.insert(BH.trackDrops, "48126");
BH.dropChances["48126"] = 1/1000;
BH.trackKills["48126"] = {
	"Razzashi Raptor",
};

-- Captured Firefly (29960)
table.insert(BH.trackDrops, "29960");
BH.dropChances["29960"] = 1/1000;
BH.trackKills["29960"] = {
	"Captured Firefly",
};

-- Azure Whelpling (34535)
table.insert(BH.trackDrops, "34535");
BH.dropChances["34535"] = 1/1000;
BH.trackKills["34535"] = {
	"Draconic Magelord",
	"Blue Scalebane",
	"Draconic Mageweaver",
	"Blue Dragonspawn",
};

-- Tiny Crimson Whelpling (8499)
table.insert(BH.trackDrops, "8499");
BH.dropChances["8499"] = 1/1000;
BH.trackKills["8499"] = {
	"Red Whelp",
	"Flamesnorting Whelp",
	"Crimson Whelp",
};

-- Dark Whelpling (10822)
table.insert(BH.trackDrops, "10822");
BH.dropChances["10822"] = 1/1000;
BH.trackKills["10822"] = {
	"Searing Whelp",
	"Scalding Whelp",
};

-- Tiny Emerald Whelpling (8498)
table.insert(BH.trackDrops, "8498");
BH.dropChances["8498"] = 1/1000;
BH.trackKills["8498"] = {
	"Dreaming Whelp",
	"Adolescent Whelp",
};

-- Black Tabby Cat (8491)
table.insert(BH.trackDrops, "8491");
BH.dropChances["8491"] = 1/1000;
BH.trackKills["8491"] = {
	"Dalaran Summoner",
	"Dalaran Theurgist",
	"Dalaran Shield Guard",
};

-- Green Wing Macaw (8492)
table.insert(BH.trackDrops, "8492");
BH.dropChances["8492"] = 1/1000;
BH.trackKills["8492"] = {
	"Defias Pirate",
};

-- Phoenix Hatchling (35504)
table.insert(BH.trackDrops, "35504");
BH.dropChances["35504"] = 1/10;
BH.trackKills["35504"] = {
	"Kael'thas Sunstrider",
};

-- Disgusting Oozeling (20769) (SPECIAL!)
-- Sprite Darter Hatchling (horde only)


if (false) then
table.insert(BH.trackDrops, "5465");
BH.dropChances["5465"] = 1/10;
BH.trackKills["5465"] = {
	"Forest Spider",
	"Mangy Wolf",
};
end

--
-- END OF THE MOBS
--
-- ##################################################################


function BH.OnLoad()

	--print("BH.OnLoad()");

	for item, names in pairs(BH.trackKills) do

		for _, name in pairs(names) do

			BH.nameList[name] = item;
		end
	end
end

function BH.OnReady()

	--print("BH.OnReady()");

	_G.BunnyHunterDB = _G.BunnyHunterDB or {};
	_G.BunnyHunterDB.kills = _G.BunnyHunterDB.kills or {};
	_G.BunnyHunterDB.loots = _G.BunnyHunterDB.loots or {};
	_G.BunnyHunterDB.opts = _G.BunnyHunterDB.opts or {};

	_G.BunnyHunterDB.opts.curItem = _G.BunnyHunterDB.opts.curItem or "8494";

	--BH.DumpStatus();

	BH.StartFrame();
end

function BH.OnSaving()
	
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
		else
			--print("Item "..itemId.." is NOW selected")

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

	table.insert(_G.BunnyHunterDB.loots[itemId], BH.GetTotalKills(itemId));

	BH.UpdateFrame();
end

function BH.GetTotalKills(itemId)

	local totalKills = 0;
	if (BH.trackKills[itemId]) then
		for _, name in pairs(BH.trackKills[itemId]) do

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
		for _, num in pairs(_G.BunnyHunterDB.loots[itemId]) do
			if (num > latestKill) then
				latestKill = num
			end
		end
	end

	return totalKills - latestKill;
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

	return "|cffffff00Unseen Item "..itemId
end

function BH.DumpStatus()

	for itemId, names in pairs(BH.trackKills) do

		itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice = GetItemInfo(itemId);

		print("Info for item "..itemId.." / "..itemName);

		local totalKills = BH.GetTotalKills(itemId);

		print("---Total kills for all mobs: "..totalKills);

		if (_G.BunnyHunterDB.loots[itemId]) then
			for _, num in pairs(_G.BunnyHunterDB.loots[itemId]) do

				print("--found at "..num.." kills");
			end
		end

	end

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

				if (BH.trackKills[itemId]) then

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
	BH.Label:SetPoint("LEFT", BH.ProgressBar, "LEFT", 2, 0)
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

	local dropChance = BH.dropChances[itemId];
	local totalChance = 100 * (1 - math.pow(1 - dropChance, kills));

	BH.ProgressBar:SetValue(totalChance)
	BH.Label:SetText(""..kills.." loots - "..BH.FormatPercent(totalChance).."%");

	BH.Button:SetNormalTexture(itemData.itemTexture or [[Interface\Icons\INV_Misc_QuestionMark]]);
end


function BH.ShowMenu()

	local menu_frame = CreateFrame("Frame", "menuFrame", UIParent, "UIDropDownMenuTemplate")

	local menuList = {};

	for _, itemId in pairs(BH.trackDrops) do

		table.insert(menuList, { text = BH.GetItemColoredName(itemId), func = function() BH.SetItem(itemId) end; });
	end

	EasyMenu(menuList, menu_frame, BH.Button, 0 , 0, "MENU")
end

function BH.SetItem(itemId)

	_G.BunnyHunterDB.opts.curItem = itemId;
	BH.UpdateFrame();
end

function BH.ShowTooltip()

	GameTooltip:SetOwner(BH.ProgressBar, "ANCHOR_BOTTOM");


	local itemId = _G.BunnyHunterDB.opts.curItem;
	local itemData = BH.ItemData(itemId);
	local totalKills = BH.GetTotalKills(itemId);
	local totalKillsSince = BH.GetTotalKillsSince(itemId);

	local dropChance = BH.dropChances[itemId];
	local invChance = 1 / dropChance
	local totalChance = 100 * (1 - math.pow(1 - dropChance, totalKillsSince));

	GameTooltip:SetText(BH.GetItemColoredName(itemId))

	GameTooltip:AddLine(" ")
	GameTooltip:AddDoubleLine("Loots since last drop:", totalKillsSince, 1,1,1,1,1,1)
	GameTooltip:AddDoubleLine("Drop chance:", " 1 in "..invChance, 1,1,1,1,1,1)
	GameTooltip:AddDoubleLine("Chance so far:", BH.FormatPercent(totalChance).."%", 1,1,1,1,1,1)
	GameTooltip:AddLine(" ")
	GameTooltip:AddDoubleLine("Total loots:", totalKills, 1,1,1,1,1,1)

	if (BH.trackKills[itemId]) then
		for _, name in pairs(BH.trackKills[itemId]) do

			GameTooltip:AddDoubleLine(name..":", (_G.BunnyHunterDB.kills[name] or 0), 1,1,1,1,1,1);
		end
	end

	local lastLoot = 0;
	local drop = 1;

	if (_G.BunnyHunterDB.loots[itemId]) then
		for _, loots in pairs(_G.BunnyHunterDB.loots[itemId]) do

			local lootsThis = loots - lastLoot;
			lastLoot = loots;
			local thisChance = 100 * (1 - math.pow(1 - dropChance, lootsThis));

			if (drop == 1) then
				GameTooltip:AddLine(" ")
			end

			GameTooltip:AddDoubleLine("Drop "..drop, lootsThis.." loots / "..BH.FormatPercent(thisChance).."%", 1,1,1,1,1,1);

			drop = drop + 1;
		end
	end

	--GameTooltip:AddLine(itemData.itemTexture);

	GameTooltip:ClearAllPoints()
	GameTooltip:SetPoint("TOPLEFT", BH.ProgressBar, "BOTTOMLEFT"); 

	GameTooltip:Show()
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
BH.Frame:RegisterEvent("ADDON_LOADED")
BH.Frame:RegisterEvent("PLAYER_TARGET_CHANGED")
BH.Frame:RegisterEvent("LOOT_OPENED")
BH.Frame:RegisterEvent("LOOT_CLOSED")
BH.Frame:RegisterEvent("PLAYER_LOGOUT")

BH.OnLoad()
