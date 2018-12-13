extends "res://Scripts/FSM/States/PlayableStates.gd"

export(float) var JUMP_SPEED = 300
export(float) var MAX_FALL_SPEED = 1000
export(float) var JUMP_CUTOFF_SPEED = 150
export(float) var FALL_GRAVITY_MULTIPLIER = 1.25

export(float) var MAX_GROUND_SPEED = 250
export(float) var GROUND_ACCELERATION = 1000
export(float) var GROUND_DECELERATION = 750

var falling = false
var animation_player

func _ready():
	animation_player = owner.get_node("AnimationPlayer")

func initialize(falling):
	self.falling = falling

func enter():
	if not falling:
		self.velocity.x = owner.velocity.x
		self.velocity.y = -JUMP_SPEED
		animation_player.play("Jump")
	else:
		self.velocity = owner.velocity
		animation_player.play("Fall")
	pass

func calculate_fall_velocity(delta):
	if not Input.is_action_pressed("jump") and velocity.y > -JUMP_CUTOFF_SPEED and velocity.y < 0:
		velocity.y = 0
	var adjusted_gravity = GRAVITY * (FALL_GRAVITY_MULTIPLIER if velocity.y > 0 else 1) * delta
	velocity.y += adjusted_gravity
	velocity.y = min(velocity.y, MAX_FALL_SPEED)
	

func update(delta):
	var direction = get_input_direction()
	velocity = base_horizontal_movement(velocity, direction, GROUND_ACCELERATION, GROUND_DECELERATION, delta)
	velocity.x = clamp(velocity.x, -MAX_GROUND_SPEED, MAX_GROUND_SPEED)

	calculate_fall_velocity(delta)
	
	.update(delta)
	update_look_direction(direction)
	
	if velocity.y >= 0 && animation_player.assigned_animation == "Jump":
		animation_player.play("Fall")
	if owner.is_on_floor():
		if velocity.x != 0 or direction.x != 0:
			emit_signal("finished", "run")
		else:
			emit_signal("finished", "idle")