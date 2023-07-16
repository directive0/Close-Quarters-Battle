extends Control
var player_ship = preload("res://player_ship_control.tscn")

#var enemy_ship = load("res://enemy_ship.tscn")
var enemy_ship_rom = preload("res://bop.tscn")
var enemy_ship_kling = preload("res://klang.tscn")
var ship_space


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func distinguish_cell():
	pass

func _on_GridContainer_ready():
	# call deferred so we don't load ships into a playfield that has not settled on its final resolution.
	#call_deferred("add_ships")
	pass
	
# add the ships to their starting positions
func add_ships():
	ship_space = get_tree().get_nodes_in_group("ship_space")[0]
	#print("playfield ready")
	var new_player = player_ship.instance()
	for i in range(globals.opponents):
		var new_enemy
		if globals.species == 0:
			new_enemy = enemy_ship_kling.instance()
		if globals.species == 1:
			new_enemy = enemy_ship_rom.instance()
		new_enemy.start_cell = globals.starts[i]
		ship_space.add_child(new_enemy)
		new_enemy.place()
		
	ship_space.add_child(new_player)
	new_player.place()

	globals.state = "idle"
