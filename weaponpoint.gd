extends Position2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if globals.state == "move":
		if not get_tree().get_nodes_in_group("player")[0].destroyed:
			set_global_position(get_parent().get_node("Sprite/Position2D").get_global_position())
#	pass
