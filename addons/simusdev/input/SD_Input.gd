extends SD_Object
class_name SD_Input

const P_KEYBIND := "keybind_"
const PKB_MOUSE := "mouse"

static func is_mouse_string(string: String) -> bool:
	return string.begins_with(PKB_MOUSE)
static func get_mouse_index_from_string(string_mouse: String) -> int:
	if is_mouse_string(string_mouse):
		var new_string_mouse: String = string_mouse.replace(PKB_MOUSE, "")
		return new_string_mouse.to_int()
	return 0
static func get_string_from_mouse_index(index_mouse: int) -> String:
	return PKB_MOUSE + str(index_mouse)

static func create_input_event_from_string(string: String) -> InputEvent:
	if is_mouse_string(string):
		var input_event_mouse := InputEventMouseButton.new()
		input_event_mouse.button_index = get_mouse_index_from_string(string)
		return input_event_mouse
	
	var input_event_key := InputEventKey.new()
	input_event_key.keycode = find_keycode_from_string(string)
	return input_event_key

static func create_input_events_array_from_string(string: String) -> Array[InputEvent]:
	var result: Array[InputEvent] = []
	var keys := []
	var available_split_symbols: PackedStringArray = [";"]
	for split_symbol in available_split_symbols:
		var splited_string := string.split(split_symbol, false)
		for key in splited_string:
			var ievent := create_input_event_from_string(key)
			if key != string:
				SD_Array.append_to_array_no_repeat(result, ievent)
				SD_Array.append_to_array_no_repeat(keys, key)
			if keys.is_empty():
				SD_Array.append_to_array_no_repeat(result, ievent)
				
	return result

static func create_string_from_input_event(event: InputEvent) -> String:
	if event is InputEventMouseButton:
		return get_string_from_mouse_index(event.button_index)
	elif event is InputEventKey:
		return get_string_from_keycode(event.keycode)
	else:
		return ""
	return ""

static func find_keycode_from_string(string: String) -> int:
	return OS.find_keycode_from_string(string.to_lower())
static func get_string_from_keycode(keycode: int) -> String:
	return OS.get_keycode_string(keycode).to_lower()

static func get_input_keys() -> SD_InputKeys:
	return SimusDev.input_keys

static func is_key_pressed(key_string: String) -> bool:
	return get_input_keys().is_key_pressed(key_string)

static func is_key_just_pressed(key_string: String) -> bool:
	return get_input_keys().is_key_just_pressed(key_string)
