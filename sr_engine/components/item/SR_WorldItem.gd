extends CharacterBody3D
class_name SR_WorldItem

@export var section: SR_ComponentNodeSection
@export var sprite: Sprite3D

@export var storage := {}

@export var resource: SR_ResourceWorldItem

func _ready() -> void:
	var section_resource: SR_ResourceWorldItem = section.get_resource()
	if section_resource:
		resource = section_resource
		sprite.texture = resource.texture_on_floor
		sprite.pixel_size = resource.texture_pixel_size

func get_resource() -> SR_ResourceWorldItem:
	if section:
		return section.get_resource()
	return resource

static func create_from_inventory_item(item: SR_InventoryItem) -> SR_WorldItem:
	var world_item: SR_WorldItem = SR_GameWorld.instance().spawner.spawn(item.resource.get_section())
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
