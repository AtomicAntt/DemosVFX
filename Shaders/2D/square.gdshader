shader_type canvas_item;

uniform float square_size1 : hint_range(0.1, 0.5) = 0.25;
uniform float square_size2 : hint_range(0.1, 0.5) = 0.35;

uniform float blur : hint_range(0.0, 0.2) = 0.02;

void fragment() {
	vec2 center = UV - vec2(0.5, 0.5);
	//vec2 radius = abs(center);
	//float highest_radius = max(radius.x, radius.y);
	//float value1 = smoothstep(square_size1-blur, square_size1+blur, highest_radius);
	//float value2 = 1.0-smoothstep(square_size2-blur, square_size2+blur, highest_radius);
	//float value = value1 * value2;
	//
	//COLOR.rgb = vec3(value);
	
	float r = length(max(abs(center)-.1, 0.0));
	//// We can't do below because values might become negative, which with length, equates to a positive number
	////r = length(abs(center)-.1);
	//
	//COLOR.rgb = vec3(r);
	
	float value = step(square_size1, r);
	COLOR.rgb = vec3(value);
}