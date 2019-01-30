extends ProgressBar
var player

func _process(delta):
	
	if globals.state == "idle" or globals.state == "move":
		player = get_tree().get_nodes_in_group("player")[0]
		set_value(player.stats["hull"])

