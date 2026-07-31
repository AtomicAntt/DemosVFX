shader_type canvas_item; 

float random(vec2 uv) {
	return fract(sin(dot(uv.xy, vec2(12.998, 78.232))) * 43758.5454221);
}

float noise(vec2 uv) {
	vec2 i = floor(uv);
	vec2 f = fract(uv);
	
	float a = random(i);
	float b = random(i + vec2(1.0, 0.0));
	float c = random(i + vec2(0.0, 1.0));
	float d = random(i + vec2(1.0, 1.0));
	
	vec2 u = smoothstep(0.0, 1.0, f);
	
	return mix(a, b, u.x) +
			(c - a) * u.y * (1.0 - u.x) +
			(d - b) * u.x * u.y;
}

void fragment() {
	vec2 pos = vec2(UV * 5.0);
	float n = noise(pos);
	COLOR = vec4(vec3(n), 1.0);
}