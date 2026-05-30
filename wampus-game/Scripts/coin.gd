# Coins, can be used to buy stuff in the store and the amount you have left determines your score
extends Area2D

# This is pretty self explanatory
func _on_body_entered(body: Node2D) -> void:
	if "coins" in body:
		#print("coin collected")
		body.coins += 1
		body.coin() # Sound
		queue_free()
