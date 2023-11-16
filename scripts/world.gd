extends Node2D

@onready var world = $"."
@onready var player = $Player

var map_wiz_school = preload("res://scenes/maps/wiz_school.tscn")
var map_ench_forest = preload("res://scenes/maps/ench_forest.tscn")



#-------------------------------------------------------------------------------

func _ready():
	RenderingServer.set_default_clear_color(Color.BLACK)
	match _Globals.starting_map:
		0:
			var instance = map_wiz_school.instantiate()
			add_child(instance)
			player.position = Vector2(-1465,256-_Globals.TILE_SIZE*.5)
			_Globals.current_map = "Wiz.School"
		1:
			var instance = map_ench_forest.instantiate()
			call_deferred("add_child", instance)
			player.position = Vector2(-528,644-_Globals.TILE_SIZE*.5)
			_Globals.current_map = "Ench.Forest"

#-------------------------------------------------------------------------------

func _Transition_WizSchool2EnchForest():
	var instance = map_ench_forest.instantiate()
	call_deferred("add_child", instance)
	player.position = Vector2(-528,644-_Globals.TILE_SIZE*.5)

func _Transition_EnchForest2WizSchool():
	var instance = map_wiz_school.instantiate()
	call_deferred("add_child", instance)
	player.position = Vector2(1047,640-_Globals.TILE_SIZE*.5)
