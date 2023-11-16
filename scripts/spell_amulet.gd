extends Node2D

@onready var amulet = $"."

@onready var xtal_orange = $xtal_orange
@onready var xtal_green = $xtal_green
@onready var xtal_blue = $xtal_blue
@onready var xtal_purple = $xtal_purple

@onready var area_orange = $area_orange
@onready var area_green = $area_green
@onready var area_blue = $area_blue
@onready var area_purple = $area_purple


var previous_spell

func _ready():
	amulet.visible = false

func _process(delta):
	_Display_Current_Spell()
	_Detect_Input()
	if !amulet.visible:
		position = get_global_mouse_position()
		area_orange.set_monitoring(false)
		area_green.set_monitoring(false)
		area_blue.set_monitoring(false)
		area_purple.set_monitoring(false)
	else:
		area_orange.set_monitoring(true)
		area_green.set_monitoring(true)
		area_blue.set_monitoring(true)
		area_purple.set_monitoring(true)

func _Detect_Input():
	if Input.is_action_just_pressed("spell_select"):
		amulet.visible = true
	
	if Input.is_action_just_released("spell_select"):
		amulet.visible = false

func _Display_Current_Spell():
	xtal_orange.visible=false
	xtal_green.visible=false
	xtal_blue.visible=false
	xtal_purple.visible=false
	match _Globals.current_spell:
		"Hold":
			xtal_orange.visible=true
		"Pixie":
			xtal_green.visible=true
		"Platform":
			xtal_blue.visible=true
		"Purple":
			xtal_purple.visible=true

func _on_area_orange_area_entered(area):
	xtal_orange.visible = true
	previous_spell = _Globals.current_spell
	_Globals.current_spell = "Hold"

func _on_area_green_area_entered(area):
	xtal_green.visible = true
	previous_spell = _Globals.current_spell
	_Globals.current_spell = "Pixie"

func _on_area_blue_area_entered(area):
	xtal_blue.visible = true
	previous_spell = _Globals.current_spell
	_Globals.current_spell = "Platform"

func _on_area_purple_area_entered(area):
	xtal_purple.visible = true
	previous_spell = _Globals.current_spell
	_Globals.current_spell = "Purple"
