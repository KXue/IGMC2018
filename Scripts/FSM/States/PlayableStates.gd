extends "res://Scripts/FSM/State.gd"

export(float) var GRAVITY = 600
var velocity = Vector2()

func enter():
	self.velocity = owner.velocity

func exit():
	owner.velocity = self.velocity

func get_input_direction():
	var direction = Vector2()
	direction.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	direction.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	return direction

func update_look_direction(direction):
	if direction.x < 0:
		owner.get_node("Sprite").flip_h = true
	elif direction.x > 0:
		owner.get_node("Sprite").flip_h = false

func base_horizontal_movement(velocity, direction, acceleration, deceleration, delta):
	if direction.x == 0 and velocity.x != 0:
		velocity.x += sign(velocity.x) * -deceleration * delta
	else:
		velocity.x += direction.x * acceleration * delta
	return velocity
	
func update(delta):
	velocity = owner.move_and_slide(velocity, Global.UP)
#	owner.velocity = velocity