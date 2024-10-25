extends SD_Object
class_name SD_ConsoleMessage

var category: int = 0
var text

func parse_and_get_as_string() -> String:
	return "[%s] %s" % [SD_ConsoleCategories.get_category_as_string(category), str(text)]
