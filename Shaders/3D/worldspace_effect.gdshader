shader_type spatial;

varying vec3 world_pos;
global uniform vec3 effect_origin;
global uniform float effect_radius;

void vertex() {
	world_pos = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
}

void fragment() {
	if (distance(world_pos, effect_origin) <= effect_radius) {
		ALBEDO = vec3(0.0);
	}
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
