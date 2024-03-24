extends Area2D
#pake input arrow atas
func _process(_delta):
	if Input.is_action_just_pressed("ui_up"):
		var bodies = get_overlapping_bodies()
		for body in bodies:
			if body.name == "Player":
				if get_tree().change_scene("res://Prefabs/TestPlatform.tscn") != OK:
					print ("An unexpected error occured when trying to switch to the scene")

func _on_Gate_body_entered(body):
		if body.name == "Player":
			if get_tree().change_scene("res://Prefabs/TestPlatform.tscn") != OK:
					print ("An unexpected error occured when trying to switch to the scene")

