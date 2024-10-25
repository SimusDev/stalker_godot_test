extends SD_Object
class_name SD_InputKey

var key_string: String

func _init(key: String) -> void:
	key_string = key

func is_pressed() -> bool:
	var keycode: int = SD_Input.find_keycode_from_string(key_string)
	return Input.is_key_pressed(keycode)
