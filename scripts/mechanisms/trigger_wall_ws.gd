extends StaticBody2D

@export_category("Triggers:")
@export_enum("1","2","3") var set_nr_of_triggers
@export var trigger_1: Node
@export var trigger_2: Node
@export var trigger_3: Node
@export var overide_switch: Node
@export_category("Door:")
@export_enum("upwards", "downwards") var set_direction
@export var open_duration = 2.0
@export var closing_delay = 1.5
@export var closing_duration =1.0
#-----------------------------------------------------------
@onready var collision = $Collision
@onready var timer = $Timer
@onready var sprite = $AnimatedSprite2D
@onready var upward_particles = $upward_particles
@onready var downward_particles = $downward_particles

var nr_of_triggers
var open = false
var direction

func _ready():
	nr_of_triggers = set_nr_of_triggers + 1
	if set_direction == 0:
		direction = -1.0
		sprite.play("upwards_closed")
	else:
		direction = 1.0
		sprite.play("downwards_closed")

func _process(delta):
	if !overide_switch.active:
		match nr_of_triggers:
			1:
				if trigger_1.active:
					_Opening()
				else:
					_Closing()
			2:
				if trigger_1.active and trigger_2.active:
					_Opening()
				else:
					_Closing()
			3:
				if trigger_1.active and trigger_2.active and trigger_3.active:
					_Opening()
				else:
					_Closing()
	else:
		_Overide()

func _Opening():
	timer.start(closing_delay) 
	if !open:
		if direction == 1.0:
			sprite.play("downwards",1.0)
			downward_particles.set_emitting(true)
		else:
			sprite.play("upwards",1.0)
			upward_particles.set_emitting(true)
		var frame = sprite.get_frame()
		collision.position.y = (direction*128.0) * ((frame+1.0)/65.0)
		if frame == 64:
			upward_particles.set_emitting(false)
			downward_particles.set_emitting(false)
			open = true

func _Closing():
	if timer.is_stopped() && open:
		if direction == 1.0:
			sprite.play("downwards",-1.0, true)
			downward_particles.set_emitting(true)
		else:
			sprite.play("upwards",-1.0, true)
			upward_particles.set_emitting(true)
		var frame = sprite.get_frame()
		collision.position.y = (direction*128.0) * ((frame+1.0)/65)
		if frame == 0:
			upward_particles.set_emitting(false)
			downward_particles.set_emitting(false)
			open = false

func _Overide():
	if !open:
		if direction == 1.0:
			sprite.play("downwards",1.0)
			downward_particles.set_emitting(true)
		else:
			sprite.play("upwards",1.0)
			upward_particles.set_emitting(true)
		var frame = sprite.get_frame()
		collision.position.y = (direction*128.0) * ((frame+1.0)/65.0)
		if frame == 64:
			upward_particles.set_emitting(false)
			downward_particles.set_emitting(false)
			open = true
