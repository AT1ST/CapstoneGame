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

var() ParticleSystemComponent psg;

var SkelControlBase ASkelControl;


simulated event PostInitAnimTree(SkeletalMeshComponent SkelComp)
{
  Super.PostInitAnimTree(SkelComp);

  if (SkelComp == Mesh)
  {
    ASkelControl = Mesh.FindSkelControl('LocationOffset');
  }
}

//Just to make sure things are removed when they are.
simulated event Destroyed()
{
  Super.Destroyed();

  ASkelControl = None;
}



var SkelControlBase ASkelControl;


simulated event PostInitAnimTree(SkeletalMeshComponent SkelComp)
{
  Super.PostInitAnimTree(SkelComp);

  if (SkelComp == Mesh)
  {
    ASkelControl = Mesh.FindSkelControl('LocationOffset');
  }
}

//Just to make sure things are removed when they are.
simulated event Destroyed()
{
  Super.Destroyed();

  ASkelControl = None;
}



// code for removal of double click delay************************************************
simulated function StartFire(byte FireModeNum)
{
	local SPG_PlayerController PC;

	super.StartFire(FireModeNum);

	PC = SPG_PlayerController(Instigator.Controller);
	if (PC != None)
		PC.BurstWeaponModify();
}
//*********************


//For animations, we do it from here.
//Don't trust the SkeletalMeshComponent to actually play it because AnimTrees...are only from UDK base.
//So...we make our own!
//Probably not supposed to do this this way, but if you've been paying attention to the rest of the code comments...
//...Yeah... :p

/** simple generic case animation player
 * requires that the one and only animation node in the AnimTree is an AnimNodeSequence
 * @param AnimName name of the animation to play
 * @param Duration (optional) override duration for the animation
 * @param bLoop (optional) whether the animation should loop
 * @param bRestartIfAlreadyPlaying whether or not to restart the animation if the specified anim is already playing
 * @param StartTime (optional) What time to start the animation at
 * @param bPlayBackwards (optional) Play this animation backwards
 */

//TODO: Look into this.
/*function PlayAnim(name AnimName, optional float Duration, optional bool bLoop, optional bool bRestartIfAlreadyPlaying = true, optional float StartTime=0.0f, optional bool bPlayBackwards=false)
{
	local AnimNodeSequence AnimNode;
	local float DesiredRate;

	AnimNode = Mesh.AnimNodeSequence(Mesh.Animations);
	if (AnimNode == None && Mesh.Animations.IsA('AnimTree'))
	{
		AnimNode = Mesh.AnimNodeSequence(AnimTree(Mesh.Animations).Children[0].Anim);
	}
	if (AnimNode == None)
	{
		`warn("Base animation node is not an AnimNodeSequence (Owner:" @ Owner $ ")");
	}
	else
	{
		if (AnimNode.AnimSeq != None && AnimNode.AnimSeq.SequenceName == AnimName)
		{
			DesiredRate = (Duration > 0.0) ? (AnimNode.AnimSeq.SequenceLength / (Duration * AnimNode.AnimSeq.RateScale)) : 1.0;
			DesiredRate = (bPlayBackwards) ? -DesiredRate : DesiredRate;
			if (bRestartIfAlreadyPlaying || !AnimNode.bPlaying)
			{
				AnimNode.PlayAnim(bLoop, DesiredRate, StartTime);
			}
			else
			{
				AnimNode.Rate = DesiredRate;
				AnimNode.bLooping = bLoop;
			}
		}
		else
		{
			AnimNode.SetAnim(AnimName);
			if (AnimNode.AnimSeq != None)
			{
				DesiredRate = (Duration > 0.0) ? (AnimNode.AnimSeq.SequenceLength / (Duration * AnimNode.AnimSeq.RateScale)) : 1.0;
				DesiredRate = (bPlayBackwards) ? -DesiredRate : DesiredRate;
				AnimNode.PlayAnim(bLoop, DesiredRate, StartTime);
			}
		}
	}
}*/


function Tick(float deltaTime){
	local FireTriggerVolume a;
	super.Tick(deltaTime);
	ForEach TouchingActors(class'CapstoneGame.FireTriggerVolume',a){
		//Since we are touching, then we add the weapon
		a.iNeedAWeapon = Spawn(class'CapstoneGame.FireHand');
		//a.iNeedAWeapon.Mesh.SetLightEnvironment(a.iNeedAWeapon.PickupMesh.LightEnvironment);
		a.iNeedAWeapon.GiveTo(Self);
		GetALocalPlayerController().ConsoleCommand("showMainWeapon");
		//Controller.SwitchToBestWeapon();//Enforces switchover
		//Since we take no damage...
		//return false;
		return;
	}
	GetALocalPlayerController().ConsoleCommand("hideMainWeapon");
	//If we get this far, it means we haven't had any trigger volumes to be near.
	//Ergo, discard all inventory.
	InvManager.DiscardInventory();
}

/*exec function testWeapon(){
	local FireTriggerVolume a;
	ForEach TouchingActors(class'Ruination.FireTriggerVolume',a){
		//Since we are touching, then we add the weapon
		//a.iNeedAWeapon = Spawn(class'RuinLinkGun');
		//a.iNeedAWeapon.GiveTo(Self);
		GetALocalPlayerController().ConsoleCommand("showMainWeapon");//Show the weapon - we may want a boolean for this
		Controller.SwitchToBestWeapon();//Enforces switchover
		//Since we take no damage...
		//return false;
		return;
	}
	GetALocalPlayerController().ConsoleCommand("hideMainWeapon");
	//If we get this far, it means we haven't had any trigger volumes to be near.
	//Ergo, discard all inventory.
	InvManager.DiscardInventory();
}*/


//Just to load custom assets in (Currently, none, so makes the pawn invisible)



exec function showMainWeapon(){
	Mesh.SetSkeletalMesh(defaultMesh);
	//psg.SetTemplate(particleSystemComponent);
	psg.setActive(true);
}

exec function hideMainWeapon(){
	Mesh.SetSkeletalMesh(SkeletalMesh'CapstoneWeaponPackage.firehandbaserigB');
	//psg.SetTemplate(PaticleSystem'P');
	psg.setActive(false);
}


simulated function SetCharacterClassFromInfo(class<UTFamilyInfo> Info)
{
Mesh.SetSkeletalMesh(defaultMesh);
Mesh.SetMaterial(0,defaultMaterial0);
Mesh.SetPhysicsAsset(defaultPhysicsAsset);
Mesh.SetLightEnvironment(LightEnvironment);//Force the light to stick to it?
Mesh.AnimSets=defaultAnimSet;
Mesh.SetAnimTreeTemplate(defaultAnimTree);
//By default, don't show the right thing
//psg.SetTemplate(PaticleSystem'P');
//Though we do show the particle
psg.SetLightEnvironment(LightEnvironment);
//AttachComponent(particleSystemComponent);
} 




defaultproperties
{
	bCanPickupInventory=false
	
	//WaterSpeed=220.0
	//WalkingPct=+0.4
	//AccelRate=500000000.0
	//WalkableFloorZ=0.78
	//bCanStrafe=False   does nothing?
	AirControl=+0.2
	DefaultAirControl=+0.2 //these change air motion limitations
	GroundSpeed=260.0 //movement speed
	//AirSpeed=50000.0 //nothing

	

	//Since usually we assume we can take the lighting environment from the pawn, let's go do that.
	Begin Object Class=DynamicLightEnvironmentComponent Name=LightEnvironment
		bSynthesizeSHLight=TRUE
		bIsCharacterLightEnvironment=TRUE
		bUseBooleanEnvironmentShadowing=FALSE
		InvisibleUpdateTime=1
		MinTimeBetweenFullUpdates=.2
	End Object
	Components.Add(LightEnvironment)
	
	particleSystemComponent=ParticleSystem'FirePackage.Particles.PS_Fire_Small'
	
	
	psg =CapstoneGame.PlayerEmitter
	
	/*Begin Object Class=ParticleSystemComponent Name=psg
		Template=particleSystemComponent
		LightEnvironment=LightEnvironment
	EndObject*/
	
	//This code was previously used to replace the pawn in previous projects.
	//Because the assets don't exist, it effectively makes the pawn invisible.
	defaultMesh=SkeletalMesh'CapstoneWeaponPackage.firehandtest2'
   //defaultMesh=SkeletalMesh'CapstoneWeaponPackage.firehandbaserig'
   //   defaultMesh=SkeletalMesh'KismetGame_Assets.Anims.SK_Turtle'
  //Change this to reflect our character's skeletal mesh
   //SkeletonControl = LocationOffset
   //defaultAnimTree=AnimTree'CH_AnimHuman_Tree.AT_CH_Human'
   defaultAnimTree=AnimTree'CapstoneWeaponPackage.FireHand_Tree'
   //  defaultAnimTree=AnimTree'KismetGame_Assets.Anims.Turtle_AnimTree'

   defaultAnimSet[0]=AnimSet'CapstoneWeaponPackage.pasted__pasted__bones'

   //defaultAnimSet[0]=AnimSet'KismetGame_Assets.Anims.SK_Turtle_Anims'

    defaultPhysicsAsset=PhysicsAsset'CH_AnimHuman.Mesh.SK_CH_AnimHuman_Physics'
	
	JumpZ+600.0
	MaxMultiJump=0
	

 

deaultMaterial0=StaticMesh'RuinationModels.Characters.jump_character_unreal_M_CH_IronG_Head-LOD-1-'

 

Begin Object Name=WPawnSkeletalMeshComponent

AnimTreeTemplate=AnimTree'CH_AnimHuman_Tree.AT_CH_Human'

End Object

particleSystemComponent = ParticleSystem'insertParticleSystemLink'

//Components.add(ParticleSystemComponent)


}