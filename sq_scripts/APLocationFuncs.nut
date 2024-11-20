class APLocationFuncs extends SqRootScript
{
    function OnFrobWorldEnd()
    {
        Debug.Command("dump_cmds", "pylocid" + Property.Get(self, "VoiceIdx") + ".txt");
        Object.Destroy(self);
    }

    function OnCollectedItemsUpdate()
    {
        if (message().data.find(Property.Get(self, "VoiceIdx").tostring()))
            Object.Destroy(self);
    }
}

class ItemUnrestrict extends SqRootScript
{
    function OnFrobWorldEnd()
    {
        SendMessage(Networking.FirstPlayer(), "ItemsUnrestricted");
    }
}