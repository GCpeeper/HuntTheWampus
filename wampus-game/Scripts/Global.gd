extends Node

var rooms = []
var room
var rng = RandomNumberGenerator.new()
var username = ""
# Leaderboard, keeps track of names and scores
	# This leaderboard is the base leaderboard that is built off of by subsequent saves
var LeaderBoard = [["Player 1", 50],["Player 2", 63]]

# Sorting it using a custom function that checks if things are bigger than other things
func sortLeaderBoard(a,b):
	if a[1]>b[1]:
		return true
	return false

func makeScore(coins,travels):
	LeaderBoard.append([username,(100-travels+coins)])

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rng.set_seed(0)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func generateRoom(top: bool, left: bool, right: bool, bottom: bool, hazard: int, has_wumpus: bool):
	pass

#func connectRooms():
	while rooms.size() < 30:
		rooms.append(room)
		
		
