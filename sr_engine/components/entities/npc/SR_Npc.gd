extends CharacterBody3D
class_name SR_Npc

@onready var callbacks := Stalker.callbacks
@onready var world := Stalker.world

@export var section: SR_ComponentNodeSection
@export var character: W_ComponentCharacterBody3D
@export var health: SR_ComponentHealth
@export var skin: SR_Skin
@export var saveable: W_SaveableNode
@export var hitbox: SR_Hitbox
@export var inventory: SR_ComponentInventory
@export var effects: SR_CharacterEffectsComponent
@export var stats: SR_CharacterStatsComponent

var db := {}

var _resource: SR_ResourceNpc

func _ready() -> void:
	
	$MeshInstance3D.queue_free()
	var section_resource: SR_ResourceNpc = section.get_resource()
	_resource = section_resource
	skin.load_skin(section_resource.skin)
	
	Stalker.callbacks.SR_Npc_ready.emit(self)
	
	

func _on_sr_component_health_health_changed() -> void:
	pass # Replace with function body.



func _on_sr_component_health_died() -> void:
	callbacks.SR_Npc_died.emit(self)
	
	var corpse: SR_Corpse = SR_Corpse.create(self, skin.get_resource())
	inventory.transfer_items(corpse.inventory)
	SR_Level.find_level(self).despawn(self)
