extends Node

const TILE_SIZE = 64
const START_LOCATION = Vector2(-1456,256 - TILE_SIZE*0.5)

# PLayer:
@export_category("PlayerMovement")
@export var player_move_speed = 200
@export var player_climb_speed = 125
@export var player_jump_velocity = -350
@export_category("Spell settings")
@export var has_spell_Hold = true
@export var hold_duration = 3.0 #in seconds

var current_spell = "Hold"

var can_climb_up = false
var can_climb_down = false
var is_climbing = false


var player_position = Vector2.ZERO

# Master Fargnel:
@export_category("NPCs:")

@export var Fargnel_is_active = true
@export var Fargnel_player_can_pass = false

@export_category("Game Params:")
@export var start_location = Vector2.ZERO
