@tool
extends EditorPlugin

const KEEP_SETTINGS := false
const SETTINGS := [
	{
		"name": "nmkr/config/global/api_keys",
		"type": TYPE_PACKED_STRING_ARRAY,
		"value": [],
		"hint_string": "Your API key(s) from NMKR Studio",
	},
	{
		"name": "nmkr/config/global/debug",
		"type": TYPE_BOOL,
		"value": false,
		"hint_string": "Throws the returned body as a warning message in case of non-successful HTTP requests",
	},
]


func _enter_tree():
	add_custom_type("NMKR", "Node", preload("nmkr.gd"), preload("icon.svg"))


func _exit_tree():
	remove_custom_type("NMKR")


func _enable_plugin():
	if not _has_settings():
		_add_settings()
	print("NMKR-SDK: Plugin initialized")


func _disable_plugin():
	if not KEEP_SETTINGS:
		_remove_settings()
	print("NMKR-SDK: Plugin cleaned up")


func _has_settings() -> bool:
	for setting in SETTINGS:
		if not ProjectSettings.has_setting(setting["name"]):
			return false
	return true


func _add_settings():
	for _setting in SETTINGS:
		var setting: Dictionary = _setting
		if setting.type == TYPE_PACKED_STRING_ARRAY:
			ProjectSettings.set(setting["name"], PackedStringArray(setting["value"]))
		else:
			ProjectSettings.set(setting["name"], setting["value"])
		
		var property_info := {
			"name": setting["name"],
			"type": setting["type"],
		}
		
		if setting.has("hint"):
			property_info["hint"] = setting["hint"]
		
		if setting.has("hint_string"):
			property_info["hint_string"] = setting["hint_string"]
		
		ProjectSettings.add_property_info(property_info)


func _remove_settings():
	for _setting in SETTINGS:
		var setting: Dictionary = _setting
		
		if ProjectSettings.has_setting(setting["name"]):
			ProjectSettings.clear(setting["name"])
