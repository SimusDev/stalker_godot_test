extends CharacterBody3D
class_name SR_WorldItem

@export var section: SR_ComponentNodeSection
@export var sprite: Sprite3D

@export var storage := {}
@export var saveables: Array[Resource] = []

@export var resource: SR_ResourceWorldItem
@export var unique_data: Resource

@export var quantity: int = 1

@export var backpack_prefab: PackedScene

func _ready() -> void:
	var section_resource: SR_ResourceWorldItem = section.get_resource()
	if section_resource:
		resource = section_resource
		sprite.texture = resource.texture_on_floor
		if sprite.texture == null:
			sprite.texture = resource.icon
		sprite.pixel_size = resource.texture_pixel_size
	

func try_pack_into_backpack() -> Node3D:
	if quantity < 10:
		return null
	
	return pack_into_backpack()

func pack_into_backpack() -> Node3D:
	var backpack: Node3D = backpack_prefab.instantiate()
	get_parent().add_child(backpack)
	
	var inv_item := SR_InventoryItem.create_from_world_item(self)
	var inv: SR_ComponentInventory = backpack.inventory
	inv.add_item(inv_item)
	
	return backpack

func get_resource() -> SR_ResourceWorldItem:
	if section:
		return section.get_resource()
	return resource

static func create_from_inventory_item(item: SR_InventoryItem) -> SR_WorldItem:
	var world_item: SR_WorldItem = SR_Level.find_level(item.get_inventory()).spawn_by_resource(item.resource)
	world_item.resource = item.resource
	world_item.quantity = item.quantity
	world_item.saveables = item.saveables
	world_item.unique_data = item.unique_data
	return world_item

func pickup_by(node: Node) -> SR_InventoryItem:
	if not is_inside_tree():
		return null
	
	if !node:
		return null
	
	var component: SR_ComponentInventory = SR_ComponentInventory.find(node)
	if component:
		return component.pickup(self)
	return null

func _on_sr_interactable_area_area_interacted(interactor: sr_interactor) -> void:
	pickup_by(interactor.interactor)
