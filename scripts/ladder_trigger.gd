extends Node2D

@export var UP_area_y_scale = 1.0
@export var UP_area_y_offset = 0
@export var DOWN_area_y_scale = 1.0
@export var DOWN_area_y_offset = 0

@onready var up_area = $Up_Area
@onready var down_area = $Down_Area

func _ready():
	up_area.scale.y = UP_area_y_scale
	up_area.position.y = UP_area_y_offset
	down_area.scale.y = DOWN_area_y_scale
	down_area.position.y = DOWN_area_y_offset

func _on_up_area_body_entered(body):
	_Globals.can_climb_up = true

func _on_up_area_body_exited(body):
	_Globals.can_climb_up = false
	_Globals.is_climbing = false

func _on_down_area_body_entered(body):
	_Globals.can_climb_down = true

func _on_down_area_body_exited(body):
	_Globals.can_climb_down = false
	_Globals.is_climbing = false
