extends Button
@export var influence_parent := false
@export var _is_disabled := false
@export var ignore_scroll := false
@export var down_trans_type := Tween.new().TRANS_SINE
@export var up_trans_type := Tween.new().TRANS_BOUNCE
@export var down_trans_ease := Tween.new().EASE_IN
@export var up_trans_ease := Tween.new().EASE_OUT
var tw : Tween

func _ready():
	connect("button_down", _on_btn_down)
	connect("button_up", _on_btn_up)
	tw = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN).set_parallel()
	
	
func _on_btn_down():
	if ignore_scroll:
		if not _is_disabled or disabled == false:
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

func _on_btn_up():
	if ignore_scroll:
		if not _is_disabled or disabled == false:
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



func _on_CustomBtn_gui_input(event):
	if event is InputEventScreenDrag:# or event is InputEventMouseMotion:
		disabled = true
		_is_disabled = true
	else:
		disabled = false
		_is_disabled = false
