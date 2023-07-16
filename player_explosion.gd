extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$biguns.set_emitting(true)
	$quickuns.set_emitting(true)
	$AudioStreamPlayer.play()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_AudioStreamPlayer_finished():
	globals.state = "player dead"
	get_parent().queue_free()
	queue_free()

