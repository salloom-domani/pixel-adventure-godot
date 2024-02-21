@tool
class_name JumpState
extends PlayerStateAnimation


@onready var ground = %Ground

@onready var dust_jump_particles: CPUParticles2D = %DustJumpParticles
@onready var ice_jump_particles: CPUParticles2D = %IceJumpParticles
@onready var sand_jump_particles: CPUParticles2D = %SandJumpParticles
@onready var mud_particles: CPUParticles2D = %MudParticles

func enter(args = {}):
	super.enter(args)
	var emit_particles: bool = args.has("emit_particles")
	if emit_particles:
		match get_ground_tile_type():
			"ice":
				ice_jump_particles.restart()
			"sand":
				sand_jump_particles.restart()
			"mud":
				mud_particles.restart()
			_:
				dust_jump_particles.restart()
	var jump_speed = args["jump_speed"] if args.has("jump_speed") else player_data.JUMP_SPEED
	
	#await get_tree().create_timer(.02).timeout
	character.velocity.y = jump_speed
	

func get_ground_tile_type():
	var tile_map = ground.get_collider()
	if tile_map and tile_map is TileMap:
		var collision_point = ground.get_collision_point()
		var local_collision_point = tile_map.local_to_map(collision_point)
		var cell_tile_data = tile_map.get_cell_tile_data(0, local_collision_point)
		return cell_tile_data.get_custom_data("type")

func phy_update(_delta):
	#print(character.velocity.y)
	if character.velocity.y > 0:
		parent.set_state("fall")

func _init() -> void:
	id = "jump"
