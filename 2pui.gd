extends Control

var timer

var weaponstr = ["Particle Beam", "Torpedo"]
var weaponselect



export var playerno = 0

func _process(delta):
	pass

func _ready():
	if playerno == 0:
		weaponselect = globals.player1_weapon
	elif playerno == 1:
		weaponselect = globals.player2_weapon
	
	$VBoxContainer/helmandtactical/VBoxContainer/change_weapon.set_text(weaponstr[weaponselect])
	pass
#	timer = get_tree().get_nodes_in_group("level_timer")[0]

func _on_Engage_pressed():
	if globals.state == "idle":
		globals.begin_turn(timer)

func _on_Set_course_pressed():
	$AudioStreamPlayer.play()
	if globals.state == "p1decide":
		
		globals.state = "p1_set_move"
		globals.note_text = "Set desired course"
		get_parent().queue_free()
		
	if globals.state == "p2decide":
		
		globals.state = "p2_set_move"
		globals.note_text = "Set desired course"
		get_parent().queue_free()

func _on_Target_weapons_pressed():
	$AudioStreamPlayer.play()
	if globals.state == "p1decide":
		#globals.chambered = $VBoxContainer/HBoxContainer2/OptionButton.get_selected() 
		$AudioStreamPlayer.play()
		globals.state = "p1_set_target"
		globals.note_text = "Please select a target"
		get_parent().queue_free()
		
	if globals.state == "p2decide":
		#globals.chambered = $VBoxContainer/HBoxContainer2/OptionButton.get_selected() 
		$AudioStreamPlayer.play()
		globals.state = "p2_set_target"
		globals.note_text = "Please select a target"
		get_parent().queue_free()
		

func _on_okay_pressed():
	if globals.state == "idle":
		globals.begin_turn(timer)



func _on_cancel_pressed():
	globals.state = "idle"
	get_parent().queue_free()
	
func _on_Button_pressed():
	if globals.state == "idle":
		$AudioStreamPlayer.play()
		globals.begin_turn(timer)
		globals.note_text = "Engaging!"
	pass # Replace with function body.

func _on_change_weapon_pressed():

	if playerno == 0:
		globals.player1_weapon += 1
		if globals.player1_weapon > 1:
			globals.player1_weapon = 0
		$VBoxContainer/helmandtactical/VBoxContainer/change_weapon.set_text(weaponstr[globals.player1_weapon])
	
	elif playerno == 1:
		globals.player2_weapon += 1
		if globals.player2_weapon > 1:
			globals.player2_weapon = 0
		$VBoxContainer/helmandtactical/VBoxContainer/change_weapon.set_text(weaponstr[globals.player2_weapon])
		
	pass # Replace with function body.
