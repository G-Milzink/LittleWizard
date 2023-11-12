extends Node2D

@export var lerp_speed = 40
@onready var player = $"../../Player"



func _ready():
	position = player.position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = lerp(position, player.position, lerp_speed * delta)
