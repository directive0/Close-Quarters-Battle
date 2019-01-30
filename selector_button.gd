extends ColorRect
export var controls = 0


var red_colour = ColorN("darkred", 1)
var grey_colour = ColorN("darkgrey", 1)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if globals.chambered == controls:
		set_frame_color(red_colour)
	else:
		set_frame_color(grey_colour)
		
#	pass


func _on_Button_pressed():
	globals.chambered = controls
	pass # Replace with function body.
