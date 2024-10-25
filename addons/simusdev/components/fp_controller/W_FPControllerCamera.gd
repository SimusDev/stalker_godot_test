extends W_FPController
class_name W_FPControllerCamera

@export var camera: Camera3D
@export var camera_angle_min: float = -90
@export var camera_angle_max: float = 90
@export var sensitivity: float = 1.0

@export var camera_rotation: Vector2 = Vector2.ZERO : set = set_camera_rotation, get = get_camera_rotation

@export var custom_cursor: bool = false

func _init() -> void:
	enabled_status_changed.connect(_on_enabled_status_changed)

func _ready() -> void:
	var body: CharacterBody3D = character_component.body
	set_camera_rotation(Vector2(0, body.rotation_degrees.y))
	update_mouse()

func update_mouse() -> void:
	if enabled:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	else:
		if custom_cursor:
			Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _input(event: InputEvent) -> void:
	if not enabled:
		return
	
	if event is InputEventMouseMotion:
		var current_rotation: Vector2 = get_camera_rotation()
		event.relative = event.relative * W_FPController.get_normalized_mouse_sensitivity(sensitivity)
		
		camera_rotation.y -= (event.relative.x)
		camera_rotation.x -= (event.relative.y)
		

func set_camera_rotation(_rotation: Vector2) -> void:
	_rotation.x = clamp(_rotation.x, camera_angle_min, camera_angle_max)
	camera_rotation = _rotation
	rotation_degrees.x = _rotation.x

	var character: Node3D = character_component.body
	character.rotation_degrees.y = _rotation.y

func get_camera_rotation() -> Vector2:
	return camera_rotation

func _on_enabled_status_changed(status: bool) -> void:
	update_mouse()
