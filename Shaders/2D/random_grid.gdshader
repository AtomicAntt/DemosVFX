shader_type canvas_item;

float random (vec2 uv) {
	return fract(sin(dot(uv.xy, vec2(12.9898, 78.232))) * 43758.543123);
}

void fragment() {
	vec2 uv = UV;
	uv *= 10.0;
	uv += vec2(-1.0, 0.0) * TIME;
	vec2 ipos = floor(uv);
	vec3 color = vec3(random(ipos));
	//COLOR.rgb = color;
	COLOR = vec4(color, 1.0);
}