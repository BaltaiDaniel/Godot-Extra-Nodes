extends PanelContainer

signal pressed

@export var text := ""							
@export var icon : Texture = null				
@export var is_pressed : = false				
@export var down_trans_type := Tween.new().TRANS_SINE
@export var up_trans_type := Tween.new().TRANS_BOUNCE
@export var down_trans_ease := Tween.new().EASE_IN
@export var up_trans_ease := Tween.new().EASE_OUT
@export var influence_parent : = false				
@export var ignore_scroll : = false				
var _is_disabled

var tw : Tween


func _ready():
	$MarginContainer/InfoBox/Text.set_text(text)
	$MarginContainer/InfoBox/Icon.set_texture(icon)
	tw = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN).set_parallel()

func _process(delta):
	if $MarginContainer/InfoBox/Icon.texture == null:
		$MarginContainer/InfoBox/Icon.hide()
	else:
		$MarginContainer/InfoBox/Icon.show()



func _on_mouse_entered():
	if not is_pressed:
		$AnimationPlayer.play("hover")

func _on_mouse_exited():
	if not is_pressed:
		$AnimationPlayer.play_backwards("hover")


func _on_btn_toggled(toggled_on):
	is_pressed = toggled_on
	if toggled_on:
		$AnimationPlayer.play("pressed")
		emit_signal("pressed")
		is_pressed = true
		
	else:
		$AnimationPlayer.play_backwards("pressed")
		is_pressed = false



func _on_btn_button_down():
	if ignore_scroll:
		if not _is_disabled:
			if influence_parent:
				get_parent().set_pivot_offset(Vector2(get_parent().size.x/2, get_parent().size.y/2))
				var tw2 = create_tween().set_trans(down_trans_type).set_ease(down_trans_ease).set_parallel()
				tw2.tween_property(get_parent(), "scale", Vector2(0.9,0.9), .1)
				tw2.play()
			set_pivot_offset(Vector2(size.x/2, size.y/2))
			tw.tween_property(self, "scale", Vector2(0.9,0.9), .1)
			tw.play()
	else:
		if influence_parent:
				get_parent().set_pivot_offset(Vector2(get_parent().size.x/2, get_parent().size.y/2))
				var tw2 = create_tween().set_trans(down_trans_type).set_ease(down_trans_ease).set_parallel()
				tw2.tween_property(get_parent(), "scale", Vector2(0.9,0.9), .1)
				tw2.play()
		set_pivot_offset(Vector2(size.x/2, size.y/2))
		var tw2 = create_tween().set_trans(down_trans_type).set_ease(down_trans_ease)
		tw2.tween_property(self, "scale", Vector2(0.9,0.9), .1)
		tw2.play()


func _on_btn_button_up():
	if ignore_scroll:
		if not _is_disabled:
			if influence_parent:
				get_parent().set_pivot_offset(Vector2(get_parent().size.x/2, get_parent().size.y/2))
				var tw2 = create_tween().set_trans(up_trans_type).set_ease(up_trans_ease).set_parallel()
				tw2.tween_property(get_parent(), "scale", Vector2(1,1), .1)
				tw2.play()
			set_pivot_offset(Vector2(size.x/2, size.y/2))
			var tw2 = create_tween().set_trans(up_trans_type).set_ease(up_trans_ease) ## was trans bounce
			tw2.tween_property(self, "scale", Vector2(1,1), .2)
			tw2.play()
	else:
		if influence_parent:
				get_parent().set_pivot_offset(Vector2(get_parent().size.x/2, get_parent().size.y/2))
				var tw2 = create_tween().set_trans(up_trans_type).set_ease(up_trans_ease).set_parallel()
				tw2.tween_property(get_parent(), "scale", Vector2(1,1), .1)
				tw2.play()
		set_pivot_offset(Vector2(size.x/2, size.y/2))
		var tw2 = create_tween().set_trans(up_trans_type).set_ease(up_trans_ease) ## was trans bounce
		tw2.tween_property(self, "scale", Vector2(1,1), .2)
		tw2.play()
