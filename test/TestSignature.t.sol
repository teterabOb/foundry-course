// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.20;

import "forge-std/Test.sol";

contract TestSign is Test {
    struct Wallet {
      address addr;
      uint256 publicKeyX;
      uint256 publicKeyY;
      uint256 privateKey;
    }

    function testSigneMessage() public {
        vm.skip(true);
        (address alice, uint256 alicePk) = makeAddrAndKey("alice");
        emit log_address(alice);
        emit log_uint(alicePk);

        bytes32 hash = keccak256("Signed by Alice");
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(alicePk, hash);
        address signer = ecrecover(hash, v, r, s);
        assertEq(signer, alice);
    }

    function testSigneMessageCreateWallet() public {
        Wallet memory alice = vm.createWallet(uint256(keccak256(bytes("1"))));
        bytes32 hash = keccak256("Signed by Alice");
        (uint8 v,bytes32 r,bytes32 s) = vm.sign(alice, hash);
        address signer = ecrecover(hash, v, r, s);
        assertEq(alice.address, signer);
    }
}
