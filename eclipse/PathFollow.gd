extends PathFollow

var speed = 1.0  # Yörünge hızı

func _process(delta):
	offset += speed * delta  # Yörüngede hareket
