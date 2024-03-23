extends Area2D


func _on_BreakingPlatform_body_entered(body):
	if body.name == "Player":
		yield(get_tree().create_timer(3), "timeout")
		#$AnimationPlayer.play("Destroyed")
		#yield(get_node("AnimationPlayer"), "animation_finished")
		queue_free()
