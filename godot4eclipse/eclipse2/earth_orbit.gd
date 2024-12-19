extends Node3D

@export var orbit_radius_x: float = 60.0  # X eksenindeki yörünge yarıçapı
@export var orbit_radius_z: float = 60.0  # Z eksenindeki yörünge yarıçapı
var current_angle: float = 0.0  # Yörüngedeki mevcut açı

func _process(delta):
	current_angle += Global.earth_orbit_speed * delta  # Hızı global değişkenden al
	if current_angle >= 360.0:
		current_angle -= 360.0

	var x_position = orbit_radius_x * cos(deg_to_rad(current_angle))
	var z_position = orbit_radius_z * sin(deg_to_rad(current_angle))

	$Earth.global_transform.origin = Vector3(x_position, 0, z_position)
