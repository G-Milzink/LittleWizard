extends Node2D

@export var orange_cursor = CanvasTexture

func _ready():
	pass

func _input(event):
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()

func _process(delta):
	pass
