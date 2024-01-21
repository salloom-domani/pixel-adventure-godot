@tool
class_name GroundVision
extends Vision


@onready var wall_check = $WallCheck
@onready var ground_check = $GroundCheck


func can_move() -> bool:
	return not wall_check.is_colliding() and ground_check.is_colliding()
