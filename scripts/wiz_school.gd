extends Node2D

@export var left_camera_limit = 0
@export var top_camera_limit = 0
@export var right_camera_limit = 0
@export var bottom_camera_limit = 0

@onready var camera = $Camera/Camera2D

func _ready():
	camera.set_limit(SIDE_LEFT, left_camera_limit)
	camera.set_limit(SIDE_TOP, top_camera_limit)
	camera.set_limit(SIDE_RIGHT, right_camera_limit)
	camera.set_limit(SIDE_BOTTOM, bottom_camera_limit)
