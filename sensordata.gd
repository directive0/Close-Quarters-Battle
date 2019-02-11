extends Line2D
var pointdata
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if globals.state == "move":
		queue_free()
#	pass
func setup(target):
	
	if target.decider == 0:
		set_default_color(ColorN("blue", 1))
	if target.decider == 1:
		set_default_color(ColorN("red", 1))
	
	set_as_toplevel(true)
	pointdata = get_points()
	print("points got = ", pointdata)
	set_point_position(0, target.lastloc)
	set_point_position(1, target.newloc)
