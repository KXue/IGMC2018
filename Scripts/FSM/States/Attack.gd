extends "res://Scripts/FSM/States/PlayableStates.gd"

func update(delta):
	print("Attack")
	emit_signal("finished", "previous")
	pass