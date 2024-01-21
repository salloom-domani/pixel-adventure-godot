class_name ZappingState
extends State

@export var x_speed = 50
@export var y_speed = 50

@export var x_timer = 3
@export var y_timer = 2

@onready var shooter = %Shooter

var tween_x: Tween
var tween_y: Tween

func enter(args = {}):
	super.enter(args)
	set_state("shoot")
	character.velocity = Vector2(-x_speed, -y_speed)
	tween_x = create_tween().set_trans(Tween.TRANS_SINE).set_loops()
	tween_y = create_tween().set_trans(Tween.TRANS_SINE).set_loops()
	tween_x.tween_property(character, "velocity:x", x_speed, x_timer)
	tween_x.tween_property(character, "velocity:x", -x_speed, x_timer)
	tween_y.tween_property(character, "velocity:y", y_speed, y_timer)
	tween_y.tween_property(character, "velocity:y", -y_speed, y_timer)

func exit():
	super.exit()
	tween_x.kill()
	tween_y.kill()

func _init():
	id = "zap"


func _on_shoot_state_event():
	shooter.shoot(Vector2.DOWN)
