extends Control
var gameoverwindow = load("res://2pgameover.tscn")
var p1control = load("res://2pui_p1.tscn")
var p2control = load("res://2pui_p2.tscn")

var p1stats = {"shields" : 100, "hull" : 100}
var p2stats = {"shields" : 100, "hull" : 100}
var gameover = false

func _ready():
	globals.mode = "2p"
# Called when the node enters the scene tree for the first time.
func _process(delta):
	print(globals.state)
	
	if globals.player1_ready and globals.player2_ready:
			globals.begin_turn($level_timer)
	# when we start up the scene for the first time we wait for the "init" signal to add the ships.
	
	if globals.state == "init":
		$playfield.add_ships()
		# we signal that the game is ready to play.
		globals.state = "idle"


# when the playfield has finished preparing itself.
func _on_playfield_ready():
	# collect the size of the cell (each screen will display the playfield different, this is resolution independant)
	var cell = get_tree().get_nodes_in_group("cell0")[0]
	globals.cellsize = cell.get_size().x

func p1go():
	if gameover:
		pass
	else:
		globals.state = "p1 gameover"
		add_child(gameoverwindow.instance())
		gameover = true
		

func p2go():
	if gameover:
		pass
	else:
		globals.state = "p2 gameover"
		add_child(gameoverwindow.instance())
		gameover = true
		
func _on_level_timer_timeout():
	globals.end_turn()


func _on_Timer_timeout():
	if globals.state == "start":
		globals.state = "init"


func p1ui_show():
	var newui = p1control.instance()
	add_child(newui)
	
func p2ui_show():
	var newui = p2control.instance()
	add_child(newui)
	