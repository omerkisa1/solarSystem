extends Button

var is_paused = false 
var saved_speeds = {}  

func _on_pressed() -> void:
	if is_paused:
		Global.sun_rotation_speed = saved_speeds["sun_rotation_speed"]
		Global.earth_rotation_speed = saved_speeds["earth_rotation_speed"]
		Global.earth_orbit_speed = saved_speeds["earth_orbit_speed"]
		Global.moon_rotation_speed = saved_speeds["moon_rotation_speed"]
		Global.moon_orbit_speed = saved_speeds["moon_orbit_speed"]
		is_paused = false
	else:
		saved_speeds = {
			"sun_rotation_speed": Global.sun_rotation_speed,
			"earth_rotation_speed": Global.earth_rotation_speed,
			"earth_orbit_speed": Global.earth_orbit_speed,
			"moon_rotation_speed": Global.moon_rotation_speed,
			"moon_orbit_speed": Global.moon_orbit_speed
		}
		Global.sun_rotation_speed = 0.0
		Global.earth_rotation_speed = 0.0
		Global.earth_orbit_speed = 0.0
		Global.moon_rotation_speed = 0.0
		Global.moon_orbit_speed = 0.0
		is_paused = true
