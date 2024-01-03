extends Node3D

var camera_position:Vector3
var camera_rotation:Vector3
var camera_zoom:Vector3

var desiredFov = 90
var fovStep = 3 
var maxFov = 110 
var minFov = 30

@onready var camera = $Camera

func _ready():
	
	camera_rotation = rotation_degrees # Initial rotation
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Set position and rotation to targets
	
	position = position.lerp(camera_position, delta * 8)
	rotation_degrees = rotation_degrees.lerp(camera_rotation, delta * 6)
	
	camera.set_fov(desiredFov)
	
	handle_input(delta)

# Handle input

func handle_input(_delta):
	
	# Rotation
	
	var input := Vector3.ZERO
	
	input.x = Input.get_axis("camera_left", "camera_right")
	input.z = Input.get_axis("camera_foward", "camera_back")
	
	input = input.rotated(Vector3.UP, rotation.y).normalized()
	
	camera_position += input / 4
	
	# Back to center
	
	if Input.is_action_pressed("camera_center"):
		camera_position = Vector3()

func _input(event):
	
	# Rotate camera using mouse (hold 'middle' mouse button)
	
	if event is InputEventMouseMotion:
		if Input.is_action_pressed("camera_rotate"):
			camera_rotation += Vector3(-event.relative.y / 5, -event.relative.x / 5, 0)
	elif event is InputEventMouse:
		if Input.is_action_pressed("camera_zoom_out"): 
			desiredFov = desiredFov - fovStep 
		elif Input.is_action_pressed("camera_zoom_in"): 
			desiredFov = desiredFov + fovStep
			
		#Not needed, but it forces the FOV to be between the min and max
		desiredFov = clamp(desiredFov, minFov, maxFov)

