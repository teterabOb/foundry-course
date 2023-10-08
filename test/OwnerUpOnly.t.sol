pragma solidity 0.8.10;

import "forge-std/Test.sol";
import {OwnerUpOnly} from "../src/OwnerUpOnly.sol";
error Unauthorized();

contract OwnerUpOnlyTest is Test {
    OwnerUpOnly upOnly;

    function setUp() public{
        upOnly = new OwnerUpOnly();
    }

    function test_Address() public view {
        console.log("Log something here :", address(msg.sender));
    }

    function test_IncrementAsOwner() public {
        assertEq(upOnly.count(), 0);
        upOnly.increment();
        assertEq(upOnly.count(), 1);
    }

    function testFail_IncrementAsNotOwner() public{
        vm.prank(address(0));
        upOnly.increment();
    }

    function test_RevertWhen_CallerIsNotOwner() public {
        vm.expectRevert(Unauthorized.selector);
        console.logBytes4(Unauthorized.selector);
        vm.prank(address(0));
        upOnly.increment();
    }
}
