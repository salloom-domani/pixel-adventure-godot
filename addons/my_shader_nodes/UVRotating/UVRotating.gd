@tool
class_name VisualShaderNodeUVRotate extends VisualShaderNodeCustom

func _init() -> void:
	set_output_port_for_preview(0)

func _get_name() -> String:
	return "UVRotating"

func _get_description() -> String:
	return "Rotates value of input UV around a reference point defined by input center by the amount of input rotation."

func _get_return_icon_type() -> VisualShaderNode.PortType:
	return PORT_TYPE_VECTOR_2D

func _get_input_port_count() -> int:
	return 3

func _get_input_port_name(port: int) -> String:
	match port:
		0:
			return "uv"
		1:
			return "center"
		2:
			return "rotation"
	return ""

func _get_input_port_type(port: int) -> VisualShaderNode.PortType:
	match port:
		0, 1:
			return PORT_TYPE_VECTOR_2D
		2:
			return PORT_TYPE_SCALAR
	return PORT_TYPE_SCALAR

func _get_input_port_default_value(port: int) -> Variant:
	match port:
		1:
			return Vector2(0.5, 0.5)
		2:
			return 0.0
		_:
			return null

func _get_output_port_count() -> int:
	return 1

func _get_output_port_name(port: int) -> String:
	return "uv"

func _get_output_port_type(port: int) -> VisualShaderNode.PortType:
	return PORT_TYPE_VECTOR_2D


func _get_global_code(mode: Shader.Mode) -> String:
	return preload("UVRotating.gdshaderinc").code

func _get_code(input_vars: Array[String], output_vars: Array[String], mode: Shader.Mode, type: VisualShader.Type) -> String:
	var uv: String

	match mode:
		0, 1:
			uv = "UV"
		_:
			uv = "vec2(0.0)"

	if input_vars[0]:
		uv = input_vars[0]

	var center: String = input_vars[1]
	var rotation: String = input_vars[2]

	return output_vars[0] + " = rotate_uv(%s, %s, %s);" % [uv, center, rotation]
