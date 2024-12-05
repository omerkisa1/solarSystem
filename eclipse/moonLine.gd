extends ImmediateGeometry

var trail_points = []
var max_points = 200  # Maksimum nokta sayısı

func _process(delta):
	# Mevcut pozisyonu trail_points'e ekle
	trail_points.append(global_transform.origin)
	
	# Maksimum noktayı aşarsa en eski noktayı sil
	if trail_points.size() > max_points:
		trail_points.pop_front()

	# Çizgiyi çizin
	clear()
	begin(Mesh.PRIMITIVE_LINE_STRIP)
	for point in trail_points:
		add_vertex(point)
	end()
