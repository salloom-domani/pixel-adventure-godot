class_name State
extends Node

@export var debug = false: get = get_debug

func get_debug():
	return debug or parent and parent.get_debug()

var id
var parent: State
var character: CharacterBody2D
var animator: AnimatedSprite2D
var children = {}
var current_state
signal state_changed(id: String)

signal state_entered
signal state_exited

# TODO: make an inner class for the args
func enter(args = {}):
	state_entered.emit()
	if debug :
		print("entering: ", id)
	if current_state:
		current_state.enter(args)


func exit():
	state_exited.emit()
	if debug:
		print("exiting: ", id)
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
# TODO: maake set state takes a node reference as its argument
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



# TIMERS
func add_default_timer(time: float, callback: Callable):
	return add_timer("DEFAULT", time, func(timer_name): callback.call())

func add_default_interval(time: float, callback: Callable):
	return add_timer("DEFAULT", time, callback, false)

func add_timer(timer_name: String, time: float, callback: Callable, one_shot = true) -> Timer:
	del_timer(timer_name)
	var timer := Timer.new()
	add_child(timer)
	timer.set_name(timer_name)
	timer.set_one_shot(one_shot)
	timer.start(time)
	timer.timeout.connect(callback.bind(timer_name))
	return timer


func del_timer(timer_name: String) -> void:
	if has_node(timer_name):
		get_node(timer_name).stop()
		get_node(timer_name).queue_free()
		get_node(timer_name).set_name("to_delete")

func del_default_timer() -> void:
	del_timer("DEFAULT")

func del_timers() -> void:
	for c in get_children():
		if c is Timer:
			c.stop()
			c.queue_free()
			c.set_name("to_delete")


func has_timer(timer_name: String) -> bool:
	return has_node(timer_name)
