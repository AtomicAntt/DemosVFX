@tool
extends Node3D

## Direct setting to the effect radius global shader parameter.
#@export var effect_radius: float = 0.0:
	#set(new_radius):
		#effect_radius = new_radius
		#set_effect_radius(new_radius)
		
@export_tool_button("Animate Effect FadeIn", "Callable") var animate_action = animate
@export_tool_button("Animate Effect FadeOut", "Callable") var animation_action_out = animate_out

@export_tool_button("Reset", "Callable") var reset_action = reset

func animate() -> void:
	var tween: Tween = create_tween()
	tween.tween_method(set_effect_radius, 0.0, 50.0, 5.0)
	await tween.finished

func animate_out() -> void:
	var tween: Tween = create_tween()
	tween.tween_method(set_effect_radius, RenderingServer.global_shader_parameter_get("effect_radius"), 0.0, RenderingServer.global_shader_parameter_get("effect_radius")/10.0)
	await tween.finished

func reset() -> void:
	set_effect_radius(0.0)

func set_effect_radius(new_radius: float) -> void:
	RenderingServer.global_shader_parameter_set("effect_radius", new_radius)
