extends CharacterBody2D
@export var moveSpeed = 100.0
@export var runSpeed = 175

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction = 0
var current_speed = 0

func _ready():
	current_speed = moveSpeed
	var rnd = randi_range(1,100)
	if rnd > 50:
		direction = 1
	else:
		direction = -1

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if is_on_wall():
		direction = direction * -1
	
	if direction:
		velocity.x = direction * current_speed
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)

	move_and_slide()


func _on_detection_area_body_entered(body):
	if body.name == "Player":
		direction = direction * -1
		current_speed = runSpeed


func _on_safety_buffer_body_exited(body):
	if body.name == "Player":
		current_speed = moveSpeed
