extends StaticBody2D

@onready var sprite = $Sprite
@onready var collision = $Collision

var active = false

func _ready():
	sprite.play("off")

func _process(delta):
	pass

func _on_area_2d_body_entered(body):
	if body.name == "Player"\
	or body.is_in_group("can_hold"):
		active = true
		sprite.play("up_2_down")

func _on_area_2d_body_exited(body):
	if body.name == "Player"\
	or body.is_in_group("can_hold"):
		active = false
		sprite.play("down_2_up")

func _on_sprite_frame_changed():
	if active:
		if collision.scale.y > 0.4:
			collision.scale.y -= 0.125
		else:
			collision.scale.y = 0.4
	
	if !active:
		if collision.scale.y < 1.0:
			collision.scale.y += 0.125
		else:
			collision.scale.y = 1.0
