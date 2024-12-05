extends DirectionalLight

func _ready():
	print_children_tree(self)  # Düğüm ağacını kontrol edin
	var earth = get_node("EarthOrbit/earth")
	if earth:
		print("Earth düğümü bulundu:", earth)
	else:
		print("Earth düğümü bulunamadı. Yol: EarthOrbit/earth")

func print_children_tree(node):  # Fonksiyon adını değiştirdik
	for child in node.get_children():
		print("Child:", child.name)
		print_children_tree(child)
