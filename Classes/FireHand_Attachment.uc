class FireHand_Attachment extends UTAttachment_LinkGun;

var Material BaseMaterialForUse;

simulated function PostBeginPlay()
{
	local Color DefaultBeamColor;
	local LinearColor BeamColor;

	Super.PostBeginPlay();
    

	//SetSkin(BaseMaterialForUse);
	if(Mesh != None){
		Mesh.SetMaterial(1, MaterialInstanceConstant'CapstoneWeaponPackage.Materials.handMaterial_INST');
		Mesh.SetMaterial(0, MaterialInstanceConstant'CapstoneWeaponPackage.Materials.handMaterial_INST');
	}
	
}

simulated function AttachTo(UTPawn OwnerPawn)
{
	SetWeaponOverlayFlags(OwnerPawn);

	if (OwnerPawn.Mesh != None)
	{
		// Attach Weapon mesh to player skelmesh
		if ( Mesh != None )
		{
			OwnerMesh = OwnerPawn.Mesh;
			AttachmentSocket = OwnerPawn.WeaponSocket;

			// Weapon Mesh Shadow
			Mesh.SetShadowParent(OwnerPawn.Mesh);
			Mesh.SetLightEnvironment(OwnerPawn.LightEnvironment);

			if (OwnerPawn.ReplicatedBodyMaterial != None)
			{
				SetSkin(BaseMaterialForUse);
			}

			OwnerPawn.Mesh.AttachComponentToSocket(Mesh, OwnerPawn.WeaponSocket);
		}

		if (OverlayMesh != none)
		{
			OwnerPawn.Mesh.AttachComponentToSocket(OverlayMesh, OwnerPawn.WeaponSocket);
		}
	}

	if (MuzzleFlashSocket != '')
	{
		if (MuzzleFlashPSCTemplate != None || MuzzleFlashAltPSCTemplate != None)
		{
			MuzzleFlashPSC = new(self) class'UTParticleSystemComponent';
			MuzzleFlashPSC.bAutoActivate = false;
			MuzzleFlashPSC.SetOwnerNoSee(true);
			Mesh.AttachComponentToSocket(MuzzleFlashPSC, MuzzleFlashSocket);
		}
	}

	OwnerPawn.SetWeapAnimType(WeapAnimType);

	GotoState('CurrentlyAttached');
}

simulated function SetSkin(Material NewMaterial)
{
	Super.SetSkin(NewMaterial);

	//if (Mesh != None)
	//{
	//	Mesh.SetMaterial(0, WeaponMaterialInstance);
	//}
	
	//WeaponMaterialInstance.SetParent(Mesh.GetMaterial(0));
    //Mesh.SetMaterial(0, WeaponMaterialInstance);
}


defaultproperties{

	// Weapon SkeletalMesh
	
	/*Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment
		bSynthesizeSHLight=TRUE
		bIsCharacterLightEnvironment=TRUE
		bUseBooleanEnvironmentShadowing=FALSE
		InvisibleUpdateTime=1
		MinTimeBetweenFullUpdates=.2
	End Object
	Components.Add(MyLightEnvironment)*/

	//BaseMaterialForUse = Material'CapstoneWeaponPackage.Materials.handMaterial'
	//WeaponMaterialInstance = MaterialInstanceConstant'CapstoneWeaponPackage.Materials.handMaterial_INST'
	
	/*Begin Object Name=SkeletalMeshComponent0
		SkeletalMesh=SkeletalMesh'CapstoneWeaponPackage.firehandbaserigA'
		Translation=(Z=0, X=40, Y=20)
		//LightEnvironment=MyLightEnvironment
		//Material=Material'CapstoneWeaponPackage.Materials.blinn1'
		//Rotation=(Roll=-400)
		Rotation=(Roll=-90, Pitch=-180, Yaw=0)
		Scale=0.1
	End Object*/
	
	//Mesh=SkeletalMeshComponent0
	//Components.Add(SkeletalMeshComponent0)
	
	
	

}