extends Node2D

func _ready() -> void:
	offset()

func offset():
	for part in get_children():
		part.offset.x += randi_range(-30,30)
		print(part.offset.x)
