extends RefCounted
class_name SR_GameScript

func world() -> SR_GameWorld:
	return Stalker.world

func spawner() -> SR_ComponentSpawner:
	return world().spawner

func hud() -> SR_HUD:
	return SR_HUD.instance()

func resources() -> Stalker_ResourceSectionDataBase:
	return Stalker.resources

func get_resource(section: String, default_value = null) -> SR_Resource:
	return  resources().get_resource(section, default_value)

func __initialize__() -> void:
	Stalker.callbacks.callback.connect(_on_callback)
	var tree = Stalker.get_tree()
	tree.process_frame.connect(_process)
	tree.physics_frame.connect(_physics_process)
	Stalker.on_input.connect(_input)
	_ready()

func _input(event: InputEvent) -> void:
	pass

func _ready() -> void:
	pass

func _process() -> void:
	pass

func _physics_process() -> void:
	pass

func _on_callback(cb: Variant, value: Variant) -> void:
	pass

func post_callback(cb, value) -> void:
	Stalker.callbacks.post(cb, value)

func get_delta() -> float:
	return Stalker.get_process_delta_time()

func get_physics_delta() -> float:
	return Stalker.get_physics_process_delta_time()
