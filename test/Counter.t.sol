// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.20;

import "forge-std/Test.sol";
import {HelperContract} from "../src/HelperContract.sol";
import {Counter} from "../src/Counter.sol";

contract CounterTest is Test, HelperContract {
    Counter public counter;
    uint256 testNumber;
    address importantAddress;

    function setUp() public {
        counter = new Counter();
        testNumber = 42;
        importantAddress = 0xb4c79daB8f259C7Aee6E5b2Aa729821864227e84;
    }

    function test_ImportantAddress() public {
        assertEq(importantAddress, HelperContract.IMPORTANT_ADDRESS);
    }

    function test_NumberIs42() public {
        assertEq(testNumber, 42);
    }

    function testIncrementa() public {
        counter.incrementa();
        console.log("Imprimiendo el siguiente mensaje :", 256);
        assertEq(counter.contador(), 1);
    }

    function testFail_Substract43() public {
        testNumber -= 43;
    }

    function test_GetContador() public {
        uint256 contadorValue = counter.getContador();
        assertEq(contadorValue, 0);
    }

    function testFail_reduce() public {
        counter.reduce();
    }
}
