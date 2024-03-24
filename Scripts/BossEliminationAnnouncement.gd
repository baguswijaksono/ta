extends Node2D

func _ready():
	$AnimationPlayer.play("Fadein")
	yield($AnimationPlayer, "animation_finished")
	$AnimationPlayer.play("Announcement")
	yield($AnimationPlayer, "animation_finished")
	$AnimationPlayer.play("Fadeout")
