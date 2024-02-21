shader_type canvas_item;


uniform vec4 outline_color: source_color;
uniform float width;

void fragment()
{
	vec4 sprite_color = texture(TEXTURE, UV);
	float alpha = -4.0 * sprite_color.a;
	
	alpha += texture(TEXTURE, UV + vec2(width, 0.0)).a;
	alpha += texture(TEXTURE, UV + vec2(-width, 0.0)).a;
	alpha += texture(TEXTURE, UV + vec2(0.0, width)).a;
	alpha += texture(TEXTURE, UV + vec2(0.0, -width)).a;
	
	vec4 final_color = mix(sprite_color, outline_color, clamp(alpha, 0.0, 1.0));
	COLOR = vec4(final_color.rgb, clamp(abs(alpha) + sprite_color.a, 0.0, 1.0));
}