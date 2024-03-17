extends KinematicBody2D

var velocity = Vector2.ZERO
var speed = 250
var maxSpeed = 500
var jump = 150
var gravity = 300
var lives = 3
var canSlash = false
var coinNumber = 0

export (PackedScene) var hurtScene

var dashLength = 0.3  
var dashSpeed = 300  
var isDashing = false

func _process(delta):
	var movement = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	if movement != 0 && canSlash == false:
		velocity.x += movement * speed * delta
		$anim.flip_h = movement < 0
		if $anim.flip_h == true:
			$Sword.position.x = -8
		elif $anim.flip_h == false:
			$Sword.position.x = 8
		$anim.play("Walk")
	elif velocity.x == 0 && velocity.y < 0 && canSlash == false:
		$anim.play("Jump")
	elif velocity.x == 0 && velocity.y > 30 && canSlash == false:
		$anim.play("Fall")
	elif movement == 0 && canSlash == false:
		velocity.x = 0
		$anim.play("Idle")
	
	if velocity.y > 350 :
		var _result = get_tree().reload_current_scene()
		
	if is_on_floor() && Input.is_action_just_pressed("ui_accept") && canSlash == false:
		velocity.y -= jump
		$anim.play("Idle")
	elif velocity.y < 0 && velocity.x != 0 && canSlash == false:
		$anim.play("Jump")
	elif velocity.y > 30 && velocity.x != 0 && canSlash == false:
		$anim.play("Fall")
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	
	if Input.is_action_just_pressed("ui_sword"):
		attack()
	if Input.is_action_just_pressed("ui_dash") && !isDashing:
		dash()

func dash():
	isDashing = true
	if $anim.flip_h:
		velocity.x = -dashSpeed
	else:
		velocity.x = dashSpeed
	#$anim.play("Dash")
	yield(get_tree().create_timer(dashLength), "timeout")
	isDashing = false
	velocity.x = 0
	
func hurt():
	lives -= 1
	var red = hurtScene.instance()
	add_child(red)
	print("player has enter", lives)
	if lives <= 0:
		var _result = get_tree().reload_current_scene()
	if velocity.x >= 0:
		velocity.y = -73
		velocity.x = -53
	elif velocity.x <=0:
		velocity.y = -73
		velocity.x = 53

func attack():
	$Sword/CollisionShape2D.disabled = false
	canSlash = true
	$anim.play("Sword")
	if is_on_floor() && canSlash == true:
		$anim.play("Sword")
	elif velocity.y < 0 && velocity.x !=0 && canSlash == true:
		$anim.play("Sword")
	elif velocity.y > 0 && velocity.x !=0 && canSlash == true:
		$anim.play("Sword")

func coinPickup():
	coinNumber += 1
	print(coinNumber)

func brust():
	pass

func pogo():
	pass
func _on_anim_animation_finished():
	if $anim.animation == "Sword":
		canSlash = false
		$Sword/CollisionShape2D.disabled = true
