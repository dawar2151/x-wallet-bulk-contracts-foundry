// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.26;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ERC1155Token is ERC1155 {

    constructor() ERC1155("")  {
    }
    function mint(address account, uint256 tokenId, uint256 amount) public {
        _mint(account, tokenId, amount, "");
    }
}
