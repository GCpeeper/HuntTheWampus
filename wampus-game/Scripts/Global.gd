extends Node

var rooms = []
var room

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func generateRoom(top: bool, left: bool, right: bool, bottom: bool, hazard: int, has_wumpus: bool):
	pass

func connectRooms():
	while rooms.size() < 30:
		rooms.append(room)
