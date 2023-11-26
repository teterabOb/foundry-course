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

    function testEnrollFailBeforeStartDate() public {
        vm.expectRevert("cannot enroll");
        university.enroll();
    }

    function testEnrollFailBeforeEndDate() public {
        vm.expectRevert("cannot enroll");
        vm.warp(startDate + 2 days);
        university.enroll();
    }

    function testEnroll() public {
        vm.warp(startDate + 1 days);
        university.enroll();
    }

    function testLeave() public {
        vm.warp(startDate + 2 days + 1 seconds);
        university.leave();
    }

    function testSkip() public {
        //console.logUint(block.timestamp);
        vm.warp(0);
        assertEq(block.timestamp, 0);
        skip(3600); 
        assertEq(block.timestamp, 3600);
    }

    function testRewind() public {
        uint256 t = block.timestamp;
        rewind(1);
        assertEq(block.timestamp, 0);
    }


}

