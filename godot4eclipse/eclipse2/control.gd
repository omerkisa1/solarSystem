extends Control

# Sahne dosyalarını manuel olarak yükle
var ay_tutulmasi_scene: PackedScene = load("res://scenes/ay-tutulması/ay_tutulmasi.tscn")
#var gunes_tutulmasi_scene: PackedScene = load("res://gunes_tutulmasi.tscn")
#var ayin_evleri_scene: PackedScene = load("res://ayin_evleri.tscn")

func _ready():
	# Butonları bağla
	$VBoxContainer/AyTutulmasiButton.connect("pressed", Callable(self, "_on_ay_tutulmasi_pressed"))
	$VBoxContainer/GunesTutulmasiButton.connect("pressed", Callable(self, "_on_gunes_tutulmasi_pressed"))
	$VBoxContainer/AyinEvleriButton.connect("pressed", Callable(self, "_on_ayin_evleri_pressed"))

# Fonksiyonlar
func _on_ay_tutulmasi_pressed():
	print("Ay Tutulması sahnesine gidiliyor.")
	get_tree().change_scene_to_packed(ay_tutulmasi_scene)

func _on_gunes_tutulmasi_pressed():
	print("Güneş Tutulması sahnesine gidiliyor.")
	#get_tree().change_scene_to_packed(gunes_tutulmasi_scene)

func _on_ayin_evleri_pressed():
	print("Ayın Evreleri sahnesine gidiliyor.")
	#get_tree().change_scene_to_packed(ayin_evleri_scene)
