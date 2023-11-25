// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {University} from "../src/University.sol";

contract UniversityTest is Test {
    University public university;
    uint256 private startDate;

    // vm.warp - establecer block.timestamp    
    // skip - incrementar el tiempo actual en segundos
    // rewind - reducir el tiempo actual en segundos

    function setUp() public {
        university = new University();
        startDate = block.timestamp;
    }

    function testEnrollFailBeforStartDate() public {
        vm.expectRevert("can't enroll");
        university.enroll();
    }

    function testEnroll() public {
        vm.warp(startDate + 1 days);
        university.enroll();
    }

    function testEnrollFailBeforEndDate() public {
        vm.expectRevert("can't enroll");
        vm.warp(startDate + 2 days);
        university.enroll();
    }

    function testSkip() public {
        vm.warp(0);
        assertEq(block.timestamp, 0);
        skip(3600);
        assertEq(block.timestamp, 3600);
    }

    function testRewind() public {
        // Imprimir por consola el valor inicial del block.timestamp que es 1
        console.logUint(block.timestamp);
        uint256 t = block.timestamp;
        rewind(1);
        assertEq(block.timestamp, 0);
    }
}
