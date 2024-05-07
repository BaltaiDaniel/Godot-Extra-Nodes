@tool
extends ColorRect
class_name blur_bg


@export var blur_color := Color(1,1,1,1)
@export var amount := 3.0
@export var duration := 0.3

func _ready():
	var mat = load("res://CUSTOM_NODES/Dependencies/shaders/blur_shader.tres")
	set_material(mat)
	get_material().set_shader_parameter("col", blur_color)
	get_material().set_shader_parameter("amount", amount)

func _show(s:bool):
	if s:
		visible = true
		modulate.a = 0
		
		var tw = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		tw.tween_property(self, "modulate:a", 1, duration)
		tw.play()
	else:
		var tw = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		tw.tween_property(self, "modulate:a", 0, duration)
		tw.play()
		await tw.finished
		visible = false
