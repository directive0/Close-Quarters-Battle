extends Area2D


func hit(damage = 20):
	get_tree().get_nodes_in_group("player")[0].hit(damage)