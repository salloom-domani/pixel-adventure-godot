@tool
class_name RandomTimedState
extends StateAnimation


@export var from_times = 1
@export var to_times = 1
@export var next_state: String

signal event

var current_times

func enter(args = {}):
	super.enter(args)
	current_times = randi_range(from_times, to_times)
	animated_sprite.animation_finished.connect(on_animation_finished)


func on_animation_finished():
	current_times -= 1
	if current_times <= 0:
		parent.set_state(next_state)
		return
	animated_sprite.play(animation)



func exit():
	super.exit()
	animated_sprite.animation_finished.disconnect(on_animation_finished)

