extends SR_GameScript

var _resource: SR_ResourceAudioStreams

func _ready() -> void:
	sr_callbacks.i().sr_cameraRoot_footstep.connect(_on_sr_cameraRoot_footstep)

func _on_resource_loaded(resource: SR_Resource) -> void:
	if resource.get_section() == "sr_scripts=footsteps_audio_streams":
		_resource = resource

func _on_sr_cameraRoot_footstep(camera_root: sr_cameraRoot) -> void:
	var node: Node3D = camera_root.node
	sr_sounds.play_at_node_position(_resource.streams.pick_random(), node)
