# NmkrGodot
A Godot plugin for accessing the NMKR Studio API


Please check our [https://cardano.ideascale.com/c/idea/119196](Catalyst Proposal) for more details.


The **NMKR SDK for Godot** addresses the need for seamless integration of Cardano's NFT
capabilities in the gaming industry, particularly targeting indie game developers using Godot.

By developing a Godot plugin for NMKR's NFT minting API, we facilitate easier Cardano adoption,
potentially increasing both the number of NFTs minted and the transactions within the Cardano
network. With this tool, we aim to attract new developers and users to the Cardano ecosystem,
broadening its user base, while facilitating the implementation of NFT technology for the game
developers who are adopting different revenue models.

Before using this plugin in your projects, **you need to have at least an API Key** configured
in the [NMKR Studio console](https://studio.nmkr.io/apikeys). Copy your key, then open
the *Project Settings* and search for **Nmkr** (you may need to activate the
*Advanced Settings* toggle for it to show up). Click on *Config* and add your key(s)
in the input field(s).

##Code Examples
Each available method will emit a signal as soon as the request is completed. You can either
*await* the corresponding signal for synchronous requests or connect a callback function
to it. If you only need to perform consequential synchronous requests, you can also wait for the
generic *completed* signal instead of having to specify a specific one after each call.

Example with *coroutines*:

```
@onready var nmkr: Nmkr = $NMKR

func _ready():
	await nmkr.get_ada_rates()
	print(nmkr.result)
```

Example with *await on signal*:

```
@onready var nmkr: Nmkr = $NMKR

func _ready():
	nmkr.get_ada_rates()
	await nmkr.get_ada_rates_completed # or just "await nmkr.completed"
	print(nmkr.result)
```

Example with a *callback* function:

```
@onready var nmkr: Nmkr = $NMKR

func _ready():
	nmkr.get_ada_rates_completed.connect(_on_get_ada_rates_completed)
	nmkr.get_ada_rates()

func _on_get_ada_rates_completed(result: Dictionary):
	print(result)
```


##Conventions used in the NMKR SDK for Godot
The *NMKR custom node* is a GDScript class that exposes both a public *method* and a
*custom signal* for each of the available endpoints in the **NMKR API**, as documented
in the [NMKR Swagger](https://studio-api.nmkr.io/swagger/index.html).

Each endpoint corresponds to a method that has the same name, but is written using
*snake_case* without the leading version number, and will emit two signals on completion:
*completed*, and another one with the same name plus the *_completed* suffix. See the
example above for more details.

Each required parameter, as mentioned in the
[NMKR Swagger](https://studio-api.nmkr.io/swagger/index.html), is expected to be provided
to the functions with the same name. For example, if you want to access the

```
/v2/AddPayoutWallet/{walletaddress}
```
endpoint, you will use the following function:

```
func add_payout_wallet(walletaddress)
```


##Passing data to POST and PUT requests
To pass the required data to the endpoints that are accessible with the POST or PUT methods, you
can simply define a *Dictionary* with the necessary key/value pairs, and pass it to the
desired function after the other required parameters. The name of this parameter is always
"data" for all the available functions that use POST or PUT methods. Example:

```
check_metadata(nftuid, { "metadata": "string" })
```


##Optional parameters
Some of the endpoints accept optional parameters. In that case, when needed, you can define a
*Dictionary* with all the optional parameters that you need, and pass it to the desired
function after all the required ones. The name of this parameter is always "optional" for all the
available functions that allow specifying optional parameters. Example:

```
get_customer_transaction(customerid, { "exportOptions": "Csv" })
```



##Implemented functions
Please refer to the offical [NMKR Swagger](https://studio-api.nmkr.io/swagger/index.html) for more
details about the available endpoints.
Each function will return a *Dictionary* when used as a coroutine.

###Customer
- func add_payout_wallet(walletaddress := "")
- func get_customer_transactions(customerid: int = 0, optional := {})
- func get_mint_coupon_balance()
- func get_payout_wallets()

###Tools
- func get_ada_rates()
- func get_all_assets_in_wallet(address := "")
- func get_amount_of_specific_token_in_wallet(address := "", policyid := "", tokenname := "", data := {})
- func get_cardano_token_registry_information(policyid := "", tokenname := "")
- func get_metadata_for_token(policyid := "", tokennamehex := "")
- func get_preview_image_for_token(policyid := "", tokennamehex := "")
