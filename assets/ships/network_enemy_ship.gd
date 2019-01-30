extends "res://assets/ships/ship.gd"

func _ready():
	if is_network_master():
		start_cell = 120
	else:
		start_cell = 0

func _process(delta):
	
	if globals.state == "ready":
		if globals.move_count == 0:
			jump_to(find_start())
			#globals.state = "idle"
	
	#if globals.state == "idle":
	if not courset:
			random_move()

	if globals.state == "move":
		
		if courset:
			move(delta)

		if chambered:
			fire_torpedo()
			chambered = false
			
func hit(damage):
		
	var this_splode = explosion.instance()
	
	add_child(this_splode)
	
	if stats["shield"] <= 0:
		stats["hull"] -= damage
		globals.note_text = "Enemy hull damaged! " + str(stats["hull"]) + "% remaining!"
	else:
		stats["shield"] -= damage
		globals.note_text = "Enemy shields damaged! " + str(stats["shield"]) + "% remaining!"
		if stats["shield"] <= 0:
			globals.note_text = "Enemy shields down!"


remote func notify_choice(course,target,weapon):
	move_to(course)
	fire_at(target,weapon)
	
func damage_report():

	if stats["hull"] == 0:
		globals.note_text = "Enemy ship destroyed!"
		globals.state = "game over"

func random_move():
	randomize()
	var firing = randi()% 2
	print("firing =", firing)
	var moving = randi()% 2
	
	if moving == 1:
		var next_move = randi()% 121
		var next_move_coordinate = grid[next_move].get_node("Position2D").get_global_position()
		move_to(next_move_coordinate)
	
	if firing == 1:
		var next_target = randi()% 121
		var next_target_coordinate = get_tree().get_nodes_in_group("player")[0].get_global_position()#grid[next_target].get_node("Position2D").get_global_position()
		fire_at(next_target_coordinate)