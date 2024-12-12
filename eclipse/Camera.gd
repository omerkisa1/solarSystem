extends Camera3D

# Zoom parametreleri
var zoom_speed = 5.0
var min_distance = 2.0  # Minimum yakınlık
var max_distance = 150.0  # Maksimum uzaklık

# Pan ve Döndürme Kontrolleri
var sensitivity = 0.1
var pan_speed = 5.0
var mouse_middle_pressed = false
var mouse_left_pressed = false
var last_mouse_position = Vector2()

# Dünya'ya odaklanma ayarları
var is_locked_on_earth = false  # Kamera Dünya'ya kilitlenmiş mi?
@onready var earth = null  # Dünya düğümüne referans

func _ready():
	# Dünya düğümünü bul
	earth = get_node("../EarthOrbit/earth")  # Sahne yapınıza göre bu yolu kontrol edin
	if earth:
		print("Dünya bulundu: ", earth.name)
	else:
		print("Dünya bulunamadı! Yol hatalı olabilir.")

func _input(event):
	# Orta fare tuşuyla pan kontrolü
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_MIDDLE:
			mouse_middle_pressed = event.pressed
			last_mouse_position = event.position
		elif event.button_index == MOUSE_BUTTON_LEFT:  # Sol tıklama
			mouse_left_pressed = event.pressed
			last_mouse_position = event.position

	# Dünya'ya odaklanma tuşu (örnek: F tuşu)
	if Input.is_action_just_pressed("ui_focus"):
		is_locked_on_earth = !is_locked_on_earth  # Kilit durumunu değiştirin
		if is_locked_on_earth:
			print("Kamera Dünya'ya odaklandı.")
		else:
			print("Kamera serbest moda geçti.")

	# Fare hareketini kontrol et (serbest moddayken)
	if event is InputEventMouseMotion and not is_locked_on_earth:
		if mouse_middle_pressed:  # Pan hareketi
			var delta = event.position - last_mouse_position
			translate(Vector3(-delta.x * pan_speed * 0.01, delta.y * pan_speed * 0.01, 0))
			last_mouse_position = event.position

		elif mouse_left_pressed:  # Kamera çevirme
			var delta = event.relative
			rotate_x(deg_to_rad(-delta.y * sensitivity))  # Yukarı/aşağı
			rotate_y(deg_to_rad(-delta.x * sensitivity))  # Sağa/sola
			rotation_degrees.x = clamp(rotation_degrees.x, -90, 90)  # Dikey açı sınırı

	# Fare tekerleği ile zoom
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_WHEEL_UP:
		zoom_camera(-zoom_speed)  # Yakınlaştır
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
		zoom_camera(zoom_speed)  # Uzaklaştır

func zoom_camera(amount):
	# Kamerayı Z ekseni boyunca ileri/geri hareket ettir
	var new_translation = position + transform.basis.z * amount
	if new_translation.length() >= min_distance and new_translation.length() <= max_distance:
		position = new_translation

func _process(delta):
	# Eğer Dünya'ya kilitlenmişse, Dünya'ya odaklan
	if is_locked_on_earth and earth:
		look_at(earth.global_transform.origin, Vector3.UP)
