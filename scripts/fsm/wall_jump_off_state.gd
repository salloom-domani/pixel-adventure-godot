@tool
class_name WallJumpOffState
extends PlayerStateAnimation

const WALL_JUMP_OFF_FACTOR = 1.5

func enter(_args = {}):
	animator.animation = "jump"
	state_machine.flip()
	character.velocity.y = player_data.JUMP_SPEED
	character.velocity.x = character.get_wall_normal().x * -player_data.WALL_JUMP.x * WALL_JUMP_OFF_FACTOR
	parent.parent.set_state("in_air")

func _init() -> void:
	id = "wall_jump_off"
