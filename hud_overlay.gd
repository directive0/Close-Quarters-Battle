extends Label
var target

func _process(delta):
	if globals.state == "idle":
		target = get_tree().get_nodes_in_group("enemy")[0]
	
	if globals.state == "move":
		set_text(str(target.stats["shield"]))
#	pass
