extends Node3D

@export var orbit_speed: float = 5.0  # Dünya'nın yörünge hızı
@export var orbit_radius_x: float = 60.0  # X eksenindeki yörünge yarıçapı
@export var orbit_radius_z: float = 60.0  # Z eksenindeki yörünge yarıçapı
var current_angle: float = 0.0  # Yörüngedeki mevcut açı

func _process(delta):
	# Açı ilerliyor
	current_angle += orbit_speed * delta
	if current_angle >= 360.0:
		current_angle -= 360.0  # Açı tekrar başa döner
	
	# X ve Z pozisyonlarını hesapla
	var x_position = orbit_radius_x * cos(deg_to_rad(current_angle))
	var z_position = orbit_radius_z * sin(deg_to_rad(current_angle))
	
	# Dünya'nın pozisyonunu güncelle
	$Earth.global_transform.origin = Vector3(x_position, 0, z_position)
