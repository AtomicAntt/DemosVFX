shader_type canvas_item;

uniform sampler2D noise;
//uniform float progress : hint_range(0.0, 1.0) = 0.0;

void fragment() {
	vec4 tex = texture(noise, UV);
	float progress = (sin(TIME) + 1.0) / 2.0;
	float value = 1.0-step(tex.x, progress);
	COLOR.a = value;
}
