extends Sprite

var counter = 1000000

var direction = 0

var scaler = 0

var speed = 0


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	randomtate()
	pass # Replace with function body.

func randomtate():
	randomize()
	var starter = randi() % 365
	
	set_rotation(starter)
	
func animate():
	
	if counter > 1000000:
		
		randomize()
		
		direction = randi() % 2
		
		if direction == 0:
			direction = -1

		scaler = randf()
		speed = randf()

	
	set_scale(Vector2(.3 + scaler, .3 + scaler))
	rotate((0.1 * direction) * speed)

	
	counter += 1
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	animate()
#	pass
