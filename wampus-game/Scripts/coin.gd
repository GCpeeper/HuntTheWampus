extends Area2D

# This is pretty self explanatory
func _on_body_entered(body: Node2D) -> void:
	if "coins" in body:
		#print("coin collected")
		body.coins += 1
		body.coin() # Sound
		queue_free()
