extends Node2D

@onready var world = $"."
@onready var player = $Player

@export var map_wiz_school = preload("res://scenes/maps/wiz_school.tscn")
@export var map_ench_forest = preload("res://scenes/maps/ench_forest.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	RenderingServer.set_default_clear_color(Color.BLACK)
	var instance = map_wiz_school.instantiate()
	add_child(instance)
	player.position = Vector2(1047,640-_Globals.TILE_SIZE*.5)

func _Transition_WizSchool2EnchForest():
	var instance = map_ench_forest.instantiate()
	call_deferred("add_child", instance)
	player.position = Vector2(-528,644-_Globals.TILE_SIZE*.5)

func _Transition_EnchForest2WizSchool():
	var instance = map_wiz_school.instantiate()
	call_deferred("add_child", instance)
	player.position = Vector2(1047,640-_Globals.TILE_SIZE*.5)
