extends SD_Object
class_name SD_KeyBindings

signal on_keybind_added(keybind_name: String)
signal on_keybind_changed(keybind_name: String)
signal on_keybind_removed(keybind_name: String)

signal on_keybind_object_added(keybind_object: SD_Keybind)
signal on_keybind_object_changed(keybind_object: SD_Keybind)
signal on_keybind_object_removed(keybind_object: SD_Keybind)

var _keybind_list := {}

func console() -> SD_TrunkConsole:
	return SimusDev.console

func settings() -> SD_Settings:
	return console().settings

func add_keybind(keybind_name: String, key_string: String, do_signal := true) -> void:
	if keybind_name.is_empty():
		return
	
	if has_keybind(keybind_name):
		return
	
	var keybind_object := SD_Keybind.new()
	keybind_object.name = keybind_name
	keybind_object.key_string = key_string
	if do_signal: emit_signal("on_keybind_added", keybind_name)
	add_keybind_object(keybind_object, do_signal)

func add_keybind_object(keybind_object: SD_Keybind, do_signal := true) -> void:
	if has_keybind_object(keybind_object):
		return
	_keybind_list[keybind_object.name] = keybind_object
	keybind_object.initialize()
	if do_signal: emit_signal("on_keybind_object_added", keybind_object)

func remove_keybind(keybind_name: String, do_signal := true) -> void:
	if has_keybind(keybind_name):
		var keybind_object: SD_Keybind = get_keybind_as_object(keybind_name)
		if do_signal: emit_signal("on_keybind_removed", keybind_name)
		remove_keybind_object(keybind_object)

func remove_keybind_object(keybind_object: SD_Keybind, do_signal := true) -> void:
	if has_keybind_object(keybind_object):
		keybind_object.destroy()
		_keybind_list.erase(keybind_object.name)
		if do_signal: emit_signal("on_keybind_object_removed", keybind_object)

func change_keybind(keybind_name: String, key_string: String, do_signal := true) -> void:
	add_keybind(keybind_name, key_string, do_signal)
	if has_keybind(keybind_name):
		var keybind_object: SD_Keybind = get_keybind_as_object(keybind_name)
		change_keybind_object(keybind_object, key_string, do_signal)
		if do_signal: emit_signal("on_keybind_changed", keybind_name)

func change_keybind_object(keybind_object: SD_Keybind, key_string: String, do_signal := true) -> void:
	if has_keybind_object(keybind_object):
		var new_keybind_object := SD_Keybind.new()
		new_keybind_object.name = keybind_object.name
		new_keybind_object.key_string = key_string
		_keybind_list[new_keybind_object.name] = new_keybind_object
		keybind_object.destroy()
		new_keybind_object.initialize() 
		if do_signal: emit_signal("on_keybind_object_changed", new_keybind_object)

func is_keybind_just_pressed(keybind_name: String) -> bool:
	return get_keybind_as_object(keybind_name).is_just_pressed()

func is_keybind_just_released(keybind_name: String) -> bool:
	return get_keybind_as_object(keybind_name).is_just_released()

func is_keybind_pressed(keybind_name: String) -> bool:
	return get_keybind_as_object(keybind_name).is_pressed()


func has_keybind(keybind_name: String) -> bool:
	return _keybind_list.has(keybind_name)

func has_keybind_object(keybind_object: SD_Keybind) -> bool:
	return _keybind_list.values().has(keybind_object)

func get_keybind_as_object(keybind_name: String) -> SD_Keybind:
	if has_keybind(keybind_name):
		return _keybind_list[keybind_name] as SD_Keybind
	return null

func get_keybind_full_name(keybind_name: String) -> String:
	return SD_Input.P_KEYBIND + keybind_name
