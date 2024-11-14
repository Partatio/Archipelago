class CybModShop extends SqRootScript
{
    function OnFrobWorldEnd()
    {
        local cybmodshoplist = split(Property.Get("Player", "ObjBrokenIcon"));
        local price = cybmodshoplist[1].tointeger();
        local playercybmodcount = Property.Get("FakeCookie", "StackCount");
        if (playercybmodcount >= price)
            {
            Debug.Command("dump_cmds", "pylocid" + cybmodshoplist[0] + ".txt");#send out location
            Property.SetSimple("FakeCookie", "StackCount", playercybmodcount - price);#reduce player cyber modules
            cybmodshoplist.remove(0);#remove id and price of just purchased location
            cybmodshoplist.remove(0);
            local newcybmodshoplist = "";
            foreach(element in cybmodshoplist)#recreate stored shop string then restore it
                newcybmodshoplist = newcybmodshoplist + element + ","
            Property.SetSimple("Player", "ObjBrokenIcon", newcybmodshoplist);
            }
    }
}