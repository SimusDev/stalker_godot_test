extends RayCast3D
class_name SR_Projectile

const PREFAB_UID: String = "uid://chsc7nwvtl48n"

@export var speed: float = 100.0
@export var gravity: bool = true
@export var gravity_force: float = 2.0
@export var air_drag: bool = true
@export var air_drag_force: float = 0.5
@export var damage: float = 10.0

func _physics_process(delta: float) -> void:
	position += transform.basis * Vector3.FORWARD * speed * delta
	target_position = Vector3.FORWARD * speed * delta
	
	if air_drag:
		speed -= air_drag_force * delta
	
	if gravity:
		position.y -= gravity_force * delta
	
	force_raycast_update()
	
	if is_colliding():
		var collider: Object = get_collider()
		global_position = get_collision_point()
		
		if collider is SR_Hurtbox:
			collider.take_from_projectile(self)
			
		set_physics_process(false)
		collide_and_destroy()
	

static func create(level: SR_Level, node: Node3D) -> SR_Projectile:
	var scene: PackedScene = load(PREFAB_UID)
	var projectile: SR_Projectile = scene.instantiate() as SR_Projectile
	level.add_child(projectile)
	projectile.position = node.global_position
	projectile.transform.basis = node.global_transform.basis
	return projectile

func _on_destory_timer_timeout() -> void:
	queue_free()



func collide_and_destroy() -> void:
	queue_free()
