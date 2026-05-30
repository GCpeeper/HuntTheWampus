# Here you can start the game, go to the leaderboard, save scores, or load scores
extends CenterContainer

func _ready() -> void:
	Global._loadScores()

# Starting a game
func _on_new_game_pressed() -> void:
	$LineEdit.visible = true
	$VBoxContainer.visible = false

# Going to the leaderboard
func _on_high_scores_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/leaderboard.tscn")

# Starting the game (for real this time)
func _on_line_edit_text_submitted(new_text: String) -> void:
	Global.username = new_text
	get_tree().change_scene_to_file("res://Scenes/map.tscn")


func _on_load_game_pressed() -> void:
	Global._loadScores()

func _on_save_game_pressed() -> void:
	Global._saveScores()
