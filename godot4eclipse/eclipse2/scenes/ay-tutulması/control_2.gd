extends Control

# Sahne dosyasını yükle
var target_scene: PackedScene = load("res://node.tscn")

func _ready():
	# Butonun tıklama sinyalini bağla
	$/scenes/root/Node/Control2/Button.connect("pressed", Callable(self, "_on_button_pressed"))

# Buton tıklama sinyali işlendiğinde çağrılır
func _on_button_pressed():
	print("Sahneye geçiş yapılıyor: node.tscn")
	get_tree().change_scene_to_packed(target_scene)
