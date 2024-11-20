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
					{
					local NewAPLocation = Object.Create("APLocation");
					Property.Set(NewAPLocation, "VoiceIdx", "", data[2]);
					if (type(data[1]) == type([]))
					{
						local chosencontainer = data[1][ShockGame.RandRange(0, data[1].len() - 1)];
						Property.SetSimple(NewAPLocation, "HasRefs", FALSE);
						Link.Create(linkkind("Contains"), chosencontainer, NewAPLocation);
					}
					else
						Object.Teleport(NewAPLocation, data[1], vector());
					Link.Create("Mutate", NewTracker, NewAPLocation); #Link to object, EveryLoad send a message called CollectedItemsUpdate to whatever the tracker is linked to with the data being the sent items string
					if (data[3])
						Object.Destroy(data[3]);
					continue;
					}
				case "replaceCybModShop":
					{
					foreach (Terminal in data[1])
						Object.Destroy(Terminal);
					local CybModShop = Object.Create("CybModShop");
					Object.Teleport(CybModShop, data[2], vector(0, 0, 0));
					continue;
					}
				case "destroy":
					{
					Object.Destroy(data[1]);
					continue;
					}
				case "slayvictoryprop": #add script to last script slot on many or shodan that on slay sends a victory location out.  both bosses have scripts in slot 0 and 1.
					{
					Property.Set(data[1], "Scripts", "Script 3", "OnSlayVictory");
					continue;
					}
				case "randomizerepl": #randomize a repl with random items and costs.
					{
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
					ReplItem = PickHackedReplItem();
					Property.Set(data[1], "RepHacked", "Obj 1 Name", ReplItem[0]);
					Property.Set(data[1], "RepHacked", "Obj 1 Cost", ReplItem[1]);
					ReplItem = PickHackedReplItem();
					Property.Set(data[1], "RepHacked", "Obj 2 Name", ReplItem[0]);
					Property.Set(data[1], "RepHacked", "Obj 2 Cost", ReplItem[1]);
					ReplItem = PickHackedReplItem();
					Property.Set(data[1], "RepHacked", "Obj 3 Name", ReplItem[0]);
					Property.Set(data[1], "RepHacked", "Obj 3 Cost", ReplItem[1]);
					ReplItem = PickHackedReplItem();
					Property.Set(data[1], "RepHacked", "Obj 4 Name", ReplItem[0]);
					Property.Set(data[1], "RepHacked", "Obj 4 Cost", ReplItem[1]);
					continue;
					}
				case "lovesense": #changes lovesense objects to aplocations with set ids.  ids can be changed in the gamesys
					{
					Property.Set(240, "RepContents", "Obj 1 Name", "APLLovesense1");
					Property.Set(240, "RepContents", "Obj 2 Name", "APLLovesense2");
					Property.Set(240, "RepContents", "Obj 3 Name", "APLLovesense3");
					Property.Set(240, "RepContents", "Obj 4 Name", "APLLovesense4");
					Property.Set(240, "RepHacked", "Obj 1 Name", "APLLovesense1");
					Property.Set(240, "RepHacked", "Obj 2 Name", "APLLovesense2");
					Property.Set(240, "RepHacked", "Obj 3 Name", "APLLovesense3");
					Property.Set(240, "RepHacked", "Obj 4 Name", "APLLovesense4");
					continue;
					}
				case "command1repl": #changes command1s first hacked item to a location, this is to replace the resonator.  id changeable in gamesys
					{
					Property.Set(394, "RepHacked", "Obj 1 Name", "APLCommand1");
					Property.Set(394, "RepHacked", "Obj 1 Cost", 100);
					continue
					}
				case "setcareer":
					{
					Property.SetSimple(self, "CharGenYear", 2);
					continue;
					}
				case "resetchar":
					{
					Property.Set(Networking.FirstPlayer(), "BaseStatsDesc", "STR",1);
					Property.Set(Networking.FirstPlayer(), "BaseStatsDesc", "AGI",1);
					Property.Set(Networking.FirstPlayer(), "BaseStatsDesc", "CYB",1);
					Property.Set(Networking.FirstPlayer(), "BaseWeaponDesc", "Conventional",0);
					Property.Set(Networking.FirstPlayer(), "BaseTechDesc", "Repair",0);
					Property.SetSimple(Networking.FirstPlayer(), "PsiPowerDesc",0);
					Property.SetSimple(Networking.FirstPlayer(), "PsiPower2Desc",0);
					ShockGame.RecalcStats(Networking.FirstPlayer());
					continue; #taken from RoSoDudes alternate start mod
					}
				case "skipstation":
					{
					Object.Teleport(self, vector(56.5, -20, -9), vector(0, 0, 0));
					continue; #teleport player to level end tripwire, only do after "setcareer"
					}
				case "itemrestrictorapl": #creates an APLocation at location data[1], with Locid data[2], and a script that sends a message to the player to start sending items.  does not link to APlocationTracker.  Used on medsci1 to stop items from spawning.
					{
					local NewAPLocation = Object.Create("APLocation");
					Property.Set(NewAPLocation, "VoiceIdx", "", data[2]);
					Object.Teleport(NewAPLocation, data[1], vector());
					Property.Set(NewAPLocation, "Scripts", "Script 0", "ItemUnrestrict");
					continue;
					}
				case "medsci1replpsihypo": #put a psi hypo in the security crate in the circular room with xerxes in both the unhacked and hacked.  This is to avoid softlocks where psi is required to get a location.
					{
					Property.Set(300, "RepContents", "Obj 1 Name", "Psi Booster");
					Property.Set(300, "RepContents", "Obj 1 Cost", ShockGame.RandRange(50, 90));
					Property.Set(300, "RepHacked", "Obj 1 Name", "Psi Booster");
					Property.Set(300, "RepHacked", "Obj 1 Cost", ShockGame.RandRange(35, 65));
					continue;
					}
				case "skipearth": #skip the first level of the game by teleporting the player to a tripwire, required to not have tutorial setting on
					{
					Object.Teleport(self, vector(6.8, 170.5, 64.6), vector(0, 0, 0))
					continue;
					}
				case "randomizeenemy": #destroy data[1] enemy if that field isnt set to 0.  Get the correct tier array based on data[2].  choose a random enemy from that, then create it and teleport it to data[3] with the original enemies properties if there was one.
					{
					local enemytier = VariousDataTables.enemytables.rawget(data[2]); #array of enemies based on spawn tier
					local chosenenemy = enemytier[ShockGame.RandRange(0, enemytier.len() - 1)];
					local newenemy = Object.Create(chosenenemy);
					local enemyfacing = vector();
					if (data[1] != 0)#lots of this was taken from Sarge945s rando
					{
						enemyfacing = Property.Get(data[1], "PhysState", "Facing");

						CopyMetaProp(data[1], newenemy, "Docile");
						CopyMetaProp(data[1], newenemy, "Patrolling");
						CopyMetaProp(data[1], newenemy, "Silent");
						CopyMetaProp(data[1], newenemy, "Deaf");
						CopyMetaProp(data[1], newenemy, "Posing");
						CopyMetaProp(data[1], newenemy, "Blind");

						Property.CopyFrom(newenemy, "EcoType", data[1]);

						#For turrets, copy over hack difficulty
						Property.CopyFrom(newenemy, "HackDiff", data[1]);
						Property.CopyFrom(newenemy, "RepairDiff", data[1]);
						Property.CopyFrom(newenemy, "AmbientHacked", data[1]);

						//Remove friendly (fixes issue with Repairman)
						Object.RemoveMetaProperty(newenemy, "Good Guy");

						//Set HP to max (fixes issues with RSD)
						Property.SetSimple(newenemy, "HitPoints", Property.Get(newenemy, "MAX_HP"));

						//Copy over AI Properties
						Property.CopyFrom(newenemy, "AI_Fidget", data[1]);
						Property.CopyFrom(newenemy, "AI_Patrol", data[1]);
						Property.CopyFrom(newenemy, "AI_PtrlRnd", data[1]);
						Property.CopyFrom(newenemy, "AI_Mode", data[1]);
						Property.CopyFrom(newenemy, "AI_Alertness", data[1]);
						Property.CopyFrom(newenemy, "AI_Efficiency", data[1]);

						//Copy Multiplayer Handoff (maybe not needed)
						Property.CopyFrom(newenemy, "AI_NoHandoff", data[1]);

						//Set Idling Directions (maybe not needed)
						Property.CopyFrom(newenemy, "AI_IdleDirs", data[1]);

						//Set Idling Return to Origin (maybe not needed)
						Property.CopyFrom(newenemy, "AI_IdlRetOrg", data[1]);

						//Copying Signal and Alert Responses
						Property.CopyFrom(newenemy, "AI_SigRsp", data[1]);
						Property.CopyFrom(newenemy, "AI_AlrtRsp", data[1]);

						//Copy transparency (for Shodan level)
						Property.CopyFrom(newenemy, "LBAlpha", data[1]);
						Property.CopyFrom(newenemy, "ExtraLight", data[1]);

						CopyLinks(data[1], newenemy,"SwitchLink");
						CopyLinks(data[1], newenemy,"~SwitchLink");
						CopyLinks(data[1], newenemy,"Target");
						CopyLinks(data[1], newenemy,"~Target");
						CopyLinks(data[1], newenemy,"Contains");
						CopyLinks(data[1], newenemy,"~Contains");

						FixProjectiles(newenemy);

						local enemyname = Object.GetName(data[1]);
						Object.SetName(data[1], "temp" + data[1]);
						Object.Destroy(data[1]);
						Object.SetName(newenemy, enemyname)
					}
					Object.Teleport(newenemy, data[3], enemyfacing);
					if (chosenenemy == "Wall Pod" || chosenenemy == "Swarmer Floor Pod" || chosenenemy == "Grub Floor Pod")
						{
						local podtrip = Object.Create("Floor Egg Tripwire");
						Property.SetSimple(podtrip, "Scale", vector(3, 3, 2));
						Link.Create("SwitchLink", podtrip, newenemy);
						Object.Teleport(podtrip, data[3], vector(0, 0, 0));
						}
					continue;
					}
				case "directmonstergenrando":#change the enemies a DirectMonsterGen gotten from data[1] spawns to enemies chosen randomly from a tier table based on data[2]
					{
					local enemytier = VariousDataTables.enemytables.rawget(data[2]); #array of enemies based on spawn tier
					local chosenenemy = enemytier[ShockGame.RandRange(0, enemytier.len() - 1)];
					Property.Set(data[1], "Spawn", "Type 1", chosenenemy);
					local enemytier = VariousDataTables.enemytables.rawget(data[2]);
					local chosenenemy = enemytier[ShockGame.RandRange(0, enemytier.len() - 1)];
					Property.Set(data[1], "Spawn", "Type 2", chosenenemy);
					local enemytier = VariousDataTables.enemytables.rawget(data[2]);
					local chosenenemy = enemytier[ShockGame.RandRange(0, enemytier.len() - 1)];
					Property.Set(data[1], "Spawn", "Type 3", chosenenemy);
					local enemytier = VariousDataTables.enemytables.rawget(data[2]);
					local chosenenemy = enemytier[ShockGame.RandRange(0, enemytier.len() - 1)];
					Property.Set(data[1], "Spawn", "Type 4", chosenenemy);
					Property.Set(data[1], "Spawn", "Rarity 1", 25);
					Property.Set(data[1], "Spawn", "Rarity 2", 25);
					Property.Set(data[1], "Spawn", "Rarity 3", 25);
					Property.Set(data[1], "Spawn", "Rarity 4", 25);
					continue;
					}
				case "monstercontainsaplocation":#add an APlocation with id[2] to a monster[1] and delete [3] if it isn't 0
					{
					local NewAPLocation =  Object.Create("APLocation");
					Property.Set(NewAPLocation, "VoiceIdx", "", data[2]);
					Link.Create("Mutate", NewTracker, NewAPLocation); #Link to object, EveryLoad send a message called CollectedItemsUpdate to whatever the tracker is linked to with the data being the sent items string
					Link.Create("Contains", data[1], NewAPLocation);
					if(data[3])
						Object.Destroy(data[3]);
					continue;
					}
				}
		}
	}

	function OnItemsUnrestricted()
	{
		Property.SetSimple(self, "AI_PtrlRnd", FALSE);
		SetOneShotTimer("ItemReceiver", 1);
	}

	function PickUnhackedReplItem()
	{
		local randitemnum = ShockGame.RandRange(0, 115);
		local price = 0;
		if (randitemnum >= 0 && randitemnum <= 29)
			price = ShockGame.RandRange(2, 6);
		if (randitemnum >= 30 && randitemnum <= 52)
			price = ShockGame.RandRange(25, 40);
		if (randitemnum >= 53 && randitemnum <= 85)
			price = ShockGame.RandRange(50, 90);
		if (randitemnum >= 86 && randitemnum <= 99)
			price = ShockGame.RandRange(80, 120);
		if (randitemnum >= 100 && randitemnum <= 115)
			price = ShockGame.RandRange(90, 150);
		return [VariousDataTables.UnhackedReplItems[randitemnum], price];
	}

	function PickHackedReplItem()
	{
		local randitemnum = ShockGame.RandRange(0, 115);
		local price = 0;
		if (randitemnum >= 0 && randitemnum <= 26)
			price = ShockGame.RandRange(15, 35);
		if (randitemnum >= 27 && randitemnum <= 64)
			price = ShockGame.RandRange(35, 65);
		if (randitemnum >= 65 && randitemnum <= 96)
			price = ShockGame.RandRange(55, 105);
		if (randitemnum >= 97 && randitemnum <= 110)
			price = ShockGame.RandRange(75, 140);
		if (randitemnum >= 112 && randitemnum <= 115)
			price = ShockGame.RandRange(125, 175);
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
			local settings = ParseFile("DMM\\Archipelago\\data\\Settings.txt");
			local runseed = split(settings, ",")[0].tointeger();
			if (!settings)
				{
				ShockGame.AddText("You aren't connected to a slot with the client.  Open the client, connect, and reload.  If you are connected then the settings file failed to be read.", self);
				return;
				}
			#if (curmap == "earth.mis" && !Object.FindClosestObjectNamed(Networking.FirstPlayer(), "APLocationTracker")) #uncomment this when done testing
				{
				Property.SetSimple(self, "Modify1", settings); #store the settings
				Property.SetSimple(self, "CurWpnDmg", runseed); #storedseed
				Property.SetSimple(self, "BaseWpnDmg", 1); #StoredItemsReceived could just be changed to the amount of items received
				Property.SetSimple(self, "AI_PtrlRnd", TRUE); #Whether player has not left airlock

				if (settings.find("Stats"))
					{
					Property.SetSimple(self, "LockMsg", "");
					local shoparray = "";
					for (local i = 1000; i < 1139; i++)
						shoparray += i + "," + (ceil((i - 1000) / 21) + 2) + ","; #The list of items purchasable from the location shop, costs increase the more you buy. i is the locid.
					Property.SetSimple(self, "LockMsg", shoparray);
					}
				}
			local storedseed = Property.Get(self, "CurWpnDmg");
			if (runseed != storedseed)
				{
				ShockGame.AddText("You are connected to the wrong slot, connect to the correct slot and reload.", self);
				return;
				}
			if (!Object.FindClosestObjectNamed(Networking.FirstPlayer(), "APLocationTracker"))
				FirstLoad(curmap);
			if (!(curmap == "earth.mis" || curmap == "station.mis" || curmap == "medsci1.mis" && Property.Get(self,"AI_PtrlRnd"))) #cant let items spawn in places you can't backtrack to.
				SetOneShotTimer("ItemReceiver", 1);
			Link.BroadcastOnAllLinksData(Object.FindClosestObjectNamed(Networking.FirstPlayer(), "APLocationTracker"), "CollectedItemsUpdate", "Mutate", ParseFile("DMM\\Archipelago\\data\\SentItems.txt"));
			# ^ tells APLocations to delete themselves if they have already been collected.
		}

		if (message().name == "ItemReceiver")
		{
			local ReceivedItemsfile = ParseFile("DMM\\Archipelago\\data\\ReceivedItems.txt")
			if (ReceivedItemsfile == null)
				{
					ShockGame.AddText("RecievedItemsfile could not be read or is empty.  Open the client and connect to a slot.", self)
					return;
				}
			local itemsreceived = split(ReceivedItemsfile, ",");
			local storeditemsreceivedcount = Property.Get(self, "BaseWpnDmg");
			local receiveditems = itemsreceived.slice(storeditemsreceivedcount); #check if length of itemsreceived is larger than storeditemsreceivedcount, if so spawn the new items.
			foreach (itemid in receiveditems)
				ItemReceived(itemid);
			SetOneShotTimer("ItemReceiver", 1);
		}
	}

	static function CopyMetaProp(oldenemy, newenemy, metaprop)#From Sarge945s Rando
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
			{
			Property.Set(self, "BaseStatsDesc", item[1], Property.Get(self, "BaseStatsDesc", item[1]) + 1);
			break;
			}
		case "TechUpgrade":
			{
			Property.Set(self, "BaseTechDesc", item[1], Property.Get(self, "BaseTechDesc", item[1]) + 1);
			break;
			}
		case "WeaponUpgrade":
			{
			Property.Set(self, "BaseWeaponDesc", item[1], Property.Get(self, "BaseWeaponDesc", item[1]) + 1);
			break;
			}
		case "PsiPowerUnlock": #tiers 1-4
			{
			Property.SetSimple(self, "PsiPowerDesc", Property.Get(self, "PsiPowerDesc") + pow(2, item[1] - 1));
			print(Property.Get(self, "PsiPowerDesc"))
			break;
			}
		case "PsiPowerUnlock2": #tier 5
			{
			Property.SetSimple(self, "PsiPower2Desc", Property.Get(self, "PsiPower2Desc") + pow(2, item[1] - 1));
			print(Property.Get(self, "PsiPower2Desc"))
			break;
			}
		case "OsUnlock":
			{
			if (Property.Get(self, "TraitsDesc", "Trait 1") == 0)
				{
				Property.Set(self, "TraitsDesc", "Trait 1", item[1]);
				break;
				}
			if (Property.Get(self, "TraitsDesc", "Trait 2") == 0)
				{
				Property.Set(self, "TraitsDesc", "Trait 2", item[1]);
				break;
				}
			if (Property.Get(self, "TraitsDesc", "Trait 3") == 0)
				{
				Property.Set(self, "TraitsDesc", "Trait 3", item[1]);
				break;
				}
			if (Property.Get(self, "TraitsDesc", "Trait 4") == 0)
				{
				Property.Set(self, "TraitsDesc", "Trait 4", item[1]);
				break;
				}
			print("An OS upgrade was attempted to be obtained while all slots are full.")
			break;
			}
		default:
			{
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