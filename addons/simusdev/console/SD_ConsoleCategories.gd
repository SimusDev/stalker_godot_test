extends SD_Object
class_name SD_ConsoleCategories

enum CATEGORY {
	DEFAULT,
	ERROR,
}

static var CATEGORY_STRING = {
	0: "",
	1: "error",
}

static func get_category_as_string(category_id: int) -> String:
	return CATEGORY_STRING[category_id]
