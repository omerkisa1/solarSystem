extends OmniLight3D

@onready var sun = null  # Güneşi referans alacağız

func _ready():
	# Güneş düğümünü bulun
	sun = get_node("/root/Node/Node3D/sun")
	if sun:
		print("Güneş düğümü bulundu: ", sun.name)
	else:
		print("Güneş düğümü bulunamadı!")

func _process(_delta):
	if sun:
		# OmniLight'ı güneşin konumuna hizala
		global_transform.origin = sun.global_transform.origin
	else:
		print("Güneş düğümü eksik, ışık konumu güncellenemiyor.")
