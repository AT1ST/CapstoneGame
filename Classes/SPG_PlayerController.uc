//=============================================================================
// SPG_PlayerController
//
// Pawn which represents the player. Handles visual components and driving
// the aim offset.
//
// Copyright 1998-2011 Epic Games, Inc. All Rights Reserved.
//=============================================================================
class SPG_PlayerController extends PlayerController;

//var int zOffset;//Controls height of camera (Up/Down)

//var int yOffset;//Controls shoulder offset of camera (Left/right)

//var int xOffset;//Controls ahead/behind offset of camera (Forward/Backward)

/**
 * Returns Player's Point of View
 * For the AI this means the Pawn's 'Eyes' ViewPoint
 * For a Human player, this means the Camera's ViewPoint
 *
 * @output	out_Location, view location of player
 * @output	out_rotation, view rotation of player
 */

//*****************************************************************
// CODE FOR DOUBLE CLICK DELAY REMOVAL!!!!
simulated function BurstWeaponModify()
{
	local vector2D MPos;

	if (LocalPlayer(Player) != None)
	{
		MPos = LocalPlayer(Player).ViewportClient.GetMousePosition();
		LocalPlayer(Player).ViewportClient.SetMouse(MPos.X, MPos.Y+2);
	}
}
//*************************************************************
simulated event GetPlayerViewPoint( out vector out_Location, out Rotator out_Rotation )
{
	local Actor TheViewTarget;
	local Vector weaponPlace;
	local Rotator weapRot;
	local Rotator mWeapRot;//Modified weap rot

	// sometimes the PlayerCamera can be none and we probably do not want this
	// so we will check to see if we have a CameraClass.  Having a CameraClass is
	// saying:  we want a camera so make certain one exists by spawning one
	if( PlayerCamera == None )
	{
		if( CameraClass != None )
		{
			// Associate Camera with PlayerController
			PlayerCamera = Spawn(CameraClass, Self);
			if( PlayerCamera != None )
			{
				PlayerCamera.InitializeFor( Self );
			}
			else
			{
				`log("Couldn't Spawn Camera Actor for Player!!");
			}
		}
	}

	if( PlayerCamera != None )
	{
		
		PlayerCamera.GetCameraViewPoint(out_Location, out_Rotation);
		out_Location.Z += 50;
		out_Location.X += 0;
		out_Location.Y += 0;


		//Now we turn the player around.
		//Should be facing "backwards", which is forwards because that's what the hand does
		//Unlike the FireHand_Attachment, we can't rotate this one, so the *player* is inverted
		//I know that sounds weird, but that's what we're working with.
		out_Rotation.Yaw = ((UnrRotToDeg*out_Rotation.Yaw)-180)*DegToUnrRot;


		/*weaponPlace.Z= out_Location.Z - 15;
		weaponPlace.X = out_Location.X + 10;//+ = further away, -  closer
		weaponPlace.Y = out_Location.Y - 60;*/

		//Pitch, Yaw, Roll;
		weapRot.Pitch = ((UnrRotToDeg*out_Rotation.Pitch) + 45)*DegToUnrRot;
        //We want it to be facing upwards at around 45 degrees, since it has some height to catch up on
		//We use degrees for manipulation, so we need to multiply back and forth by these constants.
		/*weapRot.Roll = out_Rotation.Roll;

		mWeapRot = Pawn.Weapon.Rotation;

		weapRot.Yaw = ((UnrRotToDeg*out_Rotation.Yaw)-180)*DegToUnrRot ;//Should invert
		//We use degrees for manipulation, so we need to multiply back and forth by these constants.

		//mWeapRot.Pitch = -out_Rotation.Pitch;
		//mWeapRot.Roll = weapRot.Roll;
		//mWeapRot.Yaw = out_Rotation.Yaw;// We don't want to invert this.		

		//makeMatrix(weaponPlace, mWeapRot);//Comments below
		//So, the newest idea is that we take the rotation of the camera,
		//Then we say "I want to adjust the FireHand's x-y-z co-ordinates based on the vector multiplification this would give.)
		//I *think* this should work - we may have to normalize weaponPlace afterwards though...
		//We do it after the offset below though.
		
		
		//weaponPlace.Z -= out_Location.Z;
		//weaponPlace.X -= out_Location.X + 5;
		//weaponPlace.Y -= out_Location.Y - 30;


		//Trying something new - going to see if, from zero, we can force it to use the socket manager
		weaponPlace = Pawn.Weapon.Location;
		//Take the location it currently is, and then rotate around the pawn origin as required.
		//weaponPlace.Z -= out_Location.Z;
		//weaponPlace.X -= out_Location.X;
		//weaponPlace.Y -= out_Location.Y;
		
		//Rotation matrix application call here
		makeMatrix(weaponPlace, mWeapRot, out_Location);
		
		//weaponPlace.Z += out_Location.Z;
		//weaponPlace.X += out_Location.X;
		//weaponPlace.Y += out_Location.Y;
		
		
		
		//Just to reattach the weapon to the camera.
		//Just to reattach the weapon to the camera.
		
		FireHand(Pawn.Weapon).SetRotation(weapRot);
		FireHand(Pawn.Weapon).SetLocation(weaponPlace);
		*/
		

		//Okay, so we lie at this point.
		//The pawn's collision mesh stays in one location, but the camera moves.
		//out_Location.X = weaponPlace.X + 30;
		//out_Location.Y = weaponPlace.Y - 15;
		//out_Location.Z = weaponPlace.Z + 15;
		//out_Rotation
		
		//FireHand(Pawn.Weapon).WeaponCalcCamera(0, out_Location, out_Rotation);
	}
	else
	{
		TheViewTarget = GetViewTarget();

		if( TheViewTarget != None )
		{
			out_Location = TheViewTarget.Location;
			out_Rotation = TheViewTarget.Rotation;
		}
		else
		{
			super.GetPlayerViewPoint(out_Location, out_Rotation);
		}
	}
}

function makeMatrix(out Vector out_Location, out Rotator out_Rotation, out Vector out_Location_Standard){
	local Vector tempVectX;
	local Vector tempVectY;
	local Vector tempVectZ;
	local float tempX;
	local float tempY;
	local float tempZ;
	tempX = 10;
	tempY = -60;
	tempZ = -15;
	
	//We get the axis of the actual rotation of the object, 
	//then we say "Okay, you need to adjust the X and Y values based off of this"
	//Some of these may be wrong, I'm not sure yet.
	GetAxes(out_Rotation, tempVectX, tempVectY, tempVectZ);
	
	tempX += (tempVectX.X*out_Location.X);
	tempX += (tempVectY.X*out_Location.X);
	tempX += (tempVectZ.X*out_Location.X);

	tempY += (tempVectX.Y*out_Location.Y);
	tempY += (tempVectY.Y*out_Location.Y);
	tempY += (tempVectZ.Y*out_Location.Y);
	
	tempZ += (tempVectX.Z*out_Location.Z);
	tempZ += (tempVectY.Z*out_Location.Z);
	tempZ += (tempVectZ.Z*out_Location.Z);
	
	`log("[SPG_PlayerController.MakeMatrix] Original X, Y, Z");
	`log(out_Location.X);
	`log(out_Location.Y);
	`log(out_Location.Z);
	
	`log("[SPG_PlayerController.MakeMatrix] New X, Y, Z");
	`log(tempX);
	`log(tempY);
	`log(tempZ);
	
	out_Location.X = tempX + out_Location_Standard.X;
	out_Location.Y = tempY + out_Location_Standard.Y;
	out_Location.Z = tempZ + out_Location_Standard.Z;
	
	
	
	//tempVect = 

}


//Below functions were pulled from similar matrix-based multiplication code I had in Python for my own testing
//For Math 130 - I figured it would help here, but unrealscript doesn't support arrays in arrays, so...Gave up on this code below.
/*function rotate_matrix(float feta, vector point_of_rotation, String axis){
    //Creates a matrix that rotates feta degress around the origin. among an axis of rotation.
	//To do the full rotation across all three axes, do this three times, one for each.
	local array<SeqVar_ObjectList> matrix;
	
    if(axis == "k"){//Determines axis of rotation
        matrix = {SeqVar_ObjectList({cos(feta), -1*(sin(feta)), 0, 0}), SeqVar_ObjectList({sin(feta), cos(feta), 0, 0}),
                  SeqVar_ObjectList({0, 0, 1, 0}), SeqVar_ObjectList({0, 0, 0, 1})};
	}
    if(axis == "j"){
	
        matrix = {{cos(feta), 0, -1*(sin(feta)), 0},
                  {0, 1, 0, 0},
                  {sin(feta), 0, cos(feta), 0},
				{0, 0, 0, 1}};
	}
    if(axis == "i"){
        matrix = {{1, 0, 0, 0},
                  {0, cos(feta),
                   -1*(sin(feta)), 0},
                  {0, sin(feta), cos(feta), 0},
                  {0, 0, 0, 1}};
	}
    
    return matrix;
}*/

/*function matrix_multiplication(array<array<int>> matrix_in,
                          array<array<int>> matrix_out):
    """Multiplies matricies together into one matrix."""
    local array<array<int>>matrix_final;
    for ra in range(matrix_in.Length):
        matrix_line = []
        for re in range(len(matrix_out[ra].Length)):
            matrix_point = 0.0
            for pa in range(len(matrix_out)):
                matrix_point += (matrix_in[ra][pa] * matrix_out[pa][re]);#ra row to pa column, at postition re 
            matrix_line.append(matrix_point);#Add point
        matrix_final.append(matrix_line);#Add line
    return matrix_final;*/

defaultProperties{
	//IGNORE - doesn't appear to work here
	//Controls camera's height
	//zOffset=150
	//Controls camera's strafe
	//yOffset=0
	//Controls camera's leaning
	//xOffset=0

	//Leave this in for now - probably can remove later, if we decide not to do 
	//black magic with camera code
	CameraClass=class'SPG_Camera'
}