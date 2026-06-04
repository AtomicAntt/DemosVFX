shader_type canvas_item;
// https://thebookofshaders.com/08/

uniform float speed : hint_range(0.0, 0.5) = 0.35;
uniform float cross_size : hint_range(0.0, 0.4) = 0.2;

float box(vec2 uv, vec2 size){
	size = vec2(0.5) - size * 0.5;
	vec2 st = step(size, uv);
	st *= step(size, vec2(1.0)-uv);
	return st.x * st.y;
}

float make_cross(vec2 uv, float size){
	float value1 = box(uv, vec2(size, size/4.)); // vertical
	float value2 = box(uv, vec2(size/4., size)); // horizontal
	return value1 + value2;
}

void fragment() {
	//float new_cross = make_cross(UV, 0.2);
	//COLOR.rgb = vec3(new_cross);
	vec2 circular_translation = vec2(cos(TIME), sin(TIME));
	vec2 uv = UV + circular_translation * speed;
	
	vec3 color_result = vec3(0.0);
	color_result += make_cross(uv, cross_size);
	COLOR.rgb = color_result;
}
