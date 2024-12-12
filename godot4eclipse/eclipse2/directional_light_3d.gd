extends DirectionalLight3D

@export var sun_node_path: NodePath

func _ready():
	if sun_node_path:
		# Güneş düğümünü bul
		var sun = get_node("root/Node/Node3D/sun")
		if sun:
			global_position = sun.global_position
			# Işık sürekli olarak güneş ile aynı yerde kalacak
			look_at(Vector3(0, 0, 0)) # Opsiyonel: Işığın hangi yöne bakacağı
