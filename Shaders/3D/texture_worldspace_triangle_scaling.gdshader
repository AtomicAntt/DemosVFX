shader_type spatial;

//uniform vec4 modelColor : source_color;
uniform sampler2D modelTexture : source_color;
uniform vec4 wireframeColor : source_color;
uniform float width : hint_range(0.0, 15.) = 1.;

uniform bool filtered = false;

const vec3 vectors[3] = {
	vec3(1.0, 0.0 ,0.0),
	vec3(0.0, 1.0 ,0.0),
	vec3(0.0, 0.0 ,1.0)
};

varying vec3 baryCoord;

varying vec3 world_pos;
global uniform vec3 effect_origin;
global uniform float effect_radius;
varying float progress;

void vertex() {
	// Remember, CUSTOM0 should be applied in our custom import script,
	// giving the vertex the local position of the vertex's face center.
	vec3 face_center = CUSTOM0.xyz;
	
	world_pos = (MODEL_MATRIX * vec4(face_center, 1.0)).xyz;
	float dist = distance(world_pos, effect_origin);
	progress = smoothstep(dist-2.0, dist+2.0, effect_radius);
	// The first half of the transition should be wireframing
	float triangle_scale = smoothstep(0.0, 0.5, progress);
	
	vec3 center_to_vertex = VERTEX - face_center;
	VERTEX = face_center + (center_to_vertex * triangle_scale);
	
	baryCoord = vectors[VERTEX_ID % 3];
}

void fragment() {
	vec4 textureColor = texture(modelTexture, UV);
	
	vec3 dBaryCoordX = dFdx(baryCoord);
	vec3 dBaryCoordY = dFdy(baryCoord);
	vec3 dBaryCoord  = sqrt(dBaryCoordX*dBaryCoordX + dBaryCoordY*dBaryCoordY);
	
	// The second half of the transiton is giving the model back its color
	float modelOpacity = smoothstep(0.9, 1.0, progress);
	float used_width = width;
	// While we are giving the model back its color, we want to also remove
	// the wireframe. We'll do this by shrinking the wireframe width.
	used_width *= 1.0-modelOpacity;
	
	vec3 remap = smoothstep(
		vec3(0.0),
		dBaryCoord * used_width,
		baryCoord
	);
	
	remap = filtered ? remap : step(.5, remap);

	float closestEdge = min(min(remap.x, remap.y), remap.z);

	ALBEDO = mix(wireframeColor, textureColor, closestEdge).xyz;
	closestEdge -= modelOpacity;
	ALPHA = mix(1., modelOpacity, closestEdge);
	ALPHA_SCISSOR_THRESHOLD = 0.5;
	ALPHA_HASH_SCALE = 1.0;
}

void light() {
	if (LIGHT_IS_AREA) {
        // Area light GGX shading.
        DIFFUSE_LIGHT += LIGHT_AREA_DIFFUSE_MULTIPLIER * ATTENUATION * LIGHT_COLOR;
        SPECULAR_LIGHT += LIGHT_AREA_SPECULAR_MULTIPLIER * ATTENUATION * LIGHT_COLOR * SPECULAR_AMOUNT;
    } else {
        // Used for all other light types (directional, omni, spot).
        DIFFUSE_LIGHT += clamp(dot(NORMAL, LIGHT), 0.0, 1.0) * ATTENUATION * LIGHT_COLOR / PI;
    }

	if (progress < 0.9) {
		DIFFUSE_LIGHT = ALBEDO;
	}
}