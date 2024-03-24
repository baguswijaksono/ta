extends KinematicBody2D

var velocity = Vector2.ZERO
var speed = 250
var maxSpeed = 500
var jump = 150
var gravity = 300
var lives = 3
var canSlash = false
var coinNumber = 0
var jumpCount = 0
const FRICTION = 0.70
var WallJump = -40
var ui_up_timer = 0
var ui_up_pressed = false

export (PackedScene) var hurtScene

var dashLength = 0.3  
var dashSpeed = 300  
var isDashing = false

func _process(delta):
	var movement = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	if !nextToWall() && movement != 0 && canSlash == false:
		velocity.x += movement * speed * delta
		velocity.x = clamp(velocity.x, -speed, speed)
		$anim.flip_h = movement < 0
		if $anim.flip_h == true:
			$Sword.position.x = -39
		elif $anim.flip_h == false:
			$Sword.position.x = 8
		$anim.play("Walk")
	elif velocity.x == 0 && velocity.y < 0 && canSlash == false:
		$anim.play("Jump")
	elif velocity.x == 0 && velocity.y > 30 && canSlash == false:
		$anim.play("Fall")
	elif !nextToWall() &&  movement == 0 && canSlash == false:
		velocity.x = lerp(velocity.x , 0 , FRICTION)
		$anim.play("Idle")
	
	if velocity.y > 350 :
		var _result = get_tree().reload_current_scene()
	
	if is_on_floor() && Input.get_action_strength("ui_up"):
		ui_up_timer += delta
		if ui_up_timer > 2:
			$Camera2D.position = Vector2(-257, -173)
	elif is_on_floor() && Input.get_action_strength("ui_down"):
		$Camera2D.position = Vector2(-257, -53)
	else:
		ui_up_timer = 0
		$Camera2D.position = Vector2(-257, -123)
	
	if Input.is_action_just_pressed("ui_up") && Input.is_action_just_pressed("ui_brust") or Input.get_action_strength("ui_up") && Input.is_action_just_pressed("ui_brust"):
		upbrust()
	if Input.is_action_just_pressed("ui_down") && Input.is_action_just_pressed("ui_brust") or Input.get_action_strength("ui_down") && Input.is_action_just_pressed("ui_brust") :
		downbrust()
		
	if is_on_floor() or nextToWall():
		jumpCount = 0
	if Input.is_action_just_pressed("ui_accept") && jumpCount < 2:
		jumpCount += 1
		velocity.y -= clamp(velocity.y , jump ,jump)
	# Wall Jump
	if Input.is_action_just_pressed("ui_accept"):
		if !is_on_floor() && rightWall():
			velocity.y = clamp(velocity.y, WallJump, WallJump)
			velocity.x -= 180
		elif !is_on_floor() && leftWall():
			velocity.y = clamp(velocity.y, WallJump, WallJump)
			velocity.x += 180
	
	# Wall Slide
	if rightWall() && velocity.y > 30:
		$anim.flip_h = true
		velocity.y = 15
		$anim.play("WallSlide")
	if leftWall() && velocity.y > 30:
		$anim.flip_h = false
		velocity.y = 15
		$anim.play("WallSlide")
		
	if Input.is_action_just_pressed("ui_accept") && jumpCount > 2:
		jumpCount = 0
	if !is_on_floor() && Input.is_action_just_pressed("ui_accept") && canSlash == false && jumpCount < 2:
		velocity.y -= clamp(velocity.y , jump ,jump)
		$anim.play("Idle")
	elif !is_on_floor() && velocity.y < 0 && velocity.x != 0 && canSlash == false:
		$anim.play("Jump")
	elif !is_on_floor() && velocity.y > 30 && velocity.x != 0 && canSlash == false:
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

func nextToWall():
	return rightWall() or leftWall()

func rightWall():
	return $RightWall.is_colliding()
	
func leftWall():
	return $LeftWall.is_colliding()
	
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

func upbrust():
	$UpBrust/CollisionShape2D.disabled = false
	yield(get_tree().create_timer(1.0), "timeout")
	$UpBrust/CollisionShape2D.disabled = true
	
func downbrust():
	$DownBrust/CollisionShape2D.disabled = false
	yield(get_tree().create_timer(1.0), "timeout")
	$DownBrust/CollisionShape2D.disabled = false

func pogo():
	pass

func _on_anim_animation_finished():
	if $anim.animation == "Sword":
		canSlash = false
		$Sword/CollisionShape2D.disabled = true
