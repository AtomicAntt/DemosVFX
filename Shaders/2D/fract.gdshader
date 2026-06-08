shader_type canvas_item;

uniform float circle_radius : hint_range(0.0, 0.5) = 0.2;
uniform float blur : hint_range(0.0, 0.2) = 0.01;
uniform float tiles : hint_range(0.0, 15.0) = 10.0;

float circle(vec2 uv, float radius){
	float dist = length(uv - vec2(0.5));
	float value = smoothstep(radius-blur, radius+blur, dist);
	return value;
}

void fragment() {
	vec2 uv = UV * tiles;
	float state_switcher_x = step(0.0, sin(TIME));
	float state_switcher_y = step(0.0, -sin(TIME));
	
	uv.x -= TIME * state_switcher_x;
	uv.x += 2.0 * step(1.0, mod(uv.y, 2.0)) * TIME * state_switcher_x;
	
	uv.y -= TIME * state_switcher_y;
	uv.y += 2.0 * step(1.0, mod(uv.x, 2.0)) * TIME * state_switcher_y;
	
	uv = fract(uv);
	vec3 result = vec3(circle(uv, circle_radius));
	
	COLOR = vec4(vec3(result), 1.0);
}