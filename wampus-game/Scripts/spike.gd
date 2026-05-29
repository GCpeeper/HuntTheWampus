extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if "coins" in body:
		body.coins -= 1
