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

export (int) var run_speed = 200
export (int) var jump_speed = 300
export (int) var jump_cutoff = 150
export (int) var gravity = 600
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
		$Sprite.flip_h = true
		if $AnimationPlayer.current_animation != "Running":
			$AnimationPlayer.play("Running")
	elif Input.is_action_pressed("ui_right"):
		velocity.x = 1
		$Sprite.flip_h = false
		state = player_state.RUNNING
		if $AnimationPlayer.current_animation != "Running":
			$AnimationPlayer.play("Running")
	elif is_on_floor() and $AnimationPlayer.current_animation != "Attack":
		state = player_state.IDLE
		$AnimationPlayer.play("Idle")
	
	velocity.x *= run_speed

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = -jump_speed
	else:
		if velocity.y < 0 and velocity.y > -jump_cutoff and not Input.is_action_pressed("ui_accept"):
			velocity.y = 0
		var actual_gravity = gravity
		if velocity.y > 0:
			actual_gravity *= fall_gravity_multiplier
		velocity.y += actual_gravity * delta
	
	if not is_on_floor():
		if velocity.y < 0:
			$AnimationPlayer.play("Jump")	
		else:
			$AnimationPlayer.play("Fall")
	
	if Input.is_action_just_pressed("ui_down"):
		$AnimationPlayer.play("Attack")
	
	velocity = move_and_slide(velocity, UP)
	
func throw_whip():
	
	pass
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
