extends Node3D

@export var orbit_speed: float = 10.0  # Ay'ın yörünge hızı
@export var orbit_radius: float = 10.0  # Dünya'ya olan uzaklık (yarıçap)
var current_angle: float = 0.0  # Yörüngedeki mevcut açı

var is_paused: bool = false  # Yörünge hareketini durdurmak için bayrak

func _process(delta):
	if is_paused:
		return
	
	current_angle += orbit_speed * delta
	if current_angle >= 360.0:
		current_angle -= 360.0

	var x_position = orbit_radius * cos(deg_to_rad(current_angle))
	var z_position = orbit_radius * sin(deg_to_rad(current_angle))

	var earth_position = $"/root/Node/Node3Dgunestutulmasi/EarthOrbit/Earth".global_transform.origin
	$Moon.global_transform.origin = earth_position + Vector3(x_position, 0, z_position)

func pause_orbit():
	is_paused = true

func stop_rotation():
	$Moon.rotation = Vector3(0, 0, 0)  # Ay'ın kendi ekseni etrafındaki dönüşünü durdur
