Parrot = {}
Parrot.trackDrops = {};
Parrot.trackKills = {};
Parrot.dropChances = {};

Parrot.seenGuids = {};
Parrot.nameList = {};	-- a list of mob names we care about (for speed!)
Parrot.lootOpen = false;

-- ##################################################################
--
-- START OF THE MOBS
--

-- Hyacinth Macaw
table.insert(Parrot.trackDrops, "8494");
Parrot.dropChances["8494"] = 1/10000;
Parrot.trackKills["8494"] = {
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
table.insert(Parrot.trackDrops, "48114");
Parrot.dropChances["48114"] = 1/100;
Parrot.trackKills["48114"] = {
	"Deviate Guardian",
	"Deviate Ravager",
};

-- Gundrak Hatchling
table.insert(Parrot.trackDrops, "48116");
Parrot.dropChances["48116"] = 1/1000;
Parrot.trackKills["48116"] = {
	"Gundrak Raptor",
};

-- Razzashi Hatchling
table.insert(Parrot.trackDrops, "48126");
Parrot.dropChances["48126"] = 1/1000;
Parrot.trackKills["48126"] = {
	"Razzashi Raptor",
};

-- Captured Firefly (29960)
table.insert(Parrot.trackDrops, "29960");
Parrot.dropChances["29960"] = 1/1000;
Parrot.trackKills["29960"] = {
	"Captured Firefly",
};

-- Azure Whelpling (34535)
table.insert(Parrot.trackDrops, "34535");
Parrot.dropChances["34535"] = 1/1000;
Parrot.trackKills["34535"] = {
	"Draconic Magelord",
	"Blue Scalebane",
	"Draconic Mageweaver",
	"Blue Dragonspawn",
};

-- Tiny Crimson Whelpling (8499)
table.insert(Parrot.trackDrops, "8499");
Parrot.dropChances["8499"] = 1/1000;
Parrot.trackKills["8499"] = {
	"Red Whelp",
	"Flamesnorting Whelp",
	"Crimson Whelp",
};

-- Dark Whelpling (10822)
table.insert(Parrot.trackDrops, "10822");
Parrot.dropChances["10822"] = 1/1000;
Parrot.trackKills["10822"] = {
	"Searing Whelp",
	"Scalding Whelp",
};

-- Tiny Emerald Whelpling (8498)
table.insert(Parrot.trackDrops, "8498");
Parrot.dropChances["8498"] = 1/1000;
Parrot.trackKills["8498"] = {
	"Dreaming Whelp",
	"Adolescent Whelp",
};

-- Black Tabby Cat (8491)
table.insert(Parrot.trackDrops, "8491");
Parrot.dropChances["8491"] = 1/1000;
Parrot.trackKills["8491"] = {
	"Dalaran Summoner",
	"Dalaran Theurgist",
	"Dalaran Shield Guard",
};

-- Green Wing Macaw (8492)
table.insert(Parrot.trackDrops, "8492");
Parrot.dropChances["8492"] = 1/1000;
Parrot.trackKills["8492"] = {
	"Defias Pirate",
};

-- Phoenix Hatchling (35504)
table.insert(Parrot.trackDrops, "35504");
Parrot.dropChances["35504"] = 1/10;
Parrot.trackKills["35504"] = {
	"Kael'thas Sunstrider",
};

-- Disgusting Oozeling (20769) (SPECIAL!)
-- Sprite Darter Hatchling (horde only)


if (false) then
Parrot.dropChances["5465"] = 1/10;
Parrot.trackKills["5465"] = {
	"Forest Spider",
	"Mangy Wolf",
};
end

--
-- END OF THE MOBS
--
-- ##################################################################


function Parrot.OnLoad()

	--print("Parrot.OnLoad()");

	for item, names in pairs(Parrot.trackKills) do

		for _, name in pairs(names) do

			Parrot.nameList[name] = item;
		end
	end
end

function Parrot.OnReady()

	--print("Parrot.OnReady()");

	_G.parrotDB = _G.parrotDB or {};
	_G.parrotDB.kills = _G.parrotDB.kills or {};
	_G.parrotDB.loots = _G.parrotDB.loots or {};
	_G.parrotDB.opts = _G.parrotDB.opts or {};

	_G.parrotDB.opts.curItem = _G.parrotDB.opts.curItem or "8494";

	--Parrot.DumpStatus();

	Parrot.StartFrame();
end

function Parrot.OnSaving()
	
	local point, relativeTo, relativePoint, xOfs, yOfs = Parrot.UIFrame:GetPoint()
	_G.parrotDB.opts.frameRef = relativePoint;
	_G.parrotDB.opts.frameX = xOfs;
	_G.parrotDB.opts.frameY = yOfs;
	_G.parrotDB.opts.frameW = Parrot.UIFrame:GetWidth();
	_G.parrotDB.opts.frameH = Parrot.UIFrame:GetHeight();
end

function Parrot.SeenGuid(guid)

	if (Parrot.seenGuids[guid]) then
		return true;
	end

	Parrot.seenGuids[guid] = 1;
end

function Parrot.DoWeCare(test_name)

	if (Parrot.nameList[test_name]) then

		_G.parrotDB.kills[test_name] = (_G.parrotDB.kills[test_name] or 0) + 1;

		local itemId = Parrot.nameList[test_name]

		if (_G.parrotDB.opts.curItem == itemId) then

			--print("Item "..itemId.." is already selected")
		else
			--print("Item "..itemId.." is NOW selected")

			_G.parrotDB.opts.curItem = itemId;
		end

		return true;
	end

	return false;
end

function Parrot.FoundLoot(itemId)

	local itemData = Parrot.ItemData(itemId);

	print("Yay! You found a "..itemData.itemLink.."!");

	if (not _G.parrotDB.loots[itemId]) then
		_G.parrotDB.loots[itemId] = {};
	end

	table.insert(_G.parrotDB.loots[itemId], Parrot.GetTotalKills(itemId));

	Parrot.UpdateFrame();
end

function Parrot.GetTotalKills(itemId)

	local totalKills = 0;
	if (Parrot.trackKills[itemId]) then
		for _, name in pairs(Parrot.trackKills[itemId]) do

			totalKills = totalKills + (_G.parrotDB.kills[name] or 0);
		end
	end

	return totalKills;
end

function Parrot.GetTotalKillsSince(itemId)

	local totalKills = Parrot.GetTotalKills(itemId);
	local latestKill = 0;

	-- find the last time we found the thing we're looking for...
	if (_G.parrotDB.loots[itemId]) then
		for _, num in pairs(_G.parrotDB.loots[itemId]) do
			if (num > latestKill) then
				latestKill = num
			end
		end
	end

	return totalKills - latestKill;
end

function Parrot.ItemData(itemId)

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

function Parrot.GetItemColor(itemLink)

	if (itemLink) then
		local _, color = strsplit("|", itemLink);
		return color;
	end

	return 'cffffff00';
end

function Parrot.GetItemColoredName(itemId)

	local itemData = Parrot.ItemData(itemId);

	if (itemData.itemName) then
		local color = Parrot.GetItemColor(itemData.itemLink)
		return "|"..color..itemData.itemName
	end

	return "|cffffff00Unseen Item "..itemId
end

function Parrot.DumpStatus()

	for itemId, names in pairs(Parrot.trackKills) do

		itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice = GetItemInfo(itemId);

		print("Info for item "..itemId.." / "..itemName);

		local totalKills = Parrot.GetTotalKills(itemId);

		print("---Total kills for all mobs: "..totalKills);

		if (_G.parrotDB.loots[itemId]) then
			for _, num in pairs(_G.parrotDB.loots[itemId]) do

				print("--found at "..num.." kills");
			end
		end

	end

end

function Parrot.OnEvent(frame, event, ...)

	if (event == 'ADDON_LOADED') then
		local name = ...;
		if name == 'Parrot' then
			Parrot.OnReady();
		end
	end

	if (event == 'PLAYER_LOGOUT') then

		Parrot.OnSaving();
	end

	if (event == 'PLAYER_TARGET_CHANGED') then

	end

	if (event == 'LOOT_OPENED') then

		Parrot.OnLoot();
		Parrot.lootOpen = true;
	end

	if (event == 'LOOT_CLOSED') then

		if (not Parrot.lootOpen) then

			--print "no loot on this target!";
			Parrot.OnLoot();
		end

		Parrot.lootOpen = false;
	end
end

function Parrot.OnLoot()

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

		if (Parrot.SeenGuid(guid)) then
			--print("We've seen this guid already");
			return;
		end

		if (not Parrot.DoWeCare(name)) then
			--print("We don't care about kills of this unit type");
			return;
		end

		--print("ok! process this baby");

		local numItems = GetNumLootItems()

		for slotID = 1, numItems, 1 do
			local itemLink = GetLootSlotLink(slotID);
			local _, itemId = strsplit(":", itemLink);

			--print("found item id "..itemId);

			if (Parrot.trackKills[itemId]) then

				--print("we care about that!!");
				Parrot.FoundLoot(itemId);
			end
		end

		Parrot.UpdateFrame();
end

function Parrot.OnDragStart(frame)
	Parrot.UIFrame:StartMoving();
	Parrot.UIFrame.isMoving = true;
	GameTooltip:Hide()
end

function Parrot.OnDragStop(frame)
	Parrot.UIFrame:StopMovingOrSizing();
	Parrot.UIFrame.isMoving = false;
end

function Parrot.StartFrame()

	Parrot.UIFrame = CreateFrame("Frame",nil,UIParent);
	Parrot.UIFrame:SetFrameStrata("BACKGROUND")
	Parrot.UIFrame:SetWidth(150)
	Parrot.UIFrame:SetHeight(32)

	Parrot.UIFrame.texture = Parrot.UIFrame:CreateTexture()
	Parrot.UIFrame.texture:SetAllPoints(Parrot.UIFrame)
	Parrot.UIFrame.texture:SetTexture(0, 0, 0)
	

	-- position the parent frame
	local frameRef = "CENTER";
	local frameX = 0;
	local frameY = 0;
	if (_G.parrotDB.opts.frameRef) then
		frameRef = _G.parrotDB.opts.frameRef;
		frameX = _G.parrotDB.opts.frameX;
		frameY = _G.parrotDB.opts.frameY;

		Parrot.UIFrame:SetWidth(_G.parrotDB.opts.frameW);
	end
	Parrot.UIFrame:SetPoint(frameRef, frameX, frameY);

	-- make it draggable
	Parrot.UIFrame:SetMovable(true);
	Parrot.UIFrame:EnableMouse(true);

	-- make it resizable
	Parrot.UIFrame:SetMaxResize(400, 32)
	Parrot.UIFrame:SetMinResize(150, 32)
	Parrot.UIFrame:SetResizable(true)
	makeSizable(Parrot.UIFrame)

	-- create the button
	local d2 = Parrot.ItemData(_G.parrotDB.opts.curItem);
	Parrot.Button = CreateFrame("Button", nil, Parrot.UIFrame)
	Parrot.Button:SetPoint("TOPLEFT", 1, -1)
	Parrot.Button:SetWidth(30)
	Parrot.Button:SetHeight(30)
	Parrot.Button:SetNormalTexture(d2.itemTexture);
	Parrot.Button:SetScript("OnClick", Parrot.ShowMenu)

	-- create the progress bar
	Parrot.ProgressBar = CreateFrame("StatusBar", nil, Parrot.UIFrame)
	Parrot.ProgressBar:SetPoint("TOPLEFT", 33, -1)
	Parrot.ProgressBar:SetPoint("BOTTOMRIGHT", -1, 1)
	Parrot.ProgressBar:SetMinMaxValues(0, 100)
	Parrot.ProgressBar:SetValue(100)
	Parrot.ProgressBar:SetOrientation("HORIZONTAL")
	Parrot.ProgressBar:SetStatusBarTexture([[Interface\Addons\Recount\Textures\statusbar\BantoBar]], "ARTWORK")
	Parrot.ProgressBar:SetStatusBarColor(0, 1, 0)

	Parrot.ProgressBar:EnableMouse(true); 
	Parrot.ProgressBar:SetHitRectInsets(0, 0, 0, 0)
	Parrot.ProgressBar:SetScript("OnEnter", Parrot.ShowTooltip);
	Parrot.ProgressBar:SetScript("OnLeave", function() GameTooltip:Hide() end);
	Parrot.ProgressBar:SetScript("OnDragStart", Parrot.OnDragStart);
	Parrot.ProgressBar:SetScript("OnDragStop", Parrot.OnDragStop);
	Parrot.ProgressBar:RegisterForDrag("LeftButton");


	-- some text to go over it
	Parrot.Label = Parrot.ProgressBar:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
	Parrot.Label:SetPoint("LEFT", Parrot.ProgressBar, "LEFT", 2, 0)
	Parrot.Label:SetJustifyH("LEFT")
	Parrot.Label:SetText("Test Text")
	Parrot.Label:SetTextColor(1,1,1,1)
	Parrot.SetFontSize(Parrot.Label, 10)


	Parrot.UpdateFrame();

	if (_G.parrotDB.opts.hide) then
		Parrot.UIFrame:Hide();
	else
		Parrot.UIFrame:Show();
	end
end

function Parrot.Toggle()

	if (_G.parrotDB.opts.hide) then

		_G.parrotDB.opts.hide = false;
		Parrot.UIFrame:Show();
		print("Now showing Parrot");
	else
		_G.parrotDB.opts.hide = true;
		Parrot.UIFrame:Hide();
		print("Now hiding Parrot");
	end
end

function Parrot.SetFontSize(string, size)

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

function Parrot.UpdateFrame()

	local itemId = _G.parrotDB.opts.curItem;
	local itemData = Parrot.ItemData(itemId);
	local kills = Parrot.GetTotalKillsSince(itemId);

	local dropChance = Parrot.dropChances[itemId];
	local totalChance = 100 * (1 - math.pow(1 - dropChance, kills));

	Parrot.ProgressBar:SetValue(totalChance)
	Parrot.Label:SetText(""..kills.." loots - "..string.format("%.1f", totalChance).."%");

	Parrot.Button:SetNormalTexture(itemData.itemTexture or [[Interface\Icons\INV_Misc_QuestionMark]]);
end


function Parrot.ShowMenu()

	local menu_frame = CreateFrame("Frame", "menuFrame", UIParent, "UIDropDownMenuTemplate")

	local menuList = {};

	for _, itemId in pairs(Parrot.trackDrops) do

		table.insert(menuList, { text = Parrot.GetItemColoredName(itemId), func = function() Parrot.SetItem(itemId) end; });
	end

	EasyMenu(menuList, menu_frame, Parrot.Button, 0 , 0, "MENU")
end

function Parrot.SetItem(itemId)

	_G.parrotDB.opts.curItem = itemId;
	Parrot.UpdateFrame();
end

function Parrot.ShowTooltip()

	GameTooltip:SetOwner(Parrot.ProgressBar, "ANCHOR_BOTTOM");


	local itemId = _G.parrotDB.opts.curItem;
	local itemData = Parrot.ItemData(itemId);
	local totalKills = Parrot.GetTotalKills(itemId);
	local totalKillsSince = Parrot.GetTotalKillsSince(itemId);

	local dropChance = Parrot.dropChances[itemId];
	local invChance = 1 / dropChance
	local totalChance = 100 * (1 - math.pow(1 - dropChance, totalKillsSince));

	GameTooltip:SetText(Parrot.GetItemColoredName(itemId))

	GameTooltip:AddLine(" ")
	GameTooltip:AddDoubleLine("Loots since last drop:", totalKillsSince, 1,1,1,1,1,1)
	GameTooltip:AddDoubleLine("Drop chance:", " 1 in "..invChance, 1,1,1,1,1,1)
	GameTooltip:AddDoubleLine("Chance so far:", string.format("%.1f", totalChance).."%", 1,1,1,1,1,1)
	GameTooltip:AddLine(" ")
	GameTooltip:AddDoubleLine("Total loots:", totalKills, 1,1,1,1,1,1)

	if (Parrot.trackKills[itemId]) then
		for _, name in pairs(Parrot.trackKills[itemId]) do

			GameTooltip:AddDoubleLine(name..":", (_G.parrotDB.kills[name] or 0), 1,1,1,1,1,1);
		end
	end

	local lastLoot = 0;
	local drop = 1;

	if (_G.parrotDB.loots[itemId]) then
		for _, loots in pairs(_G.parrotDB.loots[itemId]) do

			local lootsThis = loots - lastLoot;
			lastLoot = loots;
			local thisChance = 100 * (1 - math.pow(1 - dropChance, lootsThis));

			if (drop == 1) then
				GameTooltip:AddLine(" ")
			end

			GameTooltip:AddDoubleLine("Drop "..drop, lootsThis.." loots / "..string.format("%.1f", thisChance).."%", 1,1,1,1,1,1);

			drop = drop + 1;
		end
	end

	--GameTooltip:AddLine(itemData.itemTexture);

	GameTooltip:ClearAllPoints()
	GameTooltip:SetPoint("TOPLEFT", Parrot.ProgressBar, "BOTTOMLEFT"); 

	GameTooltip:Show()
end


SLASH_PARROT1 = '/parrot';

function SlashCmdList.PARROT(msg, editbox)
	Parrot.Toggle()
end


Parrot.Frame = CreateFrame("Frame")
Parrot.Frame:Show()
Parrot.Frame:SetScript("OnEvent", Parrot.OnEvent)
Parrot.Frame:RegisterEvent("ADDON_LOADED")
Parrot.Frame:RegisterEvent("PLAYER_TARGET_CHANGED")
Parrot.Frame:RegisterEvent("LOOT_OPENED")
Parrot.Frame:RegisterEvent("LOOT_CLOSED")
Parrot.Frame:RegisterEvent("PLAYER_LOGOUT")

Parrot.OnLoad()
