extends Label

@export var state_machine: State

func _ready():
	text = state_machine.starting_state
	state_machine.state_changed.connect(_on_state_changed)

func _on_state_changed(new_state_id: String):
	text = new_state_id
