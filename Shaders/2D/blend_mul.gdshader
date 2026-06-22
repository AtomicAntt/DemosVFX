shader_type canvas_item;
render_mode blend_mul;

void fragment(){
	// Brightness goes up as alpha goes down to simulate opacity
	float brightness = 1.0 - COLOR.a;
	// Scale accordingly
	vec3 difference = vec3(1.0, 1.0, 1.0) - COLOR.rgb;
	// Update our color
	COLOR.rgb += (difference * brightness);
}