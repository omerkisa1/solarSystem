extends MeshInstance3D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

var rotation_speed = 0.2
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotate_y(rotation_speed * delta)
