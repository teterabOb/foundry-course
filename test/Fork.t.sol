// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.20;

import {Test} from "forge-std/Test.sol";

contract ForkTest is Test {
    uint256 mainnetFork;
    uint256 optimismFork;

    string ETHEREUM_MAINNET_RPC = vm.envString("ETHEREUM_MAINNET_RPC");
    string OPTIMISM_MAINNET_RPC = vm.envString("OPTIMISM_MAINNET_RPC");
    
    function setUp() public {
        mainnetFork = vm.createFork(ETHEREUM_MAINNET_RPC);
        optimismFork = vm.createFork(OPTIMISM_MAINNET_RPC);
    }

    function testForkIdDiffer() public view {
        assert(mainnetFork != optimismFork);
    }

    function testSelectFork() public {
        vm.selectFork(mainnetFork);
        assertEq(vm.activeFork(), mainnetFork);
    }

    function testCanSwitchFork() public {
        vm.selectFork(mainnetFork);
        assertEq(vm.activeFork(), mainnetFork);

        vm.selectFork(optimismFork);
        assertEq(vm.activeFork(), optimismFork);
    } 

    function testCancreateAndSelectForkInOneStep() public {
        uint256 anotherFork = vm.createSelectFork(ETHEREUM_MAINNET_RPC);
        assertEq(vm.activeFork(), anotherFork);
    }

    function testCanSetForkBlockNumber() public {
        vm.selectFork(mainnetFork);
        vm.rollFork(1_337_000); // 1337000
        emit log_uint(block.number);
        assertEq(block.number, 1_337_000);
    }
}