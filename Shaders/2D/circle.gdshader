shader_type canvas_item;

uniform float radius : hint_range(0.1, 0.9) = 0.2;
uniform float blur : hint_range(0.0, 0.2) = 0.05;

uniform vec2 pos1 = vec2(0.2, -0.1);
uniform vec2 pos2 = vec2(-0.2, -0.1);

float circle(vec2 uv, vec2 pos) {
	uv -= pos;
	float dist = length(uv - vec2(0.5));
	float value = 1.0 - smoothstep(radius-blur, radius+blur, dist);
	return value;
}

void fragment() {
	// This is the distance from our center.
	float dist = length(UV - vec2(0.5));
	// Actually, below turned out to be like a ball bouncing when it hits the floor/wall
	//vec2 position = mix(pos1, pos2, abs(sin(TIME)));
	vec2 position = mix(pos1, pos2, (sin(TIME)+1.0)/2.0);
	
	//float value = 1.0 - step(radius, dist);
	//float value = 1.0 - smoothstep(radius-blur, radius+blur, dist);
	COLOR.rgb = vec3(circle(UV, position));
}
