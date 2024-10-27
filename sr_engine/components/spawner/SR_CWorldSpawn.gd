extends Node3D
class_name SR_CWorldSpawn

@export var resource: SR_Resource
@export var autospawn := true
@export var spawn_once := true
@export var spawned := false
@export var spawn_count: int = 1
@export var saveable: W_SaveableNode

signal on_spawn(node: Node)

func _ready() -> void:
	if autospawn:
		spawn(resource)

func spawn(resource: SR_Resource) -> void:
	if spawned and spawn_once:
		queue_free()
		return
	spawned = true
	for i in spawn_count:
		var spawned: Node = SR_Level.find_level(self).spawn_by_resource(resource)
		if spawned:
			spawned.global_position = global_position
			on_spawn.emit(spawned)
		
	
	if spawn_once:
		saveable.save_data()
		queue_free()
