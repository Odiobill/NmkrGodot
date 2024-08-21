@tool
class_name NMKR
## A Godot plugin that is a wrapper of the NMKR API to create more integrated minting experiences.
##
## The [b]NMKR SDK for Godot[/b] addresses the need for seamless integration of Cardano's NFT
## capabilities in the gaming industry, particularly targeting indie game developers using Godot.
## [br][br]
## By developing a Godot plugin for NMKR's NFT minting API, we facilitate easier Cardano adoption,
## potentially increasing both the number of NFTs minted and the transactions within the Cardano
## network. With this tool, we aim to attract new developers and users to the Cardano ecosystem,
## broadening its user base, while facilitating the implementation of NFT technology for the game
## developers who are adopting different revenue models.
## [br][br]
## Before using this plugin in your projects, [b]you need to have at least an API Key[/b] configured
## in the [url=https://studio.nmkr.io/apikeys]NMKR Studio console[/url]. Copy your key, then open
## the [i]Project Settings[/i] and search for [b]Nmkr[/b] (you may need to activate the
## [i]Advanced Settings[/i] toggle for it to show up). Click on [i]Config[/i] and add your key(s)
## in the input field(s).
## [br][br][br]
## [b]Code Examples[/b][br]
## Each available method will emit a signal as soon as the request is completed. You can either
## [i]await[/i] the corresponding signal for synchronous requests or connect a callback function
## to it. If you only need to perform consequential synchronous requests, you can also wait for the
## generic [i]completed[/i] signal instead of having to specify a specific one after each call.
## [br][br]
## Example with [i]await[/i]:
## [br][code]
## @onready var nmkr: Nmkr = $NMKR
##
## func _ready():
##     nmkr.get_ada_rates()
##     await nmkr.get_ada_rates_completed # or just "await nmkr.completed"
##     print(nmkr.result)
## [/code][br][br]
## Example with a [i]callback[/i] function:
## [br][code]
## @onready var nmkr: Nmkr = $NMKR
##
## func _ready():
##     nmkr.get_ada_rates_completed.connect(_on_get_ada_rates_completed)
##     nmkr.get_ada_rates()
##
## func _on_get_ada_rates_completed(result: Dictionary):
##     print(result)
## [/code]
## [br][br][br]
## [b]Conventions used in the NMKR SDK for Godot[/b][br]
## The [i]NMKR custom node[/i] is a GDScript class that exposes both a public [i]method[/i] and a
## [i]custom signal[/i] for each of the available endpoints in the [b]NMKR API[/b], as documented
## in the [url=https://studio-api.nmkr.io/swagger/index.html]NMKR Swagger[/url].
## [br][br]
## Each endpoint corresponds to a method that has the same name, but is written using
## [i]snake_case[/i] without the leading version number, and will emit two signals on completion:
## [i]completed[/i], and another one with the same name plus the [i]_completed[/i] suffix. See the
## example above for more details.
## [br][br]
## Each required parameter, as mentioned in the
## [url=https://studio-api.nmkr.io/swagger/index.html]NMKR Swagger[/url], is expected to be provided
## to the functions with the same name. For example, if you want to access the
## [code]/v2/AddPayoutWallet/{walletaddress}[/code] endpoint, you will the following function:
## [code]func add_payout_wallet(walletaddress)[/code]
## [br][br]
## [b]Passing data to POST and PUT requests[/b][br]
## To pass the required data to the endpoints that are accessible with the POST or PUT methods, you
## can simply define a [i]Dictionary[/i] with the necessary key/value pairs, and pass it to the
## desired function after the other required parameters. The name of this parameter is always
## "data" for all the available functions that use POST or PUT methods. Example:[br]
## [code]check_metadata(nftuid, { "metadata": "string" })[/code]
## [br][br]
## [b]Optional parameters[/b][br]
## Some of the endpoints accept optional parameters. In that case, when needed, you can define a
## [i]Dictionary[/i] with all the optional parameters that you need, and pass it to the desired
## function after all the required ones. The name of this parameter is always "optional" for all the
## available functions that allow specifying optional parameters. Example:[br]
## [code]get_customer_transaction(customerid, { "exportOptions": "Csv" })[/code]

extends Node

# General
signal completed(result: Dictionary)
# Customer
signal add_payout_wallet_completed(result: Dictionary)
signal get_customer_transactions_completed(result: Dictionary)
signal get_mint_coupon_balance_completed(result: Dictionary)
signal get_payout_wallets_completed(result: Dictionary)
# ... #
# Tools
signal get_ada_rates_completed(result: Dictionary)
signal get_all_asstes_in_wallet_completed(result: Dictionary)
signal get_amount_of_specific_token_in_wallet_completed(result: Dictionary)
signal get_cardano_token_registry_information_completed(result: Dictionary)
signal get_metadata_for_token_completed(result: Dictionary)
signal get_preview_image_for_token_completed(result: Dictionary)


## Internal error codes
enum SdkError {
	INVALID_KEY, ## No valid keys configured in the Project Settings
	INVALID_PARAMETERS, ## The provided parameters are insufficient or invalid
}

## Base URL for NMKR API requests
const BASE_URL := "https://studio-api.nmkr.io"

var _apiKeys: PackedStringArray = []
var _debug: bool
var _key := ""
var _result

## If more keys are defined, use this property to set the key index for the following requests;
## by default, the first (valid) defined key will be used, so usually you won't need this property
var current_key: int = -1:
	get:
		return current_key
	set(value):
		if value >= 0 and _apiKeys.size() > value:
			current_key = value
			_key = _apiKeys[value]
		else:
			current_key = -1
			_key = ""

## Returns the result of the last request. It can be either a Dictionary or an Array, depending on
## the requested endpoint
var result:
	get:
		return _result


func _ready():
	var keys: PackedStringArray = ProjectSettings.get_setting("nmkr/config/global/api_keys", [])
	if keys.size() == 0:
		push_warning("NMKR: API Keys non configured in Project Settings")
		current_key = -1
	else:
		var count = 0
		for key in keys:
			if key == "":
				push_warning("NMKR: API Key #" + str(count) + " is empty")
			else:
				_apiKeys.append(key)
			
			count += 1
		
		if _apiKeys.size() == 0:
			push_warning("NMKR: no valid API Key found in Project Settings")
			current_key = -1
		else:
			current_key = 0
	
	_debug = ProjectSettings.get_setting("nmkr/config/global/debug", false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



# Customer

## With this call you can add a payout wallet in your account. You have to confirm the wallet
## by clicking the link in the email
func add_payout_wallet(walletaddress := "") -> Dictionary:
	var sig := add_payout_wallet_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif not walletaddress.begins_with("addr"):
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := BASE_URL + "/v2/AddPayoutWallet/" + walletaddress
		_request(url, sig)
	
	await sig
	return result


## Returns all Transaction of a customer
func get_customer_transactions(customerid: int = 0, optional := {}) -> Dictionary:
	var sig := get_customer_transactions_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif customerid == 0:
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := BASE_URL + "/v2/GetCustomerTransactions/" + str(customerid)
		_request(url if optional.size() == 0 else _get_valid_url(url, optional), sig)
	
	await sig
	return result


## Returns the count of mint coupons in your account
func get_mint_coupon_balance() -> Dictionary:
	var sig := get_mint_coupon_balance_completed
	
	if current_key < 0:
		_trigger_error(sig)
	else:
		var url := BASE_URL + "/v2/GetMintCouponBalance"
		_request(url, sig)
	
	await sig
	return result


## Returns all payout wallets in your account
func get_payout_wallets() -> Dictionary:
	var sig := get_payout_wallets_completed
	
	if current_key < 0:
		_trigger_error(sig)
	else:
		var url := BASE_URL + "/v2/GetPayoutWallets"
		_request(url, sig)
	
	await sig
	return result


# Tools


## Returns the actual price in EUR and USD for ADA
func get_ada_rates() -> Dictionary:
	var sig := get_ada_rates_completed
	
	if current_key < 0:
		_trigger_error(sig)
	else:
		var url := BASE_URL + "/v2/GetAdaRates"
		_request(url, sig)
	
	await sig
	return result


## Returns all assets that are in a wallet
func get_all_assets_in_wallet(address := "") -> Dictionary:
	var sig := get_all_asstes_in_wallet_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif address == "":
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := BASE_URL + "/v2/GetAllAssetsInWallet/" + address
		_request(url, sig)
	
	await sig
	return result


## Returns the quantity of a specific token in a wallet. Leave the "address" field as an empty
## string if you want to provide the required data as a dictionary using the POST request.
func get_amount_of_specific_token_in_wallet(address := "", policyid := "", tokenname := "", data := {}) -> Dictionary:
	var sig := get_amount_of_specific_token_in_wallet_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif (data.size == 0 and (address == "" or policyid == "" or tokenname == "")) \
	or (data.size > 0 and (address != "" or policyid == "" or tokenname == "")):
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := BASE_URL + "/v2/GetAmountOfSpecificTokenInWallet/"
		
		if data.size() == 0:
			url += address + "/" + policyid + "/" + tokenname
			_request(url, sig)
		else:
			url += policyid + "/" + tokenname
			_request(url, sig, data)
	
	await sig
	return result


## Returns the Token Registry Information for a specific token (if available)
func get_cardano_token_registry_information(policyid := "", tokenname := "") -> Dictionary:
	var sig := get_cardano_token_registry_information_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif policyid.length() == 0 or tokenname == "":
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := BASE_URL + "/v2/GetCardanoTokenRegistryInformation/" + policyid + "/" + tokenname
		_request(url, sig)
	
	await sig
	return result


## Returns the Metadata for a specific token
func get_metadata_for_token(policyid := "", tokennamehex := "") -> Dictionary:
	var sig := get_metadata_for_token_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif policyid.length() == 0 or tokennamehex == "":
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := BASE_URL + "/v2/GetMetadataForToken/" + policyid + "/" + tokennamehex
		_request(url, sig)
	
	await sig
	return result


## Returns the IPFS Hash of the preview image for a specific token
func get_preview_image_for_token(policyid := "", tokennamehex := "") -> Dictionary:
	var sig := get_preview_image_for_token_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif policyid.length() == 0 or tokennamehex == "":
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := BASE_URL + "/v2/GetPreviewImageForToken/" + policyid + "/" + tokennamehex
		_request(url, sig)
	
	await sig
	return result


# Private methods

# Define the necessary headers for the HTTP request
func _headers() -> Array[String]:
	return [
		"Content-Type: application/json",
		"Authorization: Bearer " + _key,
	]


# Add GET options to an URL from a dicionary
func _get_valid_url(url: String, optional := {}) -> String:
	var parameters := ""
	
	for key in optional.keys():
		var separator: String = "&" if parameters != "" else "?"
		parameters += separator + str(key) + "=" + str(optional[key])
	
	return url + parameters


# Performs an http request
func _request(url: String, sig: Signal, data := {}, method := HTTPClient.METHOD_GET):
	var http := _create_http_request()
	var headers = _headers()
	if data.size() > 0:
		if method == HTTPClient.METHOD_GET:
			method = HTTPClient.METHOD_POST
		var body := JSON.new().stringify(data)
		http.request(url, headers, method, body)
	else:
		http.request(url, headers, method)
	
	http.request_completed.connect(_on_completed.bind(http, sig))


# Trigger a request error without actually making any request
func _trigger_error(sig: Signal, code: SdkError = SdkError.INVALID_KEY):
	get_tree().create_timer(0.1).timeout.connect(_on_completed.bind(-1, code, [], [], null, sig))


# Create and return an HTTPRequest node to perform requests
func _create_http_request() -> HTTPRequest:
	var _http_request := HTTPRequest.new()
	add_child(_http_request)
	_http_request.use_threads = OS.get_name() != "HTML5"
	return _http_request


# Callback for every endpoint request
func _on_completed(res: int, code: int, _h: PackedStringArray, body: PackedByteArray, node: HTTPRequest, sig: Signal):
	if node != null:
		node.queue_free()
	
	var text = body.get_string_from_utf8()
	if res == HTTPRequest.RESULT_SUCCESS and code == HTTPClient.RESPONSE_OK:
		Engine.print_error_messages = false
		_result = JSON.parse_string(text)
		Engine.print_error_messages = true
		
		_result = _result if _result != null else text
	else:
		_result = {
			"error": true,
			"code": code,
			"body": text,
		}
		
		if _debug:
			push_warning(_result)
	
	sig.emit(_result)
	completed.emit(_result)
