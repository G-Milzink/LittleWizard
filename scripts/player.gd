extends CharacterBody2D

@onready var sprite_player_body = $Sprite2D
@onready var staff_light = $StaffLight
@onready var repellant_shape_cast = $RepellantShapeCast
@onready var floor_check = $FloorCheck


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	position = _Globals.START_LOCATION


func _physics_process(delta):
	_addGravity(delta)
	_handleClimbing(delta)
	_handleJump(delta)	
	_handleRepellant()
	_handleMovement(delta)

	if _Globals.has_control:
		move_and_slide()
	_transmitPlayerPosition()

func _transmitPlayerPosition():
	_Globals.player_position = position

func _addGravity(delta):
	if !is_on_floor():
		if !_Globals.is_climbing:
			velocity.y += gravity * delta

func _handleJump(delta):
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = _Globals.player_jump_velocity

func _handleMovement(delta):
	if !_Globals.is_repelled:
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

	if _Globals.can_climb_up && !_Globals.is_climbing:
		if Input.is_action_just_pressed("action"):
			if !_Globals.is_climbing:
				_Globals.is_climbing = true
				position.y = position.y - 4
			else:
				_Globals.is_climbing = false
	
	if _Globals.can_climb_down && !_Globals.is_climbing:
		if Input.is_action_just_pressed("action"):
			if !_Globals.is_climbing:
				_Globals.is_climbing = true
				position.y = position.y - 4
			else:
				_Globals.is_climbing = false
	
	if _Globals.is_climbing:
		self.set_collision_mask_value(1,false)
		var direction = Input.get_axis("jump", "move_down")
		if direction:
			velocity.y = direction * _Globals.player_climb_speed
		else:
			velocity.y = move_toward(velocity.x, 0, _Globals.player_climb_speed)
	else:
		self.set_collision_mask_value(1,true)
	
	if floor_check.is_colliding():
		self.set_collision_mask_value(1,true)
	
func _handleRepellant():
	if repellant_shape_cast.is_colliding() && !_Globals.is_repelled:
		var repellant = repellant_shape_cast.get_collider(0)
		if repellant.position.x >= position.x:
			velocity.x = -_Globals.repulsion_force
		else:
			velocity.x = _Globals.repulsion_force
		
		velocity.y += -_Globals.repulsion_force
		_Globals.is_repelled = true
	
	if is_on_floor():
		_Globals.is_repelled = false
