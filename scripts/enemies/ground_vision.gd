class_name GroundVision
extends Vision


@onready var wall_check = $WallCheck
@onready var ground_check = $GroundCheck


func can_move() -> bool:
	return not wall_check.is_colliding() and ground_check.is_colliding()

func hit_wall():
	var hit_point = wall_check.get_collision_point()
	var origin = wall_check.global_transform.origin
	var distance = origin.distance_to(hit_point)
	return wall_check.is_colliding() and distance < 16
