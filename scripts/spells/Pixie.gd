extends Node2D

@onready var timer = $Timer

var rnd_x = 0
var rnd_y = 0
var lerp_speed = 1

func _ready():
	position.x = _Globals.player_position.x
	position.y = _Globals.player_position.y
	if _Globals.has_spell_pixie == false:
		self.visible = false

func _process(delta):
	if _Globals.pixie_underway:
		position = lerp(position, _Globals.pixie_send_to_location, lerp_speed * delta)
		if position.x  > _Globals.pixie_send_to_location.x-8\
		and position.x  < _Globals.pixie_send_to_location.x+8:
			_Globals.pixie_underway = false
	else:
		position.x = lerp(position.x, _Globals.player_position.x + rnd_x, lerp_speed * delta)
		position.y = lerp(position.y, _Globals.player_position.y + rnd_y, lerp_speed * delta)

func _on_timer_timeout():
	rnd_x = randi_range(-64, 64)
	rnd_y = randi_range(-64, 8)
