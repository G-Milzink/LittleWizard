extends Node2D

@export var ladder_y_scale = 1.0

@onready var ladder_up = $Ladder_Up
@onready var ladder_down = $Ladder_Down

@onready var icon_area_down = $Icon_Area_Down

@onready var up_arrow = $Icon_Area_Up/Up_Arrow
@onready var down_arrow = $Icon_Area_Down/Down_Arrow

@onready var animation_player = $AnimationPlayer


func _ready():
	up_arrow.visible = false
	down_arrow.visible = false
	
	ladder_up.scale.y = ladder_y_scale
	ladder_down.scale.y = ladder_y_scale
	ladder_down.position.y = -64
	icon_area_down.position.y = (ladder_y_scale * -64) - 16

func _on_ladder_up_body_entered(body):
	_Globals.can_climb_up = true

func _on_ladder_up_body_exited(body):
	_Globals.can_climb_up = false
	_Globals.is_climbing = false

func _on_ladder_down_body_entered(body):
	_Globals.can_climb_down = true

func _on_ladder_down_body_exited(body):
	_Globals.can_climb_down = false
	_Globals.is_climbing = false

func _on_icon_area_up_body_entered(body):
	up_arrow.visible = true
	if !animation_player.is_playing():
		animation_player.play("up_arrow_bobbing")
	
func _on_icon_area_up_body_exited(body):
	up_arrow.visible = false
	if animation_player.is_playing():
		animation_player.stop()

func _on_icon_area_down_body_entered(body):
	down_arrow.visible = true
	if !animation_player.is_playing():
		animation_player.play("down_arrow_bobbing")

func _on_icon_area_down_body_exited(body):
	down_arrow.visible = false
	if animation_player.is_playing():
		animation_player.stop()
