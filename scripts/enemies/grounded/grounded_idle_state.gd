@tool
class_name GroundedIdleState
extends StateAnimation


@onready var mob_state_machine = $".."

@export var idle_time = 1.0

var change_direction = false

func enter(args = {}):
	super.enter(args)
	character.velocity.x = 0
	change_direction = true if args.has("change_direction") else false
	add_default_timer(idle_time, _on_timer_timout)


func _on_timer_timout():
	if change_direction:
		character.flip()
		character.direction *= -1
	parent.set_state("move")


func exit():
	super.exit()
	del_timers()


func _init():
	id = "idle"
