extends Button

func _on_pressed():
	print("1x butonuna basıldı")  
	Global.sun_rotation_speed = 0.2
	Global.earth_rotation_speed = 1.0
	Global.earth_orbit_speed = 5.0
	Global.moon_rotation_speed = 0.5
	Global.moon_orbit_speed = 10.0
