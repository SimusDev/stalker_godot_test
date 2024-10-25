extends Node
class_name SR_ComponentAlife

@export var enabled: bool = true
@export var status: bool = true
@export var node: Node3D
@export var notifier: VisibleOnScreenNotifier3D

@export_group("Settings")
@export var switch_distance: float = 500
@export var setting_visibility := true
@export var setting_process := true
@export var setting_physics_process := true
@export var setting_input_process := true

@export var setting_internal_process := true
@export var setting_internal_physics_process := true

signal switched(status: bool)
signal switched_online()
signal switched_offline()

signal tick()
signal online_tick()
signal offline_tick()



func _ready() -> void:
	Stalker.callbacks.callback.connect(_on_stalker_callback)
	Stalker.on_tick.connect(_on_stalker_tick)
	
	if not enabled:
		return
	
	if notifier:
		notifier.screen_entered.connect(_on_screen_entered)
		notifier.screen_exited.connect(_on_screen_exited)
	

func _on_stalker_callback(cb: Variant, value: Variant) -> void:
	if node is SR_Player:
		return
	
	if cb is String:
		match cb:
			"alife_component_tick":
				if notifier != null:
					return
				
				var component: SR_ComponentAlife = value as SR_ComponentAlife
				
				if component.node is SR_Player:
					var player: SR_Player = component.node as SR_Player
					
					var distance_to_player: float = player.global_position.distance_to(node.global_position)
					if distance_to_player >= switch_distance:
						switch(false)
					else:
						switch(true)



func _on_stalker_tick() -> void:
	tick.emit()
	Stalker.callbacks.post("alife_component_tick", self)
	
	if status:
		online_tick.emit()
		Stalker.callbacks.post("alife_component_tick_online", self)
	else:
		offline_tick.emit()
		Stalker.callbacks.post("alife_component_tick_offline", self)
	
	


func _on_screen_entered() -> void:
	switch(true)

func _on_screen_exited() -> void:
	switch(false)

func switch(switch_status: bool) -> void:
	
	if not enabled:
		return
	
	if status == switch_status:
		return
	
	status = switch_status
	
	switched.emit(switch_status)
	if status:
		switched_online.emit()
		_on_switched_online()
	else:
		switched_offline.emit()
		_on_switched_offline()
	
	Stalker.callbacks.post("alife_component_switched", self)
	Stalker.printc("alife node switched(%s) to status: %s" % [self.node, status])
	
	
	

func _on_switched_online() -> void:
	_switch_all_settings_to(true)

func _on_switched_offline() -> void:
	_switch_all_settings_to(false)

func _switch_all_settings_to(boolean: bool) -> void:
	if setting_visibility: node.visible = boolean
	
	if setting_process: node.set_process(boolean)
	if setting_physics_process: node.set_physics_process(boolean)
	
	if setting_internal_process: node.set_process_internal(boolean)
	if setting_internal_physics_process: node.set_physics_process_internal(boolean)
	
	if setting_input_process:
		node.set_process_input(boolean)
		node.set_process_shortcut_input(boolean)
		node.set_process_unhandled_input(boolean)
		node.set_process_unhandled_key_input(boolean)

func is_online() -> bool:
	return status

func is_offline() -> bool:
	return !is_online()

static func find(node: Node) -> SR_ComponentAlife:
	for i in node.get_children():
		if i is SR_ComponentAlife:
			return i
	return null
