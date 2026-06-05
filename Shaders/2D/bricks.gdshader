shader_type canvas_item;

uniform float brick_width : hint_range(0.0, 0.1) = 0.05;
uniform float brick_rows : hint_range(0.0, 10.0) = 4.0;

float box(vec2 uv, vec2 size){
	size = vec2(0.5) - size;
	vec2 value = step(size, uv);
	value *= step(size, 1.0 - uv);
	return value.x * value.y;
}

void fragment() {
	vec2 zoom = UV * brick_rows;
	zoom.x += step(1.0, mod(zoom.y, 2.0)) * 0.5;
	vec2 transform = fract(zoom);
	vec3 color_result = vec3(box(transform, vec2(0.5 - brick_width)));
	COLOR = vec4(color_result, 1.0);
}
