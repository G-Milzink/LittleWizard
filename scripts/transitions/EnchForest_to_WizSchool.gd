extends Node2D

@onready var current_map = $"../.."
@onready var world = $"../../.."

var in_range = false

func _process(delta):
	if in_range:
		if Input.is_action_just_pressed("action"):
			in_range = false
			world._Transition_EnchForest2WizSchool()
			current_map.queue_free()

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		in_range = true
