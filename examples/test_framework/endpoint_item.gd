class_name EndpointItem
extends Node


@export var parameters: PackedStringArray
@export var nmkr: NMKR
@export var result: Label
var _params: Array[TextEdit] = []
@onready var label: Label = $Label
@onready var param1: TextEdit = $"TextEdit 1"
@onready var param2: TextEdit = $"TextEdit 2"
@onready var param3: TextEdit = $"TextEdit 3"
@onready var param4: TextEdit = $"TextEdit 4"
@onready var execute_button: Button = $Button


# Called when the node enters the scene tree for the first time.
func _ready():
	label.text = name
	
	var all_params := [ param1, param2, param3, param4 ]
	for i in all_params.size():
		if parameters.size() > i:
			_params.append(all_params[i])
			_params[i].placeholder_text = parameters[i]
		else:
			all_params[i].editable = false
			#all_params[i].visible = false
	
	execute_button.pressed.connect(_on_execute_button_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func execute():
	match _params.size():
		0:
			nmkr.call(name)
		1:
			nmkr.call(name, _check_param(_params[0]))
		2:
			nmkr.call(name, _check_param(_params[0]), _check_param(_params[1]))
		3:
			nmkr.call(name, _check_param(_params[0]), _check_param(_params[1]), _check_param(_params[2]))
		4:
			nmkr.call(name, _check_param(_params[0]), _check_param(_params[1]), _check_param(_params[2]), _check_param(_params[3]))
	
	await nmkr.completed
	result.text = JSON.stringify(nmkr.result)


func _get_params_string(strings: PackedStringArray) -> String:
	var params := name + "("
	for i in strings.size():
		params += strings[i]
		if i < strings.size() - 1:
			params += ", "
	params += ")"
	
	return params


func _check_param(text_edit: TextEdit):
	if text_edit.placeholder_text in [ "optional", "data" ]:
		var text = text_edit.text if text_edit.text.length() > 2 else "{}"
		return JSON.parse_string(text)
	
	if text_edit.placeholder_text in [ "customerid", "countofnfts", "countnft", "tokencount", "count", "page", "lovelace" ]:
		return int(text_edit.text)
	
	if text_edit.placeholder_text == "block_nft":
		return true if text_edit.text in [ "true", "1", "yes", "t", "one", "y" ] else false
	
	if text_edit.placeholder_text == "percentage":
		return float(text_edit.text)
	
	return text_edit.text


func _on_execute_button_pressed():
	execute()
