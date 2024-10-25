extends SD_Object
class_name SD_EventBus

signal on_event(event: Object)

func post(event: Object) -> void:
	on_event.emit(event)
