// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import "../src/PaymentSplitter.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// https://book.getfoundry.sh/tutorials/solidity-scripting#writing-the-script
contract DeployScript is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        address vTokenAddress = vm.envAddress("VAULT_TOKEN_ADDRESS");
        IERC20 vToken = IERC20(vTokenAddress);

        new PaymentSplitter(vToken);
        vm.stopBroadcast();
    }
}
