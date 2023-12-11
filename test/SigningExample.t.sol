// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.20;

import "forge-std/Test.sol";
import {SigningExample} from "../src/SigningExample.sol";
import {ECDSA} from "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import {MessageHashUtils} from "@openzeppelin/contracts/utils/cryptography/MessageHashUtils.sol";

contract SigningExampleTest is Test {
    using ECDSA for bytes32;
    using MessageHashUtils for bytes32;

    SigningExample signing;
    uint256 internal userPrivateKey;
    uint256 internal signerPrivateKey;
    
    function setUp() public {
        signing = new SigningExample();
        (, userPrivateKey) = makeAddrAndKey("first");
        address signer;
        ( signer, signerPrivateKey) = makeAddrAndKey("second");
        signing.setSystemAddress(signer);
    }


}