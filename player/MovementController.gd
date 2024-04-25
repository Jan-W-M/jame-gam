extends Node

@export var player : CharacterBody3D
@export var mesh_root : Node3D
@export var rotation_speed : float = 8

@export var fall_gravity : float = 45

var jump_gravity : float = fall_gravity
var direction : Vector3
var velocity : Vector3
var acceleration = 5
var speed = 16
var cam_rotation : float = 0

var dash_speed = 50
var dash = 1
@onready var dash_timer = $DashTimer
var dash_cd = 1
var dash_on_cd = false

var jump_height = 3
var apex_duration = 0.5


func _physics_process(delta):
	velocity.x = speed * direction.normalized().x * player.moving * dash
	velocity.z = speed * direction.normalized().z * player.moving * dash
	
	if not player.is_on_floor():
		if velocity.y >= 0:
			velocity.y -= jump_gravity * delta
		else:
			velocity.y -= fall_gravity * delta
	
	player.velocity = player.velocity.lerp(velocity, acceleration * delta)
	player.move_and_slide()
	
	dash = 1
	
	var target_rotation = atan2(direction.x, direction.z)
	mesh_root.rotation.y = lerp_angle(mesh_root.rotation.y, target_rotation, rotation_speed * delta)

func _on_set_movement_direction(_movement_direction):
	direction= _movement_direction.rotated(Vector3.UP, cam_rotation)

func _on_set_cam_rotation(_cam_rotation : float):
	cam_rotation = _cam_rotation

func _on_pressed_jump():
	velocity *= 1.2
	velocity.y = 2 * jump_height / apex_duration
	jump_gravity = velocity.y / apex_duration

func _on_pressed_dash():
	if not dash_on_cd:
		#velocity.y += 0.5
		dash = dash_speed
		dash_on_cd = true
		dash_timer.start()
	print("dash")


func _on_dash_timer_timeout():
	dash_on_cd = false
