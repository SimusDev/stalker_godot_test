extends W_Interactor3D
class_name sr_interactor

signal area_selected(area: sr_interactableArea)

func _on_interactable_selected(interactable: W_Interactable3D) -> void:
	if interactable is sr_interactableArea:
		area_selected.emit(interactable)
		
