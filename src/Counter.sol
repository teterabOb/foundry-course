// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.10;

contract Counter {
    uint256 public contador;

    function getContador() public view returns (uint256) {
        return contador;
    }

    // Nota: si el valor de contador = 0 , la funcion falla
    function incrementa() public {
        contador += 1;
    }

    function reduce() public {
        contador -= 1;
    }
}
