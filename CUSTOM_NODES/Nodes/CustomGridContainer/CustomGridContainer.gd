extends GridContainer

@export var child_added_trans_type := Tween.TRANS_BACK
@export var child_exited_trans_type := Tween.TRANS_SINE
@export var in_duration := 0.4
@export var out_duration := 0.4


func _ready():
	for i in self.get_children():
		if i.has_method("set_modulate"):
			i.modulate.a = 0
	############  FOR TESTING #############
	await get_tree().create_timer(5).timeout
	var dummy_t = load("res://icon.svg")
	var dummy = TextureRect.new()
	dummy.texture = dummy_t
	add_child(dummy)
	var dummy2 = TextureRect.new()
	dummy2.texture = dummy_t
	add_child(dummy2)
	var dummy3 = TextureRect.new()
	dummy3.texture = dummy_t
	add_child(dummy3)
	var dummy4 = TextureRect.new()
	dummy4.texture = dummy_t
	add_child(dummy4)
	var dummy5 = TextureRect.new()
	dummy5.texture = dummy_t
	add_child(dummy5)
	var dummy6 = TextureRect.new()
	dummy6.texture = dummy_t
	add_child(dummy6)
	await get_tree().create_timer(1).timeout
	set_visible(true)
	await get_tree().create_timer(5).timeout
	_custom_remove_child(get_node(_convert_object_to_nodename(dummy)))
	#########################################


func _on_child_entered_tree(node):
	$VisibilityAnimator.stacking_nodes.append(node)

func _custom_remove_child(node):
	if node in $VisibilityAnimator.stacking_nodes:
		$VisibilityAnimator.stacking_nodes.erase(node)
	
	#var tw = create_tween().set_trans(child_exited_trans_type).set_ease(Tween.EASE_OUT).set_parallel()
	var tw2 = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		
	#tw.tween_property(node, "scale", Vector2(0,0), out_duration)
	#tw.play()
	tw2.tween_property(node, "modulate:a", 0, out_duration)
	tw2.play()
	await tw2.finished
	node.queue_free()

func _convert_object_to_nodename(obj : Object) -> String:
	for i in get_children():
		if i.name == obj.name:
			return i.name
	return ""


