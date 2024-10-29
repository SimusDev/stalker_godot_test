extends SR_Attribute
class_name sr_attribute_action

@export var id: String = "action"
@export var hint: String = "hint"

static func create(id: String, hint: String) -> sr_attribute_action:
	var action := sr_attribute_action.new()
	action.id = id
	action.hint = hint
	return action
