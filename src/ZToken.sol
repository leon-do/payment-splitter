// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ZToken is ERC20 {
    constructor() ERC20("Z Token", "zTKN") {
        _mint(msg.sender, 100);
    }
}
