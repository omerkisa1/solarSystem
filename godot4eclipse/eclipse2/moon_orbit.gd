extends Node3D

@export var orbit_speed: float = 10.0  # Ay'ın yörünge hızı
@export var orbit_radius: float = 10.0  # Dünya'ya olan uzaklık (yarıçap)
var current_angle: float = 0.0  # Yörüngedeki mevcut açı

func _process(delta):
	# Açı ilerliyor
	current_angle += orbit_speed * delta
	if current_angle >= 360.0:
		current_angle -= 360.0  # Açı tekrar başa döner

	# X ve Z pozisyonlarını hesapla
	var x_position = orbit_radius * cos(deg_to_rad(current_angle))
	var z_position = orbit_radius * sin(deg_to_rad(current_angle))

	# Dünya'nın pozisyonuna göre Ay'ın pozisyonunu güncelle
	var earth_position = $"/root/Node/Node3D/EarthOrbit/Earth".global_transform.origin  # Dünya'nın pozisyonunu al
	$Moon.global_transform.origin = earth_position + Vector3(x_position, 0, z_position)
