extends MeshInstance3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $"..".direction :
		var direction  =$"..".velocity
		direction.y = 0

		if direction.x != 0 or direction.z != 0:
			look_at(global_position + direction, Vector3.UP)

