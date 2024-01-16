extends Area2D

@onready var animator: AnimatedSprite2D = $AnimatedSprite2D
@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D

var checked = false

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and not checked:
		Global.camera_shaked.emit()
		cpu_particles_2d.restart()
		checked = true
		animator.play("flag_out")


func _on_animated_sprite_2d_animation_finished() -> void:
	animator.play("flag_idle")
