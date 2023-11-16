extends StaticBody2D

@onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	if timer.is_stopped():
		timer.start(_Globals.platform_duration)

func _on_timer_timeout():
	_Globals.can_cast_platform = true
	self.queue_free()
