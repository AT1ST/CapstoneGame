class PlayerEmitter extends ParticleSystemComponent;


defaultproperties
{
	LightEnvironmentClass=class'ParticleLightEnvironmentComponent'
	// Share light environment with many other particle components by default to be inexpensive
	// This means particle lighting will update fairly slowly by default as well
	MaxLightEnvironmentPooledReuses=10
	bTickInEditor=true

	Template=ParticleSystem'FirePackage.Particles.PS_Fire_Small'
	
	MaxTimeBeforeForceUpdateTransform=5

	bAutoActivate=true
	bResetOnDetach=false
	OldPosition=(X=0,Y=0,Z=0)
	PartSysVelocity=(X=0,Y=0,Z=0)
	WarmupTime=0

	SecondsBeforeInactive=1.0

	bSkipUpdateDynamicDataDuringTick=false

	TickGroup=TG_DuringAsyncWork

	bIsViewRelevanceDirty=true

	CustomTimeDilation=1.f

	EditorDetailMode=-1
}