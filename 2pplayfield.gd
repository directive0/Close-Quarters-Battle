extends Control
var player = load("res://2pship.tscn")
var ship_space

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():

	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func distinguish_cell():
	pass

func _on_GridContainer_ready():
	# call deferred so we don't load ships into a playfield that has not settled on its final resolution.
	#call_deferred("add_ships")
	pass

# add the ships to their starting positions
func add_ships():
	ship_space = get_tree().get_nodes_in_group("ship_space")[0]
	print("playfield ready")
	var p1 = player.instance()
	
	var p2 = player.instance()
	p1.playerno = 0
	ship_space.add_child(p1)
	p2.playerno = 1
	ship_space.add_child(p2)
	
	p1.start_cell = 115
	
	p1.add_to_group("p1")
	p1.place()
	
	p2.start_cell = 5
	p2.playerno = 1
	p2.add_to_group("p2")
	p2.place()
	
	globals.state = "idle"