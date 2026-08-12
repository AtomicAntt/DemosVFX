shader_type spatial;

//varying vec4 center_of_triangle;
uniform float triangle_scale : hint_range(0.0, 1.0) = 0.5;

void vertex() {
	//vec3 face_center = BONE_WEIGHTS.xyz;
	vec3 face_center = BONE_WEIGHTS.xyz * (2.0 * 100.0) - 100.0;
	vec3 center_to_vertex = VERTEX - face_center;
	VERTEX = face_center + (center_to_vertex * triangle_scale);
	
}