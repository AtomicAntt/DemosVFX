shader_type canvas_item;

uniform sampler2D texture_used;

float random (vec2 uv) {
	return fract(sin(dot(uv.xy, vec2(12.9898, 78.232))) * 43758.543123);
}

float check_texture(vec2 uv, float seed){
	vec4 tex = texture(texture_used, uv);
	if (tex.x > 0.0){
		return -random(uv) + random(uv * seed);
	}
	return 0.0;
}

void fragment() {
	float value = random(UV);
	value += check_texture(UV, float(int(TIME*5.0)));
	COLOR = vec4(vec3(value), 1.0);
}