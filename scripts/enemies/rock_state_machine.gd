extends GroundedMobStateMachine

@onready var children_spawner = %ChildrenSpawner


func _on_grounded_dead_state_state_entered():
	children_spawner.spawn()
	await get_tree().create_timer(.1).timeout
	animator.visible = false
