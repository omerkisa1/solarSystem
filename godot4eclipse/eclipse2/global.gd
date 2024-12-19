extends Node

# Gezegen hareket hızları
var sun_rotation_speed: float = 0.2
var earth_rotation_speed: float = 1.0
var earth_orbit_speed: float = 5.0
var moon_rotation_speed: float = 0.5
var moon_orbit_speed: float = 10.0

# Hızları artıran fonksiyon
func increase_speeds(factor: float):
	sun_rotation_speed *= factor
	earth_rotation_speed *= factor
	earth_orbit_speed *= factor
	moon_rotation_speed *= factor
	moon_orbit_speed *= factor

# Hızları azaltan fonksiyon
func decrease_speeds(factor: float):
	sun_rotation_speed /= factor
	earth_rotation_speed /= factor
	earth_orbit_speed /= factor
	moon_rotation_speed /= factor
	moon_orbit_speed /= factor
