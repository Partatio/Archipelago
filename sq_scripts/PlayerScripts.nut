class PlayerScripts extends SqRootScript
{
	function OnEndAttack()
	{
		things()
	}

	function things()
	{

	}

	function FirstLoad(mapname) #runs on the first time a map is loaded in a save.
	{
		local NewTracker = Object.Create("APLocationTracker");
		local CommandListTable = VariousDataTables.mapinstructions.rawget(mapname);
		foreach(command, data in CommandListTable)
		{
			if (!Property.Get(self, "Modify1").find(data[0]))#check if settings doesn't contain the appropriate setting for the command
				continue;
			switch (command)
				{
				case "placeaploc":
					local NewAPLocation = Object.Create("APLocation");
					Property.Set(NewAPLocation, "VoiceIdx", "", data[2]);
					if (type(data[1]) == type([]))
					{
						local chosencontainer = data[1][rand() % data[1].len()];
						Container.Add(NewAPLocation, chosencontainer);
					}
					else
						Object.Teleport(NewAPLocation, data[1], vector());
					Link.Create("Target", NewTracker, NewAPLocation); #Link to object, EveryLoad send a message called CollectedItemsUpdate to whatever the tracker is linked to with the data being the sent items string
					if (data[3])
						Object.Destroy(data[3]);
					continue;
				case "replaceCybModShop":
					foreach (Terminal in data[1])
						Object.Destroy(Terminal);
					local CybModShop = Object.Create("CybModShop");
					Object.Teleport(CybModShop, data[2], vector(0, 0, 0));
					continue;
				case "destroy":
					Object.Destroy(data[1]);
					continue;
				case "slayvictoryprop": #add script to last script slot on many or shodan that on slay sends a victory location out.  both bosses have scripts in slot 0 and 1.
					Property.Set(data[1], "Scripts", "Script 3", "OnSlayVictory");
					continue;
				case "randomizerepl": #randomize a repl with random items and costs.
					local ReplItem = PickUnhackedReplItem();
					Property.Set(data[1], "RepContents", "Obj 1 Name", ReplItem[0]);
					Property.Set(data[1], "RepContents", "Obj 1 Cost", ReplItem[1]);
					ReplItem = PickUnhackedReplItem();
					Property.Set(data[1], "RepContents", "Obj 2 Name", ReplItem[0]);
					Property.Set(data[1], "RepContents", "Obj 2 Cost", ReplItem[1]);
					ReplItem = PickUnhackedReplItem();
					Property.Set(data[1], "RepContents", "Obj 3 Name", ReplItem[0]);
					Property.Set(data[1], "RepContents", "Obj 3 Cost", ReplItem[1]);
					ReplItem = PickUnhackedReplItem();
					Property.Set(data[1], "RepContents", "Obj 4 Name", ReplItem[0]);
					Property.Set(data[1], "RepContents", "Obj 4 Cost", ReplItem[1]);
					ReplItem = PickhackedReplItem();
					Property.Set(data[1], "RepHacked", "Obj 1 Name", ReplItem[0]);
					Property.Set(data[1], "RepHacked", "Obj 1 Cost", ReplItem[1]);
					ReplItem = PickhackedReplItem();
					Property.Set(data[1], "RepHacked", "Obj 2 Name", ReplItem[0]);
					Property.Set(data[1], "RepHacked", "Obj 2 Cost", ReplItem[1]);
					ReplItem = PickhackedReplItem();
					Property.Set(data[1], "RepHacked", "Obj 3 Name", ReplItem[0]);
					Property.Set(data[1], "RepHacked", "Obj 3 Cost", ReplItem[1]);
					ReplItem = PickhackedReplItem();
					Property.Set(data[1], "RepHacked", "Obj 4 Name", ReplItem[0]);
					Property.Set(data[1], "RepHacked", "Obj 4 Cost", ReplItem[1]);
					continue;
				case "lovesense": #changes lovesense objects to aplocations with set ids.  ids can be changed in the gamesys
					Property.Set(240, "RepContents", "Obj 1 Name", "APLLovesense1");
					Property.Set(240, "RepContents", "Obj 2 Name", "APLLovesense2");
					Property.Set(240, "RepContents", "Obj 3 Name", "APLLovesense3");
					Property.Set(240, "RepContents", "Obj 4 Name", "APLLovesense4");
					Property.Set(240, "RepHacked", "Obj 1 Name", "APLLovesense1");
					Property.Set(240, "RepHacked", "Obj 2 Name", "APLLovesense2");
					Property.Set(240, "RepHacked", "Obj 3 Name", "APLLovesense3");
					Property.Set(240, "RepHacked", "Obj 4 Name", "APLLovesense4");
					continue;
				case "setcareer":
					Property.SetSimple(self, "CharGenYear", 2);
					continue;
				case "resetchar":
					Property.Set("Player", "BaseStatsDesc", "STR",1);
					Property.Set("Player", "BaseStatsDesc", "AGI",1);
					Property.Set("Player", "BaseStatsDesc", "CYB",1);
					Property.Set("Player", "BaseWeaponDesc", "Conventional",0);
					Property.Set("Player", "BaseTechDesc", "Repair",0);
					Property.SetSimple("Player", "PsiPowerDesc",0);
					Property.SetSimple("Player", "PsiPower2Desc",0);
					ShockGame.RecalcStats("Player");
					continue; #taken from RoSoDudes alternate start mod
				case "skipstation":
					Object.Teleport(self, vector(56.5, -20, -9), vector(0, 0, 0));
					continue; #teleport player to level end tripwire, only do after "setcareer"
				case "medsci1trip":
					local ItemTrip = Object.Create("itemrestrictor"); #Created tripwires seem to have a lot more properties set, I don't think they are important, as long as this tripwire is in the level items should not be spawned in medsci1.
					Property.Set(ItemTrip, "PhysDims", "Size", Vector(4, 4, 4));
					Property.Set(ItemTrip, "PhysState", "Location", Vector(46.98, -102.54, -15.23));
					Property.SetSimple(ItemTrip, "Scale", Vector(10.02, 1.44, 2.37));
					Object.Teleport(ItemTrip, Vector(46.98, -102.54, -15.23), Vector(0, 0, 0));
					continue;
				case "medsci1replpsihypo": #put a psi hypo in the security crate in the circular room with xerxes in both the unhacked and hacked.  This is to avoid softlocks where psi is required to get a location.
					Property.Set(300, "RepContents", "Obj 1 Name", "Psi Booster");
					Property.Set(300, "RepHacked", "Obj 1 Name", "Psi Booster");
					continue;
				case "skipearth": #skip the first level of the game by teleporting the player to a tripwire, required to not have tutorial setting on
						Object.Teleport(self, vector(6.8, 170.5, 64.6), vector(0, 0, 0))
					continue;
				case "randomizeenemy": #destroy data[0] enemy if that field isnt set to 0.  Get the correct tier array based on data[1].  choose a random enemy from that, then create it and teleport it to data[2] with the original enemies properties if there was one.
					local enemytier = VariousDataTables.enemytables.rawget(data[1]); #array of enemies based on spawn tier
					local chosenenemy = enemytier[rand() % enemytier.len()];
					local newenemy = Object.Create(chosenenemy);
					if (data[0] != 0)#lots of this was taken from Sarge945s rando
					{
						local enemyfacing = Property.Get(data[0], "PhysState", "Facing")

						CopyMetaprop(data[0], newenemy, "Docile");
						CopyMetaprop(data[0], newenemy, "Patrolling");
						CopyMetaprop(data[0], newenemy, "Silent");
						CopyMetaprop(data[0], newenemy, "Deaf");
						CopyMetaprop(data[0], newenemy, "Posing");
						CopyMetaprop(data[0], newenemy, "Blind");

						Property.CopyFrom(newenemy, "EcoType", data[0]);

						#For turrets, copy over hack difficulty
						Property.CopyFrom(newenemy, "HackDiff", data[0]);
						Property.CopyFrom(newenemy, "RepairDiff", data[0]);
						Property.CopyFrom(newenemy, "AmbientHacked", data[0]);

						//Remove friendly (fixes issue with Repairman)
						Object.RemoveMetaProperty(newenemy, "Good Guy");

						//Set HP to max (fixes issues with RSD)
						Property.SetSimple(newenemy, "HitPoints", Property.Get(newenemy, "MAX_HP"));

						//Copy over AI Properties
						Property.CopyFrom(newenemy, "AI_Fidget", data[0]);
						Property.CopyFrom(newenemy, "AI_Patrol", data[0]);
						Property.CopyFrom(newenemy, "AI_PtrlRnd", data[0]);
						Property.CopyFrom(newenemy, "AI_Mode", data[0]);
						Property.CopyFrom(newenemy, "AI_Alertness", data[0]);
						Property.CopyFrom(newenemy, "AI_Efficiency", data[0]);

						//Copy Multiplayer Handoff (maybe not needed)
						Property.CopyFrom(newenemy, "AI_NoHandoff", data[0]);

						//Set Idling Directions (maybe not needed)
						Property.CopyFrom(newenemy, "AI_IdleDirs", data[0]);

						//Set Idling Return to Origin (maybe not needed)
						Property.CopyFrom(newenemy, "AI_IdlRetOrg", data[0]);

						//Copying Signal and Alert Responses
						Property.CopyFrom(newenemy, "AI_SigRsp", data[0]);
						Property.CopyFrom(newenemy, "AI_AlrtRsp", data[0]);

						//Copy transparency (for Shodan level)
						Property.CopyFrom(newenemy, "LBAlpha", data[0]);
						Property.CopyFrom(newenemy, "ExtraLight", data[0]);

						copyLinks(data[0], newenemy,"SwitchLink");
						copyLinks(data[0], newenemy,"~SwitchLink");
						copyLinks(data[0], newenemy,"Target");
						copyLinks(data[0], newenemy,"~Target");
						copyLinks(data[0], newenemy,"Contains");
						copyLinks(data[0], newenemy,"~Contains");

						FixProjectiles(enemy);

						local enemyname = Object.GetName(data[0]);
						Object.SetName(data[0], "temp" + data[0]);
						Object.Destroy(data[0]);
						Object.SetName(newenemy, enemyname)
					}
					else
					{
						local enemyfacing = vector(0, 0, 0)
					}
					Object.Teleport(newenemy, data[2], enemyfacing);
					if (chosenenemy == "Wall Pod" || chosenenemy == "Swarmer Floor Pod" || chosenenemy == "Grub Floor Pod")
						{
						local podtrip = Object.Create("Floor Egg Tripwire");
						Property.SetSimple(podtrip, "Scale", vector(3, 3, 2));
						Link.Create("SwitchLink", podtrip, newenemy);
						Object.Teleport(podtrip, data[2], vector(0, 0, 0));
						}
					continue;
				case "directmonstergenrando":#change the enemy a DirectMonsterGen gotten from data[0] spawns to an enemy chosen randomly from a tier table based on data[1]
					local enemytier = EnemyTables.enemytabs.rawget(data[1]); #array of enemies based on spawn tier
					local chosenenemy = enemytier[rand() % enemytier.len()];
					Property.Set(data[0], "Spawn", "Type 1", chosenenemy);
					Property.Set(data[0], "Spawn", "Type 2", "");
					Property.Set(data[0], "Spawn", "Type 3", "");
					Property.Set(data[0], "Spawn", "Type 4", "");
					Property.Set(data[0], "Spawn", "Rarity 1", 100);
					Property.Set(data[0], "Spawn", "Rarity 2", 0);
					Property.Set(data[0], "Spawn", "Rarity 3", 0);
					Property.Set(data[0], "Spawn", "Rarity 4", 0);
					continue;
				case "monstercontainsaplocation":#switch an item[3](if it isnt 0) a monster[1] contains with an APlocation with id[2]
					local NewAPLocation =  Object.Create("APLocation");
					Property.Set(NewAPLocation, "VoiceIdx", "", data[2]);
					Link.Create("Target", NewTracker, NewAPLoc); #Link to object, EveryLoad send a message called CollectedItemsUpdate to whatever the tracker is linked to with the data being the sent items string
					Link.Create("Contains", data[1], NewAPLocation);
					if(data[3])
						Object.Destroy(data[3]);
					continue;
				}
		}
	}

	function OnItemsUnrestrticted()
	{
		SetOneShotTimer("ItemReceiver", 1);
	}

	function PickUnhackedReplItem()
	{
		local randitemnum = rand() % 116;
		local price = 0;
		if (randitemname >= 0 && randitemname <= 29)
			price = (rand() % 5) + 2; #number-1 after % is range of price, number after + is minimum price.  so this one has a range of 2-6
		if (randitemname >= 30 && randitemname <= 52)
			price = (rand() % 16) + 25;
		if (randitemname >= 53 && randitemname <= 85)
			price = (rand() % 41) + 50;
		if (randitemname >= 86 && randitemname <= 99)
			price = (rand() % 41) + 80;
		if (randitemname >= 100 && randitemname <= 115)
			price = (rand() % 61) + 90;
		return [VariousDataTables.UnhackedReplItems[randitemnum], price];
	}

	function PickHackedReplItem()
	{
		local randitemnum = rand() % 116;
		local price = 0;
		if (randitemname >= 0 && randitemname <= 26)
			price = (rand() % 21) + 15;
		if (randitemname >= 27 && randitemname <= 64)
			price = (rand() % 31) + 35;
		if (randitemname >= 65 && randitemname <= 96)
			price = (rand() % 51) + 55;
		if (randitemname >= 97 && randitemname <= 110)
			price = (rand() % 66) + 75;
		if (randitemname >= 112 && randitemname <= 115)
			price = (rand() % 51) + 125;
		return [VariousDataTables.HackedReplItems[randitemnum], price];
	}

	function OnBeginScript()
	{
		SetOneShotTimer("ScriptBeginning", 0.01);
	}

	function OnTimer()
	{
		if (message().name == "ScriptBeginning")
		{
			local curmap = string();
			Version.GetMap(curmap);
			curmap = curmap.tostring();
			local settings = ParseFile("DMM\\Testing\\data\\Settings.txt");
			if (!settings)
				{
				ShockGame.AddText("You aren't connected to a slot with the client.  Open the client, connect, and reload.  If you are connected then the settings file failed to be read.", self);
				return;
				}
			if (curmap == "earth.mis" && !Object.FindClosestObjectNamed(Networking.FirstPlayer(), "APLocationTracker"))
				{
				Property.SetSimple(self, "Modify1", settings); #store the settings
				local runseed = split(settings, ",")[0].tointeger();
				Property.SetSimple(self, "CurWpnDmg", runseed);
				Property.SetSimple(self, "BaseWpnDmg", 0); #StoredItemsReceived could just be changed to the amount of items received

				if (settings.find("Stats"))
					{
					Property.SetSimple(self, "ObjBrokenIcon", "");
					for (local i = 1000; i < 1139; i++)
						Property.SetSimple(self, "ObjBrokenIcon", Property.Get(self, "ObjBrokenIcon") + i + "," + (ceil((i - 1000) / 21) + 2) + ","); #The list of items purchasable from the location shop, costs increase the more you buy.  i is the locid.
					}
				}
			if (!Property.Get(self, "CurWpnDmg") == split(settings, ",")[0].tointeger) #check seed is the same
				{
				ShockGame.AddText("You are connected to the wrong slot, connect to the correct slot and reload.", self);
				return;
				}
			if (!(curmap == "earth.mis" || curmap == "station.mis" || curmap == "medsci1.mis" && Object.FindClosestObjectNamed(Networking.FirstPlayer(), "itemrestrictor"))) #cant let items spawn in places you can't backtrack to.
				SetOneShotTimer("ItemReceiver", 1);
			if (!Object.FindClosestObjectNamed(Networking.FirstPlayer(), "APLocationTracker"))
				FirstLoad(curmap);
			Link.BroadcastOnAllLinksData(Object.FindClosestObjectNamed(Networking.FirstPlayer(), "APLocationTracker"), "CollectedItemsUpdate", "Target", ParseFile("DMM\\Testing\\data\\SentItems.txt"));
			# ^ tells APLocations to delete themselves if they have already been collected.
		}

		if (message().name == "ItemReceiver")
		{
			local itemsreceived = split(ParseFile("DMM\\Testing\\data\\ReceivedItems.txt"), ",");
			local storeditemsreceivedcount = Property.Get(self, "BaseWpnDmg");
			local receiveditems = itemsreceived.slice(storeditemsreceivedcount.len()); #check if length of itemsreceived is larger than storeditemsreceivedcount, if so spawn the new items.
			foreach (itemid in receiveditems)
				ItemReceived(itemid);
			SetOneShotTimer("ItemReceiver", 1);
		}
	}

	function CopyMetaProp(oldenemy, newenemy, metaprop)#From Sarge945s Rando
	{
		if (Object.HasMetaProperty(oldenemy, metaprop))
			Object.AddMetaProperty(newenemy, metaprop);
	}

	function CopyLinks(oldenemy, newenemy, linkType)#taken from Sarge945s rando
    {
        foreach (outLink in Link.GetAll(linkkind(linkType), oldenemy))
        {
            local realLink = sLink(outLink);
            Link.Create(realLink.flavor, newenemy, realLink.dest);
        }
    }

	//When creating a new projectile for our new enemies
    //We need to deactivate it's particle group
    //Otherwise the particles will show at 0,0,0
    //Fixes SECMOD Issue
    static function FixProjectiles(enemy)#taken from Sarge945s rando
    {
        foreach (projLink in Link.GetAll(linkkind("AIProjectile"),enemy))
        {
            local proj = sLink(projLink).dest;

            //Only apply to monkey shots and assault bot shots, otherwise, stuff breaks
            local pname = ShockGame.GetArchetypeName(proj);
            local valid = pname == "Blue Monkey Shot" || pname == "Red Monkey Shot" || pname == "Droid Fusion Shot" || pname == "Big Fusion Shot";

            if (valid)
                Property.Set(proj, "ParticleGroup", "Active", 0);
        }
    }

	function ItemReceived(itemid) #grabs the associated array from the ItemTable and spawns it, sets its properties, then teleports it to the player
	{
		local item = VariousDataTables.ItemTable.rawget(itemid);
		Property.SetSimple(self, "BaseWpnDmg", Property.Get(self, "BaseWpnDmg") + 1) #add 1 to storeditemsreceived
		switch (item[0])
		{
		case "StatUpgrade":
			Property.Set(self, "BaseStatsDesc", item[1], Property.Get(self, "BaseStatsDesc", item[1]) + 1);
			break;
		case "TechUpgrade":
			Property.Set(self, "BaseTechDesc", item[1], Property.Get(self, "BaseTechDesc", item[1]) + 1);
			break;
		case "WeaponUpgrade":
			Property.Set(self, "BaseWeaponDesc", item[1], Property.Get(self, "BaseWeaponDesc", item[1]) + 1);
			break;
		case "PsiPowerUnlock": #tiers 1-4
			Property.setSimple(self, "PsiPowerDesc", Property.Get(self, "PsiPowerDesc") + pow(item[1] - 1, 2));
			break;
		case "PsiPowerUnlock2": #tier 5
			Property.setSimple(self, "PsiPower2Desc", Property.Get(self, "PsiPower2Desc") + pow(item[1] - 1, 2));
			break;
		case "OsUnlock":
			if (Property.Get(self, "TraitsDesc", "Trait 1" == 0))
				{
				Property.Set(self, "TraitsDesc", "Trait 1", item[1]);
				break;
				}
			if (Property.Get(self, "TraitsDesc", "Trait 2" == 0))
				{
				Property.Set(self, "TraitsDesc", "Trait 2", item[1]);
				break;
				}
			if (Property.Get(self, "TraitsDesc", "Trait 3" == -1))
				{
				Property.Set(self, "TraitsDesc", "Trait 3", item[1]);
				break;
				}
			if (Property.Get(self, "TraitsDesc", "Trait 4" == -1))
				{
				Property.Set(self, "TraitsDesc", "Trait 4", item[1]);
				break;
				}
			print("An OS upgrade was attempted to be obtained while all slots are full.")
			break;
		default:
			local newitem = Object.Create(item[0]);
			local properties = item[1];
				foreach(property in properties){
					if (property.len() == 3)
						Property.Set(newitem, property[0], property[1], property[2]);
					else
						Property.SetSimple(newitem, property[0], property[1]);
				}
			Object.Teleport(newitem, Object.Position(self), Object.Facing(self));
		}
	}

	function ParseFile(path) #reads a file and returns it as a string
	{
		local file = file(path, "r")
		if (file.eos() != null)
			{
			return null;
			}
		local blob = file.readblob(file.len());
		local output = "";
		for (local i = 0; i < blob.len(); i++)
		{
			local c = blob[i];
			output += c.tochar();
		}
		file.close();
		return output;
	}
}