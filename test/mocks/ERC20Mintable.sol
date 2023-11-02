// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import {ERC20} from "solmate/tokens/ERC20.sol";

contract ERC20Mintable is ERC20 {
    constructor(string memory _name, string memory _symbol) ERC20(_name, _symbol, 18) {

    }

    function mint(uint256 amount, address to) public {
        _mint(to, amount);
    }
}