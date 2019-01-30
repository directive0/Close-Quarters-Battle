extends Control
export var player = 0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var timer 
# Called when the node enters the scene tree for the first time.
func _ready():
	timer = get_tree().get_nodes_in_group("level_timer")[0]
	pass # Replace with function body.s

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player == 0:
		if globals.player1_ready:
			$Controls/ColorRect3.set_frame_color(ColorN("darkred", 1))
		else:
			$Controls/ColorRect3.set_frame_color(ColorN("red", 1))
	if player == 1:
		if globals.player2_ready:
			$Controls/ColorRect3.set_frame_color(ColorN("darkred", 1))
		else:
			$Controls/ColorRect3.set_frame_color(ColorN("red", 1))
#	pass


func _on_Button_pressed():
	if globals.state == "start":
		globals.state = "init"
	pass # Replace with function body.


func _on_end_game_pressed():
	globals.reset()
	get_tree().change_scene("res://choice_page.tscn")



func _on_ready_pressed():
	#if globals.state == "idle":
		#$AudioStreamPlayer.play()
	#	globals.begin_turn(timer)
	#	globals.note_text = "Engaging!"
	if player == 0:
		globals.player1_ready = not globals.player1_ready
	if player == 1:
		globals.player2_ready = not globals.player2_ready