extends Resource
class_name SR_WeaponData

@export var ammo_count: int = 0

static func create(item: SR_InventoryItem) -> SR_WeaponData:
	var resource: SR_ResourceWeapon = item.resource
	var data := SR_WeaponData.new()
	data.ammo_count = resource.max_ammo_count
	return data

static func get_unique_data(item: SR_InventoryItem) -> SR_WeaponData:
	if item.unique_data is SR_WeaponData:
		return item.unique_data
	item.unique_data = SR_WeaponData.create(item)
	return item.unique_data
