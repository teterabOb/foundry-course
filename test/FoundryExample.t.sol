// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.20;

import "forge-std/Test.sol";
import {HelperContract} from "../src/HelperContract.sol";

contract ContractBTest is Test, HelperContract {
    uint256 testNumber;
    address testAddress;

    function setUp() public {
        testNumber = 42;
        testAddress = 0xb4c79daB8f259C7Aee6E5b2Aa729821864227e84;
    }

    function test_NumberIs42() public {
        assertEq(testAddress, HelperContract.IMPORTANT_ADDRESS);
    }

    function testFail_Substract43() public {
        testNumber -= 43;
    }
}
