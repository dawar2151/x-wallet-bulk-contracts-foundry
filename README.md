# <h1 align="center">Bulk sender </h1>

## Getting Started

Click "Use this template" on [GitHub](https://github.com/foundry-rs/forge-template) to create a new repository with this repo as the initial state.

Or, if your repo already exists, run:
```sh
forge init
forge build
forge test
```
## load submodules openzeppelin-contracts

```sh
 git submodule update --init --recursive
```
## deploy contracts

```sh
forge create --rpc-url "" \
				--constructor-args "" \
				--private-key "" \
				--etherscan-api-key "" \
				--verify \
				src/BulkSender.sol:BulkSender
```
