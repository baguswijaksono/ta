extends Area2D

onready var player = get_node("../Player")

func _on_Spring_body_entered(body):
	if body.name == "Player":
		body.velocity.y -= 300
		#$AnimationPlayer.play("Active")
		#yield(get_node("AnimationPlayer"),"animation_finished")
		#$AnimationPlayer.play("Idle")
