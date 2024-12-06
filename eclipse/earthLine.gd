extends Line2D

var radius = 200.0  # Yörünge yarıçapı (2D için büyük bir değer kullanın)
var segments = 64  # Dairenin pürüzsüzlüğü

func _ready():
	draw_orbit()

func draw_orbit():
	clear_points()  # Önceki noktaları temizle
	for i in range(segments):
		var angle = i * 2.0 * PI / segments
		var x = radius * cos(angle)
		var y = radius * sin(angle)
		add_point(Vector2(x, y))  # Her noktayı 2D uzayda ekle
