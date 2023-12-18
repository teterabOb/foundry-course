// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.20;

import "forge-std/Test.sol";

interface IWETH {
    function balanceOf(address) external view returns(uint256);
    function deposit() external payable;
}
contract ForkingTest is Test {
    // RPC ENDPOINT
    // Alchemy prefijo : https://eth-mainnet.g.alchemy.com/v2/
    IWETH public WETH;

    function setUp() public {
        WETH = IWETH(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);
    }

    function testDeposit() public {
        vm.deal(address(this), 1 ether);
        uint256 balance = WETH.balanceOf(address(this));
        emit log_uint(balance);
        WETH.deposit{ value : 1 ether }();
        uint256 newBalance = WETH.balanceOf(address(this));
        assertEq(newBalance, 1 ether);
    }
}