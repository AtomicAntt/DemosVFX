shader_type canvas_item;

vec2 random2(vec2 uv) {
	return fract(sin(vec2(dot(uv,vec2(127.12,311.7)),dot(uv,vec2(269.5,183.3))))*43758.5453);
}

void fragment() {
	vec3 color = vec3(0.0);
	
	// scale
	vec2 uv = UV * 3.0;
	
	// tile space
	vec2 cell = floor(uv);
	vec2 local_pos = fract(uv);
	
	float min_dist = 1.0;
	
	for (int y = -1; y <= 1; y++) {
		for (int x = -1; x <= 1; x++) {
			// neighbor's cell in the grid
			vec2 neighbor = vec2(float(x), float(y));
			
			// random pos from current + neighbor place in grid
			vec2 point = random2(cell + neighbor);
			
			// animate point
			point = 0.5 + 0.5 * sin(TIME + 6.2831 * point);
			
			// vector between pixel and point
			vec2 diff = neighbor + point - local_pos;
			
			// distance to the point
			float dist = length(diff);
			
			// keep closest
			min_dist = min(min_dist, dist);
		}
	}
	
	// draw min distance
	color += min_dist;
	
	COLOR = vec4(vec3(color), 1.0);
}