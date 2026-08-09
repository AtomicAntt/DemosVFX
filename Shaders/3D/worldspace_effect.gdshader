shader_type spatial;

varying vec3 world_pos;
global uniform vec3 effect_origin;
global uniform float effect_radius;

void vertex() {
	world_pos = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
}

void fragment() {
	float xz_dist = distance(vec3(world_pos.x, 0.0, world_pos.z), vec3(effect_origin.x, 0.0, effect_origin.z));
	ALPHA = step(xz_dist, effect_radius);
	ALPHA_SCISSOR_THRESHOLD = 0.5;
}