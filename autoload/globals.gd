extends Node

# PLayer:
@export_category("PlayerMovement Paramters")
@export var player_move_speed = 200
@export var player_climb_speed = 125
@export var player_jump_velocity = -350

var current_spell = ""

var can_climb_up = false
var can_climb_down = false
var is_climbing = false

var player_position = Vector2.ZERO

# Master Fargnel:
@export_category("NPCs:")

@export var Fargnel_is_active = true
@export var Fargnel_player_can_pass = false
