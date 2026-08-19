shader_type canvas_item;

uniform sampler2D noise : repeat_enable;
uniform sampler2D texture_albedo : source_color, repeat_enable;

uniform float noise_speed : hint_range(0.0, 5.0) = 1.0;
uniform float noise_multiplier : hint_range(0.0, 1.0) = 0.05;

uniform float cells : hint_range(1.0, 10.0) = 2.0;

void fragment() {
	vec2 noise_uv = UV * cells + (TIME * noise_speed);
	float noise_value = texture(noise, noise_uv).r;
	
	vec2 distortion_uv = UV + (noise_value * noise_multiplier);
	vec4 distorted_texture = texture(texture_albedo, distortion_uv);
	
	COLOR.rgb = distorted_texture.rgb;
}
