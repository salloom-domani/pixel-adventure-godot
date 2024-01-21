extends AnimatedSprite2D

@export var animations: Array[SpriteFrames]

func _ready():
	sprite_frames = animations.pick_random()
