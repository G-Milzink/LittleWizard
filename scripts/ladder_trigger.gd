extends Node2D

@export var y_scale = 1.0

func _ready():
	scale.y = y_scale

func _on_area_2d_body_entered(body):
	_Globals.can_climb = true
	print("can climb")

func _on_area_2d_body_exited(body):
	_Globals.can_climb = false
	print("can not climb")
