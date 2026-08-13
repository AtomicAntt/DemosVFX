shader_type spatial;
render_mode unshaded, wireframe;

uniform float triangle_scale : hint_range(0.0, 1.0) = 0.5;

void vertex() {
	// Remember, CUSTOM0 should be applied in our custom import script,
	// giving the vertex the local position of the vertex's face center.
	vec3 face_center = CUSTOM0.xyz;
	vec3 center_to_vertex = VERTEX - face_center;
	VERTEX = face_center + (center_to_vertex * triangle_scale);
}