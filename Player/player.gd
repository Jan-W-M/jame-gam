extends CharacterBody3D

@export var teleportable = true

const JUMP_VELOCITY = 4.5
@export var jump_count = 2
@export var speed = 5.0
var run_speed_mult = 1.5
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var direction = Vector3()

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	if is_on_floor():
		jump_count = 0
	
	if Input.is_action_just_pressed("ui_accept") and jump_count <2:
		jump_count +=1
		velocity.y = JUMP_VELOCITY
	


	var input_dir = Input.get_vector("left", "right", "up", "down")
	direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
		if Input.is_action_pressed("run"):
			velocity.x *= run_speed_mult
			velocity.z *= run_speed_mult
	else:
		velocity.x = 0
		velocity.z = 0

	move_and_slide()
	if Input.is_action_just_pressed("reset"):
		var center =Vector3.ZERO
		center.y =1
		self.position =center

