shader_type canvas_item;

uniform float cross_size : hint_range(0.0, 0.4) = 0.2;
uniform vec2 pos1 = vec2(0.2, 0.2);
uniform vec2 pos2 = vec2(-0.2, -0.2);

mat2 rotate2d(float angle){
	return mat2(vec2(cos(angle), -sin(angle)),
				vec2(sin(angle), cos(angle)));
}

float box(vec2 uv, vec2 size){
	size = vec2(0.5) - size;
	vec2 side = step(size, uv);
	side *= step(size, 1.0-uv);
	return side.x * side.y;
}

float make_cross(vec2 uv, float size){
	float result = box(uv, vec2(size, size/4.0)); // horizontal
	result += box(uv, vec2(size/4.0, size)); // vertical
	return result;
}

void fragment() {
	vec3 color_result = vec3(0.0);
	vec2 pos = mix(pos1, pos2, (sin(TIME) + 1.0) / 2.0);
	
	vec2 transform = UV - vec2(0.5) + pos; // Change the center so that it's (0,0) instead of (0.5, 0.5)
	transform *= rotate2d(sin(TIME) * PI); // The center gets rotated
	transform += vec2(0.5); // Now we want the center to be (0.5, 0.5) again
	color_result += vec3(make_cross(transform, cross_size)); // Cross added where (0.5, 0.5) is at
	//color_result += vec3(box(transform, vec2(cross_size, cross_size/4.)));
	
	COLOR.rgb = color_result;
}
