extends ImmediateGeometry

var radius = 10.0  # Yörünge yarıçapı (örneğin, Dünya için 10 birim)
var segments = 64  # Dairenin ne kadar pürüzsüz olacağı (daha fazla segment = daha pürüzsüz çizgi)

func _ready():
	draw_orbit()

func draw_orbit():
	clear()  # Önceki çizimi temizle
	begin(Mesh.PRIMITIVE_LINE_LOOP)  # Kapalı bir daire çizin

	for i in range(segments):
		var angle = i * 2.0 * PI / segments  # Daire için açıyı hesapla
		var x = radius * cos(angle)  # X ekseni için nokta
		var z = radius * sin(angle)  # Z ekseni için nokta
		add_vertex(Vector3(x, 0, z))  # Çizgi için bir nokta ekle
	end()
