extends PointLight2D

@export_category("Intensity")
@export var base_intensity = 2.0
@export var intensity_min_offset = -0.1
@export var intensity_max_offset = 0.2
@export var intensity_smoothing = 20.0
@export_category("Scaling")
@export var base_scale = 7.5
@export var scaling_min_offset = -0.5
@export var scaling_max_offset = 0.5
@export var scale_smoothing = 10.0


func _ready():
	self.energy = base_intensity
	self.texture_scale = base_scale


func _process(delta):
	var flicker_intensity = randf_range(intensity_min_offset, intensity_max_offset)
	var scaling_intensity = randf_range(scaling_min_offset, scaling_max_offset)
	self.energy = lerp(self.energy,base_intensity+flicker_intensity, intensity_smoothing * delta)
	self.texture_scale = lerp(self.texture_scale,base_scale+scaling_intensity, scale_smoothing * delta)
