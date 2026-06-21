shader_type canvas_item;

//uniform float progress : hint_range(0.0, 1.0) = 1.0;
uniform float blur : hint_range(0.0, 0.2) = 0.1;
uniform sampler2D noise;


void fragment() {
	vec2 uv = UV - vec2(0.5);
	vec4 tex = texture(noise, UV);
	float radial_threshold = (atan(uv.x, uv.y) + PI) / (2.0 * PI);
	float progress = (sin(TIME) + 1.0) / 2.0;
	float result = smoothstep(radial_threshold, min(radial_threshold+blur, 1.0), progress);
	float value = step(tex.x, result);
	COLOR.a = value;
}