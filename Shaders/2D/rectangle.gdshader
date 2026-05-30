shader_type canvas_item;
// https://thebookofshaders.com/07/

uniform float border_size : hint_range(0.1, 0.5) = 0.1;
uniform float blur : hint_range(0.0, 0.2) = 0.05;

float rectangle(vec2 uv) {
	vec2 left_top = smoothstep(vec2(border_size)-blur, vec2(border_size)+blur, uv);
	float value = left_top.x * left_top.y;
	
	vec2 right_bottom = smoothstep(vec2(border_size)-blur, vec2(border_size)+blur, 1.0-uv);
	float value2 = right_bottom.x * right_bottom.y;
	
	return value * value2;
}

void fragment() {
	//float left = step(0.1, UV.x);
	//float bottom = step(0.1, UV.y);
	
	//vec2 left_top = step(vec2(border_size), UV);
	//vec2 left_top = smoothstep(vec2(border_size)-blur, vec2(border_size)+blur, UV);
	//
	//float value = left_top.x * left_top.y;
	
	//vec2 right_bottom = step(vec2(border_size), 1.0-UV);
	//vec2 right_bottom = smoothstep(vec2(border_size)-blur, vec2(border_size)+blur, 1.0-UV);
	//float value2 = right_bottom.x * right_bottom.y;
	
	// The multiplication of left*bottom is alike logical AND
	//COLOR = vec4(vec3(left * bottom), 1.0);
	
	COLOR = vec4(vec3(rectangle(UV)), 1.0);
}
