extends Camera

# Hareket ve zoom parametreleri
var speed = 10.0
var sensitivity = 0.1
var pan_speed = 0.5
var zoom_speed = 2.0
var min_distance = 2.0
var max_distance = 50.0

# Durum değişkenleri
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
		zoom_camera(-zoom_speed)
	elif event is InputEventMouseButton and event.button_index == BUTTON_WHEEL_DOWN:
		zoom_camera(zoom_speed)

func zoom_camera(amount):
	# Kamerayı Z ekseni boyunca ileri/geri hareket ettir
	var new_translation = translation + transform.basis.z * amount
	if new_translation.length() >= min_distance and new_translation.length() <= max_distance:
		translation = new_translation

func _process(delta):
	# Klavye ile serbest hareket (W, A, S, D)
	var input_vector = Vector3()
	if Input.is_action_pressed("ui_up"):  # W tuşu
		input_vector.z -= 1
	if Input.is_action_pressed("ui_down"):  # S tuşu
		input_vector.z += 1
	if Input.is_action_pressed("ui_left"):  # A tuşu
		input_vector.x -= 1
	if Input.is_action_pressed("ui_right"):  # D tuşu
		input_vector.x += 1
	input_vector = input_vector.normalized()
	translate(input_vector * speed * delta)
