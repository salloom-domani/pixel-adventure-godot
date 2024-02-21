class_name InAirState
extends PlayerState

@onready var box_detector: Area2D = %BoxDetector

func enter(args = {}):
	super.enter(args)
	if not current_state:
		set_state("fall")
	else:
		current_state.enter(args)


func phy_update(delta): 
	if character.is_on_floor():
		parent.set_state("grounded/land")
	if character.is_on_wall() and character.velocity.y > 0:
		parent.set_state("touching_wall")
	if Input.is_action_just_pressed("jump") and player_data.double_jump:
		set_state("double_jump")
	
	
	var input = Input.get_axis("left", "right")
	
	character.velocity.x = input * player_data.IN_AIR_SPEED
	
	if character.velocity.y > 0:
		character.velocity.y += player_data.INTENSE_GRAVITY * delta
	else:
		character.velocity.y += player_data.GRAVITY * delta
	
	check_for_collisions()
	super.phy_update(delta)
	


func check_for_collisions():
	var collision_count = character.get_slide_collision_count()
	for i in collision_count:
		var collision = character.get_slide_collision(i)
		
		if collision and collision.get_collider() is Box:
			for box in box_detector.get_collided_boxes():
				collide_with_box(box)


func collide_with_box(box: Box):
	if box.is_directly_on_top_or_down(
		character.position,
		character.collision_shape.shape.extents.x,
		):
		box.hit()
		if character.position.y < box.position.y:
			set_state("jump", {"jump_speed": box.jump_speed })



func _init() -> void:
	id = "in_air"
