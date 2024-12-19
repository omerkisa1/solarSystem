extends Button

func _on_pressed() -> void:
	print("Buton 3 tıklandı")
	Global.increase_speeds(3.0)  # Hızları 3 kat artır
