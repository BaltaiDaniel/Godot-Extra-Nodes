extends HBoxContainer

@export var child_added_trans_type := Tween.TRANS_BACK
@export var child_exited_trans_type := Tween.TRANS_SINE
@export var in_duration := 0.4
@export var out_duration := 0.4

var entered_node


#func _ready():
	#await get_tree().create_timer(5).timeout
	#var dummy_t = load("res://icon.svg")
	#var dummy = TextureRect.new()
	#dummy.texture = dummy_t
	#add_child(dummy)
	#await get_tree().create_timer(5).timeout
	#_custom_remove_child(get_node(_convert_object_to_nodename(entered_node)))
	#

func _on_child_entered_tree(node):
	if not node.name == "Animator":
		entered_node = node
		node.modulate.a = 0
		node.scale = Vector2(0,0)
		node.set_pivot_offset(Vector2(node.size.x/2, node.size.y/2))

		var tw = create_tween().set_trans(child_added_trans_type).set_ease(Tween.EASE_OUT).set_parallel()
		var tw2 = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		
		tw.tween_property(entered_node, "scale", Vector2(1,1), in_duration)
		tw.play()
		tw2.tween_property(entered_node, "modulate:a", 1, in_duration)
		tw2.play()
		
		print_debug(entered_node.name)
		


func _custom_remove_child(node):
	if not node.name == "Animator":
	
		var tw = create_tween().set_trans(child_exited_trans_type).set_ease(Tween.EASE_OUT).set_parallel()
		var tw2 = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
			
		tw.tween_property(entered_node, "scale", Vector2(0,0), out_duration)
		tw.play()
		tw2.tween_property(entered_node, "modulate:a", 0, out_duration)
		tw2.play()
		await tw2.finished
		node.queue_free()



func _convert_object_to_nodename(obj : Object) -> String:
	for i in get_children():
		if i.name == obj.name:
			return i.name
	return ""
