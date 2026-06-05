shader_type canvas_item;

uniform float square_size : hint_range(0.0, 0.5) = 0.2;
uniform float grid_size : hint_range(0.0, 6.0) = 3.0;

mat2 rotate_2d(float angle){
	return mat2(vec2(cos(angle), -sin(angle)),
				vec2(sin(angle), cos(angle)));
}

float box(vec2 uv, vec2 size){
	size = vec2(0.5) - size;
	vec2 value = step(size, uv);
	value *= step(size, 1.0 - uv);
	return value.x * value.y;
}

void fragment() {
	vec2 transform = fract(UV * grid_size);
	
	transform -= vec2(0.5); // Look, we want to make it so the center is actually (0,0) now
	transform *= rotate_2d(TIME * PI);
	transform += vec2(0.5);
	vec3 result = vec3(box(transform, vec2(square_size)));
	COLOR.rgb = result;
}