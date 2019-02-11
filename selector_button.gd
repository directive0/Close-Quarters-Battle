extends ColorRect
export var controls = 0
var sound

var active_colour = Color(0.84,0.87,0,1)
var inactive_colour = ColorN("darkgrey", 1)
var black_colour = ColorN("black", 1)
var white_colour = ColorN("white", 1)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	sound = get_parent().get_node("AudioStreamPlayer")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if globals.chambered == controls:
		$Button.set("custom_colors/font_color", black_colour)
		set_frame_color(active_colour)
	else:
		$Button.set("custom_colors/font_color", white_colour)
		set_frame_color(inactive_colour)

		
#	pass


func _on_Button_pressed():
	if globals.state == "idle":
		#$AudioStreamPlayer.play()
		globals.state = "set_target"
		globals.note_text = "Please select a target"
	sound.play()
	globals.chambered = controls
	pass # Replace with function body.
