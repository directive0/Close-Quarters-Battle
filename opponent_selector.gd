extends ColorRect
export var controls = 0
var sound

export var active_colour = Color(0.84,0.87,0,1)
export var inactive_colour = Color(0.84,0.87,0,1)
export var black_colour = Color(0.84,0.87,0,1)
export var white_colour = Color(0.84,0.87,0,1)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	sound = get_parent().get_node("AudioStreamPlayer")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if globals.species == controls:
		$Button.set("custom_colors/font_color", black_colour)
		set_frame_color(active_colour)
	else:
		$Button.set("custom_colors/font_color", white_colour)
		set_frame_color(inactive_colour)


#	pass


func _on_Button_pressed():
	sound.play()
	globals.species = controls

