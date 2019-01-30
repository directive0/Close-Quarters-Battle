extends Control
var gameoverwindow = load("res://gameover.tscn")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func _ready():
	globals.mode = "1p"
# Called when the node enters the scene tree for the first time.
func _process(delta):
	
	# when we start up the scene for the first time we wait for the "init" signal to add the ships.
	if globals.state == "init":
		$VBoxContainer/playfield.add_ships()
		# we signal that the game is ready to play.
		globals.state == "ready"
		
	# if the game has ended, display the game over window
	if globals.state == "enemy dead":
		globals.state = "enemy gameover"
		add_child(gameoverwindow.instance())
		
	if globals.state == "player dead":
		globals.state = "player gameover"
		add_child(gameoverwindow.instance())
# when the playfield has finished preparing itself.
func _on_playfield_ready():
	# collect the size of the cell (each screen will display the playfield different, this is resolution independant)
	var cell = get_tree().get_nodes_in_group("cell0")[0]
	globals.cellsize = cell.get_size().x


func _on_level_timer_timeout():
	globals.end_turn()


func _on_Timer_timeout():
	if globals.state == "start":
		globals.state = "init"
