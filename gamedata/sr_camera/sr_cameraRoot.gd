extends Node3D
class_name sr_cameraRoot

@export var enabled := true

@export var node: Node3D
@export var character: SR_CharacterBodyComponent
@export var inventory: SR_ComponentInventory
@export var camera: Camera3D
@export var interactor: sr_interactor

@export var inventory_arms: sr_inventoryArms

@export_group("Player Controller")
@export var controlling_by_player: bool = false
@export var sensitivity: float = 0.5
@export var key_forward: String = "keybind_forward"
@export var key_backward: String = "keybind_backward"
@export var key_left: String = "keybind_left"
@export var key_right: String = "keybind_right"
@export var key_jump: String = "keybind_jump"
@export var key_crouch: String = "keybind_crouch"
@export var key_sprint: String = "keybind_sprint"

func _ready() -> void:
	interactor.interactor = node
	
	if controlling_by_player:
		camera.make_current()
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		Stalker.callbacks.SR_HUD_update.connect(_on_hud_update)

func _on_hud_update(hud: SR_HUD) -> void:
	_on_player_hud_updated(hud)

func _on_player_hud_updated(hud: SR_HUD) -> void:
	enabled = hud.get_visible_nodes().is_empty()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if !enabled:
		Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

func _input(event: InputEvent) -> void:
	if !enabled:
		return
	
	if !controlling_by_player:
		return
	
	if event is InputEventMouseMotion:
		node.rotate_y(deg_to_rad(-event.relative.x * sensitivity))
		self.rotate_x(deg_to_rad(-event.relative.y * sensitivity))
		self.rotation.x = clamp(self.rotation.x, deg_to_rad(-90), deg_to_rad(90))

func _physics_process(delta: float) -> void:
	
	if !controlling_by_player:
		return
	
	character.is_sprinting = Input.is_action_pressed(key_sprint)
	character.is_crouching = Input.is_action_pressed(key_crouch)
	
	var input_dir: Vector2 = Input.get_vector(key_left, key_right, key_forward, key_backward)
	var move_direction: Vector3 = Vector3(input_dir.x, 0, input_dir.y)
	character.set_move_direction(move_direction)
	
	if Input.is_action_pressed(key_jump):
		character.jump()
	
