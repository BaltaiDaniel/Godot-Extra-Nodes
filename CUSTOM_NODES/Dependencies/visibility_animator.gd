extends Node

@export var in_animation = "fade_in"
@export var out_animation = "fade_out"
var stacking_nodes : Array = []			:set = set_stacking_nodes

func _ready():
	get_parent().connect("visibility_changed", _on_visibility_changed.bind(get_parent()))

func set_stacking_nodes(stk_nds : Array):
	stacking_nodes = stk_nds

func _on_visibility_changed(node):
	if node.visible:
		for i in stacking_nodes:
			if i.has_method("set_modulate"):
				i.modulate.a = 0
			
		$Animator.animate([get_parent()], in_animation)
		
		await get_tree().create_timer(.4).timeout
		
		animate_stacking_nodes()

	else:
		$Animator.animate([get_parent()], out_animation)


func animate_stacking_nodes():
	#var tw = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT).set_parallel()
	for i in stacking_nodes:
		#tw.tween_property(i, "modulate:a", 1, .4).set_delay((i.get_index()+0.1)/stacking_nodes.size())
		#tw.play()
		
		$Animator.animate(
			[i], "fade_in", $Animator.DURATION.normal, [], Tween.TRANS_QUINT,
			Tween.EASE_OUT, Tween.TRANS_SINE, Tween.EASE_OUT, (i.get_index()+0.1)/stacking_nodes.size()
		)
