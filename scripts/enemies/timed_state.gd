@tool
class_name TimedState
extends StateAnimation

@export var times = 1
@export var next_state: String
@export var event_on_frame = 0
@export var delay = 0.0

signal event

var current_times

func enter(args = {}):
	super.enter(args)
	current_times = times
	animated_sprite.frame_changed.connect(on_frame_changed)
	animated_sprite.animation_finished.connect(on_animation_finished)


func on_frame_changed():
	if animated_sprite.frame == event_on_frame:
		event.emit()

func on_animation_finished():
	current_times -= 1
	if current_times <= 0:
		parent.set_state(next_state)
		return
	if delay > 0:
		await get_tree().create_timer(delay).timeout
	animated_sprite.play(animation)



func exit():
	super.exit()
	animated_sprite.frame_changed.disconnect(on_frame_changed)	
	animated_sprite.animation_finished.disconnect(on_animation_finished)
