extends Node3D
# Yörünge hızları
@export var earth_orbit_speed: float = 5.0
@export var moon_orbit_speed: float = 10.0

var current_earth_angle: float = 0.0  # Dünya'nın yörüngedeki mevcut açısı
var current_moon_angle: float = 0.0  # Ay'ın yörüngedeki mevcut açısı

var is_paused: bool = false  # Hareket durdurulacak mı?
var elapsed_time: float = 0.0  # Geçen süreyi takip eder

# Kamera referansı
var main_camera: Camera3D = null

# Oyun hızını takip etmek için bir değişken
var game_paused: bool = false
var current_speed: float = 0.35  # Varsayılan hız 0.5x (yarı hız)

func _ready():
	# Kamerayı ayarla
	main_camera = $/root/Node/Node3Devre/earth_to_moon_evre
	main_camera.current = true  # Ana kamera doğrudan kullanılıyor

	# Oyun hızını yarıya ayarla
	Engine.time_scale = current_speed

func _process(delta):
	if is_paused:
		return  # Eğer durdurulduysa hareket etme
	
	# Dünya ve Ay'ın hareketlerini güncelle
	update_orbits(delta)

func _input(event):
	# P tuşu ile oyunu durdur/devam ettir
	if Input.is_action_just_pressed("pause_game"):
		toggle_game_pause()

# Dünya ve Ay'ın hareketini güncelle
func update_orbits(delta):
	# Dünya'nın hareketi
	current_earth_angle += earth_orbit_speed * delta
	if current_earth_angle >= 360.0:
		current_earth_angle -= 360.0

	var earth_x_position = 60.0 * cos(deg_to_rad(current_earth_angle))
	var earth_z_position = 60.0 * sin(deg_to_rad(current_earth_angle))
	$/root/Node/Node3Devre/EarthOrbit/Earth.global_transform.origin = Vector3(earth_x_position, 0, earth_z_position)

	# Ay'ın hareketi
	current_moon_angle += moon_orbit_speed * delta
	if current_moon_angle >= 360.0:
		current_moon_angle -= 360.0

	var moon_x_position = 10.0 * cos(deg_to_rad(current_moon_angle))
	var moon_z_position = 10.0 * sin(deg_to_rad(current_moon_angle))
	var earth_position = $/root/Node/Node3Devre/EarthOrbit/Earth.global_transform.origin
	$/root/Node/Node3Devre/EarthOrbit/Earth/MoonOrbitevre/Moon.global_transform.origin = earth_position + Vector3(moon_x_position, 0, moon_z_position)

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
