extends Node

signal beat(beat_count, beats_per_bar)

export (int) var bpm = 80
export (int) var beats_per_bar = 4
# note value?
export (bool) var swing = false

var time_per_beat
var beat_count
var timer

func _ready():
	time_per_beat = float(60)/bpm
	timer = time_per_beat
	beat_count = 1

func start():
	set_physics_process(true)
	pass
func stop():
	set_physics_process(false)
	pass
func get_time_to_closest_beat():
	return min(timer, time_per_beat - timer)
func set_bpm(value):
	bpm = value
	time_per_beat = 60/bpm
	timer = min(timer, time_per_beat)
	beat_count = 1
func set_beats_per_bar(value):
	beats_per_bar = value
	beat_count = 1
func _physics_process(delta):
	timer -= delta
	if timer <= 0:
#		print("Beat: " + str(beat_count) + " / " + str(beats_per_bar ))
		emit_signal("beat", beat_count, beats_per_bar)
		timer = time_per_beat
		beat_count = (beat_count % beats_per_bar) + 1

