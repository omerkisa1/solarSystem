extends Node3D

func _process(_delta):
	# Dünya'nın pozisyonunu al ve kendini onun pozisyonuna sabitle
	var earth_position = $"/root/Node/Node3Devre/EarthOrbit/Earth".global_transform.origin
	global_transform.origin = earth_position
	global_transform.origin.x -= -1.0  # kırmızı 
	# Ay'ın pozisyonunu al ve ona odaklan
	var moon_position = $"/root/Node/Node3Devre/EarthOrbit/Earth/MoonOrbitevre/Moon".global_transform.origin
	look_at(moon_position, Vector3.UP)
