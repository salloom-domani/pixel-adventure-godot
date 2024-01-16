class_name GroundedState
extends PlayerState

@onready var ground: RayCast2D = %Ground


func enter(args = {}):
	player_data.double_jump = true
	if not current_state:
		if character.velocity.x != 0:
			set_state("move")
		else:
			set_state("idle")
	else:
		current_state.enter(args)


func phy_update(delta):
	if Input.is_action_just_pressed("jump"):
		parent.set_state("in_air/jump", {"emit_particles": true})
	
	if not character.is_on_floor():
		parent.set_state("in_air/coyote")
	
	#apply_ground_friction()
	#check_for_collisions()
	super.phy_update(delta)


#func apply_ground_friction():
	#var tile_map = ground.get_collider()
	#if tile_map:
		#var collision_point = ground.get_collision_point()
		#var local_collision_point = tile_map.local_to_map(collision_point)
		#var friction = tile_map.get_cell_tile_data(0, local_collision_point).get_custom_data("friction")
		#character.velocity.x -= sign(character.velocity.x) * friction * 100

#func check_for_collisions():
	#var collision_count = character.get_slide_collision_count()
	#for i in collision_count:
		#var collision = character.get_slide_collision(i)
		#
		#if collision and collision.get_collider() is TriggerPlatform:
			#collide_with_trigger_platform(collision.get_collider())

#func collide_with_trigger_platform(platform: TriggerPlatform):
	#print("Ive collided with a platfrom")
	

func _init() -> void:
	id = "grounded"
