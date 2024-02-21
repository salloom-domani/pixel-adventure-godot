extends Vision

@onready var wall_check = $WallCheck

func can_move():
	return wall_check.is_colliding()
