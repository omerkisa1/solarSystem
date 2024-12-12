extends DirectionalLight3D

func _process(_delta):
	var earth = get_node("/root/Node/Node3D/EarthOrbit/Earth")  # Düğümü alın
	if earth:  # Eğer düğüm geçerliyse
		if global_transform.origin.distance_to(earth.global_transform.origin) > 0.1:
			look_at(earth.global_transform.origin, Vector3.UP)
		else:
			print("DirectionalLight3D Dünya ile aynı pozisyonda, look_at çağrısı atlandı.")
	else:
		print("Earth düğümü bulunamadı!")
