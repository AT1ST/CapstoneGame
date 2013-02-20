class FireTriggerVolume extends DynamicTriggerVolume
	showcategories(Movement)
	placeable;

var Weapon iNeedAWeapon;//Holds a weapon

//For the weapon to be able to be seen, we need a light component to be added to it.
//Normally, you would use one that exists from the Pawn, but the Pawn...doesn't have one in our case.
//So...We hold it in these brushes.
var DynamicLightEnvironmentComponent needALight;


//var ParticleSystem ps;
//Spawn Particle system either in GameInfo PostBeginPlay() or somewhere so that they show up.
//When you are inside one of these trigger volumes, make the rotation vector point towards the player.

//function Tick(float deltaTime){
//}

defaultproperties
{
	bStatic=false

	bAlwaysRelevant=true
	bReplicateMovement=true
	bOnlyDirtyReplication=true
	RemoteRole=ROLE_None

	bColored=true
	BrushColor=(R=128,G=200,B=255,A=255)

	bEnabled=true
	
	Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment
		bSynthesizeSHLight=TRUE
		bIsCharacterLightEnvironment=TRUE
		bUseBooleanEnvironmentShadowing=FALSE
		InvisibleUpdateTime=1
		MinTimeBetweenFullUpdates=.2
	End Object
	needALight = MyLightEnvironment
	//Components.Add(MyLightEnvironment)

	//finishTheFight = class'Ruination.RuinLinkGun'
}
