extends Control



# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _process(delta):
	if globals.state == "init":
		$VBoxContainer/playfield.add_ships()
		globals.state == "ready"

func _on_playfield_ready():
	var cell = get_tree().get_nodes_in_group("cell0")[0]
	globals.cellsize = cell.get_size().x
	#print("cells look like: ", cell.get_size())
	#globals.state = "ready"
	pass # Replace with function body.


func _on_level_timer_timeout():
	globals.end_turn()
	pass # Replace with function body.
