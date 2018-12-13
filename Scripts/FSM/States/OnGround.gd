extends "res://Scripts/FSM/States/PlayableStates.gd"

func enter():
	.enter()

func interrupt(event):
	if event.is_action_pressed("jump"):
		emit_signal("finished", "jump")
	elif event.is_action_pressed("attack"):
		emit_signal("finished", "ground_attack")

func update(delta):
	velocity.y += GRAVITY * delta
	.update(delta)
	if not owner.is_on_floor():
		print(velocity.y)
		emit_signal("finished", "fall")