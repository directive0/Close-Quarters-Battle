extends Control

var timer
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	timer = get_tree().get_nodes_in_group("level_timer")[0]
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _on_Button_pressed():
	if globals.state == "idle":
		$AudioStreamPlayer.play()
		globals.begin_turn(timer)
		globals.note_text = "Engaging!"
	pass # Replace with function body.
