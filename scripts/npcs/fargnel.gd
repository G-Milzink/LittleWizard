extends CharacterBody2D

@onready var speech_bubble = $Speech_bubble

func _ready():
	speech_bubble.visible = false

func _on_range_body_entered(body):
	speech_bubble.visible = true

func _on_range_body_exited(body):
	speech_bubble.visible = false
