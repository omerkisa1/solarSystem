extends Line2D

func _ready():
	for i in range(360):
		var angle = deg_to_rad(i)
		var x = cos(angle) * 200  # Çemberin yarıçapı 200 birim
		var y = sin(angle) * 200
		add_point(Vector2(x, y))
