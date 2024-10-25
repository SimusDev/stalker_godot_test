extends SD_Object
class_name SD_Keybind

var name := ""
var key_string := ""

func initialize() -> void:
	if not is_ready_to_initialize_or_destroy():
		return
	InputMap.add_action(get_full_name())
	for ievent in SD_Input.create_input_events_array_from_string(key_string):
		InputMap.action_add_event(get_full_name(), ievent)

func destroy() -> void:
	if not is_ready_to_initialize_or_destroy():
		return
	InputMap.erase_action(get_full_name())
	

func is_just_pressed() -> bool:
	return Input.is_action_just_pressed(get_full_name())

func is_just_released() -> bool:
	return Input.is_action_just_released(get_full_name())

func is_pressed() -> bool:
	return Input.is_action_pressed(get_full_name())

func is_ready_to_initialize_or_destroy() -> bool:
	return !key_string.is_empty() or !InputMap.has_action(name)

func get_full_name() -> String:
	return SD_Input.P_KEYBIND + name
