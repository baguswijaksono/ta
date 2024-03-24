extends Control

func _ready():
	$VBoxContainer/Start.grab_focus()
	
func _on_Start_pressed():
	if get_tree().change_scene("res://Prefabs/Node2D.tscn") != OK:
		print ("An unexpected error occured when trying to switch to the scene")
		
func _on_Option_pressed():
	if get_tree().change_scene("res://Scene/Option.tscn") != OK:
		print ("An unexpected error occured when trying to switch to the scene")

func _on_Quit_pressed():
	get_tree().quit()


