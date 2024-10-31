extends Node3D
class_name SR_Corpse

const scene_path: String = "res://sr_engine/components/entities/corpse/SR_Corpse.tscn"

@export var inventory: SR_ComponentInventory
@export var _sprite: Sprite3D
@export var _skin: SR_ResourceSkin

func _ready() -> void:
	update_skin()

func update_skin() -> void:
	if _skin:
		if _sprite:
			_sprite.texture = _skin.texture_corpse

static func create(node: Node3D, skin: SR_ResourceSkin) -> SR_Corpse:
	var corpse_scene: PackedScene = load(scene_path)
	var corpse_node: SR_Corpse = SR_Level.find_level(node).spawn_from_scene(corpse_scene) as SR_Corpse
	corpse_node._skin = skin
	corpse_node.update_skin()
	corpse_node.global_position = node.global_position
	corpse_node.rotation.y = SD_Random.get_rfloat_range(0, 360)
	return corpse_node
	
