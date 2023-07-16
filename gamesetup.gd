extends Control

func _ready():
	$ColorRect/VBoxContainer/body/VBoxContainer/HSlider.set_value(globals.opponents) 
	pass # Replace with function body.


func _on_Button_pressed():
	get_tree().change_scene("res://main.tscn")

	pass # Replace with function body.


func _on_HSlider_value_changed(value):
	globals.opponents = value
	pass # Replace with function body.


func _on_Button2_pressed():
	get_tree().change_scene("res://choice_page.tscn")
	
	pass # Replace with function body.
