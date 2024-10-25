extends Node
class_name SR_GameWorld

var _AUTOLOAD := [
	SR_WorldAudio.new()
]

@export var spawner: SR_ComponentSpawner
@export var audio_player: SR_ComponentAudioPlayer


func _init() -> void:
	Stalker.world = self

func _ready() -> void:
	Stalker.load_game()
	
	
	Stalker.callbacks.post("world_ready", self)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("save_game"):
		Stalker.save_game()
	if Input.is_action_just_pressed("load_game"):
		get_tree().change_scene_to_packed(load("res://sr_engine/scenes/loadingScene.tscn"))

static func instance() -> SR_GameWorld:
	return Stalker.world

static func get_player() -> SR_Player:
	return SR_Player.instance()

static func teleport_node(node: Node, other_node: Node) -> void:
	if node and other_node:
		if node.has_method("set_global_position"):
			if other_node.has_method("set_global_position"):
				node.set_global_position(other_node.global_position)

static func get_global_position_from_node(node: Node) -> Vector3:
	if node is Node3D:
		return node.global_position
	return Vector3.ZERO
