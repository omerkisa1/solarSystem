extends Node3D
# Yörünge hızları

@export var earth_orbit_speed: float = 5.0
@export var moon_orbit_speed: float = 10.0
@export var delay_before_eclipse_check: float = 3.0  # Ay tutulması kontrolünden önce bekleme süresi (saniye)

var current_earth_angle: float = 0.0  # Dünya'nın yörüngedeki mevcut açısı
var current_moon_angle: float = 0.0  # Ay'ın yörüngedeki mevcut açısı

var is_paused: bool = false  # Ay tutulması sırasında hareket durdurulacak
var skip_first_eclipse: bool = true  # İlk hizalanmayı pas geç
var elapsed_time: float = 0.0  # Geçen süreyi takip eder

# Kamera referansları
var main_camera: Camera3D = null
var eclipse_camera: Camera3D = null

func _ready():
	# Kameraları hazır olduğunda ata
	main_camera = $/root/Node/Node3Daytutulmasi/Camera3Day
	eclipse_camera = $/root/Node/Node3Daytutulmasi/earth_to_moon

func _process(delta):
	# İlk gecikme süresi boyunca herhangi bir işlem yapma
	elapsed_time += delta
	if elapsed_time < delay_before_eclipse_check:
		update_orbits(delta)
		return

	if is_paused:
		return  # Eğer durdurulduysa hareket etme

	# Dünya ve Ay'ın hareketlerini kontrol et
	update_orbits(delta)

	# Pozisyonları al
	var sun_position = $/root/Node/Node3Daytutulmasi/sun.global_transform.origin
	var earth_position = $/root/Node/Node3Daytutulmasi/EarthOrbit/Earth.global_transform.origin
	var moon_position = $/root/Node/Node3Daytutulmasi/EarthOrbit/Earth/MoonOrbitay/Moon.global_transform.origin

	# Ay tutulması kontrolü
	if is_eclipse(earth_position, moon_position, sun_position):
		if skip_first_eclipse:
			# İlk hizalanmayı yok say
			skip_first_eclipse = false
			print("İlk hizalanma atlandı!")
			return

		is_paused = true  # Hareketi durdur
		pause_orbits()  # Yörünge hızlarını sıfırla
		print("Ay tutulması gerçekleşiyor! Eğer görmek istiyorsanız D tuşuna basınız.")
		lock_positions(earth_position, moon_position)

func _input(_event):
	if Input.is_action_just_pressed("switch_to_eclipse_camera"):
		activate_camera(eclipse_camera)  # Ay tutulması kamerasına geç
	elif Input.is_action_just_pressed("switch_to_main_camera"):
		activate_camera(main_camera)  # Ana kameraya geri dön

# Dünya ve Ay'ın hareketini güncelle
func update_orbits(delta):
	# Dünya'nın hareketi
	current_earth_angle += earth_orbit_speed * delta
	if current_earth_angle >= 360.0:
		current_earth_angle -= 360.0

	var earth_x_position = 60.0 * cos(deg_to_rad(current_earth_angle))
	var earth_z_position = 60.0 * sin(deg_to_rad(current_earth_angle))
	$/root/Node/Node3Daytutulmasi/EarthOrbit/Earth.global_transform.origin = Vector3(earth_x_position, 0, earth_z_position)

	# Ay'ın hareketi
	current_moon_angle += moon_orbit_speed * delta
	if current_moon_angle >= 360.0:
		current_moon_angle -= 360.0

	var moon_x_position = 10.0 * cos(deg_to_rad(current_moon_angle))
	var moon_z_position = 10.0 * sin(deg_to_rad(current_moon_angle))
	var earth_position = $/root/Node/Node3Daytutulmasi/EarthOrbit/Earth.global_transform.origin
	$/root/Node/Node3Daytutulmasi/EarthOrbit/Earth/MoonOrbitay/Moon.global_transform.origin = earth_position + Vector3(moon_x_position, 0, moon_z_position)

# Ay tutulması kontrolü (Dünya, Güneş ve Ay hizalaması)
func is_eclipse(earth_pos, moon_pos, sun_pos):
	var sun_to_earth = (earth_pos - sun_pos).normalized()
	var earth_to_moon = (moon_pos - earth_pos).normalized()
	return sun_to_earth.dot(earth_to_moon) > 0.99

# Yörünge hareketlerini durdur
func pause_orbits():
	$/root/Node/Node3Daytutulmasi/EarthOrbit.pause_orbit()
	$/root/Node/Node3Daytutulmasi/EarthOrbit/Earth/MoonOrbitay.pause_orbit()

	# Kendi eksen dönüşlerini sıfırla ve durdur
	$/root/Node/Node3Daytutulmasi/EarthOrbit/Earth.rotation_degrees = Vector3(0, 0, 0)
	$/root/Node/Node3Daytutulmasi/EarthOrbit/Earth/MoonOrbitay/Moon.rotation_degrees = Vector3(0, 0, 0)

	$/root/Node/Node3Daytutulmasi/EarthOrbit/Earth.set_process(false)
	$/root/Node/Node3Daytutulmasi/EarthOrbit/Earth/MoonOrbitay/Moon.set_process(false)

# Dünya ve Ay'ı hizalanma pozisyonunda sabit tut
func lock_positions(earth_pos, moon_pos):
	$/root/Node/Node3Daytutulmasi/EarthOrbit/Earth.global_transform.origin = earth_pos
	$/root/Node/Node3Daytutulmasi/EarthOrbit/Earth/MoonOrbitay/Moon.global_transform.origin = moon_pos
	print("Pozisyonlar sabitlendi: Dünya ve Ay hizalanmış durumda.")

# Kamerayı değiştir
func activate_camera(camera: Camera3D):
	# Tüm kameraları devre dışı bırak
	for child in get_tree().get_nodes_in_group("Cameras"):
		if child is Camera3D:
			child.current = false
	
	# İstenen kamerayı etkinleştir
	camera.current = true
