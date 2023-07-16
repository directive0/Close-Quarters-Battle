extends Node2D
var test = false
var firer
var origin
var ping = load("res://ping.tscn")
var shotfrom
var t
var ship
var lastloc = Vector2()
var newloc = Vector2()
var this_roll

var frame
var angle_to_target


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.set_assigned_animation("scan")
	$AnimationPlayer.set_autoplay("scan") 
	rotate_to_target()
	this_roll = decide()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func setup(fired, origin, target):
	ship = origin
	firer = fired
	shotfrom = firer.get_global_position()
	set_as_toplevel(true)
	#var adjust_origin = Vector2(origin.x + (globals.cellsize / 2), origin.y + (globals.cellsize / 2))
	#var adjust_target = Vector2(target.x + (globals.cellsize / 2), target.y + (globals.cellsize / 2))
	
	lastloc = firer.get_node("Sprite").get_global_position()
	print(target)
	newloc = target.get_node("Position2D").get_global_position()
	print("torpedo added: ", target, origin, fired)
	

	set_global_position(lastloc)

func rotate_to_target():
	var angle = get_global_position().angle_to_point(newloc)
	
	var rotate = rad2deg(lastloc.angle_to_point(newloc))
	
	set_rotation_degrees(rotate - 180)
	#set_rotation_degrees(rotate)
	
	angle_to_target = -Vector2(cos(angle), sin(angle))
func _on_AudioStreamPlayer_finished():
	queue_free()
	pass # Replace with function body.


func _on_AnimationPlayer_animation_finished(anim_name):
	#decide()
	queue_free()
	pass # Replace with function body.

func decide():
	# when scan fires theres a 1in3 chance of each thing happening
	# 0 = nothing, 1 = movement preknowledge, 2 = critical hit next shot.
	randomize()
	var outcome = randi()% 3
	if test == true:
		if outcome == 0:
			outcome = 1

	if outcome == 0:
		globals.note_text = "It's no good, Captain! Sensors can't read anything!"
	elif outcome == 1:
		globals.note_text = "Calculated enemy movement, Captain!"
	elif outcome == 2:
		globals.note_text = "We've determined a weakness, Captain!"
	
	return outcome


func _on_Area2D_area_shape_entered(area_id, area, area_shape, self_shape):
	
	var this_ship = area.get_parent().get_parent()
	if this_ship.is_in_group("enemy"):
		
		
		
		var thisping = ping.instance()
		thisping.setup(self)
		area.get_parent().add_child(thisping)
		
		
		if this_roll == 0:
			this_ship.criticaled = true
		elif this_roll == 1:
			print("GOT ONE <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<")
			this_ship.revealed = true

			
		pass
	pass # Replace with function body.
