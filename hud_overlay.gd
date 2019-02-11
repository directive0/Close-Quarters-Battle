extends Label
var target

func _process(delta):
	if globals.state == "idle":
		target = get_parent()
	
	if globals.state == "move":
		set_text(str(target.stats["shield"]))
#	pass
