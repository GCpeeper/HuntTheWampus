extends Area2D

# Takes away a coin everytime you touch
func _on_body_entered(body: Node2D) -> void:
	if "coins" in body:
		body.coins -= 1
		body._coin_lost_timer.start()
		body._coin_lost.visible = true
