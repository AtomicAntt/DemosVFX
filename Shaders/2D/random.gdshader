shader_type canvas_item;

uniform float fade_progress : hint_range(0.0, 1.0) = 0.0;

float random (vec2 uv) {
	return fract(sin(dot(uv.xy, vec2(12.9898, 78.232))) * 43758.543123);
}

void fragment() {
	float fade_val = step(fade_progress, random(UV));
	COLOR.a = fade_val;
}