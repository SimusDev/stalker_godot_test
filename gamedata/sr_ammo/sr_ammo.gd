extends SR_GameScript
class_name sr_ammo

static func create_projectile_from_ammo(ammo: SR_ResourceAmmo) -> SR_Projectile:
	if (!ammo):
		Stalker.printc("sr_ammo: create_projectile_from_ammo() ammo is null")
		return
	var projectile_scene: PackedScene = SR_Projectile.get_packed_scene()
	if ammo.custom_projectile:
		projectile_scene = ammo.custom_projectile
	
	
	var projectile: SR_Projectile = projectile_scene.instantiate() as SR_Projectile
	
	projectile.damage = ammo.damage
	projectile.speed = ammo.speed
	projectile.gravity = ammo.gravity
	projectile.gravity_force = ammo.gravity_force
	projectile.air_drag = ammo.air_drag
	projectile.air_drag_force = ammo.air_drag_force
	
	return projectile

static func create_projectile_from_weapon(weapon: SR_ResourceWeapon) -> SR_Projectile:
	return create_projectile_from_ammo(weapon.ammo)
