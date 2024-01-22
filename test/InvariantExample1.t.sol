// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.20;

import {Test} from "forge-std/Test.sol";
import {ExampleContract1} from "../src/ExampleContract1.sol";

contract InvariantExample1 is Test {
    ExampleContract1 foo;

    function setUp() public {
        foo = new ExampleContract1();
    }

    function invariant_A() external {
        assertEq(foo.value1() + foo.value2(), foo.value3());
    }

    function invariant_B() external {
        assertGe(foo.value1() + foo.value2(), foo.value1());
    }
}