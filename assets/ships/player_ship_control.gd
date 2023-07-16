extends Control
var grid
var moving = false
var target_loc
var lastloc
var newloc
var current_cell
var last_cell

var primed = false

var current_target
var last_target

var stats = {"hull" : 100, "shield" : 100, "torpedoes" : 10, "particle" : 100, "energy" : 100}

var explosion = preload("res://explosion.tscn")
var big_explosion = preload("res://player_explosion.tscn")

var current_velocity = 1
var acceleration = 1.5

var t = 0.0

var timer

# sets whether a move or target has been decided
var courset = false
var chambered = false
var decider


var weapon_away = false
var torpedo = preload("res://torpedo.tscn")
var reveal_line = preload("res://sensordata.tscn")
#var torpedo = load("res://test.tscn")
var p_beam = preload("res://phaser.tscn")
var scanner = preload("res://scan.tscn")

var init = false

var start_cell = 0

var angle = 0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var sensor = 0
var revealed = false
var criticaled = false

var destroyed = false

var player = false

# Called when the node enters the scene tree for the first time.
func _ready():
	
	if is_in_group("player"):
		player = true
		
	# load our level timer object
	t = get_tree().get_nodes_in_group("level_timer")[0]
	
	# load our grid
	grid = get_tree().get_nodes_in_group("grid")[0].get_children()
	last_cell = grid[start_cell]
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if not destroyed:
		# adjust the ship sprite to that angle of movement
		$Sprite.set_rotation_degrees(angle)
	
		# if we are ready to begin the game
		if globals.state == "ready":
			
			# see if this is the first move
			if globals.move_count == 0:
				# put ships in their proper place.
				jump_to(find_start())
				#globals.state = "idle"
	
		# when moving
		if globals.state == "move":
			
			# react to and log damage.
			damage_report()
			
			# if we have a course we are heading in
			if courset:
				# move us in that direction
				move(delta)
				

					
			# if we have a weapon selected.
			if chambered:
				
				# deploy our weapon
				if globals.chambered == 0:
					fire_p_beam()
				if globals.chambered == 1:
					fire_torpedo()
				if globals.chambered == 2:
					scan()
				
				# we are no longer chambered.
				chambered = false
#	pass
func place():
	jump_to(find_start())


func hit(damage):
	
	#if criticaled:
		#damage = damage * 2
	
	var this_splode = explosion.instance()
	
	add_child(this_splode)
	
	if stats["shield"] <= 0:
		globals.note_text = "Hull damaged! " + str(stats["hull"]) + "% remaining!"
		stats["hull"] -= damage
		if stats["hull"] <= 0:
			globals.note_text = "Ship destroyed!"
	else:
		stats["shield"] -= damage
		globals.note_text = "Shields damaged! " + str(stats["shield"]) + "% remaining!"
		if stats["shield"] <= 0:
			globals.note_text = "Shields down!"
	

func damage_report():
	if stats["hull"] <= 0 and destroyed == false:
		globals.note_text = "All hands abandon sh-"
		destroyed = true
		var this_splode = big_explosion.instance()
		add_child(this_splode)
		$Sprite.queue_free()
		print("player died")

func find_start():
	var first_spot = grid[start_cell].get_node("Position2D")
	current_cell = grid[start_cell]
	var first_pos = first_spot.get_global_position()

	return first_pos

func jump_to(location):
	
	set_global_position(location)

func point():
	#print(globals.cellsize)
	var centerlast = Vector2(lastloc.x + (globals.cellsize / 2), lastloc.y + (globals.cellsize / 2))
	var centerdest = Vector2(newloc.x + (globals.cellsize / 2), newloc.y + (globals.cellsize / 2))
	angle = rad2deg(newloc.angle_to_point(lastloc))
	#print(angle)


func move_to(destination):
	newloc = destination
	lastloc = get_global_position()
	courset = true

func fire_torpedo():
	var this_torp = torpedo.instance()
	#print("firing torp at: ", get_global_position())
	#this_torp.set_global_position(get_global_position())
	this_torp.setup(self,last_cell,current_target)
	
	#var substrate = get_tree().get_nodes_in_group("ship_space")[0]
	var substrate = get_node("Sprite")
	#var substrate = last_cell
	#this_torp.set_global_position(last_cell.get_node("Position2D").get_global_position())

	substrate.add_child(this_torp)
	#substrate.add_child(this_torp)

func fire_p_beam():
	var this_beam = p_beam.instance()
	#print("firing pbeam at: ", get_global_position())
	this_beam.setup($Sprite/Position2D,self,current_target)
	#var substrate = get_tree().get_nodes_in_group("ship_space")[0]
	$weaponpoint.add_child(this_beam)

func scan():
	var this_beam = scanner.instance()
	this_beam.setup(self,last_cell,current_target)
	#print("scanning", get_global_position())
	randomize()
	var crit = randi()% 2
	if crit == 0:
		pass
	else:
		primed = true
	#this_beam.setup(self,current_target)
	#var substrate = get_tree().get_nodes_in_group("ship_space")[0]
	$weaponpoint.add_child(this_beam)

func fire_at(target, weapon = 1):
	current_target = target
	#globals.state = "idle"
	chambered = true


func reset():
	last_cell = current_cell
	if courset:
		if player:
			current_velocity = current_velocity * acceleration
			if current_velocity >= 4:
				current_velocity = 4
			$speed_check.set_scale(Vector2(current_velocity,current_velocity))
			$slow_check.set_scale(Vector2(current_velocity,current_velocity))
			
	courset = false
	chambered = false
	criticaled = false
	#print("move done")
	#if sensor == 1:
		

func reveal():
	var this_reveal = reveal_line.instance()
	this_reveal.setup(self)
	
	#var substrate = get_tree().get_nodes_in_group("ship_space")[0]
	var substrate = get_node("Sprite")
	#var substrate = last_cell
	#this_torp.set_global_position(last_cell.get_node("Position2D").get_global_position())

	substrate.add_child(this_reveal)

func move(delta):
	point()
	var frame = t.get_time_left() / t.get_wait_time() 
	frame = 1 - frame
	#print("frame =", frame)

	var current = lastloc.linear_interpolate(newloc,frame)
	set_global_position(current)
	
