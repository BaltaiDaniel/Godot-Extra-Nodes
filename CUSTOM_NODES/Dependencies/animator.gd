extends Node
enum DURATION{short, normal, long, extra_long}


var in_tw : Tween
var out_tw : Tween


func animate(
	nodes : Array, animation : String, duration : DURATION = DURATION.normal, 
	from = [], in_trans_type := Tween.TRANS_QUINT, 
	in_ease_type := Tween.EASE_OUT, out_trans_type := Tween.TRANS_SINE,
	out_ease_type := Tween.EASE_IN, delay = 0
):
	in_tw = create_tween().set_parallel().set_trans(in_trans_type).set_ease(in_ease_type)
	out_tw = create_tween().set_parallel().set_trans(out_trans_type).set_ease(out_ease_type)
	for node in nodes:
		if node.has_method("set_size"):
			node.set_pivot_offset(Vector2(node.size.x/2, node.size.y/2))
	var _duration := 0
	
	match duration:
		0: _duration = 1.1
		1: _duration = 1.4
		2: _duration = 1.7
		3: _duration = 2
	
	match animation:
		"fade_in":
			if nodes[0].has_method("set_visible"):
				nodes[0].visible = true
			if from.size() > 0:
				in_tw.tween_property(nodes[0], "modulate:a", 1, _duration).from(from[0]).set_delay(delay)
			else:
				in_tw.tween_property(nodes[0], "modulate:a", 1, _duration).set_delay(delay)
		"fade_out":
			if from.size() > 0:
				out_tw.tween_property(nodes[0], "modulate:a", 0, _duration).from(from[0]).set_delay(delay)
			else:
				out_tw.tween_property(nodes[0], "modulate:a", 0, _duration).set_delay(delay)
				await out_tw.finished
				if nodes[0].has_method("set_visible"):
					nodes[0].visible = false
		
		"fade_in_with_bg":
			for n in nodes:
				if n.has_method("set_visible"):
					n.visible = true
			if from.size() > 0:
				in_tw.tween_property(nodes[0], "modulate:a", 1, _duration).from(from[0])
				in_tw.tween_property(nodes[1], "modulate:a", 1, _duration).from(from[1]).set_delay(_duration/2)
			else:
				in_tw.tween_property(nodes[0], "modulate:a", 1, _duration)
				in_tw.tween_property(nodes[1], "modulate:a", 1, _duration).set_delay(_duration/2)
		"fade_out_with_bg":
			if from.size() > 0:
				out_tw.tween_property(nodes[0], "modulate:a", 0, _duration).from(from[0])
				out_tw.tween_property(nodes[1], "modulate:a", 0, _duration).from(from[1]).set_delay(_duration/2)
			else:
				out_tw.tween_property(nodes[0], "modulate:a", 0, _duration)
				out_tw.tween_property(nodes[1], "modulate:a", 0, _duration).set_delay(_duration/2)
				await out_tw.finished
				for n in nodes:
					if n.has_method("set_visible"):
						nodes[0].visible = false
						nodes[1].visible = false
		
		"scale_in":
			if from.size() > 0:
				out_tw.tween_property(nodes[0], "scale", Vector2(0,0), _duration).from(from[0]).set_delay(delay)
			else:
				out_tw.tween_property(nodes[0], "scale", Vector2(0,0), _duration).set_delay(delay)
			await out_tw.finished
			if nodes[0].has_method("set_visible"):
				nodes[0].visible = false
		"scale_out":
			if nodes[0].has_method("set_visible"):
				nodes[0].visible = true
			if from.size() > 0:
				in_tw.tween_property(nodes[0], "scale", Vector2(1,1), _duration).from(from[0]).set_delay(delay)
			else:
				in_tw.tween_property(nodes[0], "scale", Vector2(1,1), _duration).set_delay(delay)
		
		"fade_out_scale_in":
			if from.size() > 0:
				out_tw.tween_property(nodes[1], "scale", Vector2(0,0), _duration/2).from(from[0]).set_delay(delay)
			else:
				out_tw.tween_property(nodes[1], "scale", Vector2(0,0), _duration/2)
			out_tw.tween_property(nodes[0], "modulate:a", 0, _duration).set_delay(_duration/2)
			await out_tw.finished
			if nodes[0].has_method("set_visible"):
				nodes[0].visible = false
		"fade_in_scale_out":
			if nodes[0].has_method("set_visible"):
				nodes[0].visible = true
			if from.size() > 0:
				in_tw.tween_property(nodes[1], "scale", Vector2(1,1), _duration).set_delay(_duration/2).from(from[1])
			else:
				in_tw.tween_property(nodes[1], "scale", Vector2(1,1), _duration).set_delay(_duration/2)
			in_tw.tween_property(nodes[0], "modulate:a", 1, _duration)
				
				
				
		"bounce_down":
			var tw1 = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT_IN).set_parallel()
			tw1.tween_property(nodes[0], "position:y", nodes[0].position.y-15, _duration/2.5).set_delay(delay)
			tw1.tween_property(nodes[0], "position:y", nodes[0].position.y+30, _duration/2).set_delay(delay)
			tw1.play()
		"bounce_up":
			var tw1 = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT_IN).set_parallel()
			tw1.tween_property(nodes[0], "position:y", nodes[0].position.y+15, _duration/2.5).set_delay(delay)
			tw1.tween_property(nodes[0], "position:y", nodes[0].position.y-30, _duration/2).set_delay(delay)
			tw1.play()
		"bounce_left":
			var tw1 = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT_IN).set_parallel()
			tw1.tween_property(nodes[0], "position:x", nodes[0].position.x+15, _duration/2.5).set_delay(delay)
			tw1.tween_property(nodes[0], "position:x", nodes[0].position.x-30, _duration/2).set_delay(delay)
			tw1.play()
		"bounce_right":
			var tw1 = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT_IN).set_parallel()
			tw1.tween_property(nodes[0], "position:x", nodes[0].position.x-15, _duration/2.5).set_delay(delay)
			tw1.tween_property(nodes[0], "position:x", nodes[0].position.x+30, _duration/2).set_delay(delay)
			tw1.play()
		"bounce_center":
			var tw1 = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT_IN).set_parallel()
			tw1.tween_property(nodes[0], "scale", Vector2(.5, .5), _duration/2.5).set_delay(delay)
			tw1.tween_property(nodes[0], "scale", Vector2(1, 1), _duration/2).set_delay(delay)
			tw1.play()
		
				
	in_tw.play()
	out_tw.play()
	
	
