extends Button

func _on_pressed() -> void:
	print("Buton 2 tıklandı")
	Global.increase_speeds(2.0)  # Hızları 2 kat artır
