// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {PaymentSplitter} from "../src/PaymentSplitter.sol";
import {VToken} from "../src/VToken.sol";
import {ZToken} from "../src/ZToken.sol";

contract VTokenTest is Test {
    PaymentSplitter public paymentSplitter;
    VToken public vToken;
    ZToken public zToken;

    function setUp() public {
        vToken = new VToken();
        paymentSplitter = new PaymentSplitter(vToken);
        zToken = new ZToken();
    }

    function test_InitialState() public view {
        assertEq(vToken.balanceOf(address(this)), 100);
        assertEq(zToken.balanceOf(address(this)), 100);
        assertEq(zToken.balanceOf(address(paymentSplitter)), 0);
    }

    function testFail_Release() public {
        // should fail if payment splitter has no balance
        paymentSplitter.release(zToken, address(this));
    }

    function test_ReleaseA() public {
        // transfer z to payment splitter
        zToken.transfer(address(paymentSplitter), 100);
        // check z state. payment spliter should have z balance
        assertEq(zToken.balanceOf(address(this)), 0);
        assertEq(zToken.balanceOf(address(paymentSplitter)), 100);
        // this address releases funds
        paymentSplitter.release(zToken, address(this));
        // check z state. this address should have z balance
        assertEq(zToken.balanceOf(address(this)), 100);
        assertEq(zToken.balanceOf(address(paymentSplitter)), 0);
    }

    function test_ReleaseB() public {
        // transfer 50% z to random user
        zToken.transfer(address(1), 50);
        // transfer 50% z to payment splitter
        zToken.transfer(address(paymentSplitter), 50);
        // check z state. payment spliter should have z balance
        assertEq(zToken.balanceOf(address(this)), 0);
        assertEq(zToken.balanceOf(address(paymentSplitter)), 50);
        // this address releases funds
        paymentSplitter.release(zToken, address(this));
        // check z state. this address should have z balance
        assertEq(zToken.balanceOf(address(this)), 50);
        assertEq(zToken.balanceOf(address(paymentSplitter)), 0);
    }

    function test_ReleaseC() public {
        // transfer 50% v to random user 1
        vToken.transfer(address(1), 50);
        // transfer z to payment splitter
        zToken.transfer(address(paymentSplitter), 100);
        // check z state. payment spliter should have z balance
        assertEq(zToken.balanceOf(address(this)), 0);
        assertEq(zToken.balanceOf(address(paymentSplitter)), 100);
        // this address releases funds
        paymentSplitter.release(zToken, address(this));
        // check z state. this address should have z balance
        assertEq(zToken.balanceOf(address(this)), 50);
        // payment splitter should keep 50% for random user 1
        assertEq(zToken.balanceOf(address(paymentSplitter)), 50);
    }
}
