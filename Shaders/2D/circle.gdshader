shader_type canvas_item;

uniform float radius : hint_range(0.1, 0.9) = 0.3;
uniform float blur : hint_range(0.0, 0.2) = 0.05;

void fragment() {
	// This is the distance from our center.
	float dist = length(UV - vec2(0.5));
	
	//float value = 1.0 - step(radius, dist);
	float value = 1.0 - smoothstep(radius-blur, radius+blur, dist);
	COLOR.rgb = vec3(value);
}
