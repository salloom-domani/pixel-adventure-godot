class_name FlyVision
extends Vision

@onready var wall_check = $WallCheck

func can_move() -> bool:
	return not wall_check.is_colliding()
