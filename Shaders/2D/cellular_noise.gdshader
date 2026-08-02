shader_type canvas_item;

void fragment() {
	vec3 color = vec3(0.0);
	
	// cell positions
	vec2 point[5];
	point[0] = vec2(0.83,0.75);
	point[1] = vec2(0.60,0.07);
	point[2] = vec2(0.28,0.64);
	point[3] = vec2(0.31,0.26);
	point[4] = vec2(0.0, 1.0);
	
	float min_dist = 1.0;
	for (int i = 0; i < 5; i++) {
		float dist = distance(UV, point[i]);
		
		min_dist = min(min_dist, dist);
	}
	
	color = vec3(min_dist);
	
	COLOR = vec4(vec3(color), 1.0);
}
