// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "src/testContracts/ERC721.sol"; // Update the path as needed
import "src/BulkSender.sol"; // Update the path as needed

contract ERC721BulkSenderTest is Test {
    ERC721Tester erc721Tester;
    BulkSender erc721BulkSender;
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
        erc721Tester = new ERC721Tester();
        erc721BulkSender = new BulkSender(account3);

        // Mint some NFTs to account1
        vm.prank(owner); // Simulate transaction as `owner`
        erc721Tester.mint(account1, 1);
        erc721Tester.mint(account1, 2);
        erc721Tester.mint(account1, 3);
    }

    function testBulkTransferSameValue() public {
        uint256 tokenId = 1;
        
        address[] memory recipients = new address[](1);
        recipients[0] = account2;

        uint256[] memory tokenIds = new uint256[](1);
        tokenIds[0] = tokenId;

        // Approve the bulk sender to transfer tokenId on behalf of account1
        vm.prank(account1); // Simulate transaction as `account1`
        erc721Tester.approve(address(erc721BulkSender), tokenId);

        // Simulate bulk transfer to account2 with the same value
        vm.prank(account1); // Simulate transaction as `account1`
        vm.deal(account1, 1 ether);
        erc721BulkSender.bulkTransferERC721{value: 0.01 ether}(
            address(erc721Tester),
            recipients,
            tokenIds
        );

        // Verify the owner of the token
        assertEq(erc721Tester.ownerOf(1), account2);
    }
}
