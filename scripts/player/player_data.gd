class_name PlayerData
extends Node


@export var MAX_SPEED = 150.0
@export var IN_AIR_SPEED = 130.0
@export var ACCELERATION = 15.0
@export var FALL_SPEED = 200.0
@export var GROUND_FRICTION = 1.0
@export var AIR_FRICTION = 1.0
@export var SMOOTH_STOP = 35.0
@export var JUMP_SPEED = -350.0
@export var BOX_JUMP_SPEED = -150.0
@export var JUMP_TIME = 0.1
@export var COYOTE_TIME = 0.05
@export var GRAVITY = 1200.0
@export var INTENSE_GRAVITY = 1400.0
@export var WALL_SLIDE = 50.0
@export var WALL_JUMP = Vector2(-250.0, -300.0)
@export var WALL_JUMP_TIME = 0.05

var facing_forward = true
var input = 0
var double_jump = true
var wanna_jump = false
var request_jump_timer = 0.0
var coyote_timer = 0.0
var wall_jump_timer = 0.0
var jumped_off_wall = false
var flip_on_input = true
