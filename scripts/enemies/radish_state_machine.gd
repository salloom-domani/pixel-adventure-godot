extends MobStateMachine



@onready var dust_move_particles = %DustMoveParticles
@onready var dust_fly_particles = %DustFlyParticles


func _on_grounded_move_state_state_entered():
	dust_move_particles.emitting = true


func _on_grounded_move_state_state_exited():
	dust_move_particles.emitting = false



func _on_zapping_state_state_entered():
	dust_fly_particles.emitting = true


func _on_zapping_state_state_exited():
	dust_fly_particles.emitting = false
