extends Node2D

@export var shape:Shape2D: set = set_shape
@export var disabled:bool: set = set_disabled
@export var one_way_collision:bool: set = set_one_way_collision
@export_range(0.0, 128.0, 1.0) var one_way_collision_margin:float: set = set_one_way_collision_margin

signal sleeping_state_changed()

@export var linear_velocity:Vector2: set = set_linear_velocity
@export var angular_velocity:float: set = set_angular_velocity
@export var can_sleep:bool = true: set = set_can_sleep
@export var sleeping:bool: set = set_sleeping
@export var custom_integrator:bool: set = set_custom_integrator

var _shape:RID



var _body:RID
var _invalid_rid:RID


func _enter_tree() -> void:
	_body = PhysicsServer2D.body_create()
	PhysicsServer2D.body_set_space(_body, get_world_2d().space)
	_update_shape()
	PhysicsServer2D.body_set_state(_body, PhysicsServer2D.BODY_STATE_TRANSFORM, global_transform)
	PhysicsServer2D.body_set_state(_body, PhysicsServer2D.BODY_STATE_ANGULAR_VELOCITY, angular_velocity)
	PhysicsServer2D.body_set_state(_body, PhysicsServer2D.BODY_STATE_CAN_SLEEP, can_sleep)
	PhysicsServer2D.body_set_state(_body, PhysicsServer2D.BODY_STATE_LINEAR_VELOCITY, linear_velocity)
	PhysicsServer2D.body_set_state(_body, PhysicsServer2D.BODY_STATE_SLEEPING, sleeping)
	PhysicsServer2D.body_set_force_integration_callback(_body, _body_moved)
	PhysicsServer2D.body_set_omit_force_integration(_body, custom_integrator)

func _exit_tree() -> void:
	PhysicsServer2D.free_rid(_body)
	_body = _invalid_rid

func _update_shape() -> void:
	var new_shape = _invalid_rid if shape == null else shape.get_rid()
	if new_shape == _shape:
		return

	if _shape.get_id() != 0:
		PhysicsServer2D.body_remove_shape(_body, 0)

	_shape = new_shape

	if _shape.get_id() != 0:
		PhysicsServer2D.body_add_shape(_body, _shape, Transform2D.IDENTITY, disabled)
		PhysicsServer2D.body_set_shape_as_one_way_collision(_body, 0, one_way_collision, one_way_collision_margin)

func set_shape(new_value:Shape2D) -> void:
	if shape == new_value:
		return

	shape = new_value
	if _body.get_id() == 0:
		return

	_update_shape()

func set_disabled(new_value:bool) -> void:
	if disabled == new_value:
		return

	disabled = new_value
	if _body.get_id() == 0:
		return

	if _shape.get_id() != 0:
		PhysicsServer2D.body_set_shape_disabled(_body, 0, disabled)

func set_one_way_collision(new_value:bool) -> void:
	if one_way_collision == new_value:
		return

	one_way_collision = new_value
	if _body.get_id() == 0:
		return

	if _shape.get_id() != 0:
		PhysicsServer2D.body_set_shape_as_one_way_collision(_body, 0, one_way_collision, one_way_collision_margin)

func set_one_way_collision_margin(new_value:float) -> void:
	if one_way_collision_margin == new_value:
		return

	one_way_collision_margin = new_value
	if _body.get_id() == 0:
		return

	if _shape.get_id() != 0:
		PhysicsServer2D.body_set_shape_as_one_way_collision(_body, 0, one_way_collision, one_way_collision_margin)

func _body_moved(state:PhysicsDirectBodyState2D, _user_data) -> void:
	_integrate_forces(state)
	global_transform = state.transform
	angular_velocity = state.angular_velocity
	linear_velocity = state.linear_velocity
	if sleeping != state.sleeping:
		sleeping = state.sleeping
		emit_signal("sleeping_state_changed")

# warning-ignore:unused_argument
func _integrate_forces(state:PhysicsDirectBodyState2D) -> void:
	pass

func set_linear_velocity(new_value:Vector2) -> void:
	if linear_velocity == new_value:
		return

	linear_velocity = new_value
	if _body.get_id() == 0:
		return

	PhysicsServer2D.body_set_state(_body, PhysicsServer2D.BODY_STATE_LINEAR_VELOCITY, linear_velocity)

func set_angular_velocity(new_value:float) -> void:
	if angular_velocity == new_value:
		return

	angular_velocity = new_value
	if _body.get_id() == 0:
		return

	PhysicsServer2D.body_set_state(_body, PhysicsServer2D.BODY_STATE_ANGULAR_VELOCITY, angular_velocity)

func set_can_sleep(new_value:bool) -> void:
	if can_sleep == new_value:
		return

	can_sleep = new_value
	if _body.get_id() == 0:
		return

	PhysicsServer2D.body_set_state(_body, PhysicsServer2D.BODY_STATE_CAN_SLEEP, can_sleep)

func set_sleeping(new_value:bool) -> void:
	if sleeping == new_value:
		return

	sleeping = new_value
	if _body.get_id() == 0:
		return

	PhysicsServer2D.body_set_state(_body, PhysicsServer2D.BODY_STATE_SLEEPING, sleeping)

func set_custom_integrator(new_value:bool) -> void:
	if custom_integrator == new_value:
		return

	custom_integrator = new_value
	if _body.get_id() == 0:
		return

	PhysicsServer2D.body_set_omit_force_integration(_body, custom_integrator)
