extends Line2D
var ship
var target
var explosion = load("res://explosion.tscn")
var tickcount = 0.0
var tick = 1
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func setup(firer, firee):
	ship = firer
	target = firee

# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer.play()
	$RayCast2D.add_exception(ship.get_node("Sprite/hit_box"))
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotate_to_target()
	
	#tickcount += tick * delta
	
	#if tickcount == 1:
	check_collision()
	#	tickcount = 0
#	pass

	
func rotate_to_target():
	var rotate = rad2deg(ship.get_global_position().angle_to_point(target.get_node("Position2D").get_global_position()))
	
	set_rotation_degrees(rotate - 180)
	
func check_collision():
	if $RayCast2D.is_colliding():
		#print("shot by: ", ship, " ", "collided with", $RayCast2D.get_collider())
		var points = get_points()
		var hitpoint = $RayCast2D.get_collision_point()
		hitpoint = to_local(hitpoint)
		points[1] = hitpoint
		set_points(points)
		
		var object = $RayCast2D.get_collider()
		#print(object)
		object.hit(1)
		
	else:
		var points = get_points()
		points[1] = Vector2(5000,0)
		set_points(points)

func _on_AudioStreamPlayer_finished():
	queue_free()