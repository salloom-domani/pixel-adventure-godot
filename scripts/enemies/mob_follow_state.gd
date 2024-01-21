@tool
class_name MobFollowState
extends StateAnimation

@onready var dust_move_particles = %DustMoveParticles
@onready var vision: Vision = %Vision

@export var speed = 150


func enter(args = {}):
	super.enter(args)
	dust_move_particles.emitting = true


func phy_update(delta):
	if not vision.can_move() or not parent.target:
		parent.set_state("wait")
	else:
		parent.follow_target_direction()
		character.velocity.x = speed * character.direction


func exit():
	super.exit()
	dust_move_particles.emitting = false

func _init():
	id = "follow"





