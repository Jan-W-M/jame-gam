extends RigidBody3D

var mouse_sensitivity := 0.001
var twist_input := 0.0
var pitch_input := 0.0

var speed = 2000
var jump_speed = 25
var dash_speed = 40
var dash_cooldown = 0
var jump_cooldown = 0 #i should add a new mesh to check if on floor, this is stupid
var is_on_floor = false
var is_falling = false
var cur_height
@onready var twist_pivot := $TwistPivot
@onready var pitch_pivot := $TwistPivot/PitchPivot

func _ready() -> void:
	gravity_scale = 2



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:


	var input := Vector3.ZERO
	
	input.x = Input.get_axis("left", "right")
	input.z = Input.get_axis("forward", "back")
	#if not is_on_floor:
		#input.y = - 1
	if Input.is_action_just_pressed("dash") and dash_cooldown == 0:
		input *= dash_speed
		dash_cooldown = 1
		$DashTimer.start()
	if Input.is_action_just_pressed("jump") and is_on_floor:
		input.y = jump_speed
		jump_cooldown = 1
		print("jump")
		#$JumpTimer.start()
	if not is_on_floor:
		input *= 1.2 
		
	#print(input)
	apply_central_force(twist_pivot.basis * input * speed * delta)
	cur_height = global_position.y
	
		
	twist_pivot.rotate_y(twist_input)
	pitch_pivot.rotate_x(pitch_input)
	pitch_pivot.rotation.x = clamp(pitch_pivot.rotation.x, 
		deg_to_rad(-35), 
		deg_to_rad(30)
	)
	twist_input = 0.0
	pitch_input = 0.0


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			twist_input = - event.relative.x * mouse_sensitivity
			pitch_input = - event.relative.y * mouse_sensitivity


func _on_dash_timer_timeout():
	dash_cooldown = 0


func _on_jump_timer_timeout():
	jump_cooldown = 0


func _on_is_on_floor_body_entered(_body):
	is_on_floor = true


func _on_is_on_floor_body_exited(_body):
	is_on_floor = false
