extends Area2D
var enemy
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	#enemy = get_tree().get_nodes_in_group("enemy")[0]
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func hit(damage = 20):
	get_parent().get_parent().hit(damage)