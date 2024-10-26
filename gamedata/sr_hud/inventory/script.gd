extends SR_GameScript

var packed_inventory: PackedScene

var instance: sr_inventory

func _ready() -> void:
	callbacks().SR_Player_ready.connect(_player_ready)

func _player_ready(player: SR_Player) -> void:
	packed_inventory = load("res://gamedata/sr_hud/inventory/sr_inventory.tscn")
	instance = packed_inventory.instantiate()
	instance.visible = false
	hud().add_node(instance)
