extends Control

var timer

func _ready():
	timer = get_tree().get_nodes_in_group("level_timer")[0]

func _on_Engage_pressed():
	if globals.state == "idle":
		globals.begin_turn(timer)

func _on_Set_course_pressed():
	if globals.state == "idle":
		$AudioStreamPlayer.play()
		globals.state = "set_move"
		globals.note_text = "Set desired course"

func _on_Target_weapons_pressed():
	if globals.state == "idle":
		#globals.chambered = $VBoxContainer/HBoxContainer2/OptionButton.get_selected() 
		$AudioStreamPlayer.play()
		globals.state = "set_target"
		globals.note_text = "Please select a target"
