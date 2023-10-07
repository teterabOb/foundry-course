// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.13;

contract Counter {
    uint256 private contador;

    function getContador() public view returns(uint256){
        return contador;
    }

    function incrementa() public{
        contador += 1;
    }

    // Nota: si el valor de contador = 0 , la funcion falla
    function reduce() public {
        contador -= 1;
    }
}
