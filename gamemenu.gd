extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ok_pressed():
	globals.reset()
	get_tree().change_scene("res://choice_page.tscn")
	pass # Replace with function body.


func _on_cancel_pressed():
	queue_free()
	pass # Replace with function body.
