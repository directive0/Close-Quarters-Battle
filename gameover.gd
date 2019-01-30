extends Control

export var playerno = 0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var playerwin = ["Your enemy's ship cracks apart like an egg. You are victorious!","In a flash of brilliant light your enemy is destroyed. Congratulations captain!", "The shards of your enemy's ship twinkle in the darkness. You win!"]
var playerlose = ["Your ship has been destroyed. Its hull is displayed as a trophy on your rivals homeworld.","The destruction of your vessel heralds the end of your people. You lose.", "The shards of your ship twinkle in the darkness. You lose."]
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	var decide = randi() % 3

	if globals.state == "player gameover":
		$Control/VBoxContainer/ColorRect/VBoxContainer/Label.set_text(playerlose[decide])
		$Control/VBoxContainer/ColorRect/VBoxContainer/ok.set_text("Bummer!")

	
	if globals.state == "enemy gameover":
		$Control/VBoxContainer/ColorRect/VBoxContainer/Label.set_text(playerwin[decide])
		$Control/VBoxContainer/ColorRect/VBoxContainer/ok.set_text("Sweet!")
	
	
	if globals.state == "p1 gameover":
		if playerno == 0:
			$Control/VBoxContainer/ColorRect/VBoxContainer/Label.set_text(playerlose[decide])
			$Control/VBoxContainer/ColorRect/VBoxContainer/ok.set_text("Bummer!")
			
		if playerno == 1:
			$Control/VBoxContainer/ColorRect/VBoxContainer/Label.set_text(playerwin[decide])
			$Control/VBoxContainer/ColorRect/VBoxContainer/ok.set_text("Sweet!")
	
	if globals.state == "p2 gameover":
		if playerno == 1:
			$Control/VBoxContainer/ColorRect/VBoxContainer/Label.set_text(playerlose[decide])
			$Control/VBoxContainer/ColorRect/VBoxContainer/ok.set_text("Bummer!")
			
		if playerno == 0:
			$Control/VBoxContainer/ColorRect/VBoxContainer/Label.set_text(playerwin[decide])
			$Control/VBoxContainer/ColorRect/VBoxContainer/ok.set_text("Sweet!")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_ok_pressed():
	globals.reset()
	get_tree().change_scene("res://choice_page.tscn")

