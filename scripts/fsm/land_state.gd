@tool
class_name LandState
extends PlayerStateAnimation

@onready var box_detector: Area2D = %BoxDetector
@onready var ground = %Ground

@onready var dust_land_particles: CPUParticles2D = %DustLandParticles
@onready var ice_land_particles: CPUParticles2D = %IceLandParticles
@onready var sand_land_particles: CPUParticles2D = %SandLandParticles
@onready var mud_particles: CPUParticles2D = %MudParticles



func enter(args = {}):
	super.enter(args)
	match get_ground_tile_type():
		"ice":
			ice_land_particles.restart()
		"sand":
			sand_land_particles.restart()
		"mud":
			mud_particles.restart()
		_:
			dust_land_particles.restart()


func phy_update(delta):
	var input = Input.get_axis("left", "right")
	
	if input and get_ground_tile_type() != "mud":
		parent.set_state("move")
	else:
		parent.set_state("idle")
	
	#check_for_collisions()
	super.phy_update(delta)


func get_ground_tile_type():
	var tile_map = ground.get_collider()
	if tile_map and tile_map is TileMap:
		var collision_point = ground.get_collision_point()
		var local_collision_point = tile_map.local_to_map(collision_point)
		var cell_tile_data = tile_map.get_cell_tile_data(0, local_collision_point)
		return cell_tile_data.get_custom_data("type")

# TODO: should I consider leaving this logic here
func check_for_collisions():
	var collision = character.get_last_slide_collision()
	if collision:
		if collision.get_collider() is Box:
			for box in box_detector.get_collided_boxes():
				collide_with_box(box)


func collide_with_box(box: Box):
	if box.is_directly_on_top_or_down(
		character.position,
		character.collision_shape.shape.extents.x,
		):
		box.hit()
		if character.position.y < box.position.y:
			parent.parent.set_state("in_air/jump", {"jump_speed": box.jump_speed })


func _init() -> void:
	id = "land"
