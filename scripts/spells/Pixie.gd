extends Node2D

@onready var timer = $Timer
@onready var pixie_light = $PixieLight

@export var min_brightness = 0.5
@export var max_brightness = 3.5
@export var min_scale = 1.5
@export var max_scale = 4.5

var rnd_x = 0
var rnd_y = 0
var move_lerp = 1
var light_lerp = .75

func _ready():
	position.x = _Globals.player_position.x
	position.y = _Globals.player_position.y
	if _Globals.has_spell_pixie == false:
		self.visible = false

func _process(delta):
	if _Globals.pixie_underway:
		position = lerp(position, _Globals.pixie_send_to_location, move_lerp * delta)
		if position.x  > _Globals.pixie_send_to_location.x-8\
		and position.x  < _Globals.pixie_send_to_location.x+8:
			_Globals.pixie_underway = false
	else:
		position.x = lerp(position.x, _Globals.player_position.x + rnd_x, move_lerp * delta)
		position.y = lerp(position.y, _Globals.player_position.y + rnd_y, move_lerp * delta)
	
	if _Globals.pixie_in_darkness:
		pixie_light.energy = lerp(pixie_light.energy, max_brightness, light_lerp * delta)
		pixie_light.texture_scale = lerp(pixie_light.texture_scale, max_scale, light_lerp * delta)
	else:
		pixie_light.energy = lerp(pixie_light.energy, min_brightness, light_lerp * delta)
		pixie_light.texture_scale = lerp(pixie_light.texture_scale, min_scale, light_lerp * delta)

func _on_timer_timeout():
	rnd_x = randi_range(-64, 64)
	rnd_y = randi_range(-64, 8)

