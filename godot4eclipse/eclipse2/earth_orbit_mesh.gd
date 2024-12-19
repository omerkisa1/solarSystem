extends MeshInstance3D

# Dünya'nın referansını saklayacağız
@export var earth_node: Node3D

# İz noktalarını saklamak için bir liste
var trail_points = []
var max_trail_points = 50  # Maksimum iz noktası (iz uzunluğu)

func _ready():
	# Eğer `earth_node` atanmadıysa otomatik olarak Dünya düğümünü bul
	if not earth_node:
		earth_node = get_node("Earth")  # Yeni hiyerarşiye göre Earth düğümünü bul

	# RibbonTrailMesh oluştur
	var ribbon_mesh = MeshInstance3D.new()
	ribbon_mesh.mesh = ArrayMesh.new()
	self.mesh = ribbon_mesh.mesh  # RibbonTrailMesh'i MeshInstance3D'ye ata

func _process(delta: float):
	# Eğer Dünya'nın referansı yoksa işleme devam etme
	if not earth_node:
		return

	# Dünya'nın pozisyonunu alın
	var earth_transform = earth_node.global_transform

	# İz noktalarını güncelle
	trail_points.append(earth_transform.origin)
	
	# Noktalar maksimum uzunluğu aşarsa eski noktaları kaldır
	while trail_points.size() > max_trail_points:
		trail_points.pop_front()

	# İz için mesh güncelle
	_update_trail_mesh()

func _update_trail_mesh():
	# Yeni bir ArrayMesh oluştur
	var st = SurfaceTool.new()
	st.begin(Mesh.PRIMITIVE_LINE_STRIP)

	# İz noktalarını mesh'e ekle
	for point in trail_points:
		st.add_vertex(point)

	# Mesh'i tamamla ve ata
	var mesh = st.commit()
	self.mesh = mesh
