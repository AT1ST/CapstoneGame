class FireHand_Attachment extends UTAttachment_LinkGun;


defaultproperties{

	// Weapon SkeletalMesh
	Begin Object Name=SkeletalMeshComponent0
		SkeletalMesh=SkeletalMesh'CapstoneWeaponPackage.firehandbaserig'
		Translation=(Z=0, X=40, Y=20)
		Material=Material'CapstoneWeaponPackage.Materials.blinn1'
		//Rotation=(Roll=-400)
		Rotation=(Roll=-90, Pitch=-180, Yaw=0)
		Scale=0.1
	End Object

}