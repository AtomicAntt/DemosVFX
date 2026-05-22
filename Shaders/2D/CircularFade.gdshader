shader_type canvas_item;

uniform float fade : hint_range(0.0, 1.0, 0.05) = 0.0;
uniform float blur : hint_range(0.0, 0.1, 0.01) = 0.02;

void vertex() {
	
}

void fragment() {
	vec2 center = vec2(0.5, 0.5);
	float radius = length(UV - center);
	
	float progress = smoothstep(radius-blur, radius+blur, fade);
	COLOR.a = progress;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
