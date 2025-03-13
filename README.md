# NmkrGodot
A Godot plugin for accessing the NMKR Studio API


Please check our [Catalyst Proposal](https://cardano.ideascale.com/c/idea/119196) for more details.


The **NMKR SDK for Godot** addresses the need for seamless integration of NFTs and other blockchain
capabilities in the gaming industry, particularly targeting indie game developers using Godot.

By developing a Godot plugin for NMKR's API, we facilitate easier Web3 adoption, potentially
increasing both the number of NFTs minted and the transactions within the Cardano network, with
other blockchains being on the NMKR roadmap, starting with Solana.

With this tool, we aim to attract new developers and users to the blockchain ecosystem,
broadening its user base, while facilitating the implementation of NFT technology for the game
developers who are adopting different revenue models.


## Setup instructions
- Copy the *addons* directory and its content (*addons/nmkr*) to the root of your project
- Before using this plugin in your projects, **you need to have at least an API Key** configured
in the [NMKR Studio console](https://studio.nmkr.io/apikeys)
- Copy your key, then open the *Project Settings* and search for **Nmkr** (you may need to activate
the *Advanced Settings* toggle for it to show up)
- Click on *Config* and add your key(s) in the input field(s).

You can find a video that covers the initial setup instructions here:
	[Milestone 1 Proof of Achievement](https://youtu.be/zYt-qpAeA-0)


## YASG (Yet Another Snake Game) - the official example project
While you can find a couple of basic scenes to show how to use the *NMKR SDK for Godot* plugin in
your projects under the "examples" directory, we built a simple but complete game to provide a more
comprensive scenario that showcases how to implement the most common Web3-related tasks, like:
	- Create new NFTs
	- Mint NFTs and deliver them to the user's wallet
	- Verify users' wallet
	- Reading the users' wallet to find the required content
	- Use any FT or NFT as game assets
	- Use the metadata attached to any NFT for changing game features

YASG, like the plugin itself, is a fully open-source project released under the MIT license,
and available on GitHub at the following address:
	[YASG](https://github.com/Odiobill/YASG)


## Code Examples
Each available method will emit a signal as soon as the request is completed. You can either
*await* the corresponding signal or *await* directly on the function call for synchronous requests,
or connect a callback function to it if you prefer async requests.
If you only need to perform consequential synchronous requests, you can also wait for the
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


## Conventions used in the NMKR SDK for Godot
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
add_payout_wallet(walletaddress)
```


## Passing data to POST and PUT requests
To pass the required data to the endpoints that are accessible with the POST or PUT methods, you
can simply define a *Dictionary* with the necessary key/value pairs, and pass it to the
desired function after the other required parameters. The name of this parameter is always
"data" for all the available functions that use POST or PUT methods. Example:

```
check_metadata(nftuid, { "metadata": "string" })
```


## Optional parameters
Some of the endpoints accept optional parameters. In that case, when needed, you can define a
*Dictionary* with all the optional parameters that you need, and pass it to the desired
function after all the required ones. The name of this parameter is always "optional" for all the
available functions that allow specifying optional parameters. Example:

```
get_customer_transactions(customerid, { "exportOptions": "Csv" })
```



## Implemented functions
Please refer to the offical [NMKR Swagger](https://studio-api.nmkr.io/swagger/index.html) for more
details about the available endpoints.
Most of the functions will return a *Dictionary* when used as a coroutine, some of them an
Array (ex. get_customer_transactions, get_nfts, etc).

### Customer
- func add_payout_wallet(walletaddress := "")
- func get_customer_transactions(customerid: int = 0, optional := {})
- func get_mint_coupon_balance()
- func get_payout_wallets()

### Tools
- func get_ada_rates()
- func get_all_assets_in_wallet(address := "")
- func get_amount_of_specific_token_in_wallet(address := "", policyid := "", tokenname := "", data := {})
- func get_cardano_token_registry_information(policyid := "", tokenname := "")
- func get_metadata_for_token(policyid := "", tokennamehex := "")
- func get_preview_image_for_token(policyid := "", tokennamehex := "")

### NFT
- func block_unblock_nft(nftuid := "", block_nft := true)
- func check_metadata(nftuid := "", data := {})
- func delete_all_nfts_from_project(projectuid := "")
- func delete_nft(nftuid := "")
- func duplicate_nft(nftuid := "", data := {})
- func get_nft_details_by_id(nftuid := "")
- func get_nft_details_by_tokenname(projectuid := "", nftname := "")
- func get_nfts(projectuid := "", state := "", count: int = 0, page: int = -1, optional := {})
- func update_metadata(projectuid := "", nftuid := "", data := {})
- func upload_nft(projectuid := "", data := {}, optional := {})

### Address reservation (sale)
- func cancel_address_reservation(projectuid := "", paymentaddress := "")
- func check_address(projectuid := "", address := "")
- func check_address_with_customproperty(projectuid := "", customproperty := "")
- func get_payment_address_for_random_nft_sale(projectuid := "", countnft: int = 1, lovelace: int = -1, optional := {})
- func get_payment_address_for_specific_nft_sale(nftuid := "", tokencount: int = 0, lovelace: int = -1, data := {}, optional := {})

### Wallet validation
- func check_wallet_validation(validationuid := "")
- func get_wallet_validation_address(validationname := "")

### Auctions
- func create_auction(customerid := "", data := {})
- func delete_auction(auctionuid := "")
- func get_all_auctions(customerid := "")
- func get_auction_state(auctionuid := "")

### Projects
- func create_burning_address(projectuid := "", addressactiveinhours := "")
- func create_project(data := {})
- func delete_project(projectuid := "")
- func get_counts(projectuid := "")
- func get_discounts(projectuid := "")
- func get_identity_accounts(projectuid := "")
- func get_notifications(projectuid := "")
- func get_pricelist(projectuid := "")
- func get_project_details(projectuid := "")
- func get_project_transactions(projectuid := "", optional := {})
- func get_refunds(projectuid := "", optional := {})
- func get_sale_conditions(projectuid := "")
- func list_projects(count: int = 0, page: int = 0, optional := {})
- func update_discounts(projectuid := "", data := {})
- func update_notifications(projectuid := "", data := {})
- func update_pricelist(projectuid := "", data := {})
- func update_sale_conditions(projectuid := "", data := {})

### Split Addresses
- func create_split_address(customerid: int = 0, data := {})
- func get_split_addresses(customerid: int = 0)
- func update_split_address(customerid: int = 0, address := "", data := {})

### Vesting Addresses
- func create_vesting_address(customerid: int = 0, data := {})
- func get_utxo_from_vesting_address(customerid: int = 0, address := "")
- func get_vesting_addresses(customerid: int = 0)

### Managed Wallets
- func create_wallet(customerid: int = 0, data := {})
- func get_key_hash(customerid: int = 0, data := {})
- func get_wallet_utxo(address := "")
- func import_wallet(customerid: int = 0, data := {})
- func list_all_wallets(customerid: int = 0)
- func make_transaction(customerid: int = 0, data := {})
- func send_all_assets(customerid: int = 0, data := {})

### NMKR Pay
- func get_nmkr_pay_link(data := {})
- func get_nmkr_pay_status(paymenttransactionuid := "")

### Misc
- func get_public_mints()
- func get_server_state()

### Whitelists
- func manage_whitelist(projectuid := "", address := "", countofnfts:int = 0, data := {})

### Mint
- func mint_and_send_random(projectuid := "", countnft: int = 0, receiveraddress := "")
- func mint_and_send_specific(projectuid := "", nftuid := "", tokencount: int = 0, receiveraddress := "")
- func mint_royalty_token(projectuid := "", royaltyaddress := "", percentage: float = 0)
- func remint_and_burn(projectuid := "", nftuid := "")

### IPFS
- func upload_to_ipfs(customerid: int = 0, data := {})
