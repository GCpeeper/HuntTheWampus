extends Area2D


func _on_body_entered(body: Node2D) -> void:
	body.has_sword = true
	print("got sword")
	queue_free()
