extends ColorRect
export var controls = 0
var sound
var player

export var active_colour = Color(0.84,0.87,0,1)
export var inactive_colour = Color(0.84,0.87,0,1)
export var black_colour = Color(0.84,0.87,0,1)
export var white_colour = Color(0.84,0.87,0,1)


# Called when the node enters the scene tree for the first time.
func _ready():
	sound = get_parent().get_node("AudioStreamPlayer")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	if get_tree().get_nodes_in_group("player").size() > 0:
		
		player = get_tree().get_nodes_in_group("player")[0]
		
		if player.chambered == true:
			
			if globals.chambered == controls:
				$Button.set("custom_colors/font_color", black_colour)
				set_frame_color(active_colour)
			else:
				$Button.set("custom_colors/font_color", white_colour)
				set_frame_color(inactive_colour)
		else:
			$Button.set("custom_colors/font_color", white_colour)
			set_frame_color(inactive_colour)

func _on_Button_pressed():
	if globals.state == "idle":
		#$AudioStreamPlayer.play()
		globals.state = "set_target"
		globals.note_text = "Please select a target"
		sound.play()
		globals.chambered = controls

