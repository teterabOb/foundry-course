// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.10;

contract Counter {
    uint256 public contador;

    function getContador() public view returns(uint256){
        return contador;
    }

    function incrementa() public {
        contador += 1;
    }

    function reduce() public {
        contador -= 1;
    }
}
