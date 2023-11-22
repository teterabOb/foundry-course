// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.10;

import {Test} from "forge-std/Test.sol";
import {Factory} from "../src/Factory.sol";

contract FactoryTest is Test {
    Factory public factory;

    function setUp() public {
        factory = new Factory();
    }

    function test_Deploy() public {
        vm.prank(address(0));
        address result = factory.deploy();
        require(result != address(0), "No adddress zero");
    }

    function testFail_Revert() public  {
        vm.prank(address(0));
        factory.revertFunction();
    }
}