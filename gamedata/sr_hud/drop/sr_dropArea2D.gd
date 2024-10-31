extends Area2D
class_name sr_dropArea2D

const PREFAB_PATH: String = "res://gamedata/sr_hud/drop/sr_dropArea2D.tscn"

@export var _control: Control

@onready var _collision: CollisionShape2D = $CollisionShape2D

signal dropped_to(control: Control)
signal dropped_from(control: Control)

func _ready() -> void:
	if _control:
		initialize(_control)

func initialize(control: Control) -> void:
	_control = control
	_collision.shape = _collision.shape.duplicate()
	update_area2d()

func _process(delta: float) -> void:
	update_area2d()

func update_area2d() -> void:
	
	if !_control:
		return
	
	if !_collision:
		return
	
	var shape: RectangleShape2D = _collision.shape as RectangleShape2D
	if shape:
		shape.size = _control.size
		if shape.size == Vector2.ZERO:
			shape.size = Vector2(1, 1)
	
	position = _control.size / 2

func _exit_tree() -> void:
	var picked_area: sr_dropArea2D
	for area in get_overlapping_areas():
		if area is sr_dropArea2D:
			if area.get_control():
				picked_area = area
	
	if picked_area:
		dropped_to.emit(picked_area.get_control())
		picked_area.dropped_from.emit(get_control())

static func create_area_to(control: Control) -> sr_dropArea2D:
	var scene: PackedScene = load(PREFAB_PATH)
	var area: sr_dropArea2D = scene.instantiate() as sr_dropArea2D
	control.add_child(area)
	area.initialize(control)
	return area

static func find(control: Control) -> sr_dropArea2D:
	for i in control.get_children():
		if i is sr_dropArea2D:
			return i
	return null

func get_control() -> Control:
	return _control
