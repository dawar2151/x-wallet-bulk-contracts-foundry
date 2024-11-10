
# Ethereum Bulk Sender

![Demo](./demo-bulk-sender.gif)

Ethereum Bulk Sender is a dApp designed for users who want to airdrop tokens or send tokens to multiple users in a few transactions, with customizable transaction fees. Built with Next.js.

---

## Table of Contents
1. [Presentation](#presentation)
2. [What You Can Do With Bulk Sender](#what-you-can-do-with-bulk-sender)
3. [Code Source Components](#code-source-components)
4. [Disclaimer](#disclaimer)
5. [Contract Usage and Functions](#contract-usage-and-functions)
6. [Getting Started](#getting-started)

---

## A) Presentation <a id="presentation"></a> - [top](#table-of-contents)

Ethereum Bulk Sender allows users to efficiently distribute tokens via bulk transactions, minimizing fees.

---

## B) What You Can Do With Bulk Sender <a id="what-you-can-do-with-bulk-sender"></a> - [top](#table-of-contents)

- **Airdrop Native Tokens:** Distribute ETH efficiently.
- **Airdrop ERC20 Tokens:** Bulk transfer of ERC20 tokens.
- **Airdrop ERC721 Tokens:** Send multiple ERC721 tokens.
- **Airdrop ERC1155 Tokens:** Efficiently distribute ERC1155 tokens.
- **VIP Membership:** Free usage for VIP members.

---

## C) Code Source Components <a id="code-source-components"></a> - [top](#table-of-contents)

- **BulkSender Smart Contracts:** Solidity-based contracts for bulk sending tokens and ethers.
- **Web Bulk Sender:** A decentralized web app built with Next.js.

---

## D) Disclaimer <a id="disclaimer"></a> - [top](#table-of-contents)

### Disclaimer
The `BulkSender` contract facilitates bulk transfers of ETH, ERC20, ERC721, and ERC1155 tokens. Before use:
- Test thoroughly in a safe environment.
- Verify compatibility with target token contracts.
- Understand gas costs and risks for large transactions.

**Note:** Use at your own risk. Neither Foundry nor the authors are responsible for any losses.

---

## E) Contract Usage and Functions <a id="contract-usage-and-functions"></a> - [top](#table-of-contents)

### Key Variables
- `receiverAddress`: Address receiving transaction fees.
- `txFee`: Fee for non-VIP bulk transfers.
- `VIPFee`: Fee for VIP membership.

### Core Functions

#### Register VIP
```solidity
function registerVIP() public payable
```

#### Bulk Transfer ETH
```solidity
function bulkTransfer(address[] calldata _receivers, uint[] calldata _values) external payable onlyAllowedAccount
```

#### Bulk Transfer ERC20 Tokens
```solidity
function bulkTransferERC20(address _tokenAddress, address[] calldata _receivers, uint _value) external payable onlyAllowedAccount
function bulkTransferERC20(address _tokenAddress, address[] calldata _receivers, uint[] calldata _values) external payable onlyAllowedAccount
```

#### Bulk Transfer ERC721 Tokens
```solidity
function bulkTransferERC721(address _tokenAddress, address[] calldata _receivers, uint[] calldata _tokenIds) external payable onlyAllowedAccount
```

#### Bulk Transfer ERC1155 Tokens
```solidity
function bulkTransferERC1155(address _tokenAddress, address[] calldata _receivers, uint[] calldata _tokenIds, uint[] calldata _values) external payable onlyAllowedAccount
```

---

## F) Getting Started <a id="getting-started"></a> - [top](#table-of-contents)

### Prerequisites
- Node.js v20.15.0
- npm
- Foundry and Forge ([Installation Guide](https://book.getfoundry.sh/getting-started/installation))

### Deployment Steps

1. **Create a `.env` file** in the root project directory:
	```env
	SEPOLIA_RPC_URL=
	MAINNET_RPC_URL=
	PRIVATE_KEY=
	ETHERSCAN_API_KEY=
	OWNER_ADDRESS=
	```

2. **Initialize submodules:**
	```bash
	cd x-wallet-bulk-sender-contracts-foundry
	git submodule update --init --recursive
	```

3. **Build and Deploy Contracts:**
	```bash
	forge build
	forge script --chain sepolia script/BulkSender.s.sol:BulkSenderDeploy --broadcast --verify -vvvv
	```
