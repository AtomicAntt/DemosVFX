shader_type spatial;
render_mode blend_mix, depth_draw_opaque, cull_disabled;

uniform vec4 albedo : source_color;
uniform sampler2D texture_albedo;
uniform vec2 tiling = vec2(2.0, 2.0);
uniform vec2 offset = vec2(1.0, 0.0);

varying vec2 uv_interp;

void vertex() {
	uv_interp = UV * tiling + offset * TIME;
}

void fragment() {
	vec4 albedo_tex = texture(texture_albedo, uv_interp);
	albedo_tex *= COLOR;
	ALBEDO = albedo.rgb * albedo_tex.rgb;
	ALPHA *= albedo.a * albedo_tex.a;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
