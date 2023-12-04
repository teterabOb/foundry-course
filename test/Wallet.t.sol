// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {Wallet} from "../src/Wallet.sol";

contract WalletTest is Test { 
    Wallet wallet;

    function setUp() public {
        wallet = new Wallet();
    }

    function _send(uint256 amount) private {
        payable(address(wallet)).transfer(amount);
    }

    function _sendLowLevelCall(uint256 amount) private {
        (bool transfered, ) = address(wallet).call{value: amount}("");
        require(transfered, "Transfer failed");
    }

    function testDepositWithdrawDeal() public {
        vm.skip(true);
        deal(address(this), 1 ether);
        _sendLowLevelCall(1 ether);
        assertEq(address(this).balance, 0);
        assertEq(address(wallet).balance, 1 ether);
        wallet.withdrawAll();
        assertEq(address(wallet).balance, 0);        
    }

    function testDepositWithdrawHoax() public {        
        vm.skip(true);
        hoax(address(1), 1 ether);        
        _sendLowLevelCall(1 ether);
        assertEq(address(1).balance, 0);            
        wallet.withdrawAll();   
        assertEq(address(1).balance, 0); 
    }

    receive() external payable {}
}