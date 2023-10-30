// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.10;

import {Test, console } from "forge-std/Test.sol";
import {Counter} from "../src/Counter.sol";

contract CounterTest is Test {
    Counter public counter;

    function setUp() public {
        counter = new Counter();
    }

    function testIncrementa() public {
        counter.incrementa();
        console.log("Imprimiendo el siguiente mensaje :", 256);
        assertEq(counter.contador(), 1);
    }
}
