// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Counter {
    uint256 public number;
    uint256 public total;

    function setNumber(uint256 newNumber) public {
        number = newNumber;
        total += newNumber;
    }
    
    function increment() public {
        number++;
    }
    
}
