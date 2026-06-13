shader_type canvas_item;

uniform float blur : hint_range(0.0, 0.2) = 0.01;
uniform float tiles : hint_range(0.0, 15.0) = 5.0;
uniform float from_radius : hint_range(0.0, 0.8) = 0.2;
uniform float to_radius : hint_range(0.0, 0.8) = 0.8;
uniform float speed: hint_range(0.0, 3.0) = 2.0;

float circle(vec2 uv, float rad){
	float d = length(uv - vec2(0.5));
	float value = smoothstep(rad - blur, rad + blur, d);
	return value;
}

void fragment() {
	float radius = mix(from_radius, to_radius, (sin(TIME * speed) + 1.0)/2.0);
	
	vec2 zoom = UV * tiles;
	zoom.x -= step(1.0, mod(zoom.y, 2.0)) * 0.5;
	vec2 transform = fract(zoom);
	float value = circle(transform, radius);
	COLOR = vec4(vec3(value), 1.0);
}