shader_type spatial;
render_mode wireframe, unshaded;

varying vec3 world_pos;
global uniform vec3 effect_origin;
global uniform float wireframe_effect_radius;
global uniform float effect_radius;

void vertex() {
	world_pos = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
}

void fragment() {
	float dist = distance(world_pos, effect_origin);
	float xdist = distance(vec3(world_pos.x, 0.0, world_pos.z), vec3(effect_origin.x, 0.0, effect_origin.z));
	ALPHA = step(dist, wireframe_effect_radius);
	if (xdist <= effect_radius) {
		ALPHA = 0.0;
	}
	ALPHA_SCISSOR_THRESHOLD = 0.5;
}