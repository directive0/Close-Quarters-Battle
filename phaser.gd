extends Line2D
var ship
var target
var turret
#var explosion = preload("res://explosion.tscn")
var tickcount = 0.0
var tick = 1
var damage = 1
var critdam = 5
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func setup(aperture, firer, firee):
	ship = firer
	target = firee
	turret = aperture

# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer.play()
	$RayCast2D.add_exception(ship.get_node("Sprite/hit_box"))
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not ship.destroyed: 
		rotate_to_target()
		check_collision()
	else:
		queue_free()

	
func rotate_to_target():
	var rotate = rad2deg(turret.get_global_position().angle_to_point(target.get_node("Position2D").get_global_position()))
	
	# dont know why but if I substract by 180 degrees it slightly misses the center???
	set_rotation_degrees(rotate - 180)
	
func check_collision():
	
	if $RayCast2D.is_colliding():


		# get closest hit point.
		var points = get_points()
		var hitpoint = $RayCast2D.get_collision_point()
		hitpoint = to_local(hitpoint)
		points[1] = hitpoint
		set_points(points)
		
		var object = $RayCast2D.get_collider()
		
		# check to see if we hit something damagable
		if object != null:
			# RNG a damage amaount
			randomize()
			var variance = randf()
			var damagenow
			
			if object.is_in_group("ship_hit"):
				if object.get_parent().get_parent().criticaled:
					damagenow = (critdam)
				else:
					damagenow = (damage)
					
			object.hit(damagenow)
	else:
		var points = get_points()
		points[1] = Vector2(5000,0)
		set_points(points)

func _on_AudioStreamPlayer_finished():
	queue_free()
