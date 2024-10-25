extends SR_GameScript

var instance = null

func _on_callback(cb: Variant, value: Variant) -> void:
	if cb == "player_ready":
		var ui: PackedScene = load("res://gamedata/sr_hud/interactables/sr_interactables_hud.tscn")
		instance = ui.instantiate()
		instance.visible = true
		hud().set_node_static_status(instance)
		hud().add_node(instance)
