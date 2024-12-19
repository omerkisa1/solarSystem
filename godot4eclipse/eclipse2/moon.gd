extends MeshInstance3D

func _process(delta):
	rotate_y(Global.moon_rotation_speed * delta)  # Hızı global değişkenden al
