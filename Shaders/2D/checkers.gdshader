shader_type canvas_item;

uniform float grid_size : hint_range(0.0, 10.0) = 4.0;
uniform vec2 pan_direction = vec2(-1.0, 1.0);

void fragment() {
	vec2 transform = UV * grid_size;
	transform += pan_direction * TIME;
	float color_value = step(1.0, mod(transform.y, 2.0));
	color_value += 1.0-step(1.0, mod(transform.x, 2.0));
	color_value = mod(color_value, 2.0); // Well, if it's both even, so value is 2.0 from the two above operations, it's 0.0 instead.
	
	COLOR = vec4(vec3(color_value), 1.0);
}