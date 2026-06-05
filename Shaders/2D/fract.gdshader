shader_type canvas_item;

uniform float circle_radius : hint_range(0.0, 0.5) = 0.2;

float circle(vec2 uv, float radius){
	float dist = length(uv - vec2(0.5));
	float value = step(radius, dist);
	return 1.-value;
}

void fragment() {
	vec2 uv = UV * 3.0;
	uv = fract(uv);
	vec3 result = vec3(circle(uv, circle_radius));
	
	COLOR.rgb = result;
}
