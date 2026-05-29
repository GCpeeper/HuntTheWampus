extends CenterContainer


func _on_new_game_pressed() -> void:
	$LineEdit.visible = true
	$VBoxContainer.visible = false


func _on_high_scores_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/leaderboard.tscn")


func _on_line_edit_text_submitted(new_text: String) -> void:
	Global.username = new_text
	get_tree().change_scene_to_file("res://Scenes/map.tscn")
