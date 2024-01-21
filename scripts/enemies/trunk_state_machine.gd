class_name TrunkStateMachine
extends MobStateMachine

@onready var label = %Label

func _ready():
	start()
	state_changed.connect(_on_state_changed)


func _on_player_detector_body_entered(body):
	if body.is_in_group("player"):
		set_state("shoot")


func _on_state_changed(_state_id: String) -> void:
	label.text = _state_id
