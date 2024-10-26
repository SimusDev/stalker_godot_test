extends Control
class_name SR_HUD

signal updated()
signal node_added(node: Node)
signal node_removed(node: Node)

var _static_nodes: Array[Node] = []

signal hud_input(event: InputEvent)
signal hud_active_input(event: InputEvent)

static func instance() -> SR_HUD:
	return Stalker.get_tree().get_first_node_in_group("sr_hud") as SR_HUD

func _ready() -> void:
	Stalker.callbacks.SR_HUD_ready.emit(self)
	

func add_node(node: Node) -> void:
	if node.is_inside_tree() or (node in node.get_children()):
		printc("cant add node, is already inside tree: %s" % [str(node)])
		return
	
	add_child(node)
	
	node.tree_exiting.connect(_on_node_tree_exiting.bind(node))
	if (node is CanvasItem) or (node is CanvasLayer):
		node.visibility_changed.connect(_on_node_visibility_changed.bind(node))
	
	printc("node added: %s" % [str(node)])
	
	update_hud()

func remove_node(node: Node) -> void:
	if (not node in get_children()):
		printc("cant remove node, is not hud children: %s" % [str(node)])
		return
	
	node.queue_free()
	
	update_hud()

func set_node_static_status(node: Node) -> void:
	SD_Array.append_to_array_no_repeat(_static_nodes, node)

func update_hud() -> void:
	updated.emit()
	Stalker.callbacks.SR_HUD_update.emit(self)

func get_nodes() -> Array[Node]:
	return get_children()

func get_visible_nodes() -> Array[Node]:
	var result: Array[Node] = []
	for i in get_nodes():
		if (not _static_nodes.has(i)) and i.visible:
			result.append(i)
	return result

func _on_node_visibility_changed(node: Node) -> void:
	update_hud()

func _on_node_tree_exiting(node: Node) -> void:
	update_hud()

func printc(msg) -> void:
	Stalker.printc("HUD: %s" % [str(msg)])

func create_sound(stream: AudioStream) -> AudioStreamPlayer:
	if not stream:
		return null
	
	var player := AudioStreamPlayer.new()
	player.stream = stream
	player.finished.connect(_on_sound_finished.bind(player))
	SR_GameWorld.instance().add_child(player)
	return player

func _on_sound_finished(player: AudioStreamPlayer) -> void:
	player.queue_free()

func _input(event: InputEvent) -> void:
	if get_visible_nodes().size() > 0:
		hud_active_input.emit(event)
		return
	
	hud_input.emit(event)
