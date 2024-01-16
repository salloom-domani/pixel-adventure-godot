@tool
class_name Chain
extends Node2D

@export var texture: Texture
@export var target: Node2D
@export var offset = 2

@onready var texture_size = texture.get_width()
@onready var repeat = target.position.length() / ( texture_size + offset )
@onready var step_length = target.position.length() / repeat



func _draw() -> void:
	if texture:
		for i in repeat - 1:
			var step_point = target.position.normalized() * step_length * i
			var texture_pos = Vector2(step_point.x - texture_size / 2, step_point.y - texture_size / 2) 
			draw_texture(texture, texture_pos)

