extends Control
var menu = load("res://menu.tscn")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	get_parent().get_parent().add_child(menu.instance())
	#if globals.state == "start":
		#globals.state = "init"
		
	
	pass # Replace with function body.
