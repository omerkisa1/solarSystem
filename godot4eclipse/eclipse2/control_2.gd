extends Control

# Sahne dosyasını manuel olarak yükle
var node_scene: PackedScene = load("res://node.tscn")

func _ready():
	# Butonu bağla
	$Button.connect("pressed", Callable(self, "_on_button_pressed"))

# Buton tıklama sinyali işlendiğinde çağrılır
func _on_button_pressed():
	print("Ana sahneye  dönülüyor.")
	get_tree().change_scene_to_packed(node_scene)
