/**
 * Copyright 1998-2012 Epic Games, Inc. All Rights Reserved.
 */
class FireHand extends UTWeap_LinkGun;

function WeaponCalcCamera(float fDeltaTime, out vector out_CamLoc, out rotator out_CamRot){

}
defaultproperties
{
	FireOffset=(X=320,Y=100,Z=-10)

	WeaponProjectiles(0)=class'FireHandProj' // UTProj_LinkPowerPlasma if linked (see GetProjectileClass() )

	WeaponEquipSnd=SoundCue'A_Interface.Menu.none'//UT3MenuSliderBarMoveCue'
	WeaponPutDownSnd=SoundCue'A_Weapon_Sniper.Sniper.none'
	WeaponFireSnd(0)=SoundCue'A_Ambient_NonLoops.Fire.Fire_TorchStart_01_Cue'
	WeaponFireSnd(1)=SoundCue'none'

	Begin Object class=AnimNodeSequence Name=MeshSequenceA
		bCauseActorAnimEnd=true
	End Object

	// Weapon SkeletalMesh
	Begin Object Name=FirstPersonMesh
		SkeletalMesh=SkeletalMesh'CapstoneWeaponPackage.firehandbaserig'
		AnimSets(0)=AnimSet'CapstoneWeaponPackage.pasted__pasted__bones'
		Material'CapstoneWeaponPackage.Materials.blinn1'
		Animations=MeshSequenceA
		Scale=0.1
		FOV=60.0
	End Object

	AttachmentClass=class'CapstoneGame.FireHand_Attachment'

	// Pickup staticmesh
	Begin Object Name=PickupMesh
		SkeletalMesh=SkeletalMesh'CapstoneWeaponPackage.firehandbaserig'
		Material'CapstoneWeaponPackage.Materials.blinn1'
		Scale=0.1
	End Object


}
