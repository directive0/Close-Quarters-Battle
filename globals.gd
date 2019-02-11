extends Node
var version = "Open Beta v1.4a"
var version2 = "(The 'How about this?' update!)"
var player = {}
var enemy = {}
var state = "start"
var moving = false
var firing = false
var cellsize

var mode = "unset"


# 2p variables
var player1_turn
var player2_turn
var player1_ready = false
var player2_ready = false
var player1_color = ColorN("indianred", 1)
var player2_color = ColorN("lightblue", 1)
var player1_weapon = 0
var player2_weapon = 0

var ready_to_go


#single player data
var opponents = 1
var species = 0
var starts = [120, 10, 110]


# variable to determine which move has been made.
var move_count = 0


#chambered determines what will fire next. 
# 0 = nothing
# 1 = torpedo
# 2 = particle
# 3 = mine
var chambered = 0

# Opening notifier text
var note_text = "Welcome to Close Quarters Battle"
var p2note_text = "Welcome to Close Quarters Battle"

# variables to hold the current status of both players
var player1_stats = {"hull" : 100, "shield" : 100, "torpedoes" : 10, "particle" : 100, "energy" : 100}
var player2_stats = {"hull" : 100, "shield" : 100, "torpedoes" : 10, "particle" : 100, "energy" : 100}




var reset = false

# if true the playfield grid hides itelf
var hide_field = false

# stores the location of the turn timer.
var timer

func reset():
	state = "start"
	moving = false
	firing = false
	chambered = 0
	move_count = 0
	note_text = "Welcome to Close Quarters Battle a1.0"
	p2note_text = "Welcome to Close Quarters Battle a1.0"
	player1_stats = {"hull" : 100, "shield" : 100, "torpedoes" : 10, "particle" : 100, "energy" : 100}
	player2_stats = {"hull" : 100, "shield" : 100, "torpedoes" : 10, "particle" : 100, "energy" : 100}
	player1_ready = false
	player2_ready = false
	hide_field = false


func begin_turn(timer):
	if not state == "move":
		timer.start()
		reset = true
		hide_field = true
		state = "move"
	
func end_turn():
	if state == "move":
		clear_course()
		clear_target()
		hide_field = false
		state = "idle"
		
	if mode == "2p":
		# all this stuff is in 2p only
		player1_ready = false
		player2_ready = false
		get_tree().get_nodes_in_group("p1")[0].reset()
		get_tree().get_nodes_in_group("p2")[0].reset()
	else:
		# all this stuff is single player only.
		
		get_tree().get_nodes_in_group("player")[0].reset()
		
		if get_tree().get_nodes_in_group("player")[0].sensor == 1:
			get_tree().get_nodes_in_group("player")[0].sensor = 0
			for i in range(get_tree().get_nodes_in_group("enemy").size()):
				get_tree().get_nodes_in_group("enemy")[i].revealed = true
		
		#reset every enemy ship
		for i in range(get_tree().get_nodes_in_group("enemy").size()):
			get_tree().get_nodes_in_group("enemy")[i].reset()
		
		
	
func clear_target():
	var tarret = get_tree().get_nodes_in_group("target_reticule")
	if tarret.size() > 0:
		tarret[0].queue_free()

func clear_course():
	var tarret = get_tree().get_nodes_in_group("course_reticule")
	if tarret.size() > 0:
		tarret[0].queue_free()


func which_player():
	var which = false
	
	if not is_network_master():
		which = true
	
	return which

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print("Global state is: ", state)
	pass
