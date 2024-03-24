extends KinematicBody2D

var speed = 40
var velocity = Vector2.ZERO
var direction = Vector2.RIGHT
var gravity = 500 

var coinScene = preload("res://Prefabs/Coin.tscn")

var lives = 3

func _ready():
	var _pathdetector = $pathDetector.connect("area_entered", self ,"onPathEntered")

func _process(delta):
	velocity.x = direction.x * speed
	if lives <= 0:
		velocity = Vector2.ZERO
	velocity.y += gravity + delta
	velocity = move_and_slide(velocity,Vector2.UP)
	$Sprite.flip_h = true if direction.x < 0 else false

func onPathEntered(_area2d):
	direction *= -1

func _on_hitBox_body_entered(body):
	if body.has_method("hurt"):
		body.hurt()
		
#hurting enemy
func _on_hitBox_area_entered(area):
	if area.is_in_group("Sword"):
		#$AnimationPlayer.play("hurt) 
		#yield(get_node("AnimationPlayer"), "animation_finished")
		#$AnimationPlayer.play("run")
		lives -= 1
		if lives <= 0:
			#$AnimationPlayer.play("dead) 
			#yield(get_node("AnimationPlayer"), "animation_finished")
			onDestroyed()
			queue_free()

func onDestroyed():
	var coin = coinScene.instance()
	coin.global_position = global_position
	get_tree().get_root().add_child(coin) # error
