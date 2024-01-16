class_name State
extends Node

var id
var parent: State
var character: CharacterBody2D
var animator: AnimatedSprite2D
var children = {}
var current_state
signal state_changed(id: String)


func enter(args = {}):
	#print("entering: ", id)
	if current_state:
		current_state.enter(args)
	else:
		animator.animation = id

func exit():
	#print("exiting: ", id)
	if current_state:
		current_state.exit()
		current_state = null

func update(delta: float) -> void:
	if current_state:
		current_state.update(delta)

func phy_update(delta: float) -> void:
	if current_state:
		current_state.phy_update(delta)

# TODO: make set state discover its parent
func set_state(path: String, enter_args = {}):
	var ids = path.split("/")

	if current_state:
		current_state.exit()
	
	var curr = self
	for state_id in ids:
		curr.current_state = curr.children[state_id]
		curr.state_changed.emit(state_id)
		curr = curr.current_state
	
	current_state.enter(enter_args)


func awake():
	pass


func ready():
	pass


func set_child_refs(child):
	child.character = character
	child.animator = animator

func _on_state_changed(_state_id: String) -> void:
	pass


func start() -> void:
	awake()
	for state in get_children():
		if state is State:
			state.parent = self
			set_child_refs(state)
			state.state_changed.connect(_on_state_changed)
			children[state.id] = state
			state.start()
	ready()

