extends CharacterBody2D

@onready var sprite_player_body = $Sprite2D
@onready var staff_light = $StaffLight

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = _Globals.player_jump_velocity

	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * _Globals.player_move_speed
	else:
		velocity.x = move_toward(velocity.x, 0, _Globals.player_move_speed)
	
	if direction < 0:
		sprite_player_body.set_flip_h(true)
		staff_light.position.x = -20
	elif direction > 0:
		sprite_player_body.set_flip_h(false)
		staff_light.position.x = 20

	
	move_and_slide()
