class CybModShop extends SqRootScript
{
    function OnFrobWorldEnd()
    {
        local cybmodshoplist = split(Property.Get(Networking.FirstPlayer(), "LockMsg"), ",");
        local price = cybmodshoplist[1].tointeger();
        local cybmodholder = Object.FindClosestObjectNamed(Networking.FirstPlayer(), "FakeCookie")
        local playercybmodcount = Property.Get(cybmodholder, "StackCount");
        if (playercybmodcount >= price)
            {
            Debug.Command("dump_cmds", "pylocid" + cybmodshoplist[0] + ".txt");#send out location
            Property.SetSimple(cybmodholder, "StackCount", playercybmodcount - price);#reduce player cyber modules
            cybmodshoplist.remove(0);#remove id and price of just purchased location
            cybmodshoplist.remove(0);
            local newcybmodshoplist = "";
            foreach(element in cybmodshoplist)#recreate stored shop string then restore it
                newcybmodshoplist = newcybmodshoplist + element + ","
            Property.SetSimple(Networking.FirstPlayer(), "LockMsg", newcybmodshoplist);
            ShockGame.AddText("Bought a location for " + price + " Cyber Modules.", Networking.FirstPlayer())
            }
        else
            ShockGame.AddText("You do not have enough Cyber Modules to buy a location.  The next one costs " + price + ".", Networking.FirstPlayer())
    }
}