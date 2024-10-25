extends W_FPController
class_name W_FPControllerMovement

@export_group("Input Map Keys")
@export var key_forward: String = "ui_up"
@export var key_backward: String = "ui_down"
@export var key_left: String = "ui_left"
@export var key_right: String = "ui_right"
@export var key_jump: String = "ui_accept"


func _physics_process(delta: float) -> void:
	if not enabled:
		return
	
	var input_dir: Vector2 = Input.get_vector(key_left, key_right, key_forward, key_backward)
	var move_direction: Vector3 = Vector3(input_dir.x, 0, input_dir.y)
	character_component.set_move_direction(move_direction)
	
	if Input.is_action_pressed(key_jump):
		character_component.jump()
