extends Control

@onready var nmkr: NMKR = $NMKR

@export var update_button: Button
@export var usd: Label
@export var eur: Label
@export var jpy: Label
@export var btc: Label

var _result: Dictionary


# Called when the node enters the scene tree for the first time.
func _ready():
	update_button.disabled = true
	
	update_button.pressed.connect(_on_update_button_pressed)


	# Method 1 (async)
	# Define a callback that will be executed every time that nmkr function-specific
	# signal (in this case: "get_ada_rates_completed") is received.
	
	nmkr.get_ada_rates_completed.connect(_on_get_ada_rates)
	nmkr.get_ada_rates()


	# Method 2 (sync)
	# You use the desired method as a coroutine, and await for it assigning
	# the result to a variable.

	#_result = await nmkr.get_ada_rates()
	#display_rates()


	# Method 3 (sync)
	# You run the desired method, await for the nmkr function-specific signal
	# (in this case: "get_ada_rates_completed") or the generic one that is
	# emitted from any function ("completed"), then you fetch and use the
	# result.
	
	#nmkr.get_ada_rates()
	#await nmkr.completed
	#_result = nmkr.result
	#display_rates()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func display_rates():
	_on_get_ada_rates(_result)


func _on_update_button_pressed():
	print("Button pressed")
	update_button.disabled = true
	usd.text = "--- USD"
	eur.text = "--- EUR"
	jpy.text = "--- JPY"
	btc.text = "--- BTC"
	
	#nmkr.get_ada_rates()
	#
	#await nmkr.get_ada_rates_completed
	_result = await nmkr.get_ada_rates()
	_on_get_ada_rates(_result)


func _on_get_ada_rates(result: Dictionary):
	update_button.disabled = false
	
	usd.text = str(result.usdRate) + " USD"
	eur.text = str(result.eurRate) + " EUR"
	jpy.text = str(result.jpyRate) + " JPY"
	btc.text = str(result.btcRate) + " BTC"
