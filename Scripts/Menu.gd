extends Control

func _ready():
	$VBoxContainer/Start.grab_focus()
func _on_Start_pressed():
	get_tree().change_scene("res://Prefabs/Node2D.tscn")

func _on_Option_pressed():
	get_tree().change_scene("res://Prefabs/Node2D.tscn")

func _on_Quit_pressed():
	get_tree().quit()


