shader_type canvas_item;

// This is some shader that interpolates between two albedo values.

uniform vec4 albedo1 : source_color = vec4(1.0, 0.0, 1.0, 1.0); // Default color is purple
uniform vec4 albedo2 : source_color = vec4(1.0, 1.0, 0.0, 1.0); // Default color is yellow

uniform float speed : hint_range(0.1, 10.0, 0.1) = 1.0;

void fragment() {
	float value = abs(sin(TIME * speed));
	COLOR = mix(albedo1, albedo2, value);
}
