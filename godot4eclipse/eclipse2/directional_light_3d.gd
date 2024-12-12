extends DirectionalLight3D

@export var earth_node_path: NodePath  # Dünya'nın yolunu belirtmek için

func _process(delta):
	look_at(get_node("/root/Node/Node3D/EarthOrbit/Earth").global_position)
