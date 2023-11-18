extends CharacterBody2D
#-------------------------------------------------------------------
@onready var moss_guy = $"."
@onready var sprite = $Sprite
@onready var hold_timer = $HoldTimer
@onready var edge_left = $Edge_Detection/Edge_Left
@onready var edge_right = $Edge_Detection/Edge_Right

#-------------------------------------------------------------------

@export var moveSpeed = 100.0
@export var runSpeed = 175

#-------------------------------------------------------------------

var direction = 0
var current_speed = 0
var selected = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var creature_held = false
var turning = false
#---------------------------------------------------------------------

func _ready():
	current_speed = moveSpeed
	var rnd = randi_range(1,100)
	if rnd > 50:
		direction = 1
	else:
		direction = -1
	sprite.material.set_shader_parameter("width", 0)

#---------------------------------------------------------------------

func _physics_process(delta):
	_Handle_Spell_Hold()
	_Handle_Movement(delta)
	_Detect_Edge()
	move_and_slide()
	
#---------------------------------------------------------------------

func _Handle_Movement(delta):
		#apply gravity:
		if not is_on_floor():
			velocity.y += gravity * delta
		#check for wall:
		if is_on_wall():
			direction = direction * -1
		# apply movement:
		if !creature_held:
			if direction:
				velocity.x = direction * current_speed
			else:
				velocity.x = move_toward(velocity.x, 0, current_speed)
			#flip sprite:
			if direction == 1:
				sprite.set_flip_h(true)
			else:
				sprite.set_flip_h(false)

func _Handle_Spell_Hold():
	if selected && _Globals.current_spell == "Hold":
		if Input.is_action_just_pressed("cast_spell"):
			if hold_timer.is_stopped():
				sprite.stop()
				current_speed = 0
				velocity = Vector2.ZERO
				creature_held = true
				sprite.material.set_shader_parameter("width", 2)
				moss_guy.set_collision_layer_value(5, false)
				hold_timer.start(_Globals.hold_duration)
	if !hold_timer.is_stopped():
		if hold_timer.time_left <= 1.0:
			sprite.play("walking")

func _on_hold_timer_timeout():
	sprite.play("walking")
	current_speed = moveSpeed
	creature_held = false
	moss_guy.set_collision_layer_value(5, true)
	sprite.material.set_shader_parameter("width", 0)

func _on_detection_area_body_entered(body):
	if body.name == "Player" && !creature_held:
		if _Globals.player_position.x < position.x:
			direction = 1
		else:
			direction = -1
		current_speed = runSpeed
		sprite.play("running")

func _on_safety_buffer_body_exited(body):
	if body.name == "Player" && !creature_held:
		current_speed = moveSpeed
		sprite.play("walking")

func _on_mouse_detection_body_entered(body):
	selected = true

func _on_mouse_detection_body_exited(body):
	selected = false

func _Detect_Edge():
	if !edge_left.is_colliding()\
	or !edge_right.is_colliding():
		if !turning:
			turning = true
			direction = direction * -1
	else:
		turning = false
	
