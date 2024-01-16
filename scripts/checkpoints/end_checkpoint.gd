extends StaticBody2D


var checked = false
@onready var animator: AnimatedSprite2D = $AnimatedSprite2D
@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and not checked:
		Global.camera_shaked.emit()
		cpu_particles_2d.restart()
		checked = true
		animator.play("hit")


func _on_animated_sprite_2d_animation_finished() -> void:
	animator.play("default")
