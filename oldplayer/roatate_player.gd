extends MeshInstance3D

@onready var player = $".."
@onready var twist_pivot := $"../TwistPivot"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player.input.x != 0 or player.input.z != 0:
		var look_to = - player.linear_velocity
		print(look_to)
		look_at(global_position + look_to, Vector3.UP)
