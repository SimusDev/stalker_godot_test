extends SR_GameScript

var _player: SR_Player

func _input(event: InputEvent) -> void:
	if hud():
		if hud().get_visible_nodes().is_empty():
			if Stalker.keybinds.is_keybind_just_pressed("interact"):
				try_to_interact()

func try_to_interact() -> void:
	var player: SR_Player = SR_Player.instance()
	if not player:
		return
	
	player.interactor.try_to_interact()
