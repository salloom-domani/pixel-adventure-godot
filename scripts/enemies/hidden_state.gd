extends State

@onready var hit_box_collision = %HitBox/CollisionShape2D
@onready var hurt_box_collision = %HurtBox/CollisionShape2D

var time = 0

func enter(args = {}):
	super.enter(args)
	animator.animation_finished.connect(_on_animation_finish)
	hit_box_collision.set_deferred("disabled", true)
	hurt_box_collision.set_deferred("disabled", true)
	time = randi_range(1, 4)
	animator.play("disappear")

func _on_animation_finish():
	if animator.animation == "disappear":
		animator.visible = false
		await get_tree().create_timer(time).timeout
		animator.visible = true
		animator.play("appear")
	elif animator.animation == "appear":
		parent.set_state("idle")

func exit():
	super.exit()
	animator.visible = true
	animator.animation_finished.disconnect(_on_animation_finish)

func _init():
	id = "hidden"
