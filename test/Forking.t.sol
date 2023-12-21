// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.20;

import "forge-std/Test.sol";

interface IWETH {
    function balanceOf(address) external view returns(uint256);
    function deposit() external payable;
}

interface IDAI {    
    function balanceOf(address) external view returns(uint256);
    function totalSupply()  external view returns(uint256);
}

contract ForkingTest is Test {    
    // DAI Address: 0x6B175474E89094C44Da98b954EedeAC495271d0F    
    // RPC ENDPOINT - Alchemy prefijo : https://eth-mainnet.g.alchemy.com/v2/
    IWETH public WETH;
    IDAI public DAI;
    
    function setUp() public {
        WETH = IWETH(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);    
        DAI = IDAI(0x6B175474E89094C44Da98b954EedeAC495271d0F);
    }

    function testDepositEtherMintWETH() public {        
        vm.deal(address(this), 1 ether);
        uint256 balance = WETH.balanceOf(address(this));
        emit log_uint(balance);
        WETH.deposit{ value : 1 ether }();
        uint256 newBalance = WETH.balanceOf(address(this));
        assertEq(newBalance, 1 ether);
    }

    function testMintDAI() public {
        address alice = makeAddr("alice");
        uint balance = DAI.balanceOf(alice); 
        uint256 initialTotalSupply = DAI.totalSupply();

        emit log_uint(balance / 1e18);
        emit log_uint(initialTotalSupply / 1e18);

        deal(address(DAI), alice, 1 ether, true);                

        uint finalBalance = DAI.balanceOf(alice); 
        uint256 finalTotalSupply = DAI.totalSupply();

        emit log_uint(finalBalance / 1e18);
        emit log_uint(finalTotalSupply / 1e18);
    }
    
}