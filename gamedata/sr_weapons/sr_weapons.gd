extends SR_GameScript
class_name sr_weapons

static func shoot(weapon_item: SR_InventoryItem, level: SR_Level, node: Node3D) -> void:
	if weapon_item == null:
		return
	
	if (!weapon_item.resource is SR_ResourceWeapon):
		return 
	
	var wpn_data: SR_WeaponData = SR_WeaponData.get_unique_data(weapon_item)
	if wpn_data.ammo_count <= 0:
		return
	
	wpn_data.ammo_count -= 1
	
	var projectile: SR_Projectile = sr_ammo.create_projectile_from_weapon(weapon_item.resource)
	level.add_child(projectile)
	projectile.position = node.global_position
	projectile.transform.basis = node.global_transform.basis

static func shoot_by_npc(weapon_item: SR_InventoryItem, npc: SR_Npc) -> void:
	shoot(weapon_item, SR_Level.find_level(npc), npc.camera_root)
