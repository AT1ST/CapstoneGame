//=============================================================================
// SPG_PlayerPawn
//
// Pawn which represents the player. Handles visual components and driving
// the aim offset.
//
// Copyright 1998-2011 Epic Games, Inc. All Rights Reserved.
//=============================================================================
class SPG_PlayerPawn extends UTPawn;

//Variables for loading custom assets

var ParticleSystem particleSystemComponent;
var SkeletalMesh defaultMesh;
var MaterialInterface defaultMaterial0;
var AnimTree defaultAnimTree;
var array<AnimSet> defaultAnimSet;
var AnimNodeSequence defaultAnimSeq;
var PhysicsAsset defaultPhysicsAsset;


function Tick(float deltaTime){
	local FireTriggerVolume a;
	super.Tick(deltaTime);
	ForEach TouchingActors(class'CapstoneGame.FireTriggerVolume',a){
		//Since we are touching, then we add the weapon
		a.iNeedAWeapon = Spawn(class'CapstoneGame.FireHand');
		a.iNeedAWeapon.GiveTo(Self);
		Controller.SwitchToBestWeapon();//Enforces switchover
		//Since we take no damage...
		//return false;
		return;
	}
	//If we get this far, it means we haven't had any trigger volumes to be near.
	//Ergo, discard all inventory.
	InvManager.DiscardInventory();
}

/*exec function testWeapon(){
	local FireTriggerVolume a;
	ForEach TouchingActors(class'Ruination.FireTriggerVolume',a){
		//Since we are touching, then we add the weapon
		a.iNeedAWeapon = Spawn(class'RuinLinkGun');
		a.iNeedAWeapon.GiveTo(Self);
		Controller.SwitchToBestWeapon();//Enforces switchover
		//Since we take no damage...
		//return false;
		return;
	}
	//If we get this far, it means we haven't had any trigger volumes to be near.
	//Ergo, discard all inventory.
	InvManager.DiscardInventory();
}*/


//Just to load custom assets in (Currently, none, so makes the pawn invisible)


simulated function SetCharacterClassFromInfo(class<UTFamilyInfo> Info)
{
Mesh.SetSkeletalMesh(defaultMesh);
Mesh.SetMaterial(0,defaultMaterial0);
Mesh.SetPhysicsAsset(defaultPhysicsAsset);
Mesh.AnimSets=defaultAnimSet;
Mesh.SetAnimTreeTemplate(defaultAnimTree);
//AttachComponent(particleSystemComponent);
} 


defaultproperties
{
	bCanPickupInventory=false


	//This code was previously used to replace the pawn in previous projects.
	//Because the assets don't exist, it effectively makes the pawn invisible.

	
   defaultMesh=SkeletalMesh'RuinationModels.Jmale_head'
   //   defaultMesh=SkeletalMesh'KismetGame_Assets.Anims.SK_Turtle'
  //Change this to reflect our character's skeletal mesh

   defaultAnimTree=AnimTree'CH_AnimHuman_Tree.AT_CH_Human'
   //  defaultAnimTree=AnimTree'KismetGame_Assets.Anims.Turtle_AnimTree'

   defaultAnimSet[0]=AnimSet'CH_AnimHuman.Anims.K_AnimHuman_BaseMale'

   //defaultAnimSet[0]=AnimSet'KismetGame_Assets.Anims.SK_Turtle_Anims'

    defaultPhysicsAsset=PhysicsAsset'CH_AnimHuman.Mesh.SK_CH_AnimHuman_Physics'

 

deaultMaterial0=StaticMesh'RuinationModels.Characters.jump_character_unreal_M_CH_IronG_Head-LOD-1-'

 

Begin Object Name=WPawnSkeletalMeshComponent

AnimTreeTemplate=AnimTree'CH_AnimHuman_Tree.AT_CH_Human'

End Object

particleSystemComponent = ParticleSystem'insertParticleSystemLink'

//Components.add(ParticleSystemComponent)


}