extends DirectionalLight3D

@export var earth_node_path: NodePath  # Dünya'nın yolunu belirtmek için

func _process(_delta):
	look_at(get_node("/root/Node/Node3Devre/EarthOrbit/Earth").global_position)
