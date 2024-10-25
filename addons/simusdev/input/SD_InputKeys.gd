extends SD_Object
class_name SD_InputKeys

var _just_pressed_keys := []

func create_key(key_string: String) -> SD_InputKey:
	return SD_InputKey.new(key_string)

func is_key_pressed(key_string: String) -> bool:
	var key := create_key(key_string)
	return key.is_pressed()

func is_key_just_pressed(key_string: String) -> bool:
	var key := create_key(key_string)
	if key.is_pressed():
		if not _just_pressed_keys.has(key_string):
			_just_pressed_keys.append(key_string)
			return true
	else:
		if _just_pressed_keys.has(key_string):
			_just_pressed_keys.erase(key_string)
	return false
