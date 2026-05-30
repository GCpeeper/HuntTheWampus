extends Node

var rooms = []
var room
var rng = RandomNumberGenerator.new()
var username = ""
# Leaderboard, keeps track of names and scores
	# This leaderboard is the base leaderboard that is built off of by subsequent saves
var LeaderBoard = [["Player 1", 50, 75, 25],["Player 2", 63, 80, 43]]
const SAVE_PATH = "user://scores.json" # This is a save path for the score json, set for each user

# Sorting it using a custom function that checks if things are bigger than other things
func sortLeaderBoard(a,b):
	if a[1]>b[1]:
		return true
	return false

func makeScore(coins,travels): # the scoring starts at 100, is decreased for every room travelled, and is increased by the coins you had in your pocket when winning
	LeaderBoard.append([username,(100-travels+coins),travels,coins])

# Saving scores, replaces data within the JSON file with the new score list
func _saveScores():
	# Uses the FileAccess class to open the JSON file for writing operations
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	# Stringifies the leaderboard array so the JSON file can store it
	var data = JSON.stringify(LeaderBoard)
	# Stores the data
	file.store_string(data)
	# Closes the file so it won't get more edits
	file.close()
	
# Loading scores
func _loadScores():
	# Returns if it can't access the JSON file
	if not FileAccess.file_exists(SAVE_PATH):
		return
	# Uses the FileAccess class to open the JSON file for reading operations
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	# Reads the file and stores it in a variable
	var scoreData = file.get_as_text()
	# Closes the file so it won't get more edits
	file.close()
	# Makes a JSON object to parse the data
	var json = JSON.new()
	# A parse variable, returns OK if the parse is successful
	var error = json.parse(scoreData)
	# If the parse works
	if error == OK:
		# Replaces the base leaderboard with the stuff in the JSON file
		LeaderBoard = json.data
		# The parsing was turning the scores into floats so I turned them back into ints with this
		for score in LeaderBoard:
			score[1] = int(score[1])
			score[2] = int(score[2])
			score[3] = int(score[3])
		#print(LeaderBoard)
	# If it doesn't work
	else:
		#print("JSON Parse Error: ", json.get_error_message(), " in ", scoreData, " at line ", json.get_error_line())
		return

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
		
		
