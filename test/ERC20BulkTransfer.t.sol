// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "src/testContracts/ERC20.sol";
import "src/BulkSender.sol";
contract ERC20BulkSenderTest is Test {
    ERC20Token erc20Token;
    BulkSender erc20BulkSender;
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
        erc20BulkSender = new BulkSender(account3);

        // Mint some tokens to the owner
        erc20Token.mint(owner, 1000 ether);

        // Approve the bulk sender to transfer tokens on behalf of the owner
        vm.prank(owner); // Simulate transaction as `owner`
         vm.deal(owner, 1 ether);
        erc20Token.approve(address(erc20BulkSender), 1000 ether);
    }

    function testBulkTransferSameValue() public {
        // Set up recipients array with one recipient (account1)
        address[] memory recipients = new address[](1);
        recipients[0] = account1;

        // Simulate bulk transfer to account1 with the same value
        vm.prank(owner); // Simulate transaction as `owner`
        vm.deal(owner, 1 ether);
        erc20BulkSender.bulkTransferERC20{value: 0.01 ether}(address(erc20Token), recipients, 300 ether);

        // Verify the balance of account1
        assertEq(erc20Token.balanceOf(account1), 300 ether);
    }

    function testBulkTransferDifferentValues() public {
        // Set up recipients array and corresponding amounts
        address[] memory recipients = new address[](1);
        uint256[] memory amounts = new uint256[](1);
        recipients[0] = account1; // Assign recipient
        amounts[0] = 300 ether;    // Assign amount

        // Simulate bulk transfer with different values
        vm.prank(owner); // Simulate transaction as `owner`
        erc20BulkSender.bulkTransferERC20{value: 0.01 ether}(address(erc20Token), recipients, amounts);

        // Verify the balance of account1
        assertEq(erc20Token.balanceOf(account1), 300 ether);
    }
}