/**
 * Copyright 1998-2012 Epic Games, Inc. All Rights Reserved.
 */
class FireHand extends UTWeap_LinkGun;

var MaterialInstanceConstant MaterialInstanced;
var Material BaseMaterialForUse;


/**
 * Initialize the weapon
 */
simulated function PostBeginPlay()
{
	super.PostBeginPlay();
	//if(Mesh != None){
		//Mesh.SetMaterial(1,  MaterialInstanceConstant'CapstoneWeaponPackage.Materials.handMaterial_INST');
		//Mesh.SetMaterial(0,  MaterialInstanceConstant'CapstoneWeaponPackage.Materials.handMaterial_INST');
	//}
    

	//SetSkin(BaseMaterialForUse);
}

function WeaponCalcCamera(float fDeltaTime, out vector out_CamLoc, out rotator out_CamRot){

}


//Not only do we refil ammo, we decided to play animations here on the pawn, since it has the FireHand
function ConsumeAmmo( byte FireModeNum )
{
	if ( bAutoCharge && (Role == ROLE_Authority) )
	{
		SetTimer(RechargeRate+1.0, false, 'RechargeAmmo');
	}
	//Figure out how this works, and we'll have firing animations.
	//PlayAnim(name AnimName, optional float Duration, optional bool bLoop, optional bool bRestartIfAlreadyPlaying = true, optional float StartTime=0.0f, optional bool bPlayBackwards=false);
	//super.ConsumeAmmo(FireModeNum);
}


simulated function bool ShouldRefire()
{
	EndFire(CurrentFireMode);
	return false;
}

/*simulated function AttachWeaponTo( SkeletalMeshComponent MeshCpnt, optional Name SocketName )
{
	local UTPawn UTP;

	UTP = UTPawn(Instigator);
	// Attach 1st Person Muzzle Flashes, etc,
	if ( Instigator.IsFirstPerson() )
	{
		AttachComponent(Mesh);
		EnsureWeaponOverlayComponentLast();
		SetHidden(True);
		bPendingShow = TRUE;
		Mesh.SetLightEnvironment(UTP.LightEnvironment);
		if (GetHand() == HAND_Hidden)
		{
			UTP.ArmsMesh[0].SetHidden(true);
			UTP.ArmsMesh[1].SetHidden(true);
		}
	}
	else
	{
		SetHidden(True);
		if (UTP != None)
		{
			Mesh.SetLightEnvironment(UTP.LightEnvironment);
			UTP.ArmsMesh[0].SetHidden(true);
			UTP.ArmsMesh[1].SetHidden(true);
		}
	}

	SetWeaponOverlayFlags(UTP);

	// Spawn the 3rd Person Attachment
	if (Role == ROLE_Authority && UTP != None)
	{
		UTP.CurrentWeaponAttachmentClass = AttachmentClass;
		if (WorldInfo.NetMode == NM_ListenServer || WorldInfo.NetMode == NM_Standalone || (WorldInfo.NetMode == NM_Client && Instigator.IsLocallyControlled()))
		{
			UTP.WeaponAttachmentChanged();
		}
	}

	SetSkin(BaseMaterialForUse);
}*/

/**
 * Material control
 *
 * @Param 	NewMaterial		The new material to apply or none to clear it
 */
simulated function SetSkin(Material NewMaterial)
{

	//super.SetSkin(NewMaterial);
	
	//Mesh.SetMaterial(0, NewMaterial);
	//Set this all inside the super call
	local int i,Cnt;

	/*if ( NewMaterial == None )
	{
		`log("[FireHand.SetSkin] No instanced material found");
		// Clear the materials
		if ( default.Mesh.Materials.Length > 0 )
		{
			Cnt = Default.Mesh.Materials.Length;
			for (i=0;i<Cnt;i++)
			{
				Mesh.SetMaterial( i, BaseMaterialForUse);
			}
		}
		else if (Mesh.Materials.Length > 0)
		{
			Cnt = Mesh.Materials.Length;
			for ( i=0; i < Cnt; i++ )
			{
				Mesh.SetMaterial(i, BaseMaterialForUse);
			}
		}
	}
	else
	{
		// Set new material
		if (true)
		{
			Cnt = default.Mesh.Materials.Length > 0 ? default.Mesh.Materials.Length : Mesh.GetNumElements();
			for ( i=0; i < Cnt; i++ )
			{
				Mesh.SetMaterial(i, BaseMaterialForUse);
			}
		}
	}
	
	Mesh.SetMaterial(1, MaterialInstanced);
	Mesh.SetMaterial(0, MaterialInstanced);*/
}

simulated function TimeWeaponEquipping()
{
    super.TimeWeaponEquipping();
	//SkeletalMeshComponent(Mesh).SetLightEnvironment(Instigator.Mesh.LightEnvironment);
    
}

defaultproperties
{
	FireOffset=(X=320,Y=100,Z=-10)
	FireInterval(0)=+0.20 //(changes delay on shooting left mouse click)
	FireInterval(1)=+0.35 //(right click fire, currently no action)
	
	

	WeaponProjectiles(0)=class'FireHandProj' // UTProj_LinkPowerPlasma if linked (see GetProjectileClass() )

	WeaponEquipSnd=SoundCue'A_Interface.Menu.none'//UT3MenuSliderBarMoveCue'
	WeaponPutDownSnd=SoundCue'A_Weapon_Sniper.Sniper.none'
	WeaponFireSnd(0)=SoundCue'A_Ambient_NonLoops.Fire.Fire_TorchStart_01_Cue'
	WeaponFireSnd(1)=SoundCue'none'

	/*Begin Object class=AnimNodeSequence Name=MeshSequenceA
		bCauseActorAnimEnd=true
	End Object
	
	Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment
		bSynthesizeSHLight=TRUE
		bIsCharacterLightEnvironment=TRUE
		bUseBooleanEnvironmentShadowing=FALSE
		InvisibleUpdateTime=1
		MinTimeBetweenFullUpdates=.2
	End Object
	Components.Add(MyLightEnvironment)*/
	
	MaterialInstanced = MaterialInstanceConstant'CapstoneWeaponPackage.Materials.handMaterial_INST'
	BaseMaterialForUse = Material'CapstoneWeaponPackage.Materials.handMaterial'
	
	//AttachmentClass=class'CapstoneGame.FireHand_Attachment'

	// Weapon SkeletalMesh
	Begin Object Name=FirstPersonMesh
		SkeletalMesh=SkeletalMesh'CapstoneWeaponPackage.firehandbaserigA'
		AnimSets(0)=AnimSet'CapstoneWeaponPackage.pasted__pasted__bones'
		LightEnvironment=MyLightEnvironment
		//Material'CapstoneWeaponPackage.Materials.blinn1'
		Animations=MeshSequenceA
		Scale=0.1
		FOV=60.0
	End Object

	
	

	
	//Mesh=FirstPersonMesh
	//Components.Add(FirstPersonMesh)

	// Pickup staticmesh
	Begin Object Name=PickupMesh
		SkeletalMesh=SkeletalMesh'CapstoneWeaponPackage.firehandbaserigA'
		//Material'CapstoneWeaponPackage.Materials.blinn1'
		LightEnvironment=MyLightEnvironment
		Scale=0.1
	End Object

}
