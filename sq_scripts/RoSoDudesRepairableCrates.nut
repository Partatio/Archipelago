// RSD: Make Hackable Crates stop exploding when critically failing a hack
// Become broken instead, can be repaired. Must be hacked again after restoring
class rsdHackableCrate extends SqRootScript {
    function OnHackCritFail() {
        // ShockGame.AddText("OnHackCritFail","Player");
        BlockMessage();
    }

    function OnObjState1to0() {
        BlockMessage();
        SetProperty("ObjState", eObjState.kObjStateLocked);
    }
}