extends Control
var gameoverwindow = load("res://gameover.tscn")

var opponents
var stellarobjects = false
var collisions = false



# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func _ready():
	globals.mode = "1p"
	opponents = globals.opponents
# Called when the node enters the scene tree for the first time.
func _process(delta):
	
	# when we start up the scene for the first time we wait for the "init" signal to add the ships.
	if globals.state == "init":
		$playfield.add_ships()
		# we signal that the game is ready to play.
		globals.state == "ready"

	if globals.state == "move":
		var enemies = get_tree().get_nodes_in_group("enemy").size()
		#print(enemies, " left.")
		if enemies <= 0:
			print("no enemies left")
			globals.state = "enemy gameover"
			$gameoverbox.add_child(gameoverwindow.instance())
	

	if globals.state == "player dead":
		print("player died")
		globals.state = "player gameover"
		$gameoverbox.add_child(gameoverwindow.instance())
# when the playfield has finished preparing itself.
func _on_playfield_ready():
	# collect the size of the cell (each screen will display the playfield different, this is resolution independant)
	var cell = get_tree().get_nodes_in_group("cell")[0]
	globals.cellsize = cell.get_size().x

func ship_died():
		var enemies = get_tree().get_nodes_in_group("enemy").size()
		print("ship died! ", enemies, " left.")
		if enemies <= 0:
			globals.state = "enemy gameover"
			add_child(gameoverwindow.instance())
	
func _on_level_timer_timeout():
	globals.end_turn()


func _on_Timer_timeout():
	if globals.state == "start":
		globals.state = "init"
