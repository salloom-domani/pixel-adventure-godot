class_name GroundedMobStateMachine
extends MobStateMachine

@onready var dust_move_particles = %DustMoveParticles


func _on_grounded_move_state_state_entered():
	dust_move_particles.emitting = true


func _on_grounded_move_state_state_exited():
	dust_move_particles.emitting = false
