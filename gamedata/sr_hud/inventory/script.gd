extends SR_GameScript

var packed_inventory: PackedScene

var instance: sr_inventory

func _on_callback(cb: Variant, value: Variant) -> void:
	if cb == "player_ready":
		packed_inventory = load("res://gamedata/sr_hud/inventory/sr_inventory.tscn")
		instance = packed_inventory.instantiate()
		instance.visible = false
		hud().add_node(instance)
