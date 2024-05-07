extends PanelContainer

@export var title := ""				:set = set_title
@export var content := ""			:set = set_content
@export var primary_text := ""		:set = set_primary_text
@export var secondary_text := ""	:set = set_secondary_text

signal primary_action
signal secondary_action



func _show(s : bool, dict := {}):
	if s:
		visible = true
		$Animator.animate([self, $Diag], "fade_in_scale_out", $Animator.DURATION.normal, [0, Vector2(0,0)])
		
		set_title(dict.get("title"))
		set_content(dict.get("content"))
		set_primary_text(dict.get("primary_text"))
		set_secondary_text(dict.get("secondary_text"))
	else:
		$Animator.animate([self, $Diag], "fade_in_scale_out", $Animator.DURATION.normal)
		await $Animator.out_tw.finished
		visible = false


func set_title(ti : String):
	$Diag/VBoxContainer/Title.set_text(ti)
	title = ti

func set_content(cont : String):
	$Diag/VBoxContainer/Content.set_text(cont)
	content = cont

func set_primary_text(pri_txt : String):
	$Diag/VBoxContainer/Buttons/PrimaryBtn.set_text(pri_txt)
	primary_text = pri_txt

func set_secondary_text(sec_txt : String):
	$Diag/VBoxContainer/Buttons/SecondaryBtn.set_text(sec_txt)
	secondary_text = sec_txt


func _on_primary_btn_pressed():
	emit_signal("primary_action")
	print_debug(">>>>>>>> Emitted signal:	primary_action")

func _on_secondary_btn_pressed():
	emit_signal("secondary_action")
	print_debug(">>>>>>>> Emitted signal:	secondary_action")
