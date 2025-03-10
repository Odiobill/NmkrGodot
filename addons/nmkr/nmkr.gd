@tool
class_name NMKR extends Node

## A Godot plugin for accessing the NMKR Studio API
##
## The [b]NMKR SDK for Godot[/b] addresses the need for seamless integration of NFTs and other
## blockchain capabilities in the gaming industry, particularly targeting indie game developers
## using Godot.
## [br][br]
## By developing a Godot plugin for NMKR's NFT minting API, we facilitate easier Web3 adoption,
## potentially increasing both the number of NFTs minted and the transactions within the Cardano
## network, with other blockchains being on the NMKR roadmap, starting with Solana.
## [br][br]
## With this tool, we aim to attract new developers and users to the blockchain ecosystem,
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
## [br][codeblock]
## @onready var nmkr: Nmkr = $NMKR
##
## func _ready():
##     nmkr.get_ada_rates()
##     await nmkr.get_ada_rates_completed # or just "await nmkr.completed"
##     print(nmkr.result)
## [/codeblock][br][br]
## Example with a [i]callback[/i] function:
## [br][codeblock]
## @onready var nmkr: Nmkr = $NMKR
##
## func _ready():
##     nmkr.get_ada_rates_completed.connect(_on_get_ada_rates_completed)
##     nmkr.get_ada_rates()
##
## func _on_get_ada_rates_completed(result: Dictionary):
##     print(result)
## [/codeblock]
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
## [codeblock]func add_payout_wallet(walletaddress)[/codeblock]
## [br][br]
## [b]Passing data to POST and PUT requests[/b][br]
## To pass the required data to the endpoints that are accessible with the POST or PUT methods, you
## can simply define a [i]Dictionary[/i] with the necessary key/value pairs, and pass it to the
## desired function after the other required parameters. The name of this parameter is always
## "data" for all the available functions that use POST or PUT methods. Example:[br]
## [codeblock]check_metadata(nftuid, { "metadata": "string" })[/codeblock]
## [br][br]
## [b]Optional parameters[/b][br]
## Some of the endpoints accept optional parameters. In that case, when needed, you can define a
## [i]Dictionary[/i] with all the optional parameters that you need, and pass it to the desired
## function after all the required ones. The name of this parameter is always "optional" for all the
## available functions that allow specifying optional parameters. Example:[br]
## [codeblock]get_customer_transactions(customerid, { "exportOptions": "Csv" })[/codeblock]

# General
signal completed(result)
signal error(result)
# Customer
signal add_payout_wallet_completed(result: Dictionary)
signal get_customer_transactions_completed(result: Array)
signal get_mint_coupon_balance_completed(result: Dictionary)
signal get_payout_wallets_completed(result: Array)
# NFT
signal block_unblock_nft_completed(result: Dictionary)
signal check_metadata_completed(result: Dictionary)
signal delete_all_nfts_from_project_completed(result: Dictionary)
signal delete_nft_completed(result: Dictionary)
signal duplicate_nft_completed(result: Dictionary)
signal get_nft_details_by_id_completed(result: Dictionary)
signal get_nft_details_by_tokenname_completed(result: Dictionary)
signal get_nfts_completed(result: Array)
signal update_metadata_completed(result: Dictionary)
signal upload_nft_completed(result: Dictionary)
# Address reservation (sale)
signal cancel_address_reservation_completed(result: Dictionary)
signal check_address_completed(result: Dictionary)
signal check_address_with_customproperty_completed(result: Dictionary)
signal get_payment_address_for_random_nft_sale_completed(result: Dictionary)
signal get_payment_address_for_specific_nft_sale_completed(result: Dictionary)
# Tools
signal check_if_eligible_for_discount_completed(result: Dictionary)
signal check_if_sale_contidions_met_completed(result: Dictionary)
signal check_utxo_completed(result: Dictionary)
signal get_active_directsale_listings_completed(result: Dictionary)
signal get_ada_rates_completed(result: Dictionary)
signal get_all_asstes_in_wallet_completed(result: Array)
signal get_amount_of_specific_token_in_wallet_completed(result: Dictionary)
signal get_cardano_token_registry_information_completed(result: Dictionary)
signal get_metadata_for_token_completed(result: Dictionary)
signal get_policy_snapshot_completed(result: Dictionary)
signal get_preview_image_for_token_completed(result: Dictionary)
signal get_rates_completed(result: Dictionary)
signal get_royalty_information_completed(result: Dictionary)
signal get_solana_rates_completed(result: Dictionary)
# Wallet validation
signal check_wallet_validation_completed(result: Dictionary)
signal get_wallet_validation_address_completed(result: Dictionary)
# Auctions
signal create_auction_completed(result: Dictionary)
signal delete_auction_completed(result: Dictionary)
signal get_all_auctions_completed(result: Array)
signal get_auction_state_completed(result: Dictionary)
# Projects
signal create_burning_address_completed(result: Dictionary)
signal create_project_completed(result: Dictionary)
signal delete_project_completed(result: Dictionary)
signal get_counts_completed(result: Dictionary)
signal get_discounts_completed(result: Array)
signal get_identity_accounts_completed(result: Dictionary)
signal get_notifications_completed(result: Array)
signal get_pricelist_completed(result: Dictionary)
signal get_project_details_completed(result: Dictionary)
signal get_project_transactions_completed(result: Array)
signal get_refunds_completed(result: Array)
signal get_sale_conditions_completed(result: Array)
signal list_projects_completed(result: Array)
signal update_discounts_completed(result: Dictionary)
signal update_notifications_completed(result: Dictionary)
signal update_pricelist_completed(result: Dictionary)
signal update_sale_conditions_completed(result: Dictionary)
# Split Addresses
signal create_split_address_completed(result: Dictionary)
signal get_split_addresses_completed(result: Array)
signal update_split_address_completed(result: Dictionary)
# Vesting Addresses
signal create_vesting_address_completed(result: Dictionary)
signal get_utxo_from_vesting_address_completed(result: Dictionary)
signal get_vesting_addresses_completed(result: Array)
# Managed Wallets
signal create_wallet_completed(result: Dictionary)
signal get_key_hash_completed(result: Dictionary)
signal get_wallet_utxo_completed(result: Dictionary)
signal import_wallet_completed(result: Dictionary)
signal list_all_wallets_completed(result: Array)
signal make_transaction_completed(result: Dictionary)
signal send_all_assets_completed(result: Dictionary)
# NMKR Pay
signal get_nmkr_pay_link_completed(result: Dictionary)
signal get_nmkr_pay_status_completed(result: Dictionary)
# Misc
signal get_public_mints_completed(result: Dictionary)
signal get_server_state_completed(result: Array)
# Whitelists
signal manage_whitelist_completed(result: Dictionary)
# Mint
signal mint_and_send_random_completed(result: Dictionary)
signal mint_and_send_specific_completed(result: Dictionary)
signal mint_royalty_token_completed(result: Dictionary)
signal remint_and_burn_completed(result: Dictionary)
# IPFS
signal upload_to_ipfs_completed(result: Dictionary)


## Internal error codes
enum SdkError {
	INVALID_KEY, ## No valid keys configured in the Project Settings
	INVALID_PARAMETERS, ## The provided parameters are insufficient or invalid
}

## Base URL for NMKR API requests
const BASE_URL := "https://studio-api.nmkr.io"

var _apiKeys: PackedStringArray = []
var _debug: bool
var _base_url: String
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
	_base_url = ProjectSettings.get_setting("nmkr/config/global/base_url", BASE_URL)
	
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
		var url := _base_url + "/v2/AddPayoutWallet/" + walletaddress
		_request(url, sig)
	
	await sig
	return result


## Returns all Transaction of a customer
func get_customer_transactions(customerid: int = 0, optional := {}) -> Array:
	var sig := get_customer_transactions_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif customerid == 0:
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := _base_url + "/v2/GetCustomerTransactions/" + str(customerid)
		_request(url if optional.size() == 0 else _get_valid_url(url, optional), sig)
	
	await sig
	return result if result is Array else [ result ]


## Returns the count of mint coupons in your account
func get_mint_coupon_balance() -> Dictionary:
	var sig := get_mint_coupon_balance_completed
	
	if current_key < 0:
		_trigger_error(sig)
	else:
		var url := _base_url + "/v2/GetMintCouponBalance"
		_request(url, sig)
	
	await sig
	return result


## Returns all payout wallets in your account
func get_payout_wallets() -> Array:
	var sig := get_payout_wallets_completed
	
	if current_key < 0:
		_trigger_error(sig)
	else:
		var url := _base_url + "/v2/GetPayoutWallets"
		_request(url, sig)
	
	await sig
	return result if result is Array else [ result ]


# NFT

## You can block an nft, if it is not already sold or reserved and you can unblock blocked nfts
func block_unblock_nft(nftuid := "", block_nft := true) -> Dictionary:
	var sig := block_unblock_nft_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif nftuid == "":
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := _base_url + "/v2/BlockUnblockNft/" + nftuid + "/" + str(block_nft)
		_request(url, sig)
	
	await sig
	return result


## Check if the metadata are valid
func check_metadata(nftuid := "", data := {}) -> Dictionary:
	var sig := check_metadata_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif nftuid.length() == 0 or not data.has("metadata"):
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := _base_url + "/v2/CheckMetadata/" + nftuid
		_request(url, sig, data)
	
	await sig
	return result


## This function deletes all NFTs from a project. You can delete a nft, if it is not in sold or reserved state. All other nfts will be deleted.
func delete_all_nfts_from_project(projectuid := "") -> Dictionary:
	var sig := delete_all_nfts_from_project_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif projectuid == "":
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := _base_url + "/v2/DeleteAllNftsFromProject/" + projectuid
		_request(url, sig)
	
	await sig
	return result


## You can delete a nft, if it is not in sold or reserved state
func delete_nft(nftuid := "") -> Dictionary:
	var sig := delete_nft_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif nftuid == "":
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := _base_url + "/v2/DeleteNft/" + nftuid
		_request(url, sig)
	
	await sig
	return result


## Duplicates a nft/token inside a project. If a token already exists, it will be skipped
func duplicate_nft(nftuid := "", data := {}) -> Dictionary:
	var sig := duplicate_nft_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif nftuid.length() == 0 or data.size() == 0:
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := _base_url + "/v2/DuplicateNft/" + nftuid
		_request(url, sig, data)
	
	await sig
	return result


## You will receive all information (fingerprint, ipfshash, etc.) about one nfts with the submitted id
func get_nft_details_by_id(nftuid := "") -> Dictionary:
	var sig := get_nft_details_by_id_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif nftuid == "":
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := _base_url + "/v2/GetNftDetailsById/" + nftuid
		_request(url, sig)
	
	await sig
	return result


## You will receive all information (fingerprint, ipfshash, etc.) about one nft with the submitted name
func get_nft_details_by_tokenname(projectuid := "", nftname := "") -> Dictionary:
	var sig := get_nft_details_by_tokenname_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif projectuid.length() == 0 or nftname == "":
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := _base_url + "/v2/GetNftDetailsByTokenname/" + projectuid + "/" + nftname
		_request(url, sig)
	
	await sig
	return result


## You will receive all information (fingerprint, ipfshash, etc.) about the nfts within a specific state. State "all" lists all available nft in this project. The other states are: "free", "reserved", "sold" and "error"
func get_nfts(projectuid := "", state := "", count: int = 0, page: int = -1, optional := {}) -> Array:
	var sig := get_nfts_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif projectuid.length() == 0 or state.length() == 0 or count <= 0 or page < 0:
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := _base_url + "/v2/GetNfts/" + projectuid + "/" + state + "/" + str(count) + "/" + str(page)
		_request(url if optional.size() == 0 else _get_valid_url(url, optional), sig)
	
	await sig
	return result if result is Array else [ result ]


## With this API you can update the Metadata Override for one specific NFT If you leave the field blank, the Metadata override will be deleted and the Metadata from the project will be used.
func update_metadata(projectuid := "", nftuid := "", data := {}) -> Dictionary:
	var sig := update_metadata_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif projectuid.length() == 0 or nftuid == "":
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := _base_url + "/v2/UpdateMetadata/" + projectuid + "/" + nftuid
		_request(url, sig, data)
	
	await sig
	return result


## With this API you can upload a file to IPFS and add it to a project. You can upload the file as BASE64 Content or as URL Link or as IPFS Hash. If you submit Metadata, this Metadata will be used instead of the Metadatatemplate from the project. You can either submit Metadata or MetadataPlaceholder, but not both (because it makes no sense). The Metadata field is optional and if you dont use it, it will use the Template from your project. It is poosible to mix both versions in one project. You can have one nft with own metadata and other nfts with the template.
func upload_nft(projectuid := "", data := {}, optional := {}) -> Dictionary:
	var sig := upload_nft_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif projectuid.length() == 0 or data.size() == 0:
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := _base_url + "/v2/UploadNft/" + projectuid
		_request(url if optional.size() == 0 else _get_valid_url(url, optional), sig, data)
	
	await sig
	return result


# Address reservation (sale)

## When you call this API, the reservation of all nfts dedicated to this address will released to free state. This function can be called, when a user closes his browser or when he hit on a "Cancel Reservation" Button
func cancel_address_reservation(projectuid := "", paymentaddress := "") -> Dictionary:
	var sig := cancel_address_reservation_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif projectuid.length() == 0 or paymentaddress == "":
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := _base_url + "/v2/CancelAddressReservation/" + projectuid + "/" + paymentaddress
		_request(url, sig)
	
	await sig
	return result


## You can call this api to check if a user has paid to this particular address or if the address has expired. The reserved/sold NFTs will only filled after the amount was fully paid. This is for security reasons. In the reserved state, only the nft ids and tokenamount are submitted.[br]
## IMPORTANT: This function uses an internal cache. All results will be cached for 10 seconds. You do not need to call this function more than once in 10 seconds, because the results will be the same.
func check_address(projectuid := "", address := "") -> Dictionary:
	var sig := check_address_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif projectuid.length() == 0 or address == "":
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := _base_url + "/v2/CheckAddress/" + projectuid + "/" + address
		_request(url, sig)
	
	await sig
	return result


## You can call this api to check if a user has paid to a particular address with a custom property or if the address has expired. The reserved/sold NFTs will only filled after the amount was fully paid. This is for security reasons. In the reserved state, only the nft ids and tokenamount are submitted.[br]
## IMPORTANT: This function uses an internal cache. All results will be cached for 10 seconds. You do not need to call this function more than once in 10 seconds, because the results will be the same.
func check_address_with_customproperty(projectuid := "", customproperty := "") -> Dictionary:
	var sig := check_address_with_customproperty_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif projectuid.length() == 0 or customproperty == "":
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := _base_url + "/v2/CheckAddressWithCustomproperty/" + projectuid + "/" + customproperty
		_request(url, sig)
	
	await sig
	return result


## When you call this API, you will receive an address where the buyer has to pay the amount of ada you define. The address will be monitored until it exipred. The count of nft will be reserved until it expires or the buyer has send the ada to this address. If the buyer has send the amount of ada, the nfts will be minted and send to his senderaddress and the nfts state changes to sold.[br]
## IMPORTANT: Please notice, that the call is limited to 300 addressreservations per minute. You will get the error 429 if you call this routine more than 300 times a minute. Please do not implement this function on your start page. And please prevent the call of this function from bots with a captcha.
func get_payment_address_for_random_nft_sale(projectuid := "", countnft: int = 1, lovelace: int = -1, optional := {}) -> Dictionary:
	var sig := get_payment_address_for_random_nft_sale_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif projectuid.length() == 0 or countnft < 1:
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := _base_url + "/v2/GetPaymentAddressForRandomNftSale/" + projectuid + "/" + str(countnft)
		if lovelace >= 0:
			url += "/" + str(lovelace)
		
		_request(url if optional.size() == 0 else _get_valid_url(url, optional), sig)
	
	await sig
	return result


## When you call this API, you will receive an address where the buyer has to pay the amount of ada you define. The address will be monitored until it exipred. The count of nft will be reserved until it expires or the buyer has send the ada to this address. If the buyer has send the amount of ada, the nfts will be minted and send to his senderaddress and the nfts state changes to sold.[br]
## Keep the first 3 parameters to the defaults for using the POST version of the endpoint, and set "data" accordingly
func get_payment_address_for_specific_nft_sale(nftuid := "", tokencount: int = 0, lovelace: int = -1, data := {}, optional := {}) -> Dictionary:
	var sig := get_payment_address_for_specific_nft_sale_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif (data.size() == 0 and (nftuid.length() == 0 or tokencount < 1)) \
	or (data.size() > 0 and (nftuid.length() > 0 or tokencount > 0 or lovelace >= 0)):
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := _base_url + "/v2/GetPaymentAddressForSpecificNftSale"
		if (data.size() > 0):
			_request(url if optional.size() == 0 else _get_valid_url(url, optional), sig, data)
		else:
			url += "/" + nftuid + "/" + str(tokencount)
			if lovelace >= 0:
				url += "/" + str(lovelace)
			_request(url if optional.size() == 0 else _get_valid_url(url, optional), sig)
	
	await sig
	return result


# Tools

## Check if there applies a discount for an address
func check_if_eligible_for_discount(projectuid := "", address := "", optional := {}) -> Dictionary:
	var sig := check_if_eligible_for_discount_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif projectuid.length() == 0 or address == "":
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := _base_url + "/v2/CheckIfEligibleForDiscount/" + projectuid + "/" + address
		_request(url if optional.size() == 0 else _get_valid_url(url, optional), sig)
	
	await sig
	return result


## Checks, if an address matches the sale conditions
func check_if_sale_conditions_met(projectuid := "", address := "", countnft: int = 0) -> Dictionary:
	var sig := check_if_sale_contidions_met_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif projectuid.length() == 0 or address.length() == 0 or countnft == 0:
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := _base_url + "/v2/CheckIfSaleCondtionsMet/" + projectuid + "/" + address + "/" + str(countnft)
		_request(url, sig)
	
	await sig
	return result


## Returns the utxo of an address
func check_utxo(address := "") -> Dictionary:
	var sig := check_utxo_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif address == "":
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := _base_url + "/v2/CheckUtxo/" + address
		_request(url, sig)
	
	await sig
	return result


## No description
func get_active_directsale_listings(stakeaddress := "") -> Dictionary:
	var sig := get_active_directsale_listings_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif stakeaddress == "":
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := _base_url + "/v2/GetActiveDirectsaleListings/" + stakeaddress
		_request(url, sig)
	
	await sig
	return result


## Returns the actual price in EUR and USD for ADA
func get_ada_rates() -> Dictionary:
	var sig := get_ada_rates_completed
	
	if current_key < 0:
		_trigger_error(sig)
	else:
		var url := _base_url + "/v2/GetAdaRates"
		_request(url, sig)
	
	await sig
	return result


## Returns all assets that are in a wallet
func get_all_assets_in_wallet(address := "") -> Array:
	var sig := get_all_asstes_in_wallet_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif address == "":
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := _base_url + "/v2/GetAllAssetsInWallet/" + address
		_request(url, sig)
	
	await sig
	return result if result is Array else [ result ]


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
		var url := _base_url + "/v2/GetAmountOfSpecificTokenInWallet/"
		
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
		var url := _base_url + "/v2/GetCardanoTokenRegistryInformation/" + policyid + "/" + tokenname
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
		var url := _base_url + "/v2/GetMetadataForToken/" + policyid + "/" + tokennamehex
		_request(url, sig)
	
	await sig
	return result


## You will receive all tokens and the holding addresses of a specific policyid
func get_policy_snapshot(policyid := "", optional := {}) -> Dictionary:
	var sig := get_policy_snapshot_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif policyid == "":
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := _base_url + "/v2/GetPolicySnapshot/" + policyid 
		_request(url if optional.size() == 0 else _get_valid_url(url, optional), sig)
	
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
		var url := _base_url + "/v2/GetPreviewImageForToken/" + policyid + "/" + tokennamehex
		_request(url, sig)
	
	await sig
	return result


## Returns the actual price in EUR and USD for ADA, APT, SOL, ETH, etc.
func get_rates(coin := "ADA") -> Dictionary:
	var sig := get_rates_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif coin == "":
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := _base_url + "/v2/GetRates?coin=" + coin
		_request(url, sig)
	
	await sig
	return result


## You will receive the rate in percent and the wallet address for the royalties (if applicable) of a specific policyid
func get_royalty_information(policyid := "") -> Dictionary:
	var sig := get_royalty_information_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif policyid == "":
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := _base_url + "/v2/GetRoyaltyInformation/" + policyid
		_request(url, sig)
	
	await sig
	return result


## Returns the actual price in EUR and USD for analOS
func get_solana_rates() -> Dictionary:
	var sig := get_solana_rates_completed
	
	if current_key < 0:
		_trigger_error(sig)
	else:
		var url := _base_url + "/v2/GetSolanaRates"
		_request(url, sig)
	
	await sig
	return result


# Wallet validation

## Here you can check the result of a wallet validation. The result are "notvalidated", "validated", "expired"
func check_wallet_validation(validationuid := "") -> Dictionary:
	var sig := check_wallet_validation_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif validationuid == "":
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := _base_url + "/v2/CheckWalletValidation/" + validationuid
		_request(url, sig)
	
	await sig
	return result


## When you call this API, you will receive an address for a wallet validation. The user can send any ada to this address and the ada (and tokens) will sent back to the sender. With the function CheckWalletValidation you can check the state of the address
func get_wallet_validation_address(validationname := "") -> Dictionary:
	var sig := get_wallet_validation_address_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	else:
		var url := _base_url + "/v2/GetWalletValidationAddress"
		
		if validationname != "":
			url += "/" + validationname
		
		_request(url, sig)
	
	await sig
	return result


# Auctions

## Creates a new legacy auction in the Cardano network
func create_auction(customerid := "", data := {}) -> Dictionary:
	var sig := create_auction_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif customerid == "" or data.size == 0:
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := _base_url + "/v2/CreateAuction/" + customerid
		_request(url, sig, data)
	
	await sig
	return result


## Deletes an auction - if the auction is not already started
func delete_auction(auctionuid := "") -> Dictionary:
	var sig := delete_auction_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif auctionuid == "":
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := _base_url + "/v2/DeleteAuction/" + auctionuid
		_request(url, sig)
	
	await sig
	return result


## Returns all auctions of the customer
func get_all_auctions(customerid := "") -> Array:
	var sig := create_auction_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif customerid == "":
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := _base_url + "/v2/GetAllAuctions/" + customerid
		_request(url, sig)
	
	await sig
	return result if result is Array else [ result ]


## Returns the state - and the last bids of a auction project
func get_auction_state(auctionuid := "") -> Dictionary:
	var sig := get_auction_state_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif auctionuid == "":
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := _base_url + "/v2/GetAuctionState/" + auctionuid
		_request(url, sig)
	
	await sig
	return result


# Projects

## When you call this endpoint, a Burning Address is created for this project. All NFTs associated with this project (same policyid) that are sent to this endpoint will be deleted (burned). All other NFTs will be sent back. The policy of the project must still be active.If it is already locked, it can no longer be deleted.
func create_burning_address(projectuid := "", addressactiveinhours := "") -> Dictionary:
	var sig := create_burning_address_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif projectuid.length() == 0 or addressactiveinhours == "":
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := _base_url + "/v2/CreateBurningAddress/" + projectuid + "/" + addressactiveinhours
		_request(url, sig)
	
	await sig
	return result


## With this Controller you can create a new project
func create_project(data := {}) -> Dictionary:
	var sig := create_project_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif data.size() == 0 or not data.has("projectname"):
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := _base_url + "/v2/CreateProject"
		_request(url, sig, data)
	
	await sig
	return result


## With this call you can delete a project
func delete_project(projectuid := "") -> Dictionary:
	var sig := delete_project_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif projectuid == "":
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := _base_url + "/v2/DeleteProject/" + projectuid
		_request(url, sig)
	
	await sig
	return result


## You will get the count of all sold, reserved and free nfts of a particular project
func get_counts(projectuid := "") -> Dictionary:
	var sig := get_counts_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif projectuid == "":
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := _base_url + "/v2/GetCounts/" + projectuid
		_request(url, sig)
	
	await sig
	return result


## If you call this function, you will get all active discounts for this project
func get_discounts(projectuid := "") -> Array:
	var sig := get_discounts_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif projectuid == "":
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := _base_url + "/v2/GetDiscounts/" + projectuid
		_request(url, sig)
	
	await sig
	return result if result is Array else [ result ]


## Returns information about the identities (if the identity token was created) of a project
func get_identity_accounts(policyid := "") -> Dictionary:
	var sig := get_identity_accounts_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif policyid == "":
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := _base_url + "/v2/GetIdentityAccounts/" + policyid
		_request(url, sig)
	
	await sig
	return result


## Returns the notifications for this project (project uid)
func get_notifications(projectuid := "") -> Array:
	var sig := get_notifications_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif projectuid == "":
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := _base_url + "/v2/GetNotifications/" + projectuid
		_request(url, sig)
	
	await sig
	return result if result is Array else [ result ]


## You will get the predefined prices for one or more NFTs
func get_pricelist(projectuid := "") -> Dictionary:
	var sig := get_pricelist_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif projectuid == "":
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := _base_url + "/v2/Pricelist/" + projectuid
		_request(url, sig)
	
	await sig
	return result


## You will receive all information about this project
func get_project_details(projectuid := "") -> Dictionary:
	var sig := get_project_details_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif projectuid == "":
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := _base_url + "/v2/GetProjectDetails/" + projectuid
		_request(url, sig)
	
	await sig
	return result


## Returns all Transactions of a project
func get_project_transactions(projectuid := "", optional := {}) -> Array:
	var sig := get_project_transactions_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif projectuid == "":
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := _base_url + "/v2/GetProjectTransactions/" + projectuid 
		_request(url if optional.size() == 0 else _get_valid_url(url, optional), sig)
	
	await sig
	return result if result is Array else [ result ]


## Returns all refunds of a project
func get_refunds(projectuid := "", optional := {}) -> Array:
	var sig := get_refunds_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif projectuid == "":
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := _base_url + "/v2/GetRefunds/" + projectuid 
		_request(url if optional.size() == 0 else _get_valid_url(url, optional), sig)
	
	await sig
	return result if result is Array else [ result ]


## If you call this funtion, you will get all active saleconditions for this project
func get_sale_conditions(projectuid := "") -> Array:
	var sig := get_sale_conditions_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif projectuid == "":
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := _base_url + "/v2/GetSaleConditions/" + projectuid
		_request(url, sig)
	
	await sig
	return result if result is Array else [ result ]


## You will receive a list with all of your projects.[br]
## IMPORTANT: This function uses an internal cache. All results will be cached for 10 seconds. You do not need to call this function more than once in 10 seconds, because the results will be the same.
func list_projects(count: int = 0, page: int = 0, optional := {}) -> Array:
	var sig := list_projects_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif count < 0 or page < 0:
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := _base_url + "/v2/ListProjects"
		if count > 0 and page >= 0:
			url += "/" + str(count) + "/" + str(page)
		_request(url if optional.size() == 0 else _get_valid_url(url, optional), sig)
	
	await sig
	return result if result is Array else [ result ]


## With this Controller you can update the discounts of a project. All old entries will be deleted. If you want to clear the discounts, just send an empty array
func update_discounts(projectuid := "", data := {}) -> Dictionary:
	var sig := update_discounts_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif projectuid.length() == 0 or data.size() == 0:
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := _base_url + "/v2/UpdateDiscounts/" + projectuid
		_request(url, sig, data, HTTPClient.METHOD_PUT)
	
	await sig
	return result


## With this Controller you can update the notifications. All old entries will be deleted. If you want to clear the notifications, just send an empty array
func update_notifications(projectuid := "", data: Array = []) -> Dictionary:
	var sig := update_notifications_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif projectuid.length() == 0 or data.size() == 0:
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := _base_url + "/v2/UpdateNotifications/" + projectuid
		_request(url, sig, data)
	
	await sig
	return result


## With this Controller you can update a pricelist of a project. All old entries will be deleted. If you want to clear the pricelist, just send an empty array
func update_pricelist(projectuid := "", data := {}) -> Dictionary:
	var sig := update_pricelist_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif projectuid.length() == 0 or data.size() == 0:
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := _base_url + "/v2/UpdateDiscounts/" + projectuid
		_request(url, sig, data, HTTPClient.METHOD_PUT)
	
	await sig
	return result


## With this Controller you can update the saleconditions of a project. All old entries will be deleted. If you want to clear the saleconditions, just send an empty array
func update_sale_conditions(projectuid := "", data: Array = []) -> Dictionary:
	var sig := update_sale_conditions_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif projectuid.length() == 0 or data.size() == 0:
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := _base_url + "/v2/UpdateSaleConditions/" + projectuid
		_request(url, sig, data, HTTPClient.METHOD_PUT)
	
	await sig
	return result


# Split Addresses

## Creates a split address
func create_split_address(customerid: int = 0, data := {}) -> Dictionary:
	var sig := create_split_address_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif customerid == 0 or data.size() == 0:
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := _base_url + "/v2/CreateSplitAddress/" + str(customerid)
		_request(url, sig, data)
	
	await sig
	return result


## Returns all split addresses from a customer account
func get_split_addresses(customerid: int = 0) -> Array:
	var sig := get_split_addresses_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif customerid == 0:
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := _base_url + "/v2/GetSplitAddresses/" + str(customerid)
		_request(url, sig)
	
	await sig
	return result if result is Array else [ result ]


## Updates a split address
func update_split_address(customerid: int = 0, address := "", data := {}) -> Dictionary:
	var sig := update_split_address_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif customerid == 0 or address == "" or data.size() == 0:
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := _base_url + "/v2/UpdateSplitAddress/" + str(customerid) + "/" + address
		_request(url, sig, data, HTTPClient.METHOD_PUT)
	
	await sig
	return result


# Vesting Addresses

## Creates a vesting/staking address. Assets can be locked on a vesting address for a certain period of time.
func create_vesting_address(customerid: int = 0, data := {}) -> Dictionary:
	var sig := create_vesting_address_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif customerid == 0 or data.size() == 0:
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := _base_url + "/v2/CreateSplitAddress/" + str(customerid)
		_request(url, sig, data)
	
	await sig
	return result


## Returns all vesting addresses from a customer account
func get_utxo_from_vesting_address(customerid: int = 0, address := "") -> Dictionary:
	var sig := get_utxo_from_vesting_address_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif customerid == 0 or address == "":
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := _base_url + "/v2/GetUtxoFromVestingAddress/" + str(customerid) + "/" + address
		_request(url, sig)
	
	await sig
	return result


## Returns all vesting addresses from a customer account
func get_vesting_addresses(customerid: int = 0) -> Array:
	var sig := get_vesting_addresses_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif customerid == 0:
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := _base_url + "/v2/GetVestingAddresses/" + str(customerid)
		_request(url, sig)
	
	await sig
	return result if result is Array else [ result ]


# Managed Wallets

## Creates an Managed Wallet
func create_wallet(customerid: int = 0, data := {}) -> Dictionary:
	var sig := create_wallet_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif customerid == 0 or data.size() == 0:
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := _base_url + "/v2/CreateWallet/" + str(customerid)
		_request(url, sig, data)
	
	await sig
	return result


## Returns the key hash of a Managed Wallet
func get_key_hash(customerid: int = 0, data := {}) -> Dictionary:
	var sig := get_key_hash_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif customerid == 0 or data.size() == 0:
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := _base_url + "/v2/GetKeyHash/" + str(customerid)
		_request(url, sig, data)
	
	await sig
	return result


## Returns the utxo of a managed Wallet
func get_wallet_utxo(address := "") -> Dictionary:
	var sig := get_wallet_utxo_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif address == "":
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := _base_url + "/v2/GetWalletUtxo/" + address
		_request(url, sig)
	
	await sig
	return result


## Imports an Wallet
func import_wallet(customerid: int = 0, data := {}) -> Dictionary:
	var sig := import_wallet_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif customerid == 0 or data.size() == 0:
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := _base_url + "/v2/ImportWallet/" + str(customerid)
		_request(url, sig, data)
	
	await sig
	return result


## Lists all managed Wallets
func list_all_wallets(customerid: int = 0) -> Array:
	var sig := list_all_wallets_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif customerid == 0:
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := _base_url + "/v2/ListAllWallets/" + str(customerid)
		_request(url, sig)
	
	await sig
	return result if result is Array else [ result ]


## Makes a transaction on a managed Wallet
func make_transaction(customerid: int = 0, data := {}) -> Dictionary:
	var sig := make_transaction_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif customerid == 0 or data.size() == 0:
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := _base_url + "/v2/MakeTransaction/" + str(customerid)
		_request(url, sig, data)
	
	await sig
	return result


## Send all ADA and all Tokens from a managed wallet to a receiver address
func send_all_assets(customerid: int = 0, data := {}) -> Dictionary:
	var sig := send_all_assets_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif customerid == 0 or data.size() == 0:
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := _base_url + "/v2/SendAllAssets/" + str(customerid)
		_request(url, sig, data)
	
	await sig
	return result


# NMKR Pay

## Returns a payment link for NMKR Pay
func get_nmkr_pay_link(data := {}) -> Dictionary:
	var sig := get_nmkr_pay_link_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif data.size() == 0 or not data.has("projectUid"):
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := _base_url + "/v2/GetNmkrPayLink"
		_request(url, sig, data)
	
	await sig
	return result


## Returns the state of a payment link for NMKR Pay
func get_nmkr_pay_status(paymenttransactionuid := "") -> Dictionary:
	var sig := get_nmkr_pay_status_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif paymenttransactionuid == "":
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := _base_url + "/v2/GetNmkrPayStatus/" + paymenttransactionuid
		_request(url, sig)
	
	await sig
	return result


# Misc

func get_public_mints() -> Dictionary:
	var sig := get_public_mints_completed
	
	if current_key < 0:
		_trigger_error(sig)
	else:
		var url := _base_url + "/v2/GetPublicMints"
		_request(url, sig)
	
	await sig
	return result


func get_server_state() -> Array:
	var sig := get_server_state_completed
	
	if current_key < 0:
		_trigger_error(sig)
	else:
		var url := _base_url + "/v2/GetServerState"
		_request(url, sig)
	
	await sig
	return result if result is Array else [ result ]


# Whitelists

## Manages of a project whitelist. Set only projectuid to get (GET), projectuid + address
## to delete (DELETE), projectuid + address + countofnfts to add (POST)
func manage_whitelist(projectuid := "", address := "", countofnfts:int = 0, data := {}) -> Dictionary:
	var sig := manage_whitelist_completed
	
	var url := _base_url + "/v2/ManageWhitelist/" + projectuid
	var method: int = -1
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	else:
		if projectuid != "" and address != "" and countofnfts > 0 and data.size() > 0:
			method = HTTPClient.METHOD_POST
		elif projectuid != "" and address != "" and countofnfts == 0 and data.size == 0:
			method = HTTPClient.METHOD_DELETE
		elif projectuid != "" and address == "" and countofnfts == 0 and data.size() == 0:
			method = HTTPClient.METHOD_GET
		else:
			_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	
	match method:
		HTTPClient.METHOD_DELETE:
			url += "/" + address
		HTTPClient.METHOD_POST:
			url += "/" + address + "/" + str(countofnfts)
	
	if method >= 0:
		_request(url, sig, {}, method)
	
	await sig
	return result


# Mint

## When you call this API, random NFTs will be selected, minted and send to an ada address. You will need ADA in your Account for the transaction and minting costs.
func mint_and_send_random(projectuid := "", countnft: int = 0, receiveraddress := "") -> Dictionary:
	var sig := mint_and_send_random_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif projectuid == "" or countnft == 0 or receiveraddress == "":
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := _base_url + "/v2/MintAndSendRandom/" + projectuid + "/" + str(countnft) + "/" + receiveraddress
		_request(url, sig)
	
	await sig
	return result


## When you call this API, a specific NFT will be minted and send to an ada address. You will need ADA in your Account for the transaction and minting costs.
func mint_and_send_specific(projectuid := "", nftuid := "", tokencount: int = 0, receiveraddress := "") -> Dictionary:
	var sig := mint_and_send_specific_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif projectuid == "" or nftuid == "" or tokencount == 0 or receiveraddress == "":
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := _base_url + "/v2/MintAndSendSpecific/" + projectuid + "/" + nftuid + "/" + str(tokencount) + "/" + receiveraddress
		_request(url, sig)
	
	await sig
	return result


## When you call this API, the royalty token for this project will be minted and send to a burning address. You have to specify the address for the royalties and the percentage of royalties. You need mint credits in your account. Only one royalty token can be minted for each project
func mint_royalty_token(projectuid := "", royaltyaddress := "", percentage: float = 0) -> Dictionary:
	var sig := mint_royalty_token_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif projectuid == "" or royaltyaddress == "" or percentage < 0 or percentage > 100:
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := _base_url + "/v2/MintRoyaltyToken/" + projectuid + "/" + royaltyaddress + "/" + str(percentage)
		_request(url, sig)
	
	await sig
	return result


## When you call this API, you can update metadata of an already sold nft. The nft will be minted and send to a burning address
func remint_and_burn(projectuid := "", nftuid := "") -> Dictionary:
	var sig := remint_and_burn_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif projectuid == "" or nftuid == "":
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := _base_url + "/v2/RemintAndBurn/" + projectuid + "/" + nftuid
		_request(url, sig)
	
	await sig
	return result


# IPFS

## With this API you can upload a file to IPFS. You can upload the file as BASE64 Content or as URL Link.
func upload_to_ipfs(customerid: int = 0, data := {}) -> Dictionary:
	var sig := upload_to_ipfs_completed
	
	if current_key < 0:
		_trigger_error(sig, SdkError.INVALID_KEY)
	elif customerid == 0 or data.size() == 0:
		_trigger_error(sig, SdkError.INVALID_PARAMETERS)
	else:
		var url := _base_url + "/v2/UploadToIpfs/" + str(customerid)
		_request(url, sig, data)
	
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
func _request(url: String, sig: Signal, data = {}, method := HTTPClient.METHOD_GET):
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
		if text.length() == 0:
			text = "{\"completed\": true}"
		Engine.print_error_messages = false
		_result = JSON.parse_string(text)
		Engine.print_error_messages = true
		
		_result = _result if _result != null else text
	else:
		_result = {
			"error": true,
			"res": res,
			"code": code,
			"body": text,
		}
		error.emit(_result)
		
		if _debug:
			push_warning(_result)
	
	sig.emit(_result)
	completed.emit(_result)
