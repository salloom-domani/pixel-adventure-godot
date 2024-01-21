@tool
class_name WallJumpState
extends PlayerStateAnimation


var wall_jump_timer = 0

func enter(_args = {}):
	animator.animation = "jump"
	state_machine.flip()
	wall_jump_timer = 0
	character.velocity.y = player_data.WALL_JUMP.y
	character.velocity.x = character.get_wall_normal().x * -player_data.WALL_JUMP.x


func phy_update(delta):
	if not character.is_on_wall():
		wall_jump_timer += delta
		if wall_jump_timer > player_data.WALL_JUMP_TIME:
			parent.parent.set_state("in_air")

func _init() -> void:
	id = "wall_jump"
