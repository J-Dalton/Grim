extends Area2D


func _on_body_entered(body):
	if body.name == "Player":
		Game.playerGravity = "water"
		


func _on_body_exited(body):
	if body.name == "Player":
		Game.playerGravity = "normal"
