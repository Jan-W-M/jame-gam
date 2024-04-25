extends CharacterBody3D

signal pressed_dash()
signal pressed_jump()
signal set_movement_direction()

var movement_direction : Vector3
var moving = 1



func _physics_process(_delta):
	if global_position.y < -10 :
		global_position = Vector3.ONE
	if is_movement_ongoing():
		set_movement_direction.emit(movement_direction)
	if Input.is_action_pressed("movement"):
		movement_direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
		movement_direction.z = Input.get_action_strength("back") - Input.get_action_strength("forward")
		moving = 1
	else:
		moving = 0
	if Input.is_action_just_pressed("jump") and is_on_floor():
		pressed_jump.emit()
	if Input.is_action_just_pressed("dash"):
		pressed_dash.emit()

func is_movement_ongoing():
	return abs(movement_direction.x) > 0 or abs(movement_direction.z) > 0
	
func _input(event):
	if event.is_action_pressed("debug") :
		global_position = Vector3.ONE
	
