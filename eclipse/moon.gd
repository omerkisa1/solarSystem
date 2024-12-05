extends MeshInstance

var rotation_speed = 0.2  # Ay'ın kendi ekseni etrafında dönüş hızı

func _process(delta):
	rotate_y(rotation_speed * delta)

	
