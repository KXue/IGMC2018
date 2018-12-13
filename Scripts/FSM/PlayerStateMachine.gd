extends "res://Scripts/FSM/StateMachine.gd"

func _ready():
	states_map = {"idle": $Idle,
		"run": $Run,
		"jump": $Jump,
		"stagger": $Stagger,
		"attack": $Attack}

func _change_state(state_name):
	if not _active:
		return
	if state_name == "jump":
		$Jump.initialize(false)
	elif state_name == "fall":
		state_name = "jump"
		$Jump.initialize(true)
	if state_name in ["stagger", "attack"]:
		states_stack.push_front(states_map[state_name])
	._change_state(state_name)