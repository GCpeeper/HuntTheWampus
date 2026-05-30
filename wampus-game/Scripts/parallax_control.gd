extends Node2D

func _ready() -> void:
	offset()

# Offsets the parallax background to make it seem like you've moved
func offset():
	for part in get_children():
		part.offset.x += randi_range(-20,20)
		#print(part.offset.x)
