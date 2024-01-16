class_name WallSlideState
extends PlayerState

@onready var wall_right: ShapeCast2D = %WallRight
@onready var wall_left: ShapeCast2D = %WallLeft

func exit():
	super.exit()
	player_data.flip_on_input = true


func phy_update(_delta):
	var input = Input.get_axis("left", "right")
	var wall_side = character.get_wall_normal().x
	
	if character.velocity.y > 0:
		if input == wall_side:
			character.velocity.y = player_data.WALL_SLIDE / 2
		else:
			character.velocity.y = player_data.WALL_SLIDE
		apply_wall_friction()
	if not character.is_on_wall():
		if character.is_on_floor():
			parent.parent.set_state("grounded")
		else:
			parent.parent.set_state("in_air")


func step_one(num: float):
	return 1 if num != 0 else 0

func apply_wall_friction():
	var tile_map = null
	var collision_point = null
	# FIXME: error when no collider 
	if wall_right.get_collision_count() > 0:
		tile_map = wall_right.get_collider(0)
		collision_point = wall_right.get_collision_point(0)
	elif wall_left.get_collision_count() > 0:
		wall_left.get_collider(0)
		collision_point = wall_left.get_collision_point(0)
	if tile_map and tile_map is TileMap:
		var local_collision_point = tile_map.local_to_map(collision_point)
		var tile_cell = tile_map.get_cell_tile_data(0, local_collision_point)
		var friction = 0 if not tile_cell else tile_cell.get_custom_data("friction")
		character.velocity.y -= character.velocity.y * friction


func _init() -> void:
	id = "wall_slide"
