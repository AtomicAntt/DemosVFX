shader_type spatial;

varying flat int v_id;
varying vec3 v_data;

float random (vec2 uv) {
	return fract(sin(dot(uv.xy, vec2(12.9898, 78.232))) * 43758.543123);
}

void vertex() {
	v_id = VERTEX_ID;
	v_data = VERTEX;
}

void fragment() {
	//if (v_id % 3 == 0) {
		//ALBEDO = vec3(1.0, 0.0, 0.0);
	//} else if (v_id % 3 == 1) {
		//ALBEDO = vec3(0.0, 1.0, 0.0);
	//} else if (v_id % 3 == 2) {
		//ALBEDO = vec3(0.0, 0.0, 1.0);
	//}
	ALBEDO = vec3(random(vec2(float(v_id), 0.0)));
}
