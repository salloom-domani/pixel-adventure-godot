class_name MoveState
extends PlayerState


@onready var higher: RayCast2D = %Higher
@onready var lower: RayCast2D = %Lower
@onready var ground: RayCast2D = %Ground

@onready var dust_move_particles: CPUParticles2D = %DustMoveParticles
@onready var ice_move_particles: CPUParticles2D = %IceMoveParticles
@onready var sand_move_particles: CPUParticles2D = %SandMoveParticles

var active_cell_tile = null

func phy_update(_delta):
	var input = Input.get_axis("left", "right")
	set_active_ground_cell()
	update_particles(input)
	if input:
		character.velocity.x += input * player_data.ACCELERATION
		if absf(character.velocity.x) > player_data.MAX_SPEED:
			character.velocity.x = sign(character.velocity.x) * player_data.MAX_SPEED
		if lower.get_collider() and not higher.get_collider():
			character.position.y -= 2
			animator.animation = "move"
	else:
		parent.set_state("idle")
	apply_ground_friction()


func turn_off_particles():
	dust_move_particles.emitting = false
	ice_move_particles.emitting = false
	sand_move_particles.emitting = false 

func exit():
	turn_off_particles()

func update_particles(input: int):
	turn_off_particles()
	if not active_cell_tile:
		dust_move_particles.emitting = true
	else:
		match active_cell_tile.get_custom_data("type"):
			"ice":
				ice_move_particles.emitting = true
			"sand":
				sand_move_particles.emitting = true
			_:
				dust_move_particles.emitting = true

func set_active_ground_cell():
	var tile_map = ground.get_collider()
	if tile_map and tile_map is TileMap:
		var collision_point = ground.get_collision_point()
		var local_collision_point = tile_map.local_to_map(collision_point)
		active_cell_tile = tile_map.get_cell_tile_data(0, local_collision_point)
	else:
		active_cell_tile = null

func apply_ground_friction():
	var friction = active_cell_tile.get_custom_data("friction") if active_cell_tile else 0
	character.velocity.x -= character.velocity.x * friction


func _init() -> void:
	id = "move"
