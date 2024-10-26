extends W_Interactable3D
class_name sr_interactableArea

@export var hint: String

signal area_selected(interactor: sr_interactor)
signal area_interacted(interactor: sr_interactor)

func _on_interacted(interactor: W_Interactor3D) -> void:
	if interactor is sr_interactor:
		area_interacted.emit(interactor)
		Stalker.callbacks.sr_interactableArea_interacted.emit(self, interactor)

func _on_selected(interactor: W_Interactor3D) -> void:
	if interactor is sr_interactor:
		area_selected.emit(interactor)
		Stalker.callbacks.sr_interactableArea_selected.emit(self, interactor)
