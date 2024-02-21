extends MobStateMachine

@onready var particles = %Particles
@onready var hit_box_collision = %HitBox/CollisionShape2D
@onready var hurt_box_collision = %HurtBox/CollisionShape2D


func _on_idle_state_state_entered():
	hit_box_collision.set_deferred("disabled", false)
	hurt_box_collision.set_deferred("disabled", false)
	particles.emitting = true


func _on_idle_state_state_exited():
	particles.emitting = false
