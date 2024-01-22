
// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.20;

contract ExampleContract1 {
    uint256 public value1;
    uint256 public value2;
    uint256 public value3;

    function addToA(uint256 _value) public {
        value1 += _value;
        value3 += _value;
    }

    function addToB(uint256 _value) public {
        value2 += _value;
        value3 += _value;
    }
}