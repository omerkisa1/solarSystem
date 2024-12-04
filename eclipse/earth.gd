extends MeshInstance


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var rotation_speed = 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotate_y(rotation_speed  * delta) #set
