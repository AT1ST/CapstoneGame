//=============================================================================
// SPG_Camera
//
// Camera which simply adds an offset to the target's location and aims
// the camera at the target.
//
// Copyright 1998-2011 Epic Games, Inc. All Rights Reserved.
//=============================================================================
class SPG_Camera extends Camera;

/*function GetCameraViewPoint(out vector OutCamLoc, out rotator OutCamRot){
	OutCamLoc.Z += 100;
}*/

defaultproperties
{
	CameraProperties=SPG_CameraProperties'StarterPlatformGameContent.Archetypes.CameraProperties'
}