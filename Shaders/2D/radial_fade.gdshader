shader_type canvas_item;

//uniform float progress : hint_range(0.0, 1.0) = 1.0;

void fragment() {
	vec2 uv = UV - vec2(0.5);
	float radial_threshold = (atan(uv.x, uv.y) + PI) / (2.0 * PI);
	float radial_progress = (sin(TIME) + 1.0) / 2.0;
	float result = step(radial_threshold, radial_progress);
	//result = step(radial_threshold, progress);
	//COLOR.rgb = vec3(result);
	COLOR.a = result;
}