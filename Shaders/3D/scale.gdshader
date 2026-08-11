shader_type spatial;

uniform float scale_amount : hint_range(0.0, 2.0) = 0.5;

void vertex() {
	VERTEX *= (sin(TIME) + 1.0) / 2.0;
}

void fragment() {
	// Called for every pixel the material is visible on.
}