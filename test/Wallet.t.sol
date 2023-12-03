// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.20;

import {Test, console} from "forge-std/Test.sol";
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

    function testDepositWithdrawHoax() public {
        vm.skip(true);
        // Setea el address(1) de manera perpetua
        // Y le transfiere 1 ether
        hoax(address(1), 1 ether);
        // Llamada a la funcion _send para transferir ETH
        _send(1 ether);
        // Valida que el balance del address sea igual a 0
        assertEq(address(1).balance, 0);
        // Esperamos que la ejecución luego de vm.expectRevert() revierta
        vm.expectRevert();
        // Hacemos withdraw de todos los fondos del contrato
        wallet.withdrawAll(1 ether);
        // Validamos que el balance del address(1) sea 0
        // Ya que transfirió todo su balance y el withdraw revirtió
        assertEq(address(1).balance, 0);
    }

    function testDepositWithdrawDeal() public {
    
        // Setea el address(1) de manera perpetua
        // Y le transfiere 1 ether
        deal(address(this), 1 ether);
        // console.log(address(this).balance);
        // Llamada a la funcion _send para transferir ETH
        _sendLowLevelCall(1 ether);
        //console.log(address(this).balance);
        // Valida que el balance del address sea igual a 0
        assertEq(address(this).balance, 0);
        // vm.prank(address(1));
        // Hacemos withdraw de todos los fondos del contrato
        wallet.withdrawAll(1 ether);
        // Validamos que el balance del address(1) sea 0
        // Ya que transfirió todo su balance y el withdraw revirtió
        // console.log(address(this).balance);
        //assertEq(address(this).balance, 1);
    }

    function testOwner() public {
        vm.skip(true);
        assertEq(wallet.getOwner(), address(this));
    }

    /*
    function testDepositEtherDeal() public {  
        vm.skip(true);              
        hoax(address(this), 10 ether);
        console.log(address(this).balance);
        address walletAddress = address(wallet);
        console.log(walletAddress.balance);
        payable(walletAddress).transfer(1 ether);
        console.log(walletAddress.balance / 1e18);
    }

    function testDepositEtherToContract() public {
        vm.skip(true);
        hoax(address(this), 10 ether);
        _sendLowLevelCall(1 ether);
        assertEq(address(wallet).balance, 1 ether);
    }

    function testDepositEtherToContractDeal() public {
        deal(address(this), 10 ether);
        _sendLowLevelCall(1 ether);
        assertEq(address(wallet).balance, 1 ether);
        _send(1 ether);
        assertEq(address(wallet).balance, 2 ether);
        deal(address(1), 10 ether);
    }
    */

   // Debemos agregar esta función para depositar 
   // para que funcione el withdraw
   receive() external payable {}
}