class_name FallingPlatform
extends RigidBody2D

@export var amptitude = 5
@export var duration = 2


var tween: Tween
var counter = 3

func _ready() -> void:
	tween = create_tween()
	tween.tween_property(self, "position:y", position.y + amptitude, duration).set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "position:y", position.y - amptitude, duration).set_trans(Tween.TRANS_SINE)
	tween.set_loops(-1)


func _physics_process(delta: float) -> void:
	if position.y > 300:
		queue_free()

func hit():
	tween.stop()
	tween = create_tween()
	tween.tween_property(self, "position:y", position.y + 2, 0.1).set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "position:y", position.y - 2, 0.1).set_trans(Tween.TRANS_SINE)
	tween.set_loops(3)
	tween.loop_finished.connect(turn_off)

func turn_off(_loops_count):
	if tween.get_loops_left() == 1:
		tween.stop()
		freeze = false
