// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "src/testContracts/ERC1155.sol"; // Adjust the path to your ERC1155 implementation
import "src/BulkSender.sol"; // Adjust the path to your BulkSender implementation

contract ERC1155BulkSenderTest is Test {
    ERC1155Token erc1155Token;
    BulkSender erc1155BulkSender;
    address owner;
    address account1;
    address account2;
    address account3;

    function setUp() public {
        // Assign wallet addresses
        owner = address(0x1);
        account1 = address(0x2);
        account2 = address(0x3);
        account3 = address(0x4);

        // Deploy contracts
        erc1155Token = new ERC1155Token();
        erc1155BulkSender = new BulkSender(account3);

        // Mint some tokens to account1
        vm.prank(owner); // Simulate transaction as `owner`
        erc1155Token.mint(account1, 1, 100);
        erc1155Token.mint(account1, 2, 100);
        erc1155Token.mint(account1, 3, 100);
    }

    function testBulkTransferSameValue() public {
        uint256 tokenId = 1;
        uint256 amount = 100;

        address[] memory recipients = new address[](1);
        recipients[0] = account2;

        uint256[] memory tokenIds = new uint256[](1);
        tokenIds[0] = tokenId;

        uint256[] memory amounts = new uint256[](1);
        amounts[0] = 100;

        // Set approval for the bulk sender
        vm.prank(account1); // Simulate transaction as `account1`
        erc1155Token.setApprovalForAll(address(erc1155BulkSender), true);

        // Simulate bulk transfer from account1 to account2
        vm.prank(account1); // Simulate transaction as `account1`
        vm.deal(account1, 1 ether);
        erc1155BulkSender.bulkTransferERC1155{value: 0.1 ether}(address(erc1155Token), recipients, tokenIds, amounts);

        // Verify the balance of account2
        assertEq(erc1155Token.balanceOf(account2, tokenId), amount);
    }
}
