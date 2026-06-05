shader_type canvas_item;

mat2 scale(vec2 scale){
	return mat2(vec2(scale.x, 0.0),
				vec2(0.0, scale.y));
}

float box(vec2 uv, vec2 scale){
	scale = vec2(0.5) - scale;
	vec2 side = step(scale, uv);
	side *= step(scale, 1.0 - uv);
	return side.x * side.y;
}

float make_cross(vec2 uv, float scale){
	return box(uv, vec2(scale, scale/4.0)) + box(uv, vec2(scale/4.0, scale));
}

void fragment() {
	vec2 transform = UV - vec2(0.5); // make the center into 0,0
	transform = scale(vec2(sin(TIME))) * transform;
	transform += vec2(0.5);
	float result = make_cross(transform, 0.2);
	
	COLOR.rgb = vec3(result);
}