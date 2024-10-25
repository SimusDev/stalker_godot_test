extends SR_GameScript

func _on_callback(cb: Variant, value: Variant) -> void:
	return
	
	if cb is String:
		match cb:
			"SR_InventoryItem.consumed":
				var item: SR_InventoryItem = value as SR_InventoryItem
				var health = SR_ComponentHealth.find(item.get_inventory().node)
				if health:
					health.kill()
