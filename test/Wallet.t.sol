// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.20;

import "forge-std/Test.sol";
import {Wallet} from "../src/Wallet.sol";

contract WalletTest is Test {
    Wallet wallet;

    function setUp() public {
        wallet = new Wallet();
    }

    function testDepositEther() public {
        console.logAddress(address(this));
        console.log(address(this).balance);
        hoax(address(this), 1 ether);
        console.log(address(this).balance);
    }
}