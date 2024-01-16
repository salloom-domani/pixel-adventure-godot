class_name TouchingWallState
extends PlayerState

var coyote_timer = 0

func enter(args = {}):
	player_data.double_jump = false
	player_data.flip_on_input = false
	coyote_timer = 0
	if not current_state:
		set_state("wall_slide")
	else:
		current_state.enter(args)

func exit():
	super.exit()
	player_data.double_jump = true
	player_data.flip_on_input = true
	

func phy_update(delta):
	var wall_side = character.get_wall_normal().x
	var input = Input.get_axis("left", "right")
	var jump = Input.is_action_just_pressed("jump")
	if input == wall_side:
		coyote_timer += delta
		if jump:
			set_state("wall_jump_off")
	else:
		coyote_timer = 0
		if jump:
			set_state("wall_jump")

	if coyote_timer > player_data.COYOTE_TIME + 0.1:
		# so its not too close to the wall and trigger the wall slide again
		character.velocity.x = wall_side * 5
		parent.set_state("in_air")

	check_for_collisions()
	super.phy_update(delta)
	


func check_for_collisions():
	var collision_count = character.get_slide_collision_count()
	for i in collision_count:
		var collision = character.get_slide_collision(i)
		if collision and collision.get_collider() is Box:
			collide_with_box(collision.get_collider())


func collide_with_box(box: Box):
	if box.is_directly_on_top_or_down(
		character.position,
		character.collision_shape.shape.extents.x,
		):
		box.hit()
		if character.position.y < box.position.y:
			parent.set_state("in_air/jump", {"jump_speed": box.jump_speed })



func _init() -> void:
	id = "touching_wall"
