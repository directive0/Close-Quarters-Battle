extends Control
var grid
var moving = false
var lastloc
var newloc
var courset
var t = 0.0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	#print("moving enemy for first time")
	grid = get_tree().get_nodes_in_group("grid")[0].get_children()
	var first_spot = grid[120]
	var first_pos = first_spot.get_global_position()
	var first_size = Vector2(first_spot.get_size().x,first_spot.get_size().x)
	
	set_size(first_size)
	jump_to(first_pos)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	if moving == true:
		move()
#	pass

func jump_to(location):
	set_global_position(location)

func move_to(destination):
	if moving:
		pass
	else:
		newloc = destination
		lastloc = get_global_position()
		moving = true



func move():
	if get_global_position() == newloc:
		moving = false
		t = 0.0
	else:
		var current = lastloc.linear_interpolate(newloc,t)
		set_global_position(current)
		t += 0.01