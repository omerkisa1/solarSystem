extends Node3D

@export var orbit_speed: float = 10.0  # Ay'ın yörünge hızı
@export var orbit_radius: float = 10.0  # Dünya'ya olan uzaklık (yarıçap)
var current_angle: float = 0.0  # Yörüngedeki mevcut açı

var is_paused: bool = false  # Yörünge hareketini durdurmak için bayrak

# Ay evrelerini tutan liste
var moon_phases = ["Dolunay", "Şişkin Ay", "Son Dördün", "Hilal", "Yeni Ay", "Hilal", "İlk Dördün", "Şişkin Ay","Dolunay"]

# Zamanlayıcı için değişkenler
var phase_timer: float = 0.0  # Evre değiştirme zamanlayıcısı
var current_phase_index: int = 0  # Şu anki evre indeksi

func _ready():
	# Oyuna başlarken Dolunay'ı yazdır
	$Moon/moon_label.text = moon_phases[current_phase_index]

func _process(delta):
	if is_paused:
		return

	# Ay'ın hareketini güncelle
	current_angle += orbit_speed * delta
	if current_angle >= 360.0:
		current_angle -= 360.0

	var x_position = orbit_radius * cos(deg_to_rad(current_angle))
	var z_position = orbit_radius * sin(deg_to_rad(current_angle))

	var earth_position = $"/root/Node/Node3Devre/EarthOrbit/Earth".global_transform.origin
	$Moon.global_transform.origin = earth_position + Vector3(x_position, 0, z_position)

	# Label'ı Ay'ın üstünde tut
	var label = $Moon/moon_label
	label.global_transform.origin = $Moon.global_transform.origin + Vector3(0, 2, 0)
	label.look_at(earth_position, Vector3.UP)
	label.rotate_object_local(Vector3.UP, deg_to_rad(180))  # Etiketi 180 derece çevir

	# Zamanlayıcıyı çalıştır ve evreyi sırayla değiştir
	update_moon_phase(delta)

func update_moon_phase(delta):
	# Zamanlayıcıyı güncelle
	phase_timer += delta
	if phase_timer >= 8.0:  # Her 2 saniyede bir evre değiştir
		phase_timer = 0.0  # Zamanlayıcıyı sıfırla
		current_phase_index = (current_phase_index + 1) % moon_phases.size()
		$Moon/moon_label.text = moon_phases[current_phase_index]  # Ay evresini değiştir
		print("Güncellenen Ay Evresi: ", moon_phases[current_phase_index])  # Kontrol için log
