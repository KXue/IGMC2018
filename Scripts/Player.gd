extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var velocity = Vector2()

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _physics_process(delta):
	if(Input.is_action_pressed("ui_right")):
		velocity.x = 30
	elif(Input.is_action_pressed("ui_left")):
		velocity.x = -30
	else:
		velocity.x = 0

	if(Input.is_action_pressed("ui_up")):
		velocity.y = -30
	elif(Input.is_action_pressed("ui_down")):
		velocity.y = 30
	else:
		velocity.y = 0
		
	move_and_slide(velocity)
	pass
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
