extends Node2D

@onready var LBNames = $CanvasLayer2/RichTextLabel

func _ready() -> void:
	# Setting up the leaderboard
	Global.LeaderBoard.sort_custom(Global.sortLeaderBoard) # Making sure it goes biggest to smallest
	# Putting the scores into the label
	for score in Global.LeaderBoard:
		# Appends the text
		LBNames.append_text(score[0] + ": " + str(score[1]) + " (Travels: " + str(score[2]) + ", Coins: " + str(score[3]) + ")" )
		# Creates a new line for the next one
		LBNames.newline()


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
