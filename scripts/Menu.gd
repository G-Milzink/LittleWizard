extends Control

@onready var splash = $CanvasLayer/Splash

# Called when the node enters the scene tree for the first time.
func _ready():
	splash.visible = _Globals.show_splash



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	splash.visible = _Globals.show_splash
