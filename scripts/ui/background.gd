extends TextureRect

@export var textures: Array[Texture2D] = []

func _ready():
	var random = randi_range(0, textures.size() - 1)
	texture = textures[random]

