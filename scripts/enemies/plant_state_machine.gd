class_name PlantStateMachine
extends MobStateMachine


func _on_player_detector_body_entered(body):
	if body.is_in_group("player") and current_state.id != "dead":
		set_state("shoot")
