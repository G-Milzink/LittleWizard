extends Node2D

@onready var sprite = $Sprite
@onready var icon = $Icon

var in_range = false
var active = false

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		in_range = true
		icon.visible = true

func _on_area_2d_body_exited(body):
	if body.name == "Player":
		in_range = false
		icon.visible = false

func _process(delta):
	if in_range:
		if Input.is_action_just_pressed("action"):
			if sprite.get_animation() == "off":
				sprite.play("on")
				active = true
			else:
				sprite.play("off")
				active = false
