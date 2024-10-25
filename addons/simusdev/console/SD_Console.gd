extends SD_Object
class_name SD_Console

signal on_update()

signal on_write(message: SD_ConsoleMessage)

var _message_buffer: Array[SD_ConsoleMessage] = []

func update_console() -> void:
	on_update.emit()

func put_message_to_buffer(message: SD_ConsoleMessage) -> void:
	_message_buffer.append(message)

func erase_message_from_buffer(message: SD_ConsoleMessage) -> void:
	_message_buffer.erase(message)

func clear_message_buffer() -> void:
	_message_buffer.clear()

func get_messages_from_buffer() -> Array[SD_ConsoleMessage]:
	return _message_buffer as Array[SD_ConsoleMessage]

func write(text, category: int = SD_ConsoleCategories.CATEGORY.DEFAULT) -> SD_ConsoleMessage:
	var message: SD_ConsoleMessage = SD_ConsoleMessage.new()
	message.text = text
	message.category = category
	
	put_message_to_buffer(message)
	on_write.emit(message)
	update_console()
	
	return message

func write_error(text) -> SD_ConsoleMessage:
	return write(text, SD_ConsoleCategories.CATEGORY.ERROR)

func execute_command(command: SD_ConsoleCommand) -> void:
	pass

func execute(value) -> void:
	pass
