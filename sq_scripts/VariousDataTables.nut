class VariousDataTables extends SqRootScript
{
//format Command: ["Setting", Data]
//"placeaploc" = create an aplocation at a location or in one of a set of containers based on whether data[1] is a vector or array, give it the LocID of data[2], destroy data[3] unless it is 0(when swapping an item for a APLocation).
//example "placeaploc": ["None", vector(55, 21, 30), 4, 341]
//example "placeaploc": ["Chems", [62, 853, 92, 1], 91, 0]
//"replaceCybModShop" = Destroy all upgrade terminals in an area, then place a CybModShop at a location.
//example "replaceCybModShop": ["Stats", [52,12], vector(12, 7, 312)]
//"destroy" = destroy an object
//example "destroy": ["None", 71]
//"setcareer" = set character gen year to 2
//example "setcareer": ["NoStats"]
//"resetchar" = set stats to default
//example "resetchar": ["NoStats"]
//"skipstation" = teleports player to level end
//example "skipstation": ["NoStats"]
//"lovesense" = change objects in lovesense machine to APLocations with set ids which are changeable in the gamesys
//example "lovesense": ["None"]
//"slayvictoryprop" = add script to script 3 that on slay sends victory loc. many obj id is 253(i think) and shodan is 298
//example "slayvictoryprop": ["Many", 253]
//"medsci1trip" = Place a tripwire after the airlock that destroys itself by linking to a destroy trap, the itemreceiving thread on medsci 1 doesnt run until this tripwire is destroyed
//example "medsci1trip": ["None"]
//"randomizerepl" = Randomize the contents and prices of a replicator
//example "randomizerepl": ["None", 116]
//"medsci1replpsihypo" = Replace the first object in medsci1's repl in the circular hub with a psi hypo to avoid softlocks. (hacked and unhacked)
//example "medsci1replpsihypo": ["None"]
//"newgame" = run on newgame to store settings and other info
//example "newgame": ["None"]
//"skipearth" = teleport player at start of game to one of the agencies skipping the first level, if tutorial is on dont do this
//example "skipearth": ["NoTutorial"]
//"randomizeenemy" = destroy data[1] enemy if that field isnt set to 0.  Get the correct tier array based on data[2].  choose a random enemy from that, then create it and teleport it to data[3] with the original enemies facing if there was one.
//example "randomizeenemy": ["none", 12, "2", vector(23, 8, 12)]
//"directmonstergenrando" = change the enemy a DirectMonsterGen gotten from data[1] spawns to an enemy chosen randomly from a tier table based on data[2]
//example "directmonstergenrando": ["None", 854, "5"]
//"monstercontainsaplocation" = #switch an item[3](if it isnt 0) a monster[1] contains with an APlocation with id[2]
//example "monstercontainsaplocation": ["None", 25, 67, 43]

mapinstructions =
{
    "earth.mis": {
        "placeaploc": ["None", vector(-26.7165, -28.2592, 4.27442), 13, 0],
        "destroy": ["None", 187]
    }
    "medsci1.mis": {
    }
}

enemytables =
{
    "0": [
    "OG-Pipe",
    "OG-Pipe",
    "OG-Pipe",
    "OG-Pipe",
    "OG-Pipe",
    "Baby Arachnid",
    "Baby Arachnid",
    "Baby Arachnid",
    "Blue Monkey",
    "Blue Monkey",
    "OG-Shotgun",
    "Swarmer Floor Pod",
    "Grub Floor Pod"
    ]

    "0Ranged": [
    "Blue Monkey",
    "Blue Monkey",
    "OG-Shotgun"
    ]

    "1": [
    "OG-Pipe",
    "OG-Pipe",
    "OG-Pipe",
    "OG-Pipe",
    "OG-Pipe",
    "Baby Arachnid",
    "Baby Arachnid",
    "Baby Arachnid",
    "Baby Arachnid",
    "Blue Monkey",
    "Blue Monkey",
    "Blue Monkey",
    "OG-Shotgun",
    "OG-Shotgun",
    "Swarmer Floor Pod",
    "Grub Floor Pod",
    "Protocol Droid",
    "Protocol Droid",
    "Slug Turret"
    ]

    "1Ranged": [
    "Blue Monkey",
    "Blue Monkey",
    "Blue Monkey",
    "OG-Shotgun",
    "OG-Shotgun",
    "Slug Turret"
    ]

    "2": [
    "OG-Pipe",
    "OG-Pipe",
    "Baby Arachnid",
    "Baby Arachnid",
    "Blue Monkey",
    "Blue Monkey",
    "Blue Monkey",
    "OG-Shotgun",
    "OG-Shotgun",
    "OG-Shotgun",
    "Swarmer Floor Pod",
    "Grub Floor Pod",
    "Floor Pod",
    "Protocol Droid",
    "Protocol Droid",
    "Slug Turret",
    "Midwife"
    ]

    "2Ranged": [
    "Blue Monkey",
    "Blue Monkey",
    "Blue Monkey",
    "OG-Shotgun",
    "OG-Shotgun",
    "OG-Shotgun",
    "Slug Turret",
    "Midwife"
    ]

    "3": [
    "OG-Pipe",
    "OG-Shotgun",
    "Baby Arachnid",
    "Baby Arachnid",
    "Blue Monkey",
    "Blue Monkey",
    "Swarmer Floor Pod",
    "Grub Floor Pod",
    "Floor Pod",
    "Protocol Droid",
    "Protocol Droid",
    "Midwife",
    "Midwife",
    "Maintenance Robot",
    "Slug Turret",
    "Slug Turret",
    "Laser Turret"
    ]

    "3Ranged": [
    "OG-Shotgun",
    "Blue Monkey",
    "Blue Monkey",
    "Midwife",
    "Midwife",
    "Maintenance Robot",
    "Slug Turret",
    "Slug Turret",
    "Laser Turret"
    ]

    "4": [
    "OG-Pipe",
    "OG-Shotgun",
    "Baby Arachnid",
    "Blue Monkey",
    "Swarmer Floor Pod",
    "Grub Floor Pod",
    "Floor Pod",
    "Slug Turret",
    "Protocol Droid",
    "Midwife",
    "Midwife",
    "Midwife",
    "Midwife",
    "Laser Turret",
    "Laser Turret",
    "Red Monkey",
    "Red Monkey",
    "Red Monkey",
    "Red Monkey",
    "Maintenance Robot",
    "Maintenance Robot",
    "Maintenance Robot",
    "Security Robot",
    "Security Robot",
    "Assassin",
    "Assassin"
    ]

    "4Ranged": [
    "OG-Shotgun",
    "Blue Monkey",
    "Slug Turret",
    "Midwife",
    "Midwife",
    "Laser Turret",
    "Red Monkey",
    "Red Monkey",
    "Maintenance Robot",
    "Maintenance Robot",
    "Security Robot",
    "Assassin"
    ]

    "5": [
    "OG-Pipe",
    "OG-Shotgun",
    "Baby Arachnid",
    "Blue Monkey",
    "Swarmer Floor Pod",
    "Grub Floor Pod",
    "Floor Pod",
    "Slug Turret",
    "Protocol Droid",
    "Maintenance Robot",
    "Security Robot",
    "Security Robot",
    "Midwife",
    "Midwife",
    "Midwife",
    "Midwife",
    "Laser Turret",
    "Laser Turret",
    "Red Monkey",
    "Red Monkey",
    "Red Monkey",
    "Red Monkey",
    "Assassin",
    "Assassin",
    "Assassin",
    "Assassin",
    "Arachnightmare",
    "Arachnightmare",
    "Arachnightmare",
    "Arachnightmare",
    "OG-Grenade",
    "OG-Grenade"
    ]

    "5": [
    "OG-Shotgun",
    "Blue Monkey",
    "Slug Turret",
    "Maintenance Robot",
    "Security Robot",
    "Midwife",
    "Midwife",
    "Laser Turret",
    "Red Monkey",
    "Red Monkey",
    "Assassin",
    "Assassin",
    "OG-Grenade"
    ]

    "6": [
    "OG-Pipe",
    "OG-Shotgun",
    "Baby Arachnid",
    "Blue Monkey",
    "Swarmer Floor Pod",
    "Grub Floor Pod",
    "Floor Pod",
    "Slug Turret",
    "Protocol Droid",
    "Maintenance Robot",
    "Security Robot",
    "Laser Turret",
    "Midwife",
    "Red Monkey",
    "Assassin",
    "Assassin",
    "Assassin",
    "Assassin",
    "Arachnightmare",
    "Arachnightmare",
    "Arachnightmare",
    "Arachnightmare",
    "OG-Grenade",
    "OG-Grenade",
    "OG-Grenade",
    "Invisible Arachnid",
    "Invisible Arachnid",
    "Assault Robot",
    "Assault Robot"
    ]

    "6Ranged": [
    "OG-Shotgun",
    "Blue Monkey",
    "Slug Turret",
    "Maintenance Robot",
    "Security Robot",
    "Laser Turret",
    "Midwife",
    "Red Monkey",
    "Assassin",
    "Assassin",
    "Assassin",
    "Assassin",
    "Assassin",
    "OG-Grenade",
    "OG-Grenade",
    "OG-Grenade",
    "OG-Grenade",
    "Assault Robot",
    "Assault Robot",
    "Assault Robot"
    ]

    "7": [
    "OG-Pipe",
    "OG-Shotgun",
    "Baby Arachnid",
    "Blue Monkey",
    "Swarmer Floor Pod",
    "Grub Floor Pod",
    "Floor Pod",
    "Slug Turret",
    "Protocol Droid",
    "Maintenance Robot",
    "Security Robot",
    "Laser Turret",
    "Midwife",
    "Red Monkey",
    "Arachnightmare",
    "Assassin",
    "Assassin",
    "Assassin",
    "OG-Grenade",
    "OG-Grenade",
    "OG-Grenade",
    "Invisible Arachnid",
    "Invisible Arachnid",
    "Invisible Arachnid",
    "Assault Robot",
    "Assault Robot",
    "Assault Robot",
    "Rumbler",
    "Rumbler"
    ]

    "7Ranged": [
    "OG-Shotgun",
    "Blue Monkey",
    "Slug Turret",
    "Maintenance Robot",
    "Security Robot",
    "Laser Turret",
    "Midwife",
    "Red Monkey",
    "Assassin",
    "Assassin",
    "Assassin",
    "Assassin",
    "OG-Grenade",
    "OG-Grenade",
    "OG-Grenade",
    "OG-Grenade",
    "OG-Grenade",
    "OG-Grenade",
    "Assault Robot",
    "Assault Robot",
    "Assault Robot",
    "Assault Robot"
    ]

    "8": [
    "OG-Pipe",
    "OG-Shotgun",
    "Baby Arachnid",
    "Blue Monkey",
    "Swarmer Floor Pod",
    "Grub Floor Pod",
    "Floor Pod",
    "Slug Turret",
    "Protocol Droid",
    "Maintenance Robot",
    "Security Robot",
    "Laser Turret",
    "Midwife",
    "Red Monkey",
    "Arachnightmare",
    "Assassin",
    "OG-Grenade",
    "OG-Grenade",
    "OG-Grenade",
    "Invisible Arachnid",
    "Invisible Arachnid",
    "Assault Robot",
    "Assault Robot",
    "Assault Robot",
    "Rumbler",
    "Rumbler",
    "Rumbler",
    "Rumbler",
    "Blast Turret",
    "Blast Turret",
    "Blast Turret",
    "Overlord",
    "Overlord",
    "Overlord"
    ]

    "8Ranged": [
    "OG-Shotgun",
    "Blue Monkey",
    "Slug Turret",
    "Maintenance Robot",
    "Security Robot",
    "Laser Turret",
    "Midwife",
    "Red Monkey",
    "Assassin",
    "OG-Grenade",
    "OG-Grenade",
    "OG-Grenade",
    "OG-Grenade",
    "Assault Robot",
    "Assault Robot",
    "Assault Robot",
    "Blast Turret",
    "Blast Turret",
    "Blast Turret",
    "Blast Turret",
    "Blast Turret",
    "Overlord",
    "Overlord",
    "Overlord"
    ]

    "9": [
    "OG-Pipe",
    "OG-Shotgun",
    "Baby Arachnid",
    "Blue Monkey",
    "Swarmer Floor Pod",
    "Grub Floor Pod",
    "Floor Pod",
    "Slug Turret",
    "Protocol Droid",
    "Maintenance Robot",
    "Security Robot",
    "Laser Turret",
    "Midwife",
    "Red Monkey",
    "Arachnightmare",
    "Assassin",
    "OG-Grenade",
    "Invisible Arachnid",
    "Assault Robot",
    "Blast Turret",
    "Rumbler",
    "Rumbler",
    "Rumbler",
    "Rumbler",
    "Rumbler",
    "Rumbler",
    "Rumbler",
    "Rumbler",
    "Rumbler",
    "Rumbler",
    "Rumbler",
    "Rumbler",
    "Rumbler",
    "Overlord",
    "Overlord",
    "Overlord",
    "Overlord",
    "Overlord",
    "Overlord",
    "Overlord",
    "Overlord",
    "Greater Over.",
    "Greater Over.",
    "Greater Over.",
    "Greater Over.",
    "Greater Over."
    ]

    "9Ranged": [
    "OG-Shotgun",
    "Blue Monkey",
    "Slug Turret",
    "Maintenance Robot",
    "Security Robot",
    "Laser Turret",
    "Midwife",
    "Red Monkey",
    "Assassin",
    "OG-Grenade",
    "Assault Robot",
    "Blast Turret",
    "Blast Turret",
    "Blast Turret",
    "Blast Turret",
    "Blast Turret",
    "Blast Turret",
    "Blast Turret",
    "Blast Turret",
    "Blast Turret",
    "Overlord",
    "Overlord",
    "Overlord",
    "Overlord",
    "Overlord",
    "Overlord"
    ]
}

#Tables made of the same overall makeup of the items found in replicators in the base game i.e. for each time a repl had chips in the base game a chips entry is added to the relevant table.
#section header is "price range" "midpoint"
UnhackedReplItems =
    [
        #2-6, 4
        "Chips",
        "Chips",
        "Chips",
        "Chips",
        "Chips",
        "Soda Can",
        "Soda Can",
        "Soda Can",
        "Soda Can",
        "Soda Can",
        "Juice Bottle",
        "Juice Bottle",
        "Juice Bottle",
        "Juice Bottle",
        "Mug",
        "Mug",
        "Cigarettes",
        "Cigarettes",
        "Cigarettes",
        "Cigarettes",
        "Cigarettes",
        "Cigarettes",
        "Cigarretes",
        "Vodka Bottle",
        "Vodka Bottle",
        "Vodka Bottle",
        "Vodka Bottle",
        "Vodka Bottle",
        "Vodka Bottle",
        "Vodka Bottle",
        #25-40 32.5
        "Med Patch",
        "Med Patch",
        "Med Patch",
        "Med Patch",
        "Med Patch",
        "Med Patch",
        "Detox Patch",
        "Detox Patch",
        "Detox Patch",
        "Detox Patch",
        "Detox patch",
        "Detox Patch",
        "Detox Patch",
        "Detox Patch",
        "Detox Patch",
        "Detox Patch",
        "Hack Soft V1",
        "Modify Soft V1",
        "Rad Patch",
        "Rad Patch",
        "Repair Soft V1",
        "Strength Boost",
        "Strength Boost",
        #50-90 70
        "Maintenance Tool",
        "Maintenance Tool",
        "Maintenance Tool",
        "Maintenance Tool",
        "Maintenance Tool",
        "Maintenance Tool",
        "Maintenance Tool",
        "Small Standard Clip",
        "Small Standard Clip",
        "Small Standard Clip",
        "Small Standard Clip",
        "Small Standard Clip",
        "Small Standard Clip",
        "Psi Booster",
        "Psi Booster",
        "Psi Booster",
        "Psi Booster",
        "Psi Booster",
        "Psi Booster",
        "Psi Booster",
        "Psi Booster",
        "Psi Booster",
        "Psi Booster",
        "Psi Booster",
        "Psi Booster",
        "Psi Booster",
        "Psi Booster",
        "Psi Booster",
        "Rifled Slug Box",
        "Rifled Slug Box",
        "Rifled Slug Box",
        "Rifled Slug Box",
        "Rifled Slug Box",
        #80-120 100
        "Portable Battery",
        "Portable Battery",
        "Pellet Shot Box",
        "Pellet Shot Box",
        "Pellet Shot Box",
        "Recycler",
        "Standard Clip",
        "Timed Grenade",
        "Timed Grenade",
        "Timed Grenade",
        "Timed Grenade",
        "Timed Grenade",
        "Timed Grenade",
        "Timed Grenade",
        #90-150 120
        "Prox. Grenade",
        "Prox. Grenade",
        "Small AP Clip",
        "small AP clip",
        "Small HE Clip",
        "Small Prism",
        "Small Prism",
        "Small Prism",
        "Small Prism",
        "Small Prism",
        "Small Prism",
        "EMP Grenade",
        "Incend. Grenade",
        "Medical Kit",
        "Medical Kit",
        "ExperTech",
    ]

HackedReplItems =
    [
        #15-35 25
        "Med Patch",
        "Med Patch",
        "Med Patch",
        "Med Patch",
        "Med Patch",
        "Med Patch",
        "Detox Patch",
        "Detox Patch",
        "Detox Patch",
        "Detox Patch",
        "Detox Patch",
        "Detox Patch",
        "Detox Patch",
        "Detox Patch",
        "Detox Patch",
        "Detox Patch",
        "Detox Patch",
        "Hack Soft V1",
        "Modify Soft V1",
        "Rad Patch",
        "Rad Patch",
        "Rad Patch",
        "Repair Soft v1",
        "Repair Soft V1",
        "Research Soft V1",
        "Strength Boost",
        "Strength Boost",
        #35-65 50
        "Maintenance Tool",
        "Maintenance Tool",
        "Maintenance Tool",
        "Maintenance Tool",
        "Maintenance Tool",
        "Maintenance Tool",
        "Maintenance Tool",
        "Maintenance Tool",
        "Small Standard Clip",
        "Small Standard Clip",
        "Small Standard Clip",
        "Small Standard Clip",
        "Small Standard Clip",
        "Small Standard Clip",
        "Small Standard Clip",
        "Psi Booster",
        "Psi Booster",
        "Psi Booster",
        "Psi Booster",
        "Psi Booster",
        "Psi Booster",
        "Psi Booster",
        "Psi Booster",
        "Psi Booster",
        "Psi Booster",
        "Psi Booster",
        "Psi Booster",
        "Psi Booster",
        "Psi Booster",
        "Psi Booster",
        "Rifled Slug Box",
        "Rifled Slug Box",
        "Rifled Slug Box",
        "Rifled Slug Box",
        "Rifled Slug Box",
        "Rifled Slug Box",
        "Portable Battery",
        "Portable Battery",
        #55-105 80
        "Pellet Shot Box",
        "Pellet Shot Box",
        "Pellet Shot Box",
        "Pellet Shot Box",
        "Recycler",
        "Recycler",
        "Recycler",
        "Standard Clip",
        "Timed Grenade",
        "Timed Grenade",
        "Timed Grenade",
        "Timed Grenade",
        "Timed Grenade",
        "Timed Grenade",
        "Timed Grenade",
        "Prox. Grenade",
        "Prox. Grenade",
        "Prox. Grenade",
        "Toxin Grenade",
        "Small Ap Clip",
        "Small Ap Clip",
        "Small AP Clip",
        "Small AP Clip",
        "Small AP Clip",
        "Small HE Clip",
        "Small HE Clip",
        "Small HE Clip",
        "Small Prism",
        "Small Prism",
        "Small Prism",
        "Small Prism",
        "Small Prism",
        #75-140 107.5
        "Repair Soft V2",
        "Repair Soft V2",
        "EMP Grenade",
        "EMP Grenade",
        "EMP Grenade",
        "Incend. Grenade",
        "Incend. Grenade",
        "Incend. Grenade",
        "Medical Kit",
        "Medical Kit",
        "Medical Kit",
        "Medical Kit",
        "Medical Kit",
        "Medical Kit",
        "ExperTech",
        #125-175 150
        "Large Prism",
        "Large Prism",
        "Large Prism",
        "Repair Soft V3",
    ]

//format id: ["archetype or archetypeid", [["property", value], ["property", value], ["property", "field", value]]], #setting
//example "239": ["Standard Clip", []], #None
//2nd example "12": ["Big Nanite Pile", [["StackCount", 239], ["Scale", vector(3.00, 0.50, 1.00)], ["LightColor", "hue", 8.3]]], #Wrench

ItemTable = {
    #medsci1
    "12": ["Big Nanite Pile", [["StackCount", 239], ["Scale", vector(3.00, 0.50, 1.00)], ["LightColor", "hue", 8.3]]],
    "239": ["Standard Clip", []],
    #medsci2
    }
}