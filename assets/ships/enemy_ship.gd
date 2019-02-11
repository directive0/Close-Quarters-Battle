extends "res://assets/ships/player_ship_control.gd"

#if set to "true" the enemy will ALWAYS shoot, and will ALWAYS choose torpedoes (I needed this to fix a bug with torpedoes)
var testing = false

func _process(delta):
	
	if globals.state == "ready":
		if globals.move_count == 0:
			jump_to(find_start())
			#globals.state = "idle"
	
	# every time 
	if globals.state == "idle":
		if not courset:
				random_move()
		if courset:
				if revealed == true:
					print("revealed met")
					reveal()
					revealed = false

	if globals.state == "move":
		
		# if a move has been selected move to it
		if courset:
			move(delta)

		# if a weapon and target have been selected fire them.
		if chambered:

			if decider == 0:
				fire_p_beam()
			elif decider == 1:
				fire_torpedo()
				
			print("decider = ", decider)
			chambered = false
			
func hit(damage):
	
	if criticaled:
		damage = damage * 2
		
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
			if stats["shield"] < 0:
				stats["hull"] + stats["shield"]
				stats["shield"] = 0
	

func damage_report():

	if stats["hull"] <= 0:
		globals.note_text = "Enemy ship destroyed!"
		globals.state = "enemy dead"

func random_move():
	randomize()
	var firing = randi()% 2
	if testing == true:
		firing = 1
	
	print("firing =", firing)
	
	var moving = randi()% 2
	
	randomize()
	decider = randi() % 2      # returns random number between 0 and 19
	if testing == true:
		decider = 1
	
	if moving == 1:
		var next_move = randi()% 121
		var next_move_coordinate = grid[next_move].get_node("Position2D").get_global_position()
		last_cell = current_cell
		current_cell = grid[next_move]
		move_to(next_move_coordinate)
	
	if firing == 1:
		var next_target = randi()% 121
		var next_target_coordinate = get_tree().get_nodes_in_group("player")[0].current_cell#grid[next_target].get_node("Position2D").get_global_position()
		fire_at(next_target_coordinate)