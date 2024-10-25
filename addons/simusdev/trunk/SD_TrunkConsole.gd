extends SD_Console
class_name SD_TrunkConsole

var _console_prefab: PackedScene = preload("res://addons/simusdev/console/prefabs/ui_console.tscn")

var _console_node: Control = null

func _ready() -> void:
	#write("SimusDev Console Initialized!")
	_console_node = _console_prefab.instantiate()
	_console_node.visible = false
	SimusDev.canvas.get_last_layer().add_child(_console_node)

func _process(delta: float) -> void:
	if SD_Input.is_key_just_pressed("quoteleft"):
		_console_node.visible = !_console_node.visible
