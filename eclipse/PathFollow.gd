extends PathFollow3D

var speed = 1.0  # Yörünge hızı

func _process(delta):
	offset += speed * delta  # Yörüngede hareket
