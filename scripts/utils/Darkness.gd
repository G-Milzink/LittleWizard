extends Node2D

@export var canvas_modulate: Node
@export var base_color: Color
@export var dark_color: Color

var current_color

func _ready():
	current_color = base_color

func _on_area_2d_body_entered(body):
	if body.name == "Pixie":
		_Globals.pixie_in_darkness = true
	if body.name == "Player":
		current_color = dark_color

func _on_area_2d_body_exited(body):
	if body.name == "Pixie":
		_Globals.pixie_in_darkness = false
	if body.name == "Player":
		current_color = base_color


func _process(delta):
	var tween = get_tree().create_tween()
	tween.tween_property(canvas_modulate, "color", current_color, .66)
