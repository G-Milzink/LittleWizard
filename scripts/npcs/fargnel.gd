extends CharacterBody2D

@onready var character = $Character
@onready var speech_bubble = $Speech_bubble
@onready var idle_timer = $Idle_timer

const TILESIZE = 64

func _ready():
	speech_bubble.visible = false

func _process(delta):
	self.set_collision_layer_value(1, !_Globals.Fargnel_player_can_pass)
	if _Globals.player_position.x > position.x + TILESIZE * 0.5:
		character.set_flip_h(true)
	elif _Globals.player_position.x < position.x - TILESIZE * 0.5:
		character.set_flip_h(false)

func _on_range_body_entered(body):
	if _Globals.Fargnel_is_active:
		speech_bubble.visible = true

func _on_range_body_exited(body):
	speech_bubble.visible = false


func _on_idle_timer_timeout():
	character.play("idle_blink")

func _on_character_animation_finished():
	character.play("idle")
	var rnd = randf_range(0.25, 10.0)
	idle_timer.start(rnd)
	
