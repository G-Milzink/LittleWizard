extends Node2D

@onready var current_map = $"../.."
@onready var world = $"../../.."


func _on_area_2d_body_entered(body):
	if body.name == "Player":
		world._Transition_EnchForest2WizSchool()
		current_map.queue_free()
