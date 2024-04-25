extends StaticBody3D 
@onready var player = $"../../player" as RigidBody3D

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_3d_body_entered(body):
	print(body)
	if body == player :
		var impulse = Vector3.ZERO
		impulse.y = 50
		player.apply_central_impulse(impulse)
	pass # Replace with function body.
