extends KinematicBody2D

var velocity = Vector2(0, 0)

var jumpTokensMax = 2

var jumpTokens = jumpTokensMax

var jumped = false

const GRAVITY = 20

const GRAVITY_DIRECTION = Vector2.DOWN

const SPEED = 300.0

const JUMP_SPEED = 800.0

func _physics_process(delta):
	
	# Gravity
	velocity = velocity + (GRAVITY * GRAVITY_DIRECTION)
	
	if Input.is_action_pressed("move_left"):
		velocity.x = -SPEED
		$Sprite.flip_h = false;
		if is_on_floor():
			$Sprite.play("Walk")
	elif Input.is_action_pressed("move_right"):
		velocity.x = SPEED
		$Sprite.flip_h = true;
		if is_on_floor():
			$Sprite.play("Walk")
	else:
		if is_on_floor():
			$Sprite.play("Idle")
		
	if is_on_floor():
		jumpTokens = jumpTokensMax
		jumped = false
	elif not jumped:
		jumpTokens -= 1
		jumped = true
		$Sprite.play("Air")
	
	if (Input.is_action_just_pressed("jump") and jumpTokens > 0) or (Input.is_action_pressed("jump") and is_on_floor()):
		velocity.y = -JUMP_SPEED
		jumpTokens -= 1
		jumped = true
		$Sprite.play("Air")
	
	velocity = move_and_slide(velocity, GRAVITY_DIRECTION * -1)

	velocity.x = lerp(velocity.x, 0, 0.1)
