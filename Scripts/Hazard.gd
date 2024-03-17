extends Area2D

func _on_Hazard_body_entered(body):
	if body.has_method("hurt"):
		body.hurt()
