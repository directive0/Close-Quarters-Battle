extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$ColorRect/VBoxContainer/body/VBoxContainer/HSlider.set_value(globals.opponents) 
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	
#	pass


func _on_Button_pressed():
	get_tree().change_scene("res://main.tscn")

	pass # Replace with function body.


func _on_HSlider_value_changed(value):
	globals.opponents = value
	pass # Replace with function body.
