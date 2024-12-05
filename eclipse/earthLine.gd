extends ImmediateGeometry

var trail_points = []
var max_points = 200  # Maksimum nokta sayısı

func _process(delta):
	# İz bırakması için pozisyonu ekle
	var current_position = global_transform.origin
	trail_points.append(current_position)

	# Maksimum noktayı aşarsa eski noktaları sil
	if trail_points.size() > max_points:
		trail_points.pop_front()

	# Çizgiyi güncelle
	clear()
	begin(Mesh.PRIMITIVE_LINE_STRIP)
	for point in trail_points:
		add_vertex(point)
	end()
