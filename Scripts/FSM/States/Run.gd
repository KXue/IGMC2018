extends "res://Scripts/FSM/States/OnGround.gd"

export (float) var MAX_SPEED = 250
export (float) var ACCELERATION = 1000
export (float) var DECELERATION = 750

func enter():
	.enter()
	owner.get_node("AnimationPlayer").play("Running")


func interrupt(event):
	return .interrupt(event)

func update(delta):
	var input_direction = get_input_direction()
	velocity = base_horizontal_movement(velocity, input_direction, ACCELERATION, DECELERATION, delta)
	velocity.x = clamp(velocity.x, -MAX_SPEED, MAX_SPEED)
	.update(delta)
	update_look_direction(input_direction)
	if velocity.x == 0 and input_direction.x == 0:
		emit_signal("finished", "idle")