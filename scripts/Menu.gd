extends Control

@onready var splash = $Splash
@onready var fade_2_black = $Fade2Black
@onready var button_play = $Splash/Button_Play
@onready var menu_animations = $MenuAnimations

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(delta):
	pass

func _on_button_play_pressed():
	menu_animations.play("game_start")
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _on_menu_animations_animation_finished(anim_name):
	if anim_name == "game_start":
		_Globals.has_control = true
