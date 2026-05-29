shader_type canvas_item;

void fragment() {
	float value = step(0.5, UV.x);
	COLOR.rgb = vec3(value);
}
