@tool
extends Sprite3D
class_name SR_Skin

@export var _resource: SR_ResourceSkin
@export var _player: AnimationPlayer 

func load_skin(skin: SR_ResourceSkin) -> void:
	_resource = skin
	texture = _resource.get_first_texture()
	

func get_resource() -> SR_ResourceSkin:
	return _resource
