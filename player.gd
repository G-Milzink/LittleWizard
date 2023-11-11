extends CharacterBody2D

@onready var sprite_player_body = $Sprite2D
@onready var staff_light = $StaffLight


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	_handleClimbing(delta)
	_handleJump(delta)
	_addGravity(delta)
	_handleMovement(delta)

	move_and_slide()

func _addGravity(delta):
	if !is_on_floor() && !_Globals.is_climbing:
			velocity.y += gravity * delta

func _handleJump(delta):
	if !_Globals.can_climb_up:
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = _Globals.player_jump_velocity

func _handleMovement(delta):
	if _Globals.is_climbing:
		velocity.x = 0
	else: 
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
	

func _handleClimbing(delta):
	var climb_direction = 0
	
	if _Globals.can_climb_up:
		if Input.is_action_pressed("jump"):
			climb_direction = -1
			print("climbing")
			_Globals.is_climbing = true
			self.set_collision_mask_value(1,false)
	
	if _Globals.can_climb_down:
		if Input.is_action_pressed("move_down"):
			climb_direction = 1
			print("climbing")
			_Globals.is_climbing = true
			self.set_collision_mask_value(1,false)
	
	if climb_direction != 0:
		velocity.y = climb_direction * _Globals.player_climb_speed
	
	if !_Globals.is_climbing:
		self.set_collision_mask_value(1,true)

