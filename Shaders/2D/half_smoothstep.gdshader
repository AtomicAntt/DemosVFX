shader_type canvas_item;

uniform float blur : hint_range(0.0, 0.2, 0.01) = 0.1;

void fragment() {
	float value = smoothstep(0.5-blur, 0.5+blur, UV.x);
	COLOR.rgb = vec3(value);
}
