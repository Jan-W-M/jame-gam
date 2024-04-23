extends CharacterBody3D

@export var teleportable = true

const JUMP_VELOCITY = 4.5
@export var max_jump_count = 2
@export var speed = 5.0
@export var blind = false

var jump_count = 0
var run_speed_mult = 1.5
var running = false
#Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var direction = Vector3()

func _physics_process(delta):
	movement(delta)

	if Input.is_action_just_pressed("reset"):
		reset()

func movement(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta

	if is_on_floor():
		jump_count = 0

	if Input.is_action_just_pressed("jump") and is_on_floor() and jump_count < max_jump_count:
		jump_count +=1
		velocity.y = JUMP_VELOCITY

	elif Input.is_action_just_pressed("jump") and running and jump_count < max_jump_count:
		jump_count +=1
		velocity.y = JUMP_VELOCITY

	var input_dir = Input.get_vector("left", "right", "up", "down")
	direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
		if Input.is_action_pressed("run"):
			velocity.x = run_speed_mult
			velocity.z= run_speed_mult
			running = true
		else :
			running = false
	else:
		velocity.x = 0
		velocity.z = 0

	move_and_slide()


func reset():
		var center =Vector3.ZERO
		center.y =1
		speed = 5
		max_jump_count = 2
		$Camera3D.far = 4000
		self.position =center
		$MeshInstance3D.hide()

func _on_leg_hurt_body_entered(_body):
	speed = 2.5
	max_jump_count = 1


func _on_blindness_body_entered(_body):
	$MeshInstance3D.show()
