extends CanvasLayer



func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

# For skipping
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("open store"):
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
