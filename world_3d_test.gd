@tool
extends Node3D

## Direct setting to the effect radius global shader parameter.
#@export var effect_radius: float = 0.0:
	#set(new_radius):
		#effect_radius = new_radius
		#set_effect_radius(new_radius)
		
@export_tool_button("Animate Effect", "Callable") var animate_action = animate

func animate() -> void:
	var tween: Tween = create_tween()
	tween.tween_method(set_effect_radius, 0.0, 50.0, 10.0)
	await tween.finished
	set_effect_radius(0.0)

func set_effect_radius(new_radius: float) -> void:
	RenderingServer.global_shader_parameter_set("effect_radius", new_radius)
