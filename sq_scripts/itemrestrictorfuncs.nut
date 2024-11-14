class itemrestrictorfuncs extends SqRootScript
{
    function OnPhysEnter()
        {
            SendMessage("Player", "ItemsUnrestrticted");
            Object.Destroy(self);
        }
}