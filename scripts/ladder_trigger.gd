extends Node2D

@export var UP_area_y_scale = 1.0
@export var UP_area_y_offset = 0
@export var DOWN_area_y_scale = 1.0
@export var DOWN_area_y_offset = 0


@onready var up_area = $Up_Area
@onready var down_area = $Down_Area
@onready var icon_area_down = $Icon_Area_Down

@onready var up_arrow = $Icon_Area_Up/Up_Arrow
@onready var down_arrow = $Icon_Area_Down/Down_Arrow

@onready var animation_player = $AnimationPlayer


func _ready():
	up_arrow.visible = false
	down_arrow.visible = false
	icon_area_down.position.y = (UP_area_y_scale * -64) - 16
	
	up_area.scale.y = UP_area_y_scale
	up_area.position.y = UP_area_y_offset
	down_area.scale.y = DOWN_area_y_scale
	down_area.position.y = DOWN_area_y_offset
	
	

func _on_up_area_body_entered(body):
	_Globals.can_climb_up = true

func _on_up_area_body_exited(body):
	_Globals.can_climb_up = false
	_Globals.is_climbing = false

func _on_down_area_body_entered(body):
	_Globals.can_climb_down = true

func _on_down_area_body_exited(body):
	_Globals.can_climb_down = false
	_Globals.is_climbing = false

func _on_icon_area_up_body_entered(body):
	up_arrow.visible = true
	if !animation_player.is_playing():
		print("up?")
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
