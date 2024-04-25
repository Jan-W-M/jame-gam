extends Node3D

signal set_cam_rotation(_cam_rotation :float)

@onready var jaw_node = $CamJaw
@onready var pitch_node = $CamJaw/CamPitch
@onready var camera = $CamJaw/CamPitch/SpringArm3D/Camera3D

var jaw : float = 0
var pitch : float = 0

var jaw_sensitivity : float = 0.07
var pitch_sensitivity : float =0.07

var jaw_acceleration : float = 15
var pitch_acceleration : float = 15

var pitch_max : float = 75
var pitch_min : float = -55



# Called when the node enters the scene tree for the first time.
func _input(event):
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			jaw += - event.relative.x * jaw_sensitivity
			pitch += -event.relative.y * pitch_sensitivity

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	pitch = clamp(pitch, pitch_min, pitch_max)
	
	jaw_node.rotation_degrees.y = lerp(jaw_node.rotation_degrees.y, jaw, jaw_acceleration * delta)
	pitch_node.rotation_degrees.x = lerp(pitch_node.rotation_degrees.y, pitch, pitch_acceleration * delta)
	
	set_cam_rotation.emit(jaw_node.rotation.y)
