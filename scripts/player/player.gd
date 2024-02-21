@tool
class_name Player
extends CharacterBody2D

@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var state_machine: PlayerStateMachine = $PlayerStateMachine
@onready var player_data = $PlayerData
@onready var checks: Node2D = %Checks
@onready var hit_box = %HitBox
@onready var hurt_box = %HurtBox
@onready var to_flip = %ToFlip


@export var flip = false:
	get:
		return %ToFlip.scale.x < 0
	set(new_val):
		%ToFlip.scale.x = -1 if new_val else 1

signal body_entered(body: Node, collision: KinematicCollision2D)
signal body_exited(body: Node)

var colliding_bodies := {}

var alive = true


func die(dir: Vector2):
	state_machine.set_state("dead", {"direction": dir})
	alive = false


func disable_checks():
	collision_shape.set_deferred("disabled", true)
	%HitBox/CollisionShape2D.set_deferred("disabled", true)
	%HurtBox/CollisionShape2D.set_deferred("disabled", true)
	for child in checks.get_children():
		child.collision_mask = 0


func bogo_jump(bogo_jump_amount: int):
	player_data.double_jump = true
	state_machine.set_state("in_air/jump", { "jump_speed": bogo_jump_amount })

func _physics_process(_delta: float) -> void:
	move_and_slide()
	check_for_collisions()


func check_for_collisions():
	var new_colliding_bodies := {}
	var collision_count = get_slide_collision_count()
	for i in collision_count:
		var collision = get_slide_collision(i)
		var body = collision.get_collider()
		var rid = collision.get_collider_rid()
		if not is_instance_valid(body):
			continue
		new_colliding_bodies[rid] = body
		if not colliding_bodies.has(rid):
			body_entered.emit(body, collision)
			colliding_bodies[rid] = body
	
	for rid in colliding_bodies.keys():
		if not new_colliding_bodies.has(rid):
			var body = colliding_bodies[rid]
			body_exited.emit(body)
		


func _on_body_entered(body: Node, collision: KinematicCollision2D) -> void:
	#print(body.name, " has entered")
	if body.name == "Platform":
		body.get_parent().turn_on()
	elif body.is_in_group("fire"):
		var pos = collision.get_position()
		if is_equal_approx(pos.x, body.position.x) \
		or is_equal_approx(pos.y, body.position.y):
			body.hit()
	elif body is FallingPlatform:
		body.hit()
	#elif body.is_in_group("mob"):
		#var mob = body
		#if mob is Snail and mob.in_shell_idle_state:
			#mob.die(Vector2.RIGHT * to_flip.scale.x)
			#if mob.is_directly_below(self.position, collision_shape.shape.extents.x):
				#state_machine.set_state("in_air/jump", { "jump_speed": mob.bogo_jump })
		##elif mob.is_directly_below(self.position, collision_shape.shape.extents.x):
		#elif mob.should_die(collision.get_position()):
			#var dir = (position - mob.position as Vector2).normalized()
			#mob.die(dir)
			#state_machine.set_state("in_air/jump", { "jump_speed": mob.bogo_jump })
		#else:
			#self.die(collision.get_normal())
			#if mob.has_signal("target_died"):
				#mob.target_died.emit()
	elif body.is_in_group("bullet"):
		#body.break_it()
		self.die(collision.get_normal())


func _on_body_exited(body: Node) -> void:
	#print(body.name, " has exited")
	if body.name == "Platform":
		body.get_parent().turn_off()
