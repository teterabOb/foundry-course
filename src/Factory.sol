// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.10;

import {HolaMundo} from "../src/HolaMundo.sol";

error ThrowError();

contract Factory {
    HolaMundo public holaMundo;

    event Reverting(string indexed message);

    function deploy() external returns (address) {
        HolaMundo newContract = new HolaMundo();
        holaMundo = newContract;
        emit Reverting("Log");
        return address(newContract);
    }

    function revertFunction() external pure {
        revert ThrowError();
    }
}
