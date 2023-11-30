pragma solidity 0.8.10;

import "forge-std/Test.sol";
import {OwnerUpOnly} from "../src/OwnerUpOnly.sol";

error Unauthorized();

contract OwnerUpOnlyTest is Test {
    OwnerUpOnly upOnly;
    
    event Caller(address indexed sender);

    function setUp() public {
        upOnly = new OwnerUpOnly();
    }
    
    function test_IncrementAsOwner() public {
        vm.skip(true);
        assertEq(upOnly.count(), 0);
        upOnly.increment();
        assertEq(upOnly.count(), 1);
    }

    function testFail_IncrementAsNotOwner() public {
        vm.skip(true);
        vm.prank(address(0));
        upOnly.increment();
    }

    function test_RevertWhen_CallerIsNotOwner() public {
        vm.skip(true);
        vm.expectRevert(Unauthorized.selector);
        vm.prank(address(0));
        upOnly.increment();
    }
    
    // Nuevos tests
    // prank setea msg.sender para la siguiente llamada
    // no incluye llamadas a la cheat code address       
    function test_CallerIsOwnerPrank() public {                                
        vm.prank(address(1));     

        vm.expectEmit(true, false, false, false);  
        emit Caller(address(1));
        upOnly.incrementNotOwner();

        vm.expectEmit(true, false, false, false);  
        emit Caller(address(this));
        upOnly.incrementNotOwner();                
    }
        
    // startPrank: setea el msg.sender hasta que se utilice stopPrank
    function test_CallerIsOwner() public {
        // Seteamos el address para las siguiente llamada 
        // y llamadas subsecuentes
        vm.startPrank(address(1));        
        // Esperamos el siguiente evento y validamos solo el primer topic
        vm.expectEmit(true, false, false, false);
        // Emitimos el evento
        emit Caller(address(1));
        // Llamamos la función del contrato que emite el evento
        upOnly.incrementNotOwner();  

        // Repetimos el proceso anterior        
        vm.expectEmit(true, false, false, false);
        emit Caller(address(1)); 
        upOnly.incrementNotOwner();    

        // Detenemos el startPrank
        vm.stopPrank();

        // Repetimos el proceso pero ahora el caller es distinto
        vm.expectEmit(true, false, false, false);
        emit Caller(address(this)); 
        upOnly.incrementNotOwner();                  
    }
}
