extends Button

func _unhandled_input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		$"../GUI/ColorRect".show()
		get_tree().paused =true

func _on_Resume_pressed():
	get_tree().paused =false
