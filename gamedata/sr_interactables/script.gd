extends SR_GameScript

var _player: SR_Player

const LOOT_MENU_PATH: String = "res://gamedata/sr_hud/inventory/menus/loot_inventory.tscn"

func _ready() -> void:
	Stalker.callbacks.SR_Player_ready.connect(_player_ready)

func _player_ready(player: SR_Player) -> void:
	_player = player
	_player.input.connect(_player_input)
	_player.camera_root.interactor.area_interacted.connect(_player_area_interacted)

func _player_input(event: InputEvent) -> void:
	if Stalker.keybinds.is_keybind_just_pressed("interact"):
		try_to_interact()

func _player_area_interacted(area: sr_interactableArea) -> void:
	if area is sr_interactableContainer:
		sr_inventory.instance().open()
		var loot_menu: Control = sr_inventory.instance().create_menu(load(LOOT_MENU_PATH))
		loot_menu.set_loot_inventory(area.inventory)

func try_to_interact() -> void:
	if not _player:
		return
	
	_player.camera_root.interactor.try_to_interact()
