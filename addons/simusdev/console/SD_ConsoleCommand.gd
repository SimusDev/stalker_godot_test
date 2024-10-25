extends SD_Object
class_name SD_ConsoleCommand

var name: String 
var value: Variant

func _init(cmd_name: String, cmd_value: Variant) -> void:
	name = cmd_name
	value = cmd_value
