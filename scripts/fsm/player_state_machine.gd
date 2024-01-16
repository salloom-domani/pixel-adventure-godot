class_name PlayerStateMachine
extends PlayerState


@onready var label: Label = $"../Label"
@onready var higher: RayCast2D = %Higher
@onready var lower: RayCast2D = %Lower
@onready var wall_right: ShapeCast2D = %WallRight
@onready var wall_left: ShapeCast2D = %WallLeft


func awake():
	state_machine = $"."
	character = $".."
	animator = $"../Animator"
	player_data = $"../PlayerData"
	collision_shape = $"../CollisionShape2D"

func ready():
	set_state("in_air/fall")


func flip_for_input(input):
	if input:
		character.scale = Vector2(input, 1)
		character.rotation = 0

func flip():
	character.apply_scale(Vector2(-1, 1))


func _ready() -> void:
	start()


func _process(delta):
	var input = Input.get_axis("left", "right")
	if player_data.flip_on_input: flip_for_input(input)
	update(delta)


func _physics_process(delta: float) -> void:
	phy_update(delta)
	var collision = character.get_last_slide_collision()
	if collision and collision.get_collider().is_in_group("spike"):
		set_state("dead", {"direction": collision.get_normal()})
	
	if wall_left.get_collision_count() > 0 \
	and wall_right.get_collision_count() > 0:
		check_if_squashed()

func check_if_squashed():
	var wall_left_collider = wall_left.get_collider(0)
	var wall_right_collider = wall_right.get_collider(0)
	if wall_left_collider and wall_right_collider:
		var wall_left_type = get_wall_type(wall_left)
		var wall_right_type = get_wall_type(wall_right)
		if wall_left_type != "platform" and wall_right_type != "platform":
			print(wall_left_type, wall_right_type)
			print(wall_left_collider, wall_right_collider)
			set_state("dead", {"direction": Vector2.UP})


func get_wall_type(shapecast: ShapeCast2D):
	var collider = shapecast.get_collider(0)
	if collider is TileMap:
		var tile_map = collider as TileMap
		var collision_point = shapecast.get_collision_point(0)
		var local_collision_point = tile_map.local_to_map(collision_point)
		var cell_tile_data = tile_map.get_cell_tile_data(0, local_collision_point)
		return cell_tile_data.get_custom_data("type") if cell_tile_data else null
	elif collider is FallingPlatform \
		or collider is TriggerPlatform \
		or collider is MovingPlatform \
		or collider is Platform:
		return "platform"


func _on_state_changed(state_id: String) -> void:
	label.text = state_id
