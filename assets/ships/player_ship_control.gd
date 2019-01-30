extends Control
var grid
var moving = false
var target_loc
var lastloc
var newloc
var current_cell
var last_cell

var current_target
var last_target

var stats = {"hull" : 100, "shield" : 100, "torpedoes" : 10, "particle" : 100, "energy" : 100}

var explosion = load("res://explosion.tscn")

var t = 0.0

var timer

# sets whether a move or target has been decided
var courset = false
var chambered = false


var weapon_away = false
var torpedo = load("res://torpedo.tscn")
var p_beam = load("res://phaser.tscn")

var init = false

var start_cell = 0

var angle = 0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	
	# load our level timer object
	t = get_tree().get_nodes_in_group("level_timer")[0]
	
	# load our grid
	grid = get_tree().get_nodes_in_group("grid")[0].get_children()

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Sprite.set_rotation_degrees(angle)
	
	if globals.state == "ready":
		if globals.move_count == 0:
			jump_to(find_start())
			#globals.state = "idle"

	if globals.state == "move":
		
		damage_report()
		
		if courset:
			move(delta)

		if chambered:
			print(globals.chambered)
			if globals.chambered == 0:
				fire_p_beam()#fire_torpedo()
			if globals.chambered == 1:
				fire_torpedo()
			chambered = false
#	pass
func place():
	jump_to(find_start())


func hit(damage):
	
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
	if stats["hull"] <= 0:
		globals.note_text = "Ship destroyed!"
		globals.state = "player dead"

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
	globals.state = "idle"
	courset = true

func fire_torpedo():
	var this_torp = torpedo.instance()
	print("firing torp at: ", get_global_position())
	this_torp.setup(self,current_cell,current_target)
	
	#var substrate = get_tree().get_nodes_in_group("ship_space")[0]
	var substrate = current_cell.get_node("Position2D")
	this_torp.set_global_position($Sprite.get_global_position())
	substrate.add_child(this_torp)
	#substrate.add_child(this_torp)

func fire_p_beam():
	var this_beam = p_beam.instance()
	print("firing pbeam at: ", get_global_position())
	this_beam.setup(self,current_target)
	#var substrate = get_tree().get_nodes_in_group("ship_space")[0]
	$weaponpoint.add_child(this_beam)


func fire_at(target, weapon = 1):
	current_target = target
	globals.state = "idle"
	chambered = true


func reset():
	courset = false
	chambered = false
	print("move done")


func move(delta):
	point()
	var frame = t.get_time_left() / t.get_wait_time() 
	frame = 1 - frame
	#print("frame =", frame)

	var current = lastloc.linear_interpolate(newloc,frame)
	set_global_position(current)
	