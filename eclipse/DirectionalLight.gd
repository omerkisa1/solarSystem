extends DirectionalLight3D

func _process(delta):
	var earth = get_node("/root/Node3D/EarthOrbit/earth")  # Düğümü alın
	if earth:  # Eğer düğüm geçerliyse
		look_at(earth.global_transform.origin, Vector3.UP)
	else:
		print("Earth düğümü bulunamadı!")
