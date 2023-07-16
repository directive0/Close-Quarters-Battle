extends Node2D

func _ready():
	$Particles2D.set_emitting(true)
	#$AudioStreamPlayer.play()
	
func _on_AudioStreamPlayer_finished():
	queue_free()



func _on_Timer_timeout():
	queue_free()