extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var velocity = Vector2()
const UP = Vector2(0, -1)
export var run_speed = 60
export var jump_speed = 250
export var gravity = 500
export var fall_gravity_multiplier = 1.5

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _physics_process(delta):	
	velocity.x = 0;
	if Input.is_action_pressed("ui_left"):
		velocity.x = -1
	elif Input.is_action_pressed("ui_right"):
		velocity.x = 1
	velocity.x *= run_speed

	if Input.is_action_pressed("ui_up") and is_on_floor():
		velocity.y -= jump_speed
	else:
		var actual_gravity = gravity
		if velocity.y > 0:
			actual_gravity *= fall_gravity_multiplier
		velocity.y += actual_gravity * delta
	
	velocity = move_and_slide(velocity, UP)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
