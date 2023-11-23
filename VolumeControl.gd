extends Node

@onready var music_bus = AudioServer.get_bus_index("Music")
@onready var ambience_bus = AudioServer.get_bus_index("Ambience")

func _ready():
	AudioServer.set_bus_mute(music_bus, _Globals.MuteMusic)
	AudioServer.set_bus_volume_db(music_bus, linear_to_db(_Globals.MusicVolume))
	AudioServer.set_bus_mute(ambience_bus, _Globals.MuteAmbience)
	AudioServer.set_bus_volume_db(ambience_bus, linear_to_db(_Globals.AmbienceVolume))


func _process(delta):
	AudioServer.set_bus_mute(music_bus, _Globals.MuteMusic)
	AudioServer.set_bus_volume_db(music_bus, linear_to_db(_Globals.MusicVolume))
	AudioServer.set_bus_mute(ambience_bus, _Globals.MuteAmbience)
	AudioServer.set_bus_volume_db(ambience_bus, linear_to_db(_Globals.AmbienceVolume))
