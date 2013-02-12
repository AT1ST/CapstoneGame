class FireTriggerVolume extends DynamicTriggerVolume
	showcategories(Movement)
	placeable;

var Weapon iNeedAWeapon;//Holds a weapon
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

	//finishTheFight = class'Ruination.RuinLinkGun'
}
