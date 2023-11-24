// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.10;

import {Test} from "forge-std/Test.sol";
import {Factory} from "../src/Factory.sol";

contract FactoryTest is Test {
    /*
    // verde: para las llamadas que no revierten
    // rojo: para las llamadas que revierten
    // azul: para las llamadas a los cheatcodes
    // cin: para los logs/ eventos emitidos
    // amarillo: para el despliegue de contratos
    */

    Factory public factory;

    function setUp() public{
        factory = new Factory();
    }

    function test_Deploy() public{
        vm.prank(address(0));
        string memory result = factory.deploy();
        assertEq(result, "Contrato desplegado");
    }

    function testFail_Revert() public {
        vm.prank(address(0));
        factory.revertFunction();
    }
}