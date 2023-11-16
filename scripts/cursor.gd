extends Node2D

var platform_spell = preload("res://scenes/spells/platform_spell.tscn")

@export var base_intensity = 1.5
@export var active_intensity = 7.0
@export var base_scale = 1.0
@export var active_scale = 2.0

@onready var sparkle = $Sparkle
@onready var cursor_light = $CursorLight

@onready var cursor_icon = $Cursor


# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	sparkle.emitting = false
	cursor_light.energy = base_intensity
	cursor_light.texture_scale = base_scale

func _process(delta):
	_Change_Color()
	var new_position = get_global_mouse_position()
	position = new_position
	_Platform_Spell()
	_Send_Pixie_Spell()

func _on_area_2d_body_entered(body):
	if body.is_in_group("can_hold") && _Globals.current_spell == "Hold":
		sparkle.emitting = true
		cursor_light.energy = active_intensity
		cursor_light.texture_scale = active_scale

func _on_area_2d_body_exited(body):
	if body.is_in_group("can_hold") && _Globals.current_spell == "Hold":
		sparkle.emitting = false
		cursor_light.energy = base_intensity
		cursor_light.texture_scale = base_scale

func _Change_Color():
	match _Globals.current_spell:
		"Hold":
			cursor_icon.play("Hold")
			cursor_light.color = Color("ff7300")
		"Pixie":
			cursor_icon.play("Light")
			cursor_light.color = Color("6ebb00")
		"Platform":
			cursor_icon.play("Platform")
			cursor_light.color = Color("0097bb")
		"Purple":
			cursor_icon.play("Purple")
			cursor_light.color = Color("9601df")
		_:
			pass 

func _Platform_Spell():
	if _Globals.current_spell == "Platform" && _Globals.can_cast_platform:
		if Input.is_action_just_pressed("cast_spell"):
			_Globals.can_cast_platform = false
			var instance = platform_spell.instantiate()
			instance.position = position
			call_deferred("add_sibling", instance)

func _Send_Pixie_Spell():
	if _Globals.current_spell == "Pixie":
		if Input.is_action_just_pressed("cast_spell"):
			_Globals.pixie_send_to_location = position
			_Globals.pixie_underway = true
			print("send pixie")
