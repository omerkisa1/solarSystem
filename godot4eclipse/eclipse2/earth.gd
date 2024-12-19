extends MeshInstance3D

func _process(delta):
	rotate_y(Global.earth_rotation_speed * delta)  # Hızı global değişkenden al
