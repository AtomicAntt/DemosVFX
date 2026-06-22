shader_type canvas_item;

uniform float line_width : hint_range(0.0, 0.4) = 0.2;
uniform float line_count : hint_range(0.0, 15.0) = 6.0;
uniform float blur : hint_range(0.0, 0.1) = 0.01;
uniform float speed: hint_range(0.0, 3.0) = 0.3;

vec2 rotate_2d(vec2 uv, vec2 pivot, float angle){
	mat2 rotation = mat2(vec2(cos(angle), -sin(angle)),
					vec2(sin(angle), cos(angle)));
	uv -= pivot;
	uv *= rotation;
	uv += pivot;
	return uv;
}

float line(vec2 uv, float scale){
	vec2 size = vec2(0.5) - scale * 0.5;
	vec2 result = smoothstep(size-blur, size+blur, uv);
	result *= smoothstep(size-blur, size+blur, 1.0 - uv);
	return result.x;
}

void fragment() {
	
	vec2 transform = rotate_2d(UV, vec2(0.5), (45.0/180.0) * PI);
	transform += vec2(-1.0, 1.0) * TIME * speed;
	transform = fract(vec2(transform.x * line_count, UV.y));
	//transform += vec2(0.1, 0.1) * TIME;
	//COLOR.rgb = vec3(transform.x, transform.y, 0.0);
	COLOR.rgb = vec3(line(transform, line_width));
}