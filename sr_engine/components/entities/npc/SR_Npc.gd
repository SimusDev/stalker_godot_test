extends CharacterBody3D
class_name SR_Npc

@onready var callbacks := Stalker.callbacks
@onready var world := Stalker.world
@onready var spawner := world.spawner

@export var section: SR_ComponentNodeSection
@export var character: W_ComponentCharacterBody3D
@export var health: SR_ComponentHealth
@export var skin: SR_Skin
@export var saveable: W_SaveableNode
@export var hitbox: SR_Hitbox
@export var inventory: SR_ComponentInventory
@export var effects: SR_CharacterEffectsComponent

var db := {}

var _resource: SR_ResourceNpc

func _ready() -> void:
	
	$MeshInstance3D.queue_free()
	var section_resource: SR_ResourceNpc = section.get_resource()
	_resource = section_resource
	skin.load_skin(section_resource.skin)
	
	Stalker.callbacks.post("npc_ready", self)

func _process(delta: float) -> void:
	callbacks.post("npc_process", self)

func _physics_process(delta: float) -> void:
	callbacks.post("npc_physics_process", self)

func _on_sr_component_health_health_changed() -> void:
	pass # Replace with function body.



func _on_sr_component_health_died() -> void:
	callbacks.post("npc_died", self)
	
	var corpse: SR_Corpse = SR_Corpse.create(self, skin.get_resource())
	inventory.transfer_items(corpse.inventory)
	spawner.despawn(self)
