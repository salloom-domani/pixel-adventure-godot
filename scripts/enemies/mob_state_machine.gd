class_name MobStateMachine
extends State

@export var starting_state: String

func awake():
	#state_machine = $"."
	character = $".."
	animator = %Animator
	#collision_shape = $"../CollisionShape2D"


func ready():
	set_state(starting_state)


func _ready() -> void:
	start()


func _process(delta):
	update(delta)


func _physics_process(delta: float) -> void:
	phy_update(delta)
