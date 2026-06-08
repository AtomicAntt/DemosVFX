shader_type canvas_item;

uniform float radius : hint_range(0.0, 0.5) = 0.2;
uniform vec2 pos1 = vec2(-0.2, 0.0);
uniform vec2 pos2 = vec2(0.2, 0.0);
uniform float speed = 1.0;

float random (vec2 uv) {
	return fract(sin(dot(uv.xy, vec2(12.9898, 78.232))) * 43758.543123);
}

float random_circle(vec2 uv, vec2 pos, float seed) {
	uv -= pos;
	float dist = length(uv - vec2(0.5));
	float value = (1.0 - step(radius, dist));// * random(uv);
	if (value == 1.0){
		value -= random(uv) + 1.0 - random(uv * TIME);
	}
	return value;
}

float circle(vec2 uv, vec2 pos) {
	uv -= pos;
	float dist = length(uv - vec2(0.5));
	float value = step(radius, dist);
	return value;
}

void fragment() {
	float seed = 1.0 + (TIME * speed);
	float value = random(UV);
	value += random_circle(UV, vec2(0.0), seed);
	COLOR.rgb = vec3(value);
}
