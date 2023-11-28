pragma solidity 0.8.10;

import "forge-std/Test.sol";
import {OwnerUpOnly} from "../src/OwnerUpOnly.sol";

error Unauthorized();

contract OwnerUpOnlyTest is Test {
    OwnerUpOnly upOnly;

    function setUp() public {
        upOnly = new OwnerUpOnly();
    }

    /*
    function test_IncrementAsOwner() public {
        assertEq(upOnly.count(), 0);
        upOnly.increment();
        assertEq(upOnly.count(), 1);
    }

    function testFail_IncrementAsNotOwner() public {
        vm.prank(address(0));
        upOnly.increment();
    }

    function test_RevertWhen_CallerIsNotOwner() public {
        vm.expectRevert(Unauthorized.selector);
        vm.prank(address(0));
        upOnly.increment();
    }
    */

    // Nuevos tests
    // prank setea msg.sender para la siguiente llamada
    // no incluye llamadas a la cheat code address   
    /* 
    function test_CallerIsOwnerPrank() public {
        vm.prank(address(1));
        console.logAddress(address(msg.sender));
        upOnly.incrementNotOwner();
        upOnly.incrementNotOwner();
        console.logAddress(address(msg.sender));        
    }
    */
    
    // startPrank: setea el msg.sender hasta que se utilice stopPrank
    function test_CallerIsOwner() public {
        vm.startPrank(address(1));        
        vm.expectEmit(address(1));
        upOnly.incrementNotOwner();   
        //vm.expectEmit(address(1));
        upOnly.incrementNotOwner();    
        vm.stopPrank();
        //vm.expectEmit(address(this));
        upOnly.incrementNotOwner();                  
    }

}
