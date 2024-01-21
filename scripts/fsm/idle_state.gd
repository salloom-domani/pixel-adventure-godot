@tool
class_name IdleState
extends PlayerStateAnimation

@onready var ground: RayCast2D = %Ground

var active_cell_tile = null

func phy_update(_delta):
	set_active_ground_cell()
	var input = Input.get_axis("left", "right")
	if input and (not active_cell_tile or active_cell_tile.get_custom_data("type") != "mud"):
		parent.set_state("move")
	apply_ground_friction()

func step(num: float):
	return 0 if num == 0 else 1
	


func set_active_ground_cell():
	var tile_map = ground.get_collider()
	if tile_map and tile_map is TileMap:
		var collision_point = ground.get_collision_point()
		var local_collision_point = tile_map.local_to_map(collision_point)
		active_cell_tile = tile_map.get_cell_tile_data(0, local_collision_point)
	else:
		active_cell_tile = null

func apply_ground_friction():
	if active_cell_tile:
		var friction = active_cell_tile.get_custom_data("friction")
		character.velocity.x -= character.velocity.x * step(friction)
	else:
		character.velocity.x -= character.velocity.x * step(0.1)


func _init() -> void:
	id = "idle"
