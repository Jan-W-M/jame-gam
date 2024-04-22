extends RigidBody3D

class_name Item

var dropped = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if dropped == true:
		var move = Vector3.ONE
		move.y = 10
		translate(move)
		dropped = false
