extends Node3D

func _process(_delta):
	# Dünya'nın pozisyonunu al ve kendini onun pozisyonuna sabitle
	var earth_position = $"/root/Node/Node3Daytutulmasi/EarthOrbit/Earth".global_transform.origin
	global_transform.origin = earth_position

	# Ay'ın pozisyonunu al ve ona odaklan
	var moon_position = $"/root/Node/Node3Daytutulmasi/EarthOrbit/Earth/MoonOrbitay/Moon".global_transform.origin
	look_at(moon_position, Vector3.UP)
