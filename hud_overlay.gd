extends Label
var target
var red = Color(0.992188, 0, 0, 0.631373)
var blue = Color(0, 0.956522, 1, 0.576471)

func _ready():
	target = get_parent()
	update()
	
func _process(delta):
	if globals.state == "move":
		update()
#	pass

func update():
		if target.stats["shield"] <= 0:
			set("custom_colors/font_color",red)
			set_text(str(target.stats["hull"]))
		else:
			set("custom_colors/font_color",blue)
			set_text(str(target.stats["shield"]))
		if target.stats["hull"] <= 0:
			set_visible(false)