extends Node2D

@onready var LBNames = $CanvasLayer2/RichTextLabel
var base_pos = Vector2(0,0)

func _ready() -> void:
	var rank = 1
	# Setting up the leaderboard
	Global.LeaderBoard.sort_custom(Global.sortLeaderBoard) # Making sure it goes biggest to smallest
	# Putting the scores into the label
	for score in Global.LeaderBoard:
		# Appends the text
		LBNames.append_text(str(rank) + ". " + score[0] + ": " + str(score[1]) + " (Travels: " + str(score[2]) + ", Coins: " + str(score[3]) + ")" )
		# Creates a new line for the next one
		LBNames.newline()
		rank += 1

func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_up") and LBNames.position.y != base_pos.y:
		LBNames.position.y += 5
	if Input.is_action_pressed("ui_down"):
		LBNames.position.y -= 5

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
