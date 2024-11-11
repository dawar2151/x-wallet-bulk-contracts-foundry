// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "src/testContracts/ERC20.sol";
import "src/BulkSender.sol";
contract bulkSenderTest is Test {
    ERC20Token erc20Token;
    BulkSender bulkSender;
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
        erc20Token = new ERC20Token();
        bulkSender = new BulkSender(account3);

        // Mint some tokens to the owner
        erc20Token.mint(owner, 1000 ether);

        // Approve the bulk sender to transfer tokens on behalf of the owner
        vm.prank(owner); // Simulate transaction as `owner`
        vm.deal(owner, 10 ether);
      
    }

    function testBulkTransferDifferentValues() public {
        // Set up recipients array and corresponding amounts
        address[] memory recipients = new address[](1);
        uint256[] memory amounts = new uint256[](1);
        recipients[0] = account1; // Assign recipient
        amounts[0] = 2 ether;    // Assign amount

        bulkSender.bulkTransfer{value: 2.01 ether}(recipients, amounts);

        // Verify the balance of account1
        assertEq(address(account1).balance, 2 ether);
    }
}