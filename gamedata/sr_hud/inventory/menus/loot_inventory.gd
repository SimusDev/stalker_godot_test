extends Control

@export var player_container: sr_inventoryContainer
@export var player_stats: sr_characterStatsInterface

@export var loot_container: sr_inventoryContainer
@export var loot_stats: sr_characterStatsInterface

func set_loot_inventory(inventory: SR_ComponentInventory) -> void:
	loot_container.set_inventory(inventory)
	loot_stats.set_stats_from_node(inventory.node)


func _on_take_all_pressed() -> void:
	loot_container.get_inventory().transfer_items(player_container.get_inventory())

func _on_player_inv_item_interface_clicked(interface: sr_inventoryItemInterface) -> void:
	interface.get_inventory().transfer_item(interface.get_item(), loot_container.get_inventory())

func _on_loot_inv_item_interface_clicked(interface: sr_inventoryItemInterface) -> void:
	interface.get_inventory().transfer_item(interface.get_item(), player_container.get_inventory())
