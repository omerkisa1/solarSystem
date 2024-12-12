extends MeshInstance3D

@export var rotation_speed: float = 0.5  # Ay'ın kendi ekseni etrafındaki dönüş hızı

func _process(delta):
	rotate_y(rotation_speed * delta)  # Y ekseni etrafında döner
