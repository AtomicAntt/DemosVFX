shader_type canvas_item;

uniform float y_threshold : hint_range(0.0, 1.0) = 0.3;
uniform float wavy_intensity : hint_range(0.0, 200.0) = 50.0;

void vertex() {
	//VERTEX.x -= VERTEX.y;
	VERTEX.x += step(y_threshold, -VERTEX.y) * wavy_intensity * sin(TIME);
}
