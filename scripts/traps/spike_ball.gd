extends Node2D

@onready var chain: Chain = $Chain
@onready var ball: AnimatableBody2D = $Ball

@export_range(0, 180, .99, "degrees") var angle: int = 45
@export var in_circle = false
@export var loops_in_second = 1.0
@export var offset = 0.0

var time = 0
var _angle
var length

func _ready() -> void:
	_angle = angle
	length = ball.position.length()
	chain.offset = 0.1
	time += offset

func _physics_process(delta: float) -> void:
	time += delta * loops_in_second
	if not in_circle:
		_angle = sin(time * 2 * PI) * angle
	else:
		_angle = time * 360
	ball.position.x = sin(deg_to_rad(_angle)) * length
	ball.position.y = cos(deg_to_rad(_angle)) * length
	chain.queue_redraw()
