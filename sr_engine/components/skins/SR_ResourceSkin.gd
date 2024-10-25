extends SR_Resource
class_name SR_ResourceSkin

@export var textures: Array[Texture]
@export var textures_id: Array[String]

@export var texture_corpse: Texture

func get_first_texture() -> Texture:
	return textures[0]

func get_texture_by_id(id: String) -> Texture:
	return textures[textures_id.find(id)]
