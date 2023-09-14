// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.10;

import {Test, console } from "forge-std/Test.sol";
import {Counter} from "../src/Counter.sol";

contract CounterTest is Test {
    Counter public counter;

    function setUp() public{
        counter = new Counter();        
    }

    function test_Consolelog() public view {
        console.log(address(this));
    }

    function testIncrementa() public{
        counter.incrementa();
        assertEq(counter.contador(), 1);
    }

}
