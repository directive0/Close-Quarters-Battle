extends Node2D

func _ready():
	#$AudioStreamPlayer.play()
	pass
	
func _on_AudioStreamPlayer_finished():
	print("xplosion done!")
	queue_free()



func _on_Timer_timeout():
	queue_free()