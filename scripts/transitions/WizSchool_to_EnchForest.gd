extends Node2D

@onready var current_map = $"../.."
@onready var world = $"../../.."
@onready var arrow = $Arrow

var in_range = false

func _ready():
	arrow.visible = false

func _process(delta):
	if in_range:
		if Input.is_action_just_pressed("action"):
			in_range = false
			world._Transition_WizSchool2EnchForest()
			current_map.queue_free()

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		in_range = true
		arrow.visible = true 


func _on_area_2d_body_exited(body):
	if body.name == "Player":
		in_range = false
		arrow.visible = false
