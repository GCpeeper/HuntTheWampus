extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if "has_sword" in body:
		if !body.has_sword:
			body.has_sword = true
			print("got sword")
			get_parent().get_parent().remove_sword()
			queue_free()
