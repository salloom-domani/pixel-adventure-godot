extends MobStateMachine

@onready var shooter = %Shooter


func _on_shoot_state_event():
	shooter.shoot(Vector2.DOWN)
