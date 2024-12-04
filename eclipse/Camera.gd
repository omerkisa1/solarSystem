extends Camera

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

func _input(event):
	# Orta fare tuşuyla pan kontrolü
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_MIDDLE:
			mouse_middle_pressed = event.pressed
			last_mouse_position = event.position
		elif event.button_index == BUTTON_LEFT:  # Sol tıklama
			mouse_left_pressed = event.pressed
			last_mouse_position = event.position

	# Fare hareketini kontrol et
	if event is InputEventMouseMotion:
		if mouse_middle_pressed:  # Pan hareketi
			var delta = event.position - last_mouse_position
			translate(Vector3(-delta.x * pan_speed * 0.01, delta.y * pan_speed * 0.01, 0))
			last_mouse_position = event.position

		elif mouse_left_pressed:  # Kamera çevirme
			var delta = event.relative
			rotate_x(deg2rad(-delta.y * sensitivity))  # Yukarı/aşağı
			rotate_y(deg2rad(-delta.x * sensitivity))  # Sağa/sola
			rotation_degrees.x = clamp(rotation_degrees.x, -90, 90)  # Dikey açı sınırı

	# Fare tekerleği ile zoom
	if event is InputEventMouseButton and event.button_index == BUTTON_WHEEL_UP:
		zoom_camera(-zoom_speed)  # Yakınlaştır
	elif event is InputEventMouseButton and event.button_index == BUTTON_WHEEL_DOWN:
		zoom_camera(zoom_speed)  # Uzaklaştır

func zoom_camera(amount):
	# Kamerayı Z ekseni boyunca ileri/geri hareket ettir
	var new_translation = translation + transform.basis.z * amount
	if new_translation.length() >= min_distance and new_translation.length() <= max_distance:
		translation = new_translation
