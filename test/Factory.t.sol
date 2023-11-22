// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.10;

import {Test} from "forge-std/Test.sol";
import {Factory} from "../src/Factory.sol";

contract FactoryTest is Test {
    /* Colores
    // Verde-Green: Para llamadas que no revierten / For calls that do not revert
    // Rojo-Red: Para llamadas que revierten / For reverting calls
    // Azul-Blue: Para llamadas a cheat codes / For calls to cheat codes
    // Cyan-Cin: Para logs/eventos emitidos / For emitted logs
    // Amarillo-Yellow: Para despliegue de contratos / For contract deployments
    */
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