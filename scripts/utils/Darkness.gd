extends Node2D



func _on_area_2d_body_entered(body):
	_Globals.pixie_in_darkness = true

func _on_area_2d_body_exited(body):
	_Globals.pixie_in_darkness = false
