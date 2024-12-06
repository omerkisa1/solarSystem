extends ImmediateGeometry

var trail_points = []  # Çizgi için pozisyonlar
var max_trail_length = 50  # Çizginin maksimum uzunluğu

func _process(delta):
	# Dünya'nın (earth) pozisyonunu alın
	var earth_position = get_node("../EarthOrbit/earth").global_transform.origin

	# Pozisyonu kaydedin
	trail_points.append(earth_position)
	if trail_points.size() > max_trail_length:
		trail_points.pop_front()  # Eski noktaları kaldırın

	# Çizgiyi güncelleyin
	draw_trail()

func draw_trail():
	clear()
	
	var scale_factor = 10.0
	begin(Mesh.PRIMITIVE_LINE_STRIP)
	for point in trail_points:
		add_vertex(point * scale_factor)  # Her bir pozisyonu çiz
	end()
