extends Node3D

var index:int = 0 # Index of structure being built

@export var selector:Node3D # The 'cursor'
@export var view_camera:Camera3D # Used for raycasting mouse
@export var gridmap:GridMap

var plane:Plane # Used for raycasting mouse

func _ready():
	
	plane = Plane(Vector3.UP, Vector3.ZERO)
	

func _process(delta):
	# Map position based on mouse
	
	var world_position = plane.intersects_ray(
		view_camera.project_ray_origin(get_viewport().get_mouse_position()),
		view_camera.project_ray_normal(get_viewport().get_mouse_position()))
	
	if world_position != null:
		var gridmap_position = Vector3(round(world_position.x), 1, round(world_position.z))
		selector.position = lerp(selector.position, gridmap_position, delta * 40)

