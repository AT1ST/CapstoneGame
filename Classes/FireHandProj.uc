/**
 * Copyright 1998-2012 Epic Games, Inc. All Rights Reserved.
 */
class FireHandProj extends UTProj_LinkPlasma;

var vector ColorLevel;
var vector ExplosionColor;

simulated function ProcessTouch (Actor Other, vector HitLocation, vector HitNormal)
{
	if ( Other != Instigator )
	{
		if ( !Other.IsA('Projectile') || Other.bProjTarget )
		{
			MomentumTransfer = (UTPawn(Other) != None) ? 0.0 : 1.0;
			Other.TakeDamage(Damage, InstigatorController, HitLocation, MomentumTransfer * Normal(Velocity), MyDamageType,, self);
			Explode(HitLocation, HitNormal);
		}
	}
}

simulated event HitWall(vector HitNormal, Actor Wall, PrimitiveComponent WallComp)
{
	MomentumTransfer = 1.0;

	Super.HitWall(HitNormal, Wall, WallComp);
}

simulated function SpawnFlightEffects()
{
	Super.SpawnFlightEffects();
	if (ProjEffects != None)
	{
		ProjEffects.SetVectorParameter('LinkProjectileColor', ColorLevel);
	}
}


simulated function SetExplosionEffectParameters(ParticleSystemComponent ProjExplosion)
{
	Super.SetExplosionEffectParameters(ProjExplosion);
	ProjExplosion.SetVectorParameter('LinkImpactColor', ExplosionColor);
}

function Init(vector Direction)
{
	SetRotation(Rotator(Direction));

	Velocity = Speed * Direction;
	TossZ = TossZ + (FRand() * TossZ / 2.0) - (TossZ / 4.0);
	Velocity.Z += TossZ;
	Acceleration = AccelRate * Normal(Velocity);
}


defaultproperties
{
	//ProjFlightTemplate=ParticleSystem'gizm0san_FireTutorial.Particles.PA_Effect_Fire'
	ProjFlightTemplate=ParticleSystem'FirePackage.Particles.PS_Fire_Small'
	ProjExplosionTemplate=ParticleSystem'gizm0san_FireTutorial.Particles.PA_Effect_Fire2'
	MaxEffectDistance=50.0

	Speed=1500
	MaxSpeed=2000
	AccelRate=0.0
	TossZ=200
	Physics=PHYS_Falling
	

	Damage=5
	DamageRadius=0
	MomentumTransfer=0
	CheckRadius=26.0

	MyDamageType=class'UTDmgType_LinkPlasma'
	LifeSpan=5.0// distance of bullet
	NetCullDistanceSquared=+144000000.0

	bCollideWorld=true
	DrawScale=1.2

	//ExplosionSound=SoundCue'A_Weapon_Link.Cue.A_Weapon_Link_ImpactCue'
	ColorLevel=(X=1,Y=1.3,Z=1)
	ExplosionColor=(X=1,Y=1,Z=1);
}
