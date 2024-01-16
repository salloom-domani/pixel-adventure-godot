class_name PlayerState
extends State

var player_data: PlayerData
var collision_shape: CollisionShape2D
var state_machine: PlayerStateMachine


func set_child_refs(child):
	child.character = character
	child.animator = animator
	child.player_data = player_data
	child.state_machine = state_machine
