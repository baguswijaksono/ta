extends Node2D

var changing_scene = false

func _ready():
	$AnimationPlayer.connect("animation_finished", self, "_on_animation_finished")
	$AnimationPlayer.play("fadein")

func _on_animation_finished(animation_name):
	if animation_name == "fadein":
		$AnimationPlayer.play("fadeout")
		$AnimationPlayer.connect("animation_finished", self, "_on_fadeout_finished")

func _on_fadeout_finished(animation_name):
	if animation_name == "fadeout":
		change_to_menu_scene()

func change_to_menu_scene():
	if not changing_scene:
		changing_scene = true
		get_tree().change_scene("res://Scene/Menu.tscn")

func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		change_to_menu_scene()
