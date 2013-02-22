//=============================================================================
// SPG_GameInfo
//
// Game info which spawns the player controller, pawn and HUD for the player.
//
// Copyright 1998-2011 Epic Games, Inc. All Rights Reserved.
//=============================================================================

class Cap_GameInfo extends UTDeathmatch;



static event class<GameInfo> SetGameType(string MapName, string Options, string Portal)
{
	return Default.Class;
}


function Tick(float deltaTime){
	WorldInfo.Tick(deltaTime);//Pretend regular tick happens
	//Reset time
	//reset timelimit
	GameReplicationInfo.RemainingTime = 60 * TimeLimit;
	// if the round lasted less than one minute, we won't be actually changing RemainingMinute
	// which will prevent it from being replicated, so in that case
	// reduce the time limit by one second to ensure that it is unique
	if ( GameReplicationInfo.RemainingTime == GameReplicationInfo.RemainingMinute )
	{
		GameReplicationInfo.RemainingTime--;
	}
	GameReplicationInfo.RemainingMinute = GameReplicationInfo.RemainingTime;
}


/*function NavigationPoint FindPlayerStart( Controller Player, optional byte InTeam, optional string IncomingName )
{
	local NavigationPoint N, BestStart;
	local Teleporter Tel;

	//Mostly overrriding the funciton in GameInfo
	//And giving us this inserted funciton.
	//Should give us everything we need.
	//We don't want to rank them, because...well, ranking would be useless.
	//We choose one by random.
	BestStart = ChoosePlayerStart(Player, InTeam);
	return BestStart;
}*/

/*function PlayerStart ChoosePlayerStart( Controller Player, optional byte InTeam )
{	
	local Sequence seq;
	local PlayerStart P, BestStart;
	local float BestRating, NewRating;
	local byte Team;
	local array<PlayerStart> playerList;
	local int index;
	local array<SequenceObject> Results;
	// Find best playerstart
	seq = WorldInfo.GetGameSequence();
	seq.FindSeqObjectsByClass(class'SeqVar_Object', true, Results);
	index = 0;
	while(index < Results.Length){
		if(SeqVar_Object(Results[index]).GetObjectValue().class == class'PlayerStart'){
			playerList.addItem(PlayerStart(SeqVar_Object(Results[index]).GetObjectValue()));	
		}
		//This will isolate the player start objects
		index++;
	}

	//foreach WorldInfo.AllNavigationPoints(class'PlayerStart', P)
	//{
	//	playerList.addItem(P);
	//}
	
	index = Rand(playerList.Length-1);
	`log("[Cap_GameInfo] Random index");
	`log(index);
	//Random integer between 0 and the last index of the player starts is chosen.
	//Label that the "Best Start"
	BestStart = playerList[index];

	return BestStart;
}*/


defaultproperties
{
	// What player controller class to create for the player
	PlayerControllerClass=class'SPG_PlayerController'
	DefaultPawnClass=Class'CapstoneGame.SPG_PlayerPawn'
	// What default pawn archetype to spawn for the player
	//DefaultPawnArchetype=SPG_PlayerPawn'StarterPlatformGameContent.Archetypes.PlayerPawn'
	// What default weapon archetype to spawn for the player
	DefaultWeapon=class'CapstoneGame.FireHand'
	// What HUD class to create for the player
	//HUDType=class'SPG_HUD'
}