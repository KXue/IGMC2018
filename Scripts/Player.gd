extends KinematicBody2D

enum player_state{
	IDLE,
	RUNNING,
	JUMPING,
	FALLING,
	ATTACKING,
	DAMAGED
}

const UP = Vector2(0, -1)
const ATTACK = preload("res://Units/Misc/Fork.tscn")

export (int) var run_speed = 60
export (int) var jump_speed = 250
export (int) var gravity = 500
export (float) var fall_gravity_multiplier = 1.5

var velocity = Vector2()
var state = player_state.IDLE

func _ready():

	pass
func _process(delta):
	
	pass
func _physics_process(delta):	
	velocity.x = 0;
	if Input.is_action_pressed("ui_left"):
		velocity.x = -1
		$AnimatedSprite.play("Run")
		$AnimatedSprite.flip_h = true
	elif Input.is_action_pressed("ui_right"):
		velocity.x = 1
		state = player_state.RUNNING
		$AnimatedSprite.play("Run")
		$AnimatedSprite.flip_h = false
	elif is_on_floor() and $AnimatedSprite.animation != "Attack":
		state = player_state.IDLE
		$AnimatedSprite.play("Idle")
	velocity.x *= run_speed

	if Input.is_action_pressed("ui_accept") and is_on_floor():
		velocity.y -= jump_speed
	else:
		var actual_gravity = gravity
		if velocity.y > 0:
			actual_gravity *= fall_gravity_multiplier
		velocity.y += actual_gravity * delta
	if not is_on_floor():
		if velocity.y < 0:
			$AnimatedSprite.play("Jump")
		else:
			$AnimatedSprite.play("Fall")
	
	if Input.is_action_just_pressed("ui_down"):
		$AnimatedSprite.play("Attack")
	velocity = move_and_slide(velocity, UP)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
