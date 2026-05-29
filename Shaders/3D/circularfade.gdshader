shader_type spatial;
render_mode cull_disabled;

uniform float fade : hint_range(0.0, 1.0, 0.01) = 0.0;
uniform float blur : hint_range(0.0, 0.2, 0.01) = 0.1;

uniform sampler2D texture_albedo;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec3 texture_rgb = texture(texture_albedo, UV).rgb;
	
	vec2 center = vec2(0.5, 0.5);
	float radius = length(UV - center);
	
	float progress = step(radius, fade);
	
	ALPHA = progress;
	ALBEDO *= texture_rgb;
	
}


//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
