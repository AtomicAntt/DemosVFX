shader_type canvas_item;
// actually, this approach currently isnt working well

uniform sampler2D tex;
uniform float grid_size : hint_range(0.0, 128.0, 1.0) = 16.0;
// Actually this represents the subgrid size.
const int precision = 3;

void fragment() {
	vec2 cell = floor(UV * grid_size);
	//vec2 center_uv = (cell + vec2(0.5)) / grid_size;
	//vec4 color_result = texture(tex, center_uv);
	//COLOR = color_result;
	
	// Storage of color values in the subgrid.
	vec4 arr[precision*precision];
	// Starting # cell for X & Y
	int cell_x = int(cell.x) * precision;
	int cell_y = int(cell.y) * precision;
	// Here we shall go through each split cell in the subgrid and append it to arr to be processed.
	//vec2 split_cell = floor(UV * grid_size * float(precision));
	for (int i = cell_x; i < (cell_x + precision); i++){
		for (int j = cell_y; j < (cell_y + precision); j++){
			int local_i = i-cell_x;
			int local_j = j-cell_x;
			// It's supposed to be (i * column) + j but we know its going to always be a NxN grid
			vec2 center_uv = (vec2(float(i), float(j)) + vec2(0.5)) / (grid_size * float(precision));
			arr[(local_i * precision) + local_j] = texture(tex, center_uv);
		}
	}
	// Okay, our color result shall now be the median:
	vec4 color_result = arr[arr.length()/2];
	COLOR = color_result;
}