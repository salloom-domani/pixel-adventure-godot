class_name Snail
extends Mob

@onready var dead_body_particle = %DeadBodyParticle
@onready var animator = %Animator
@onready var collision_shape_2d = %CollisionShape2D


func actually_die():
	pass


func die(hit_dir: Vector2):
	Global.camera_shaked.emit()
	match state_machine.current_state.id:
		"shell_idle":
			should_bogo_jump = false
			update_collisions_to_roll_state()
			state_machine.set_state("roll", {"direction": hit_dir})
		"roll":
			should_bogo_jump = true
			state_machine.set_state("dead", {"direction": hit_dir * -1})
		_:
			animator.play("hit")
			update_collisions_to_shell_shape()
			#state_machine.set_state("shell_idle")


func update_collisions_to_shell_shape():
	# Push Box
	var push_box_shape = RectangleShape2D.new()
	push_box_shape.extents.x = 12
	push_box_shape.extents.y = 10
	collision_shape_2d.set_deferred("shape", push_box_shape)
	collision_shape_2d.set_deferred("position", Vector2(collision_shape_2d.position.x, 2))
	
	# Hit Box
	var hit_box_shape = RectangleShape2D.new()
	hit_box_shape.extents.x = 12
	hit_box_shape.extents.y = 7
	hit_box_collision.position.x = 0
	hit_box_collision.position.y = 5
	hit_box_collision.set_deferred("shape", hit_box_shape)
	hit_box_collision.set_deferred("disabled", true)
	
	# Hurt Box
	var hurt_box_shape = RectangleShape2D.new()
	hurt_box_shape.extents.x = 12
	hurt_box_shape.extents.y = 10
	hurt_box_collision.position.x = 0
	hurt_box_collision.position.y = 2
	hurt_box_collision.set_deferred("shape", hurt_box_shape) 


func update_collisions_to_roll_state():
	hurt_box_collision.shape.extents.x = 12
	hurt_box_collision.shape.extents.y = 3
	hurt_box_collision.position.x = 0
	hurt_box_collision.position.y = -5
	#hurt_box_collision.set_deferred("shape", hurt_box_shape)
	
	await get_tree().create_timer(0.5).timeout
	hit_box_collision.set_deferred("disabled", false)


func _on_shell_idle_state_state_entered():
	velocity.x = 0


func _on_animator_animation_finished():
	if animator.animation == "hit":
		dead_body_particle.restart()
		state_machine.set_state("shell_idle")
