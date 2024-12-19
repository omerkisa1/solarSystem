extends Node3D

@export var orbit_radius: float = 10.0  # Yörünge yarıçapı
var current_angle: float = 0.0  # Yörüngedeki mevcut açı

func _process(delta):
	current_angle += Global.moon_orbit_speed * delta  # Hızı global değişkenden al
	if current_angle >= 360.0:
		current_angle -= 360.0

	var x_position = orbit_radius * cos(deg_to_rad(current_angle))
	var z_position = orbit_radius * sin(deg_to_rad(current_angle))

	var earth_position = $"/root/Node/Node3D/EarthOrbit/Earth".global_transform.origin
	$Moon.global_transform.origin = earth_position + Vector3(x_position, 0, z_position)
