extends CharacterBody2D
#-------------------------------------------------------------------

@onready var character = $Character
@onready var hold_timer = $HoldTimer

#-------------------------------------------------------------------

@export var moveSpeed = 100.0
@export var runSpeed = 175

#-------------------------------------------------------------------

var direction = 0
var current_speed = 0
var selected = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var creature_held = false

#---------------------------------------------------------------------

func _ready():
	current_speed = moveSpeed
	var rnd = randi_range(1,100)
	if rnd > 50:
		direction = 1
	else:
		direction = -1
		
#---------------------------------------------------------------------

func _physics_process(delta):
	_Handle_Spell_Hold()
	_Handle_Movement(delta)
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
		if direction:
			velocity.x = direction * current_speed
		else:
			velocity.x = move_toward(velocity.x, 0, current_speed)
		#flip sprite:
		if direction == 1:
			character.set_flip_h(true)
		else:
			character.set_flip_h(false)

func _Handle_Spell_Hold():
	if selected && _Globals.current_spell == "Hold":
		if Input.is_action_just_pressed("cast_spell"):
			character.stop()
			current_speed = 0
			creature_held = true
			if hold_timer.is_stopped():
				hold_timer.start(_Globals.hold_duration)

func _on_hold_timer_timeout():
	character.play("walking")
	current_speed = moveSpeed
	creature_held = false

func _on_detection_area_body_entered(body):
	if body.name == "Player":
		if _Globals.player_position.x < position.x:
			direction = 1
		else:
			direction = -1
		current_speed = runSpeed
		character.play("running")

func _on_safety_buffer_body_exited(body):
	if body.name == "Player":
		current_speed = moveSpeed
		character.play("walking")

func _on_mouse_detection_body_entered(body):
	selected = true

func _on_mouse_detection_body_exited(body):
	selected = false


