class_name PlayerData
extends Node

@export_group("Speed")
@export var MAX_SPEED = 150.0
@export var IN_AIR_SPEED = 150.0
@export var ACCELERATION = 25.0
@export var FALL_SPEED = 200.0
@export var JUMP_SPEED = -370.0
@export var BOX_JUMP_SPEED = -150.0

@export_group("Friction")
@export var GROUND_FRICTION = 100.0
@export var AIR_FRICTION = 100.0
@export var SMOOTH_STOP = 35.0

@export_group("Time")
@export var JUMP_TIME = 0.1
@export var COYOTE_TIME = 0.05

@export_group("Gravity")
@export var GRAVITY = 1400.0
@export var INTENSE_GRAVITY = 1500.0

@export_group("Wall")
@export var WALL_SLIDE = 50.0
@export var WALL_JUMP = Vector2(-100.0, -200.0)
@export var WALL_JUMP_TIME = 0.1

var facing_forward = true
var input = 0
var double_jump = true
var wanna_jump = false
var request_jump_timer = 0.0
var coyote_timer = 0.0
var wall_jump_timer = 0.0
var jumped_off_wall = false
var flip_on_input = true
