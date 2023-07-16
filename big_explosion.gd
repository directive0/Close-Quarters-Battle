extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$biguns.set_emitting(true)
	$quickuns.set_emitting(true)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	#get_tree().get_nodes_in_group("main")[0].ship_died()
	get_parent().queue_free()
	pass # Replace with function body.
