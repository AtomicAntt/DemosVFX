shader_type canvas_item;

void fragment() {
	float value = pow(UV.x, 5);
	COLOR.rgb = vec3(value);
}