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

# Oyun hızını takip etmek için değişkenler
var game_paused: bool = false
var current_speed: float = 1.0  # Varsayılan hız 1x

# Kamera referansları
var main_camera: Camera3D = null
var eclipse_camera: Camera3D = null

func _ready():
	# Kameraları hazır olduğunda ata
	main_camera = $/root/Node/Node3Dgunestutulmasi/Camera3Dgunes
	eclipse_camera = $/root/Node/Node3Dgunestutulmasi/earth_to_sun

func _process(delta):
	# İlk gecikme süresi boyunca herhangi bir işlem yapma
	elapsed_time += delta * current_speed
	if elapsed_time < delay_before_eclipse_check:
		update_orbits(delta * current_speed)
		return

	if is_paused:
		return  # Eğer durdurulduysa hareket etme

	# Dünya ve Ay'ın hareketlerini kontrol et
	update_orbits(delta * current_speed)

	# Pozisyonları al
	var sun_position = $/root/Node/Node3Dgunestutulmasi/sun.global_transform.origin
	var earth_position = $/root/Node/Node3Dgunestutulmasi/EarthOrbit/Earth.global_transform.origin
	var moon_position = $/root/Node/Node3Dgunestutulmasi/EarthOrbit/Earth/MoonOrbitgunes/Moon.global_transform.origin

	# Ay Dünya ile Güneş arasına girerse hareketi durdur
	if is_eclipse(moon_position, earth_position, sun_position):
		if skip_first_eclipse:
			# İlk hizalanmayı yok say
			skip_first_eclipse = false
			print("İlk hizalanma atlandı!")
			return

		is_paused = true  # Hareketi durdur
		pause_orbits()  # Yörünge hızlarını sıfırla
		print("Ay Dünya ile Güneş arasına girdi! Eğer görmek istiyorsanız D tuşuna basınız.")
		lock_positions(earth_position, moon_position)

func _input(event):
	if Input.is_action_just_pressed("switch_to_eclipse_camera"):
		activate_camera(eclipse_camera)  # Ay tutulması kamerasına geç
	elif Input.is_action_just_pressed("switch_to_main_camera"):
		activate_camera(main_camera)  # Ana kameraya geri dön

	# P tuşu ile oyunu durdur/devam ettir
	if Input.is_action_just_pressed("pause_game"):
		toggle_game_pause()

	# 1, 2, 3 tuşları ile oyun hızını değiştir
	if Input.is_action_just_pressed("speed_1"):
		change_game_speed(1.0)
	elif Input.is_action_just_pressed("speed_2"):
		change_game_speed(2.0)
	elif Input.is_action_just_pressed("speed_3"):
		change_game_speed(3.0)

# Oyun hızını durdur veya devam ettir
func toggle_game_pause():
	if game_paused:
		Engine.time_scale = current_speed  # Mevcut hızda devam et
		game_paused = false
		print("Oyun devam ediyor...")
	else:
		Engine.time_scale = 0  # Oyunu tamamen durdur
		game_paused = true
		print("Oyun durduruldu.")

# Oyun hızını değiştir
func change_game_speed(speed: float):
	if game_paused:
		print("Oyun durdurulmuşken hız değiştirilemez.")
		return

	current_speed = speed
	Engine.time_scale = current_speed
	print("Oyun hızı değiştirildi: %.1fx" % current_speed)

# Dünya ve Ay'ın hareketini güncelle
func update_orbits(delta):
	# Dünya'nın hareketi
	current_earth_angle += earth_orbit_speed * delta
	if current_earth_angle >= 360.0:
		current_earth_angle -= 360.0

	var earth_x_position = 60.0 * cos(deg_to_rad(current_earth_angle))
	var earth_z_position = 60.0 * sin(deg_to_rad(current_earth_angle))
	$/root/Node/Node3Dgunestutulmasi/EarthOrbit/Earth.global_transform.origin = Vector3(earth_x_position, 0, earth_z_position)

	# Ay'ın hareketi
	current_moon_angle += moon_orbit_speed * delta
	if current_moon_angle >= 360.0:
		current_moon_angle -= 360.0

	var moon_x_position = 10.0 * cos(deg_to_rad(current_moon_angle))
	var moon_z_position = 10.0 * sin(deg_to_rad(current_moon_angle))
	var earth_position = $/root/Node/Node3Dgunestutulmasi/EarthOrbit/Earth.global_transform.origin
	$/root/Node/Node3Dgunestutulmasi/EarthOrbit/Earth/MoonOrbitgunes/Moon.global_transform.origin = earth_position + Vector3(moon_x_position, 0, moon_z_position)

# Ay Dünya ile Güneş arasına girdi mi? Kontrol eder
func is_eclipse(moon_pos, earth_pos, sun_pos):
	# Dünya'dan Güneş'e olan yön vektörü
	var earth_to_sun = (sun_pos - earth_pos).normalized()
	# Dünya'dan Ay'a olan yön vektörü
	var earth_to_moon = (moon_pos - earth_pos).normalized()
	
	# Eğer Dünya'dan bakıldığında Ay ile Güneş aynı doğrultudaysa (dot > 0.99), hizalanmış demektir
	return earth_to_sun.dot(earth_to_moon) > 0.99

# Yörünge hareketlerini durdur
func pause_orbits():
	$/root/Node/Node3Dgunestutulmasi/EarthOrbit.pause_orbit()
	$/root/Node/Node3Dgunestutulmasi/EarthOrbit/Earth/MoonOrbitgunes.pause_orbit()

	# Kendi eksen dönüşlerini sıfırla ve durdur
	$/root/Node/Node3Dgunestutulmasi/EarthOrbit/Earth.rotation_degrees = Vector3(0, 0, 0)
	$/root/Node/Node3Dgunestutulmasi/EarthOrbit/Earth/MoonOrbitgunes/Moon.rotation_degrees = Vector3(0, 0, 0)

	$/root/Node/Node3Dgunestutulmasi/EarthOrbit/Earth.set_process(false)
	$/root/Node/Node3Dgunestutulmasi/EarthOrbit/Earth/MoonOrbitgunes/Moon.set_process(false)

# Dünya ve Ay'ı hizalanma pozisyonunda sabit tut
func lock_positions(earth_pos, moon_pos):
	$/root/Node/Node3Dgunestutulmasi/EarthOrbit/Earth.global_transform.origin = earth_pos
	$/root/Node/Node3Dgunestutulmasi/EarthOrbit/Earth/MoonOrbitgunes/Moon.global_transform.origin = moon_pos
	print("Pozisyonlar sabitlendi: Ay Dünya ile Güneş arasında.")

# Kamerayı değiştir
func activate_camera(camera: Camera3D):
	# Tüm kameraları devre dışı bırak
	for child in get_tree().get_nodes_in_group("Cameras"):
		if child is Camera3D:
			child.current = false
	
	# İstenen kamerayı etkinleştir
	camera.current = true
