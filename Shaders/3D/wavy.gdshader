shader_type spatial;

void vertex() {
	VERTEX.y += sin(TIME * 5.0 + VERTEX.x * 10.0) * 0.2;
}

void fragment() {
	vec3 color;
	color.r = (sin(TIME * 6.0 + VERTEX.x * 10.0) + 1.0) * 0.5;
	color.g = (sin(TIME * 7.0 + VERTEX.x * 10.0) + 1.0) * 0.5;
	color.b = (sin(TIME * 8.0 + VERTEX.x * 10.0) + 1.0) * 0.5;
	ALBEDO = color;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
