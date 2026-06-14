shader_type canvas_item;

uniform sampler2D tex;

float random (vec2 uv) {
	return fract(sin(dot(uv.xy, vec2(12.9898, 78.232))) * 43758.543123);
}

void fragment() {
	vec2 seed = UV + TIME;
	vec3 random_color_value = vec3(random(seed));
	
	COLOR.rgb = random_color_value;
}