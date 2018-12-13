extends "res://Scripts/FSM/States/OnGround.gd"

func enter():
	.enter()
	owner.get_node("AnimationPlayer").play("Idle")

func interrupt(event):
	return .interrupt(event)

func update(delta):
	.update(delta)
	if velocity.x != 0 or get_input_direction().x != 0:
		emit_signal("finished", "run")