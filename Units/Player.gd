extends KinematicBody2D
var velocity = Vector2()
var floor_bounce = false
#func _physics_process(delta):
#	print(is_on_floor())
#	if is_on_floor() != floor_bounce:
#		print("changed")
#		print(velocity)
#		print(position)
#	floor_bounce = is_on_floor()
#	print(velocity)