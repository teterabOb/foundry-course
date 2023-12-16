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

    function testPurchase() public {
        // Usario que compra
        address user = vm.addr(userPrivateKey);
        // Firmante - Cuenta del Sistema
        address signer = vm.addr(signerPrivateKey);
        // Monto a pagar / comprar
        uint256 amount = 2;
        // Numero de serie
        string memory nonce = "ASDF";
        
        vm.startPrank(signer);
        bytes32 digest = keccak256(abi.encodePacked(user, amount, nonce)).toEthSignedMessageHash();
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(signerPrivateKey, digest);
        bytes memory signature = abi.encodePacked(r, s, v);
        vm.stopPrank();

        vm.startPrank(user);
        vm.deal(user, 1 ether);

        signing.purchase(amount, nonce, signature);

        vm.stopPrank();
    }
}