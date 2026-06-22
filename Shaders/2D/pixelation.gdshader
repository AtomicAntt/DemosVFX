shader_type canvas_item;

uniform sampler2D tex;
uniform float grid_size : hint_range(0.0, 128.0, 1.0) = 16.0;

void fragment() {
	vec2 cell = floor(UV * grid_size);
	vec2 center_uv = (cell + vec2(0.5)) / grid_size;
	vec4 color_result = texture(tex, center_uv);
	COLOR = color_result;
}