@tool
class_name GroundedMoveState
extends StateAnimation

#@onready var dust_move_particles = %DustMoveParticles
@onready var vision: Vision = %Vision

@export var speed = 50


func enter(args = {}):
	super.enter(args)
	#dust_move_particles.emitting = true


func phy_update(delta):
	if not vision.can_move():
		parent.set_state("idle", {"change_direction": true})
	else:
		character.velocity.x = speed * character.direction


func exit():
	super.exit()
	#dust_move_particles.emitting = false

func _init():
	id = "move"
