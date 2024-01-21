@tool
class_name MobWaitState
extends StateAnimation


@onready var vision = %Vision

func enter(args = {}):
	super.enter(args)
	character.velocity.x = 0


func phy_update(delta):
	if parent.target:
		parent.follow_target_direction()
		if vision.can_move():
			parent.set_state("follow")

func _init():
	id = "wait"



