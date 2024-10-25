extends SD_Object
class_name SD_TrunkCanvas

const count_layers := 10

var _layer_nodes := {}
var _canvas: CanvasLayer
var _canvas_center: Control

func _ready() -> void:
	_initialize_canvas()
	_initialize_canvas_center()

func _initialize_canvas() -> void:
	var base := CanvasLayer.new()
	base.name = "sd_trunkcanvas"
	_canvas = base
	
	SimusDev.add_child(_canvas)
	
	for i in count_layers:
		create_layer(i)


func _initialize_canvas_center() -> void:
	_canvas_center = Control.new()
	_canvas_center.custom_minimum_size = Vector2(0, 0)
	_canvas_center.size = Vector2(0, 0)
	_canvas_center.anchor_bottom = 0.5
	_canvas_center.anchor_left = 0.5
	_canvas_center.anchor_right = 0.5
	_canvas_center.anchor_top = 0.5
	_canvas_center.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_canvas_center.hide()
	_canvas.add_child(_canvas_center)

func create_layer(id: int) -> CanvasLayer:
	if _layer_nodes.has(id):
		return
	
	var layer := CanvasLayer.new()
	layer.name = "sd_CLayer%s" % [str(id)]
	layer.layer = id
	_layer_nodes[id] = layer
	if _canvas:
		_canvas.add_child(layer)
	return layer

func get_layer(id: int) -> CanvasLayer:
	return _layer_nodes.get(id)

func get_last_layer() -> CanvasLayer:
	var last_id: int = _layer_nodes.size() - 1
	return get_layer(last_id)

func has_layer(id: int) -> bool:
	return _layer_nodes.has(id)

func get_canvas_center_position() -> Vector2:
	return _canvas_center.position

func get_canvas_center_node() -> Control:
	return _canvas_center
