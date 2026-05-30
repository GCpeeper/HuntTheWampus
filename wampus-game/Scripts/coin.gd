extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if "coins" in body:
		#print("coin collected")
		body.coins += 1
		queue_free()
