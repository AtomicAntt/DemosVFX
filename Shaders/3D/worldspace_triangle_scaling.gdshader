shader_type spatial;
render_mode unshaded;

uniform vec4 modelColor : source_color;
uniform vec4 wireframeColor : source_color;

uniform float width : hint_range(0.0, 15.) = 1.;
uniform float modelOpacity : hint_range(0.0, 1.0) = 0.;

uniform bool filtered = false;

const vec3 vectors[3] = {
	vec3(1.0, 0.0 ,0.0),
	vec3(0.0, 1.0 ,0.0),
	vec3(0.0, 0.0 ,1.0)
};

varying vec3 baryCoord;

//uniform float triangle_scale : hint_range(0.0, 1.0) = 1.0;

varying vec3 world_pos;
global uniform vec3 effect_origin;
global uniform float effect_radius;

void vertex() {
	vec3 face_center = CUSTOM0.xyz;
	
	world_pos = (MODEL_MATRIX * vec4(face_center, 1.0)).xyz;
	float dist = distance(world_pos, effect_origin);
	float triangle_scale = smoothstep(dist-0.1, dist+0.1, effect_radius);
	
	// Remember, CUSTOM0 should be applied in our custom import script,
	// giving the vertex the local position of the vertex's face center.
	vec3 center_to_vertex = VERTEX - face_center;
	VERTEX = face_center + (center_to_vertex * triangle_scale);
	
	
	baryCoord = vectors[VERTEX_ID % 3];
}

void fragment() {
	vec3 dBaryCoordX = dFdx(baryCoord);
	vec3 dBaryCoordY = dFdy(baryCoord);
	vec3 dBaryCoord  = sqrt(dBaryCoordX*dBaryCoordX + dBaryCoordY*dBaryCoordY);

	vec3 remap = smoothstep(
		vec3(0.0),
		dBaryCoord * width,
		baryCoord
	);
	
	remap = filtered ? remap : step(.5, remap);

	float closestEdge = min(min(remap.x, remap.y), remap.z);

	ALBEDO = mix(wireframeColor, modelColor, closestEdge).xyz;
	ALPHA = mix(1., modelOpacity, closestEdge);
	ALPHA_SCISSOR_THRESHOLD = 0.5;
	
	//float dist = distance(world_pos, effect_origin);
	//if (dist < effect_radius) {
		//ALBEDO = vec3(1.0, 0.0, 0.0);
	//}
}