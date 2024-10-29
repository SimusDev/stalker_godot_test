extends CanvasLayer

@export var label: Label
@export var animation: AnimationPlayer

var _interactor: sr_interactor

func _ready() -> void:
	label.hide()
	
	var player: SR_Player = SR_Player.instance()
	_interactor = player.camera_root.interactor
	_interactor.area_selected.connect(_on_player_area_selected)
	


func _on_player_area_selected(area: sr_interactableArea) -> void:
	animation.stop()
	animation.play("animation")
	
	label.text = Stalker.localization.get_text_from_key(area.hint)
	
