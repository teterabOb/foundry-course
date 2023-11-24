// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.10;

import {HolaMundo} from "../src/HolaMundo.sol";

error ThrowError();

contract Factory {
    HolaMundo public holaMundo;

    event Reverting(address indexed newContract);

    function deploy() external returns (string memory) {
        HolaMundo newContract = new HolaMundo();
        holaMundo = newContract;
        emit Reverting(address(holaMundo));
        return "Contrato desplegado";
    }

    function revertFunction() external pure {
        revert ThrowError();
    }
}
