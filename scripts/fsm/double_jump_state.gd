@tool
class_name DoubleJumpState
extends PlayerStateAnimation

@onready var dust_jump_particles: CPUParticles2D = %DustJumpParticles

func enter(args = {}):
	super.enter(args)
	#print("entering double jump state")
	dust_jump_particles.restart()
	character.velocity.y = player_data.JUMP_SPEED
	player_data.double_jump = false


func phy_update(_delta):
	if character.velocity.y > 0:
		parent.set_state("fall")




func _init() -> void:
	id = "double_jump"
