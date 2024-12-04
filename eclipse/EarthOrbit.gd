extends Spatial 

var orbit_speed = 5.0  # Dünya'nın yörünge hızı
var orbit_radius_x = 150.0  # X eksenindeki yörünge yarıçapı
var orbit_radius_z = 130.0  # Z eksenindeki yörünge yarıçapı
var current_angle = 0.0  # Yörüngedeki mevcut açı

func _process(delta):
	# Açı ilerliyor
	current_angle += orbit_speed * delta
	
	# X ve Z pozisyonlarını hesapla
	var x_position = orbit_radius_x * cos(deg2rad(current_angle))
	var z_position = orbit_radius_z * sin(deg2rad(current_angle))
	
	# Dünya'nın pozisyonunu güncelle
	translation = Vector3(x_position, 0, z_position)
