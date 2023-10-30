// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.10;

import {Test, console2} from "forge-std/Test.sol";
import {HolaMundo} from "../src/HolaMundo.sol";

contract HolaMundoTest is Test {
    HolaMundo public holaMundo;

    function setUp() public {
        holaMundo = new HolaMundo();
    }

    function testSaludo() public {
        assertEq(holaMundo.saludo(), "Hola Mundo#");
    }
}
