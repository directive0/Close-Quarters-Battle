extends Control

#store our game members
var player
var target = load("res://target_reticule.tscn")
var course = load("res://course_reticule.tscn")
var reticule_space
var highlighted = false
var not_highlighted = Color(0, 0, 0, 0.13)
var highlight = Color(1, 1, 1, 0.13)
var highlight_slow = Color(0, 0.109375, 1, 0.13)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	reticule_space = get_tree().get_nodes_in_group("reticule_space")[0]
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
		
	# controls whether the cell lights up indicating it is within the players reach this turn.
	if $Control/checkspace.get_overlapping_areas().size() > 0:
		var slow = false
		for area in $Control/checkspace.get_overlapping_areas():
			if area.is_in_group("slow"):
				slow = true
		
		if slow:
			$ColorRect/TextureButton.set_modulate(highlight_slow)
		else:
			$ColorRect/TextureButton.set_modulate(highlight)
	else:
		$ColorRect/TextureButton.set_modulate(not_highlighted)
	
	highlighted = false
	
	find_center()
	
	if globals.hide_field == true:
		$ColorRect.set_visible(false)
	else:
		$ColorRect.set_visible(true)

# not yet functional. Will allow the cell to annunciate when it is different from other cells.
func cell_assign():
	if globals.state == "idle":
		if player.current_cell == self:
			$ColorRect.set_frame_color(Color(1,1,0,.2)) 
		pass
		
	pass

# gets the center of itself (for placing the player/enemy)
func find_center():
	var center = Vector2(get_size().x/2,get_size().y/2)
	$Position2D.set_position(center)


# the following is code relating to each press and behaviour is determined by what state the game is in.
# if the state is not something that requires interaction with the cells then it is ignored.
func _on_TextureButton_pressed():

	var position = $Position2D.get_global_position()

	if globals.state == "p1_set_move":
		$AudioStreamPlayer.play()
		player = get_tree().get_nodes_in_group("p1")[0]
		globals.note_text = "Course laid in"
		player.move_to(position)
		player.current_cell = self
		globals.state = "idle"

		
	if globals.state == "p2_set_move":
		$AudioStreamPlayer.play()
		player = get_tree().get_nodes_in_group("p2")[0]
		globals.note_text = "Course laid in"
		player.move_to(position)
		player.current_cell = self
		var reticule = course.instance()
		globals.state = "idle"

		
	if globals.state == "p1_set_target":
		$AudioStreamPlayer2.play()
		player = get_tree().get_nodes_in_group("p1")[0]
		globals.note_text = "Target set"
		player.fire_at(self)
		globals.state = "idle"

	
	if globals.state == "p2_set_target":
		$AudioStreamPlayer2.play()
		player = get_tree().get_nodes_in_group("p2")[0]
		globals.note_text = "Target set"
		player.fire_at(self)
		globals.state = "idle"


	if globals.state == "set_move":
		if $Control/checkspace.get_overlapping_areas().size() > 0:
			$AudioStreamPlayer.play()
			player = get_tree().get_nodes_in_group("player")[0]
			globals.note_text = "Course laid in"
			player.move_to(position)
			player.last_cell = player.current_cell
			player.current_cell = self
			var reticule = course.instance()
			#reticule.set_global_position(position)
			#reticule.set_size(get_size())
			globals.clear_course()
			$reticule_holder.add_child(reticule)
			globals.state = "idle"

	if globals.state == "set_target":
		$AudioStreamPlayer2.play()
		player = get_tree().get_nodes_in_group("player")[0]
		globals.note_text = "Target set"
		player.last_target = player.current_target
		#player.current_target = self
		player.fire_at(self)
		var reticule = target.instance()
		#reticule.set_global_position(position)
		#reticule.set_size(get_size())
		globals.clear_target()
		$reticule_holder.add_child(reticule)
		globals.state = "idle"
		

func _on_checkspace_area_entered(area):
	#highlighted = true
	pass


func _on_slow_space_area_entered(area):
	#highlighted = false
	pass
