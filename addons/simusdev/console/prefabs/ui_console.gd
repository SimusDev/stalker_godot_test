extends Control

@onready var console: SD_TrunkConsole = SimusDev.console

@export var label: RichTextLabel
@export var line_edit: LineEdit

var settings := SD_Settings.new()

func _ready() -> void:
	console.on_update.connect(_on_update)
	
	console.update_console()
	


func _on_update() -> void:
	var buffer: Array[SD_ConsoleMessage] = console.get_messages_from_buffer()
	while buffer.size() > 0:
		
		var msg: SD_ConsoleMessage = buffer[0]
		label.text += msg.parse_and_get_as_string() + "\n"
		console.erase_message_from_buffer(msg)
	

func _process(delta: float) -> void:
	if SD_Input.is_key_just_pressed("enter"):
		console.execute(line_edit.text)
		line_edit.text = ""
