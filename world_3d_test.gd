@tool
class_name World3DTest
extends Node3D

@export_tool_button("Animate Effect FadeIn", "Callable") var animate_action = animate
@export_tool_button("Animate Effect FadeOut", "Callable") var animation_action_out = animate_out
@export_tool_button("Reset", "Callable") var reset_action = reset

var tween: Tween

## In m/s
@export var world_effect_speed: float = 150.0
## In m
@export var world_effect_radius: float = 50.0

@export var world_effect_origin: Marker3D

func animate() -> void:
	set_effect_origin()
	reset()
	tween = create_tween()
	tween.tween_method(set_wireframe_effect_radius, 0.0, world_effect_radius, world_effect_radius / world_effect_speed)
	tween.tween_method(set_effect_radius, 0.0, world_effect_radius, world_effect_radius / world_effect_speed).set_trans(Tween.TRANS_EXPO)

func animate_out() -> void:
	set_effect_origin()
	set_effect_radius(world_effect_radius)
	set_wireframe_effect_radius(world_effect_radius)
	
	tween = create_tween()
	tween.tween_method(set_effect_radius, world_effect_radius, 0.0, world_effect_radius / world_effect_speed).set_trans(Tween.TRANS_EXPO)
	tween.tween_method(set_wireframe_effect_radius, world_effect_radius, 0.0, world_effect_radius / world_effect_speed)

func reset() -> void:
	if is_instance_valid(tween):
		tween.stop()
	set_effect_radius(0.0)
	set_wireframe_effect_radius(0.0)

func set_effect_radius(new_radius: float) -> void:
	RenderingServer.global_shader_parameter_set("effect_radius", new_radius)

func set_wireframe_effect_radius(new_radius: float) -> void:
	RenderingServer.global_shader_parameter_set("wireframe_effect_radius", new_radius)

func set_effect_origin() -> void:
	if is_instance_valid(world_effect_origin):
		RenderingServer.global_shader_parameter_set("effect_origin", world_effect_origin.global_position)
