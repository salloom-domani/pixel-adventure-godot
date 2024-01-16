extends CharacterBody2D

@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var state_machine: PlayerStateMachine = $PlayerStateMachine
@onready var checks: Node2D = %Checks


signal body_entered(body: Node, collision: KinematicCollision2D)
signal body_exited(body: Node)

var colliding_bodies := {}


func die(direction: Vector2):
	state_machine.set_state("dead", {"direction": direction})


func disable_checks():
	for child in checks.get_children():
		child.collision_mask = 0


func _physics_process(_delta: float) -> void:
	move_and_slide()
	check_for_collisions()


func check_for_collisions():
	var new_colliding_bodies := {}
	var collision_count = get_slide_collision_count()
	for i in collision_count:
		var collision = get_slide_collision(i)
		var body = collision.get_collider()
		if not is_instance_valid(body):
			continue
		new_colliding_bodies[body] = body
		if not colliding_bodies.has(body):
			body_entered.emit(body, collision)
	
	for body in colliding_bodies.keys():
		if not new_colliding_bodies.has(body):
			body_exited.emit(body)
		
	colliding_bodies = new_colliding_bodies


func _on_body_entered(body: Node, collision: KinematicCollision2D) -> void:
	#print(body.name, " has entered")
	if body.name == "Platform":
		body.get_parent().turn_on()
	if body.is_in_group("fire"):
		var pos = collision.get_position()
		if is_equal_approx(pos.x, body.position.x) or is_equal_approx(pos.y, body.position.y):
			body.hit()
	if body is FallingPlatform:
		body.hit()


func _on_body_exited(body: Node) -> void:
	#print(body.name, " has exited")
	if body.name == "Platform":
		body.get_parent().turn_off()
	
