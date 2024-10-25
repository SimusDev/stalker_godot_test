extends Node2D
class_name SD_NodeCursor

var cursor_disabled := false

func _ready() -> void:
	if not is_cursor_supported_by_platform():
		hide()
		set_process(false)
		return
	
	#settings.connect("on_setting_changed", Callable(self, "_on_setting_changed"))
	
	update_cursor_status()
	update_cursor()

func _process(delta: float) -> void:
	update_cursor()

func update_cursor() -> void:
	global_position = get_global_mouse_position()
	
	show()
	match Input.mouse_mode:
		Input.MOUSE_MODE_CAPTURED:
			hide()
	
	if cursor_disabled:
		hide()

func update_cursor_status() -> void:
	cursor_disabled = false
	
	match cursor_disabled:
		true:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		false:
			Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	
	update_cursor()

func set_cursor_centered() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	update_cursor()
	update_cursor_status()

func is_cursor_supported_by_platform() -> bool:
	return SD_Platforms.is_pc()

func _on_setting_changed(setting_name: String, value) -> void:
	match setting_name:
		"cursor_disabled":
			update_cursor_status()
