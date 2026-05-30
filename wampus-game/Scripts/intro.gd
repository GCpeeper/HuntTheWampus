extends CanvasLayer


# After the cutscene you go to main menu
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

# For skipping with shift
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("open store"):
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
