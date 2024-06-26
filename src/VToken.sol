// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract VToken is ERC20 {
    constructor() ERC20("Vault Token", "vTKN") {
        _mint(msg.sender, 100);
    }
}
