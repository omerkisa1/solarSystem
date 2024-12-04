extends Spatial 

var orbit_speed = 0.5  # Ay'ın Dünya etrafındaki dönüş hızı
var orbit_radius = 3.0  # Ay'ın Dünya'dan uzaklığı (yarıçap)
var current_angle = 0.0  # Yörüngedeki mevcut açı

func _process(delta):
	# Açı ilerliyor
	current_angle += orbit_speed * delta
	
	# X ve Z pozisyonlarını hesapla (dairesel yörünge)
	var x_position = orbit_radius * cos(deg2rad(current_angle))
	var z_position = orbit_radius * sin(deg2rad(current_angle))
	
	# Ay'ın pozisyonunu güncelle
	$moon.translation = Vector3(x_position, 0, z_position)
