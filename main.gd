extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel") and Input.mouse_mode == 2:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	elif Input.is_action_just_pressed("ui_cancel") and Input.mouse_mode == 0:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

