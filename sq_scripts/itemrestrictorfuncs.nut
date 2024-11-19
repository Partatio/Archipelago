class itemrestrictorfuncs extends SqRootScript
{
    function OnPhysEnter()
        {
            print("oaugh");
            SendMessage(Networking.FirstPlayer(), "ItemsUnrestrticted");
            Object.Destroy(self);
        }
}