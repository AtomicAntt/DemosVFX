shader_type canvas_item;

uniform vec4 color1 : source_color = vec4(0.0, 0.0, 1.0, 1.0); 
uniform vec4 color2 : source_color = vec4(1.0, 0.0, 0.0, 1.0);

void fragment() {
	vec4 value = mix(color1, color2, UV.x);
	COLOR = value;
}