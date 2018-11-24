extends Area2D

export (float) var max_distance = 64
export (float) var speed = 64
export (Vector2) var direction = Vector2(1, 1)

signal end_reached(object_hit)

func _ready():
	direction = direction.normalized()
	look_at(position + direction)
	pass

func _physics_process(delta):
	var velocity = direction * speed * delta
	translate(velocity)

