extends Node3D 

signal province_selected

@onready var camera_socket = $CameraSocket
@onready var camera = $CameraSocket/Camera3D

@export var pan_speed := 0.5
@export var zoom_speed := 2.0
@export var min_zoom := 0.1
@export var max_zoom := 50.0

# Map boundaries (centered at 0,0)
const MAP_WIDTH := 563.2
const MAP_HEIGHT := 211.2

const BORDER_MARGIN_X := MAP_WIDTH * 0.2
const BORDER_MARGIN_Z := MAP_HEIGHT * 0.2

const MAP_MIN_X := BORDER_MARGIN_X
const MAP_MAX_X := MAP_WIDTH - BORDER_MARGIN_X
const MAP_MIN_Z := BORDER_MARGIN_Z
const MAP_MAX_Z := MAP_HEIGHT - BORDER_MARGIN_Z

var is_panning := false
var is_tilting := false
var last_mouse_pos := Vector2.ZERO
var zoom_height := 2.0

func _ready():
	zoom_height = camera_socket.position.y

func _unhandled_input(event: InputEvent) -> void:
	# Left click for province selection
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			shoot_ray()

		# Middle mouse for panning
		elif event.button_index == MOUSE_BUTTON_MIDDLE:
			is_panning = event.pressed
			last_mouse_pos = event.position

		# Right mouse for tilt
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			is_tilting = event.pressed
			last_mouse_pos = event.position

		# Scroll wheel for zoom
		elif event.button_index == MOUSE_BUTTON_WHEEL_UP:
			zoom_height -= zoom_speed
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			zoom_height += zoom_speed

		zoom_height = clamp(zoom_height, min_zoom, max_zoom)

	elif event is InputEventMouseMotion:
		var delta: Vector2 = event.position - last_mouse_pos
		last_mouse_pos = event.position

		if is_panning:
			var right: Vector3 = global_transform.basis.x
			var forward: Vector3 = -global_transform.basis.z
			var pan_vector: Vector3 = (-right * delta.x + forward * delta.y) * pan_speed
			var new_position = position + pan_vector
			new_position.x = clamp(new_position.x, MAP_MIN_X, MAP_MAX_X)
			new_position.z = clamp(new_position.z, MAP_MIN_Z, MAP_MAX_Z)
			position = new_position


func _process(delta: float) -> void:
	# Smooth zooming
	var current_pos = camera_socket.position
	current_pos.y = lerp(current_pos.y, zoom_height, 5 * delta)
	camera_socket.position = current_pos

func shoot_ray():
	var mouse_pos = get_viewport().get_mouse_position()
	var ray_length = 2000
	var from = camera.project_ray_origin(mouse_pos)
	var to = from + camera.project_ray_normal(mouse_pos) * ray_length
	var space = get_world_3d().direct_space_state
	var ray_query = PhysicsRayQueryParameters3D.new()
	ray_query.from = from
	ray_query.to = to
	var raycast_result = space.intersect_ray(ray_query)
	if !raycast_result.is_empty():
		province_selected.emit(Vector2(raycast_result.position.x, raycast_result.position.z))
