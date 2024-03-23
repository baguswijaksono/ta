extends Area2D

func _on_HiddenArea_body_entered(body):
	if body.name == "Player":
		$AnimationPlayer.play("Revealed")

func _on_HiddenArea_body_exited(body):
	if body.name == "Player":
		$AnimationPlayer.play("Hided")
