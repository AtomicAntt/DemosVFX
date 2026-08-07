shader_type spatial;
render_mode wireframe, unshaded;

varying vec3 local_pos;

void vertex() {
	local_pos = VERTEX;
}

void fragment() {
	if (local_pos.x < 0.0) {
		ALBEDO = vec3(1.0, 0.0, 0.0);
	} else {
		ALPHA = 0.0;
		ALBEDO = vec3(1.0);
	}
	ALPHA_SCISSOR_THRESHOLD = 0.5;
}
