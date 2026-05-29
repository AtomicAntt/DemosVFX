shader_type spatial;

uniform sampler2D texture_albedo;

float fresnel(float amount, vec3 normal, vec3 view){
	return pow((1.0 - clamp(dot(normalize(normal), normalize(view)), 0.0, 1.0)), amount);
}

void fragment() {
	vec3 texture_rgb = texture(texture_albedo, UV).rgb;
	
	//vec3 base_color = vec3(1.0);
	float basic_fresnel = fresnel(3.0, NORMAL, VIEW);
	ALBEDO = texture_rgb + basic_fresnel;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
