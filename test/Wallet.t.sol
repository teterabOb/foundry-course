// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.20;

import "forge-std/Test.sol";
import {Wallet} from "../src/Wallet.sol";

contract WalletTest is Test {
    // deal: setea los fondos de un address
    // hoax: setea los fondos y el address
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

    function testCallerByPrank() public {
        
    }

    function testDepositEtherDeal() public {

    }

    function testDepositEther() public {                
        hoax(address(this), 10 ether);
        console.log(address(this).balance);
        address walletAddress = address(wallet);
        console.log(walletAddress.balance);
        payable(walletAddress).transfer(1 ether);
        console.log(walletAddress.balance / 1e18);
    }

    function testContractBalance() public view {
        console.log(address(this).balance);
    }

    function testDepositEtherToContract() public {
        hoax(address(this), 10 ether);
        _sendLowLevelCall(1 ether);
        assertEq(address(wallet).balance, 1 ether);
    }
}