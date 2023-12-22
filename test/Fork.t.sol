// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.20;

import "forge-std/Test.sol";

contract ForkTest is Test {
    // los identificadores del fork
    uint256 mainnetFork;
    uint256 optimismFork;

    // Acceder a variables desde el archivo .env via vm.envString("varname")
    string ETHEREUM_MAINNET_RPC = vm.envString("ETHEREUM_MAINNET_RPC");
    string OPTIMISM_MAINNET_RPC  = vm.envString("OPTIMISM_MAINNET_RPC");

    function setUp() public {
        mainnetFork = vm.createFork(ETHEREUM_MAINNET_RPC);
        optimismFork = vm.createFork(OPTIMISM_MAINNET_RPC);
    }

    function testForkIdDiffer() public view {
        assert(mainnetFork != optimismFork);
    }

    function testCanSelectFork() public {
        vm.selectFork(mainnetFork);
        assertEq(vm.activeFork(), mainnetFork);
    }

    // Manejar multiples forks en el mismo test
    function testCanSwitchForks() public {
        vm.selectFork(mainnetFork);
        assertEq(vm.activeFork(), mainnetFork);

        vm.selectFork(optimismFork);
        assertEq(vm.activeFork(), optimismFork);
    }

    // forks pueden ser creados todo el tiempo
    function testCanCreateAndSelectForkInOneStep() public {
        // crea un nuevo fork y también lo selecciona
        uint256 anotherFork = vm.createSelectFork(ETHEREUM_MAINNET_RPC);
        assertEq(vm.activeFork(), anotherFork);
    }

    // setea el `block.number` de un fork
    function testCanSetForkBlockNumber() public {
        vm.selectFork(mainnetFork);
        vm.rollFork(1_337_000);

        assertEq(block.number, 1_337_000);
    }

}