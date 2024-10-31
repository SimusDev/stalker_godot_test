extends Control

@export var interface_container: sr_inventoryContainer
@export var interface_stats: sr_characterStatsInterface

func set_loot_inventory(inventory: SR_ComponentInventory) -> void:
	interface_container.set_inventory(inventory)
	interface_stats.set_stats_from_node(inventory.node)
