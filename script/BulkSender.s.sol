// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.26;

import {Script} from "forge-std/Script.sol";
import {BulkSender} from "../src/BulkSender.sol";

contract BulkSenderDepol is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address ownerAddress = vm.envAddress("OWNER_ADDRESS");
        vm.startBroadcast(deployerPrivateKey);

        BulkSender bulkSender = new BulkSender(ownerAddress);
        
        vm.stopBroadcast();
    }
}